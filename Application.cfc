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
	    return true;
    }

	function OnRequestStart(String TargetPage){
		Setting showdebugoutput=false;

		/* Check for SSL */		
		if (not CGI.server_port_secure) {
			/* Redirect to SSL */				
			Location(url="https://#CGI.server_name##CGI.script_name#",addtoken="false");
		}

		if(StructKeyExists(URL,'reload')){
			StructClear(Session);
			SessionInvalidate();
			OnApplicationStart();
			OnSessionStart();
			Location(url=".",addtoken="false");
		}
	}

	function OnRequest(String TargetPage){ 
		return true;
	}
}