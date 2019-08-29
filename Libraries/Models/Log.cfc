component{
    this.ID         = 0;
    this.Created    = now();
    this.IPv4       = CGI.REMOTE_ADDR;
    this.User       = CreateObject("User");
    this.Type       = CreateObject("LogType");
    this.TargetID   = 0;
    this.Note       = "";

    public Log function setID(Required Numeric ID){
        this.ID = ID;
        return this;
    }
    public Log function setCreated(Required Datetime Created){
        this.Created = Created;
        return this;
    }
    public Log function setTargetID(Required Numeric TargetID){
        this.TargetID = TargetID;
        return this;
    }
    public Log function setNote(Required String Note){
        this.Note = Note;
        return this;
    }
}