component{
    this.ID             = 0;
    this.Created        = now();
    this.UUID           = "";
    this.GoogleID       = "";
    this.FirstName      = "";
    this.LastName       = "";
    this.MiddleName     = "";
    this.Avatar         = "";
    this.Birthday       = "";
    this.Phone          = "";
    this.Email          = "";
    this.IsEnabled      = true;
    this.Role           = CreateObject("Role");

    public User function setID(Required Numeric ID){
        this.ID = ID;
        return this;
    }
    public User function setCreated(Required Date Created){
        this.Created = Created;
        return this;
    }
    public User function setUUID(Required String UUID){
        this.UUID = UUID;
        return this;
    }
    public User function setGoogleID(Required String GoogleID){
        this.GoogleID = GoogleID;
        return this;
    }
    public User function setFirstName(Required String FirstName){
        this.FirstName = FirstName;
        return this;
    }
    public User function setLastName(Required String LastName){
        this.LastName = LastName;
        return this;
    }
    public User function setMiddleName(Required String MiddleName){
        this.MiddleName = MiddleName;
        return this;
    }
    public User function setAvatar(Required String Avatar){
        this.Avatar = Avatar;
        return this;
    }
    public User function setBirthday(Required String Birthday){
        this.Birthday = IsDate(Birthday) ? DateFormat(Birthday, "yyyy-mm-dd") : "";
        return this;
    }
    public User function setPhone(Required String Phone){
        this.Phone = Phone;
        return this;
    }
    public User function setEmail(Required String Email){
        this.Email = Email;
        return this;
    }
    public User function setIsEnabled(Required Boolean IsEnabled){
        this.IsEnabled = IsEnabled;
        return this;
    }
}