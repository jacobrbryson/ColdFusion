component extends="Base.Auth"{
    public function Authorize(){
        try{
            Log = CreateObject("Libraries.Models.Log"); //Getting log ready to add if something goes wrong.
            HttpRequest = getHttpRequestData()
            HeaderData = HttpRequest.Headers;
            Authorization = HeaderData.Authorization;
            Secret = HeaderData.Secret;
            Authorization = ToString(ToBinary(Right(Authorization, Len(Authorization) - 6)));//removes 'Basic '
            if(isValid('uuid', Authorization)){//Should prevent some jerkface from messing with the DB...
                APIUserController = CreateObject("Libraries.API.Controllers.APIUser");
                APIUser = APIUserController.GetObject(['APIAuthorization'],[Authorization]);
                if(APIUser.ID neq 0){//User found and is enabled.
                    if(APIUser.IsEnabled){
                        if(Decrypt(Secret, APIUser.EncryptionKey, 'AES') eq APIUser.SecretKey){
                            Target = reReplaceNoCase(cgi.SCRIPT_NAME, "/index.cfm", ""); //Removes '/index.cfm'
                            EndPointController = CreateObject("Libraries.API.Controllers.EndPoint");
                            EndPoint = EndPointController.GetObject(['EndPointURL'],[Target]);
                            if(Endpoint.ID neq 0){
                                if(EndPoint.IsEnabled){
                                    if(Config.API.Request.Logging neq false){//Logging is disabled
                                        RequestLogController = CreateObject("Libraries.API.Controllers.RequestLog");
                                        RequestLog = CreateObject("Libraries.API.Models.RequestLog");
                                        RequestLog.APIUser.setID(APIUser.ID);
                                        RequestLog.EndPoint.setID(EndPoint.ID);
                                        if(ArrayContains(["POST","PUT","PATCH"],cgi.request_method)){
                                            try{
                                                RequestLog.setData(Left(HttpRequest.Content, 5000));
                                            }catch(any e){
                                                Log.Action.setID(3);
                                                Log.setNote(e.message & " (Possibly Empty Content)");
                                                LogController.Add(Log);
                                            }
                                        }
                                        RequestLog.setMethod(cgi.request_method);
                                        RequestLogController.Add(RequestLog);
                                    }
                                    return true;
                                }else{
                                    Log.Action.setID(3);
                                    Log.setNote(Target)
                                    Log.setTargetID(EndPoint.ID);
                                }
                            }else{
                                Log.Action.setID(3);
                                Log.setNote(Target)
                                Log.setTargetID(APIUser.ID);
                            }
                        }else{
                            Log.Action.setID(3);
                            Log.setNote(Decrypt(Secret, APIUser.EncryptionKey, 'AES'))
                            Log.setTargetID(APIUser.ID);
                        }
                    }else{
                        Log.Action.setID(3);
                        Log.setNote(APIUser.Name);
                        Log.setTargetID(APIUser.ID);
                    }
                }else{
                    Log.Action.setID(3);
                    Log.setNote("User Authorization: " & Authorization);
                }
            }else{
                Log.Action.setID(3);
                Log.setNote("Basic " & Authorization);
            }
        }catch(any e){
            Log.Action.setID(3);
            Log.setNote(e.message);
        }

        //If we ever get here, something went wrong and it should be logged.
        LogController.Add(Log);
        return false;
    }
}