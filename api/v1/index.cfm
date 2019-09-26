<cfscript>
    Config = CreateObject("Config");
    response.result = 1;

    payload.version = Config.Version;
    response.payload = payload;
    writeoutput(SerializeJSON(response));
</cfscript>