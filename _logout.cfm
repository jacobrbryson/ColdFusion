<cfscript>
    Config = CreateObject("Config");
    
    if(isDefined("Session.User")){
        LogController = CreateObject("Libraries.Controllers.Log");
        Log = CreateObject("Libraries.Models.Log");
        Log.User.setID(Session.User.ID);
        Log.Action.setID(2);//Logged out.
        Log.setTargetID(Session.User.ID)
            .setNote(Session.User.FirstName & " " & Session.User.LastName);
        LogController.addLog(Log);
    }

    StructClear(Session);
    location(url=Config.BaseWebURL, addtoken="no");
</cfscript>