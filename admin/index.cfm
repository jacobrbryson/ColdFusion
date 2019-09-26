<cfscript>
	Config = CreateObject("Config");
	JavaScript = [];
	ArrayAppend(JavaScript, "<script src='/web/js/site.js'></script>");
</cfscript>
<cfinclude template="/views/layout/header.cfm"/>
<body>
	<cfinclude template="/views/layout/nav.cfm"/>
	<main class="main container">
		<cfif IsDefined("URL.dashboard")>
			<cfinclude template="views/dashboard/index.cfm"/>
			<cfscript>ArrayAppend(JavaScript, "<script src='web/js/dashboard.js'></script>");</cfscript>
		<cfelseif IsDefined("URL.users")>
			<cfinclude template="views/users/index.cfm"/>
			<cfscript>ArrayAppend(JavaScript, "<script src='web/js/users.js'></script>");</cfscript>
		<cfelseif IsDefined("URL.logs")>
			<cfinclude template="views/logs/index.cfm"/>
			<cfscript>ArrayAppend(JavaScript, "<script src='web/js/logs.js'></script>");</cfscript>
		<cfelse>
			<cflocation url="?dashboard" addtoken="false"/>
		</cfif>
	</main>
	<cfinclude template="/views/layout/footer.cfm"/>
</body>