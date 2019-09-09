<cfscript>
	Config = CreateObject("Config");
	//    Initialize javascript array to be 
	//    appended to the footer dynamically.
	JavaScript = [];
	ArrayAppend(JavaScript, "<script src='/web/js/site.js'></script>");
</cfscript>
<cfinclude template="/views/layout/header.cfm"/>
<body>
	<cfinclude template="/views/layout/nav.cfm"/>
	<main role="main" class="container-fluid py-5">
		<!--- Set the body content --->
		<cfif IsDefined("URL.dashboard")>
			<cfinclude template="views/dashboard/index.cfm"/>
		<cfelse>
			<cflocation url="?dashboard" addToken="false"/>
		</cfif>
		<!--- End set body content --->
		
		<cfinclude template="/views/layout/footer.cfm"/>
	</main>
</body>