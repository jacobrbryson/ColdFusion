component {
	Config = CreateObject("setup.Config");

    function OnApplicationStart() {
	    return true;
	}

    function OnSessionStart() {
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
	}
}