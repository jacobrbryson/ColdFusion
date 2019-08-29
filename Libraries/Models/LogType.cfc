component{
    this.ID     = 0;
    this.Name   = "";

    public LogType function setID(Required Numeric ID){
        this.ID = ID;
        return this;
    }
    public LogType function setName(Required String Name){
        this.Name = Name;
        return this;
    }
}