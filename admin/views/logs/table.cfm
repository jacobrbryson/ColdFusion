<cfscript>
    LogController = CreateObject("Libraries.Controllers.Log");
    Logs = LogController.getByURL();
</cfscript>
<cfif Logs.recordcount gt 0>
    <table id="report" class="datatable table table-striped table-hover table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>Date</th>
                <th>Type</th>
                <th>Email</th>
                <th>Name</th>
                <th>IPv4</th>
                <th>Note</th>
            </tr>
        </thead>
        <tbody>
            <cfoutput>
                <cfloop query="Logs">
                    <tr<cfif LogTypeID eq 2> class="text-danger font-weight-bold"</cfif><cfif TargetURL neq ""> data-href="#TargetURL#&id=#TargetID#"</cfif>>
                        <td>
                            <span class="d-none">#Created#</span>
                            #DateTimeFormat(Created,"m/d/yy HH:nn")#
                        </td>
                        <td>
                            #LogAction#
                        </td>
                        <td>
                            <cfif UserID neq "">#Email#<cfelse>do-not-reply@brysontech.com</cfif>
                        </td>
                        <td>
                            <cfif UserID neq "">#FirstName# #LastName#<cfelse>System</cfif>
                        </td>
                        <td>
                            <cfif UserID neq "">#IPv4#<cfelse>127.0.0.1</cfif>
                        </td>
                        <td>
                            #encodeforhtml(Note)#
                        </td>
                    </tr>
                </cfloop>
            </cfoutput>
        </tbody>
    </table>
<cfelse>
    <div class="alert alert-danger mt-3 bg-white"><i class="fas fa-exclamation-circle mr-2"></i> No results found.</div>
</cfif>