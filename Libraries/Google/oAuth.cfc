component{
    Config = CreateObject("Config");
    this.client_id     = Config.Google.ClientID;
    this.client_secret = Config.Google.ClientSecret;
    this.redirect_uri  = Config.BaseWebURL & "/" & Config.Google.AuthEndPoint;

    public function getAuthorizationUrl(){
        auth_url = "https://accounts.google.com/o/oauth2/v2/auth?scope=openid%20email%20profile" 
            & "&redirect_uri=" & this.redirect_uri 
            & "&client_id=" & this.client_id 
            & "&response_type=code";
        return auth_url;
    }

    public function getAuthorizationToken(code){
        token_url = "https://www.googleapis.com/oauth2/v4/token";
        
        httpService = new http();
        httpService
            .setMethod("POST")
            .setCharset("utf-8")
            .setUrl(token_url)
            .setResolveUrl("Yes");
        httpService
            .addParam(
                type="formfield",
                name="code",
                value=code
            );
        httpService
            .addParam(
                type="formfield",
                name="client_id",
                value=this.client_id
            );
        httpService
            .addParam(
                type="formfield",
                name="client_secret",
                value=this.client_secret
            );
        httpService
            .addParam(
                type="formfield",
                name="redirect_uri",
                value=this.redirect_uri
            );
        httpService
            .addParam(
                type="formfield",
                name="grant_type",
                value="authorization_code"
            );

        try{
            result = [];
            response = httpService.send().getPrefix().FileContent;
            result = deSerializeJSON(response);
        } catch(any e) {
            result = "Failed to parse response.";
        }
        return result;
    }

    public function getTokenInfo(id_token){
        token_url = "https://www.googleapis.com/oauth2/v3/tokeninfo";
        httpService = new http();
        httpService
            .setMethod("POST")
            .setCharset("utf-8")
            .setUrl(token_url)
            .setResolveUrl("Yes");
        httpService
            .addParam(
                type="formfield",
                name="id_token",
                value=id_token
            );
        try{
            response = httpService.send().getPrefix().FileContent;
            result = deSerializeJSON(response);
            if(isStruct(result) && result.aud eq this.client_id){
                return result;
            }else{
                result = "Client ID does not match.";
            }
        } catch(any e) {
            result = "Failed to parse response.";
        }
        return result;
    }
}