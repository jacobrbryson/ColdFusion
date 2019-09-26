component{
    this.ID         = 0;
    this.Created    = now();
    this.EndPointURL = "";
    this.IsEnabled  = false;

    public EndPoint function setID(Required Numeric ID){
        this.ID = ID;
        return this;
    }
    public EndPoint function setCreated(Required Date Created){
        this.Created = Created;
        return this;
    }
    public EndPoint function setEndPointURL(Required String EndPointURL){
        this.EndPointURL = EndPointURL;
        return this;
    }
    public EndPoint function setIsEnabled(Required Boolean IsEnabled){
        this.IsEnabled = IsEnabled;
        return this;
    }
}