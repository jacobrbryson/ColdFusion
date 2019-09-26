component{
    this.ID         = 0;
    this.Created    = now();
    this.IPv4       = CGI.REMOTE_ADDR;
    this.APIUser    = CreateObject("APIUser");
    this.EndPoint   = CreateObject("EndPoint");
    this.Method     = "";
    this.Data       = "";

    public RequestLog function setID(Required Numeric ID){
        this.ID = ID;
        return this;
    }
    public RequestLog function setCreated(Required Date Created){
        this.Created = Created;
        return this;
    }
    public RequestLog function setIPv4(Required String IPv4){
        this.IPv4 = IPv4;
        return this;
    }
    public RequestLog function setMethod(Required String Method){
        this.Method = Method;
        return this;
    }
    public RequestLog function setData(Required String Data){
        this.Data = Data;
        return this;
    }
}