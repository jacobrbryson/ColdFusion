<cfscript>
    ID = isDefined("URL.ID") && isNumeric(URL.ID) && (round(URL.ID) eq URL.ID) ? URL.ID : 0;
    UserController = CreateObject("Libraries.Controllers.User");
    User = UserController.getUser(['ID'],[ID]);
</cfscript>
<cfoutput>
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center border-bottom my-1">
        <h3 class="py-2">
            #User.FirstName# #User.LastName#
        </h3>
        <div class="d-flex justify-content-end align-items-right"></div>
    </div>
</cfoutput>