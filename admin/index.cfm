<cfscript>
  	Config = CreateObject("Config");
</cfscript>
<cfinclude template="views/layout/header.cfm"/>
<body>
	<cfinclude template="views/layout/nav.cfm"/>
	<cfinclude template="views/dashboard/index.cfm"/>
	<cfinclude template="views/layout/footer.cfm"/>
</body>