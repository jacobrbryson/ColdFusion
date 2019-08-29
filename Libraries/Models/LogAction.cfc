component{
    this.ID         = 0;
    this.Name       = "";
    this.LogType    = CreateObject("LogType");
    this.TargetURL  = "";

    public LogType function setID(Required Numeric ID){
        this.ID = ID;
        return this;
    }
    public LogType function setName(Required String Name){
        this.Name = Name;
        return this;
    }
    public LogType function setTargetURL(Required String TargetURL){
        this.TargetURL = TargetURL;
        return this;
    }
}