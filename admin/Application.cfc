component {
	Config = CreateObject("Config");

    this.SessionManagement  = Config.SessionManagement;
    this.Name               = Config.Name;
	this.DataSource         = Config.DataSource;
    this.ApplicationTimeout = Config.ApplicationTimeout;
    this.SessionTimeout     = Config.SessionTimeout;

    function OnApplicationStart() {
	    return true;
	}

    function OnSessionStart() {
		Session.Target 				 = "";
	    return true;
    }

	function OnRequestStart(String TargetPage){
		Setting showdebugoutput=false;

		if(StructKeyExists(URL,'reload')){
			StructClear(Session);
			SessionInvalidate();
			OnApplicationStart();
			OnSessionStart();
			Location(url=".",addtoken="false");
		}

		/* ******************************************** */
		/*             Manage Authentication            */
		/* All requests must have a Session.User object */
		/* ******************************************** */
        if(!IsDefined("Session.User") || Session.User.Role.ID gt 2){
			Session.Login.Error = "Please login to continue";
			Session.target 		= ReReplaceNoCase(CGI.SCRIPT_NAME, "/index.cfm", "") & (CGI.query_string neq "" ? "?" & CGI.query_string : "");
			Location(url=Config.BaseWebURL & "/login", addtoken="false");
        }
	}
}