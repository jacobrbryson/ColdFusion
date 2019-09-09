<cfscript>
	Config = CreateObject("setup.config");
    JavaScript = [];
    ArrayAppend(JavaScript, "<script src='web/js/setup.js'></script>");
    //Test root writeable...
    Writable = false;
    WritableMessage = "<i class='fas fa-exclamation-triangle mr-3'></i>Unable to write to root. ";
    try{
        fileWrite(expandPath("../_temp.cfm"), "Here's some content for my file.");
        fileDelete(expandPath("../_temp.cfm"));
        Writable = true;
        WritableMessage = "<i class='far fa-check-circle mr-3'></i>Root directory is writable.";
    }catch(any e){
        WritableMessage &= e.message & ". ";
        WritableMessage &= "You will need to manually upload your own Config.cfc file and remove setup files.";
    }
</cfscript>
<cfoutput>
<cfinclude template="/views/layout/header.cfm"/>
<cfinclude template="/views/layout/nav.cfm"/>
    <body>
        <div class="container-fluid pt-2">
            <div class="row py-5">
                <div class="col-12 col-sm-6 pt-3">
                    <cfinclude template="about/index.cfm"/>
                </div>
                <div class="col-12 col-sm-6 pt-3">
                    <cfinclude template="system/index.cfm"/>
                </div>
                <div class="col-12 pt-3">
                    <div class="text-center alert alert-#Writable ? "success" : "danger"#" role="alert">
                        #WritableMessage#
                    </div>
                </div>
                <div class="col-12 pt-3 pb-5">
                    <cfinclude template="build/index.cfm"/>
                </div>
            </div>
            <cfinclude template="/views/layout/footer.cfm"/>
        </div>
    </body>
</cfoutput>