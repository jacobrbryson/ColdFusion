<cfoutput>
	<cfinclude template="nav_right.cfm"/>
	<header>
		<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark shadow">
			<a class="navbar-brand nav-link mr-auto" href="#Config.BaseWebURL#">
				&nbsp;#Config.Name#
			</a>
			<div class="sidemenu-toggle ml-auto">
				<cfif isDefined("Session.User.Avatar") and Session.User.Avatar neq "">
					<img src="#Session.User.Avatar#" class="rounded-circle logo-small">
				<cfelse>
					<span class="logo-small">
						<i class="fas fa-2x fa-user-circle text-muted"  data-fa-transform="down-4"></i>
					</span>
				</cfif>
			</div>		
		</nav>
	</header>
</cfoutput>