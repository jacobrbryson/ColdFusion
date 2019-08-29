<cfoutput>
    <div class="sidenav shadow d-print-none">
        <a class="closebtn sidemenu-toggle">
            &times;
        </a>
        <cfif isDefined("Session.User") && Session.User.Avatar neq "">
            <img src="#Session.User.Avatar#" class="rounded-circle mx-auto d-block mb-2 w-50">
        <cfelse>
            <i class="fas fa-5x fa-user-circle text-white rounded-circle mx-auto d-block mb-2 text-center w-100"></i>
        </cfif>
        <cfif isDefined("Session.User") && Session.User.ID neq 0>
            <h4 class="text-center text-white my-4 mylsr7_title">
                #Session.User.FirstName & " " & Session.User.LastName#
            </h4>
        </cfif>
        <hr class=" my-4 border border-light mx-3"/>
        <div class="w-100">
            <cfif isDefined("Session.User") && Session.User.ID neq 0>
                <a class="btn btn-dark w-100 rounded-0" href="/app">
                    <i class="fas fa-running mr-2"></i>#Config.Name#
                </a>
                <cfif Session.User.Role.ID lte 2>
                    <a class="btn btn-dark w-100 rounded-0" href="/admin">
                        <i class="fas fa-tools mr-2"></i>Admin
                    </a>
                </cfif>
                <a class="btn btn-dark w-100 rounded-0" href="/_logout.cfm">
                    <i class="fas fa-lock mr-2"></i>Logout
                </a>
            <cfelse>
                <a class="btn btn-dark w-100 rounded-0" href="/_login.cfm">
                    <i class="fab fa-google mr-2"></i>Login
                </a>
            </cfif>
        </div>           
    </div>
</cfoutput>