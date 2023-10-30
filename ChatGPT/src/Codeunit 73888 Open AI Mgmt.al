codeunit 73888 "Open AI Mgmt."
{
    procedure GetResponseFromChatGPT(Input: Text; var Response: Text)
    var
        Clinet: HttpClient;
        Content: HttpContent;
        RequestMsg: HttpRequestMessage;
        ResponseMsg: HttpResponseMessage;
        ContentText, OutputString : Text;
    begin
        OpenAISetup.Get();
        Content.Clear();

        SetChatGPTBody(Input, ContentText);
        Content.WriteFrom(ContentText);
        SetChatGptHeader(Content, RequestMsg);

        if not Clinet.Send(RequestMsg, ResponseMsg) then
            Error('Error Sending Request %1', ResponseMsg.HttpStatusCode);

        ResponseMsg.Content.ReadAs(OutputString);

        if ResponseMsg.IsSuccessStatusCode then
            Response := ParseChatGPTResponseText(OutputString)
        else
            Error('%1', OutputString);
    end;

    local procedure SetChatGPTBody(Input: Text; var ContentText: Text)
    var
        ChatGPTBody: JsonObject;
        ChatGPTBodyArray: JsonArray;
    begin
        ChatGPTBody.Add('model', Format(OpenAISetup.Model));
        ChatGPTBody.Add('messages', GetChatGPTMessageArray(Input));

        ChatGPTBody.WriteTo(ContentText);
    end;

    local procedure SetChatGptHeader(var Content: HttpContent; var RequestMsg: HttpRequestMessage)
    var
        Headers: HttpHeaders;
    begin
        Content.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/json');
        RequestMsg.GetHeaders(Headers);
        Headers.Add('Authorization', 'Bearer ' + OpenAISetup."Secret Key");

        RequestMsg.Content(Content);
        RequestMsg.SetRequestUri('https://api.openai.com/v1/chat/completions');

        RequestMsg.Method := 'POST';
    end;

    local procedure GetChatGPTMessageArray(Input: Text) InputArray: JsonArray
    var
        InputJsonObject: JsonObject;
    begin
        InputJsonObject.Add('role', 'system');
        InputJsonObject.Add('content', Input);
        InputArray.Add(InputJsonObject);
    end;

    local procedure ParseChatGPTResponseText(OutputString: Text): Text
    var
        JsonObjectResponse: JsonObject;
        JsonTokenResponse: JsonToken;
        JsonArrayResponse: JsonArray;
    begin
        JsonObjectResponse.ReadFrom(OutputString);
        if JsonObjectResponse.Get('choices', JsonTokenResponse) then begin
            JsonArrayResponse := JsonTokenResponse.AsArray();
            JsonArrayResponse.Get(0, JsonTokenResponse);
            JsonObjectResponse := JsonTokenResponse.AsObject();
            JsonObjectResponse.Get('message', JsonTokenResponse);
            JsonObjectResponse := JsonTokenResponse.AsObject();
            JsonObjectResponse.Get('content', JsonTokenResponse);
            exit(JsonTokenResponse.AsValue().AsText());
        end;
    end;

    var
        OpenAISetup: Record "Open AI Setup";
}
