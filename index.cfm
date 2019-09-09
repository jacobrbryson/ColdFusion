<cfscript>
	Config = CreateObject("Config");
	//    Initialize javascript array to be 
	//    appended to the footer dynamically.
	JavaScript = [];
	ArrayAppend(JavaScript, "<script src='web/js/site.js'></script>");
</cfscript>
<cfinclude template="views/layout/header.cfm"/>
<body>
	<cfinclude template="views/layout/nav.cfm"/>
	<main role="main" class="container-fluid py-5">
		<cfif DirectoryExists(GetDirectoryFromPath(GetCurrentTemplatePath()) & "setup")>
			<div class="row pt-5">
				<div class="col-12">
					<div class="alert alert-danger alert-dismissible text-center">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<a href="/setup" title="Complete Setup">Setup</a> has not been completed for this site.
					</div>
				</div>
			</div>
		</cfif>
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
	</main>
</body>