<cfscript>
    UserController = CreateObject("Libraries.Controllers.User");
    Users = UserController.getByURL();
</cfscript>
<cfif Users.recordcount gt 0>
    <table id="report" class="datatable table table-striped table-hover table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>Created</th>
                <th>Name</th>
                <th>Email</th>
            </tr>
        </thead>
        <tbody>
            <cfoutput>
                <cfloop query="Users">
                    <tr data-href="?user&id=#ID#">
                        <td>
                            <span class="d-none">#Created#</span>
                            #DateTimeFormat(Created,"m/d/yy HH:nn")#
                        </td>
                        <td>
                            #FirstName# #LastName#
                        </td>
                        <td>
                            #Email#
                        </td>
                    </tr>
                </cfloop>
            </cfoutput>
        </tbody>
    </table>
<cfelse>
    <div class="alert alert-danger mt-3 bg-white"><i class="fas fa-exclamation-circle mr-2"></i> No results found.</div>
</cfif>