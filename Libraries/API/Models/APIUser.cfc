component{
    this.ID                 = 0;
    this.Name               = "";
    this.SecretKey          = "";
    this.APIAuthorization   = "";
    this.EncryptionKey      = "";
    this.IsEnabled          = false;

    public APIUser function setID(Required Numeric ID){
        this.ID = ID;
        return this;
    }
    public APIUser function setName(Required String Name){
        this.Name = Name;
        return this;
    }
    public APIUser function setSecretKey(Required String SecretKey){
        this.SecretKey = SecretKey;
        return this;
    }
    public APIUser function setAPIAuthorization(Required String APIAuthorization){
        this.APIAuthorization = APIAuthorization;
        return this;
    }
    public APIUser function setEncryptionKey(Required String EncryptionKey){
        this.EncryptionKey = EncryptionKey;
        return this;
    }
    public APIUser function setIsEnabled(Required Boolean IsEnabled){
        this.IsEnabled = IsEnabled;
        return this;
    }
}