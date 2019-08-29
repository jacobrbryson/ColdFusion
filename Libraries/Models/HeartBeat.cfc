component{
    this.ID   = 0;
    this.User = CreateObject("User");
    this.Tick = now();

    public HeartBeat function setID(Required Numeric ID){
        this.ID = ID;
        return this;
    }
    public HeartBeat function setTick(Required Date Tick){
        this.Tick = Tick;
        return this;
    }
}