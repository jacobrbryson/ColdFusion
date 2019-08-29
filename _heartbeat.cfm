<cfscript>
    try{
        HeartBeatController = CreateObject("Libraries.Controllers.HeartBeat");
        HeartBeatController.addUpdateHeartBeat(Session.User);
    }
</cfscript>