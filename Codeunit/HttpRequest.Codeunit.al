/// <summary>
/// Codeunit to handle HTTP requests
/// </summary>
codeunit 50201 "Http Request"
{
    local procedure ClearVariables()
    begin
        Clear(Client);
        Clear(Req);
        Clear(Res);
        Clear(CurrentContentType);
        Clear(RestHeaders);
        Clear(ContentTypeSet);
        Client.Clear();
        WebContent.Clear();
        WebRequestHeaders.Clear();
        WebContentHeaders.Clear();
        RestHeaders.Clear();
        ContentTypeSet := false;
        CurrentContentType := '';
    end;
    /// <summary>
    /// Initializes the HTTP request
    /// </summary>
    /// <param name="Method">HTTP Method</param>
    /// <param name="URI">URI</param>
    procedure Initialize(Method: Enum HttpMethods; URI: Text);
    begin
        ClearVariables();
        Req.Method := Method.Names.Get(Method.AsInteger());
        Req.SetRequestUri(URI);
        Req.GetHeaders(WebRequestHeaders);
    end;
    /// <summary>
    /// Adds a request header to the HTTP request
    /// <br/>
    /// <b>NOTE:</b> This method should be called AFTER <code> AddBody() </code> method
    /// </summary>
    procedure AddRequestHeader(HeaderKey: Text; HeaderValue: Text)
    begin
        RestHeaders.AppendLine(HeaderKey + ': ' + HeaderValue);

        WebRequestHeaders.Add(HeaderKey, HeaderValue);
    end;

    /// <summary>
    /// Add Basic Authentication to the HTTP request
    /// </summary>
    /// <param name="Username">Username</param>
    /// <param name="Password">Password</param>
    procedure AddBasicAuthentication(Username: Text; Password: Text)
    var
        Convert: Codeunit "Base64 Convert";
    begin
        AddRequestHeader('Authorization', 'Basic ' + Convert.ToBase64(Username + ':' + Password));
    end;

    /// <summary>
    /// Add Bearer Token to the HTTP request
    /// </summary>
    /// <param name="Token">Bearer Token</param>
    procedure AddBearerToken(Token: Text)
    begin
        AddRequestHeader('Authorization', 'Bearer ' + Token);
    end;



    /// <summary>
    /// Adds a body to the HTTP request
    /// </summary>
    procedure AddBody(Body: Text)
    begin
        WebContent.WriteFrom(Body);
    end;

    /// <summary>
    /// Sets the content type of the HTTP request
    /// <br/>
    /// <b>NOTE:</b> This method should be called after <code> AddBody() </code> method
    /// </summary>
    procedure SetContentType(ContentType: Text)
    begin
        CurrentContentType := ContentType;

        webcontent.GetHeaders(WebContentHeaders);
        if WebContentHeaders.Contains('Content-Type') then
            WebContentHeaders.Remove('Content-Type');

        WebContentHeaders.Add('Content-Type', ContentType);
        ContentTypeSet := true;
    end;

    /// <summary>
    /// Sends the HTTP request
    /// <br/>
    /// <returns>True if the request was successful, false otherwise</returns>
    /// </summary>
    procedure SendRequest() SendSuccess: Boolean
    begin
        if ContentTypeSet then
            Req.Content(WebContent);
        OnBeforeSend(Req, Res);
        SendSuccess := Client.Send(Req, Res);
        OnAfterSend(Req, Res);
        if SendSuccess then
            if not Res.IsSuccessStatusCode() then
                SendSuccess := false;
    end;

    /// <summary>
    /// Gets the response content as text
    /// </summary>
    procedure GetResponseAsText() ResponseContentText: Text
    begin
        Res.Content().ReadAs(ResponseContentText);
    end;

    /// <summary>
    /// Gets the response content as JSON
    /// </summary>
    procedure GetResponseAsJson() ResponseContentJson: JsonObject
    var
        ResponseContentText: Text;
    begin
        Res.Content().ReadAs(ResponseContentText);
        if GETHTTPSTATUSCODE() = 0 then
            ResponseContentText := '{"error": "Nav time out error"}';
        ResponseContentJson.ReadFrom(ResponseContentText);
        exit(ResponseContentJson);
    end;

    /// <summary>
    /// Gets the response reason phrase
    /// </summary>
    procedure GetResponseReasonPhrase(): Text
    begin
        exit(Res.ReasonPhrase());
    end;

    /// <summary>
    /// Gets the HTTP status code
    /// </summary>
    procedure GetHttpStatusCode(): Integer
    begin
        exit(Res.HttpStatusCode());
    end;

    /// <summary>
    /// Intercepts the request before it is sent
    /// </summary>
    [IntegrationEvent(true, false)]
    local procedure OnBeforeSend(var WebRequest: HttpRequestMessage; var WebResponse: HttpResponseMessage)
    begin
    end;

    /// <summary>
    /// Intercepts the request after it is sent
    /// </summary>
    [IntegrationEvent(true, false)]
    local procedure OnAfterSend(var WebRequest: HttpRequestMessage; var WebResponse: HttpResponseMessage)
    begin
    end;

    var
        Client: HttpClient;
        Req: HttpRequestMessage;
        Res: HttpResponseMessage;
        WebRequestHeaders: HttpHeaders;
        WebContentHeaders: HttpHeaders;
        WebContent: HttpContent;
        CurrentContentType: Text;
        RestHeaders: TextBuilder;
        ContentTypeSet: Boolean;
}
