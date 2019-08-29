<cfscript>
    Config = CreateObject("Config");
    loc = Config.BaseWebURL;
    if(isDefined("url.code") and len(url.code) gt 0){
        authCode = decodefromURL(url.code);
        googleAuthorization = CreateObject("Libraries.Google.oAuth");
        token = googleAuthorization.getAuthorizationToken(authCode);

        if(isStruct(token) && isDefined("token.id_token")){
            info = googleAuthorization.getTokenInfo(token.id_token);
            if(isStruct(info) && isDefined("info.sub")){
                UserController = CreateObject("Libraries.Controllers.User");
                User = CreateObject("Libraries.Models.User");
                User.setGoogleID(info.sub)
                    .setEmail(info.Email)
                    .setFirstName(info.given_name)
                    .setLastName(info.family_name)
                    .setAvatar(info.picture);

                User = UserController.Login(User);
                
                if(User.ID neq 0){
                    if(User.IsEnabled){
                        Session.User = User;
                        //Send the user where they wanted to go.
                        loc = Config.BaseWebURL & (isDefined("Session.target") ? Session.target : "");
                    }else{
                        Session.Login.Error = "User account locked.";
                    }
                }else{
                    Session.Login.Error = "Unable to login at this time.";
                }
            }
        }
    }
</cfscript>
<cflocation url="#loc#" addtoken="false">