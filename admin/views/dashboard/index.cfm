<cfscript>
    APIController = CreateObject("Libraries.Controllers.API");
    Ping = APIController.Ping();
</cfscript>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center border-bottom my-1">
    <h3 class="py-2">
        Dashboard
    </h3>
    <div class="d-flex justify-content-end align-items-right">
    </div>
</div>
<cfdump var="#Ping#"/>