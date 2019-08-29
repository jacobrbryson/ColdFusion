<cfscript>
	Config = CreateObject("Config");
	//    Initialize javascript array to be 
	//    appended to the footer dynamically.
	JavaScript = [];
</cfscript>
<cfinclude template="views/layout/header.cfm"/>
<body>
	<cfinclude template="views/layout/nav.cfm"/>

	<!--- Set the body content --->
	<cfif IsDefined("URL.home")>
		<cfinclude template="views/home/index.cfm"/>
	<cfelseif IsDefined("URL.about")>
		<cfinclude template="views/about/index.cfm"/>
	<cfelseif IsDefined("URL.news")>
		<cfinclude template="views/news/index.cfm"/>
	<cfelse>
		<cflocation url="?home" addToken="false"/>
	</cfif>
	<!--- End set body content --->
	
	<cfinclude template="views/layout/footer.cfm"/>
</body>