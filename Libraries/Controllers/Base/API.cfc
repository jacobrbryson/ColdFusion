component extends="_BaseController"{
    public function Ping(){
        return processRequest(
            Config.API.BaseWebURL & "/v1"
        );
    }

    private function processRequest(EndPoint, METHOD="GET", data=[]){
        httpService = new http();

        httpService
            .setMethod(METHOD)
            .setCharset("utf-8")
            .setUrl(EndPoint & "/index.cfm");

        httpService
            .addParam(
                type="header",
                name="Authorization",
                value="Basic " & ToBase64(Config.API.AuthorizationKey)
            );

        httpService
            .addParam(
                type="header",
                name="Secret",
                value=Encrypt(Config.API.SecretKey, Config.API.EncryptionKey, 'AES')
            );

        if(METHOD eq "POST" || METHOD eq "PUT"){
            httpService.addParam(
                type="header",
                name="content-type",
                value="application/json; charset=utf-8"
            );
            httpService.addParam(
                type="body",
                value=SerializeJSON(data)
            );
        }

        try{
            return httpService.send().getPrefix().Filecontent;

            if(serialized.result){
                return serialized.payload;
            }else{
                Session.API.IsEnabled = false;//On error kill the API (application fails over to local libs)
                Log = CreateObject("Libraries.Models.Log");
                Log.Action.setID(3);
                Log.setNote(serialized.message);
                LogController.Add(Log);
            }
        }catch(any e){
            Session.API.IsEnabled = false;//On error kill the API (application fails over to local libs)
            Log = CreateObject("Libraries.Models.Log");
            Log.Action.setID(3);
            Log.setNote(e.message);
            LogController.Add(Log);
        }
    }
}