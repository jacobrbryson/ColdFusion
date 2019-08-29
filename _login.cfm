<cfscript>
    GoogleAuthorization = CreateObject("Libraries.Google.oAuth");
    auth_url = GoogleAuthorization.getAuthorizationUrl();
    location(url="#auth_url#",addtoken="false");
</cfscript>