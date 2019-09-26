<cfscript>
    try{
        //User = Content;
        //HeartbeatController = CreateObject("Libraries.MyLSR7.Controllers.Heartbeat");
        //Heartbeat = HeartbeatController.saveHeartbeat(User);
        //response.result = 1;
        //response.message = "Heartbeat saved.";
        //response.payload = Heartbeat;
        Response.Message = "Hello";
    }catch(any e){
        //Log = CreateObject("Libraries.API.Models.Log");
        //Log.Type.setID(18);
        //Log.setNote(e.message);//error happening here...
        //LogController.addLog(Log);
        Response.Message = "API Login Failed: " & e.queryError;
    }

    writeoutput(SerializeJSON(response));
</cfscript>