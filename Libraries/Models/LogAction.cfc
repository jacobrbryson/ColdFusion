component{
    this.ID         = 0;
    this.Name       = "";
    this.LogType    = CreateObject("LogType");
    this.TargetURL  = "";

    public LogAction function setID(Required Numeric ID){
        this.ID = ID;
        return this;
    }
    public LogAction function setName(Required String Name){
        this.Name = Name;
        return this;
    }
    public LogAction function setTargetURL(Required String TargetURL){
        this.TargetURL = TargetURL;
        return this;
    }
}