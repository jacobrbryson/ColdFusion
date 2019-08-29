component{
    this.ID   = 99;
    this.Name = "Default";

    public Role function setID(Required Numeric ID){
        this.ID = ID;
        return this;
    }
    public Role function setName(Required String Name){
        this.Name = Name;
        return this;
    }
}