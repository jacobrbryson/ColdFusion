<cfscript>
    if(CGI.request_method eq "POST" && CSRFverifyToken(FORM._csrf_token)){
        Content =   "component{";
        Content &=  "
    this.IsProd        = false;";
        Content &=  "
    this.Version       = 'v1';";
        Content &=  "
    this.Name          = '" & FORM._name & "';";
        Content &=  "
    this.DataSource    = '" & (IsDefined("FORM._datasource") && Trim(FORM._datasource) neq "" ? FORM._datasource : "") & "';";
        Content &=  "
    this.BaseWebURL    = '" & FORM._baseweburl & "';";
        Content &=  "
    this.AssetsURL     = '" & FORM._assetsurl & "';";
        Content &=  "
    this.Theme.Color   = '##" & FORM._theme & "';";

        Content &=  "
        
    this.SessionManagement      = " & IsDefined("FORM._session_management") & ";";
        Content &=  "
    this.ApplicationTimeout     = " & (IsDefined("FORM._app_timeout") && IsNumeric(FORM._app_timeout) ? 'CreateTimeSpan(0, 0, ' & FORM._app_timeout & ', 0);' : 'CreateTimeSpan(30, 0, 0, 0); //30 days');
        Content &=  "
    this.ApplicationTimeout     = " & (IsDefined("FORM._app_timeout") && IsNumeric(FORM._session_timeout) ? 'CreateTimeSpan(0, 0, ' & FORM._session_timeout & ', 0);' : 'CreateTimeSpan(7, 0, 0, 0); //7 days');
        Content &=  "
    this.SessionCreated         = DateTimeFormat(now(),'yyyy-mm-dd HH:nn:ss');";

        Content &=  "
    this.Google.IsEnabled       = " & IsDefined("FORM._google_auth") & ";";
        Content &=  "
    this.Google.ClientID        = '" & (IsDefined("FORM._google_client_id") ? FORM._google_client_id : '<GOOGLE CLIENT_ID>') & "';";
        Content &=  "
    this.Google.ClientSecret    = '" & (IsDefined("FORM._google_client_id_secret") ? FORM._google_client_id_secret : '<GOOGLE CLIENT_ID>') & "';";
        Content &=  "
    this.Google.AuthEndPoint    = '_auth.cfm';";
        Content &=  "
}";

        temp = getTempFile(getTempDirectory(), "config.tmp");
        Writable = false;
        try{
            fileWrite(temp, Content);
        }catch(any e){
            writeoutput("Unable to write to temp directory.<br/>");
            //Error --- unable to write  to temp directory
        }
        
        try{
            FileCopy(temp, expandPath("/Config.cfc"));
            Writable = true;
        }catch(any e){
            cfzip(action="zip", file=temp & ".zip", source=temp);
            writeoutput(e.message);
            writeoutput("Failed to write to" & expandPath("/Config.cfc") & "<br/>");
        }
        
        writeoutput(expandPath("/setup"));
        //Do database stuff
        if(IsDefined("FORM._datasource") && Trim(FORM._datasource) neq "" && FORM._database_type neq 0){
            sqlString = FileRead(expandPath("/setup/create_" & (FORM._database_type eq 1 ? "mssql" : "mysql") & ".sql"));
            query = new Query();
            query.setDataSource(FORM._datasource);
            query.setSQL(sqlString);
            query.execute();
        }

        if(Writable){
            //delete setup files
            DirectoryDelete(expandPath("/setup"), true);
            location(url="/", addtoken="false");
        }
    }
</cfscript>
<cfif !Writable>
    <cfheader name="Content-Disposition" value="attachment; filename=Config.cfc">
    <cfcontent type="application/cfc" file=#temp#> 
</cfif>