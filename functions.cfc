component{
    Config = CreateObject("Config");
    remote any function sampleRequest() returnformat="JSON" {
        try{
            return "Successful Test";
        }catch(any e){
            return e.message;
        }
    }
}