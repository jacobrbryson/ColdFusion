component {
	Config = CreateObject("Config");
    AuthController = CreateObject("Libraries.API.Controllers.Auth");
    this.Name               = Config.Name;
	this.DataSource         = Config.DataSource;

    function onApplicationStart() {
	    return true;
    }
 	
	function onRequestStart(string targetPage){
		setting showdebugoutput=false;

        /* Authorize */
        ValidAuthorization = AuthController.Authorize();

		response.result = 0;

        if(!ValidAuthorization){
			response.message = "Unauthorized";
    		writeoutput(SerializeJSON(response));
            abort;
        }
	}
}