component extends="Base.User"{
    public User function Login(User User){
        LocalUser = GetObject(['GoogleID'],[User.GoogleID]);

        if(LocalUser.ID eq 0){
            User = Add(User);
        }else{
            LocalUser
                .setFirstName(User.FirstName)
                .setLastName(User.LastName)
                .setEmail(User.Email)
                .setAvatar(User.Avatar);

            User = Update(LocalUser);//If user is found sync their Google data...
        }

        //Now log all this
        LogController = CreateObject("Libraries.Controllers.Log");
        Log = CreateObject("Libraries.Models.Log");
        Log.User.setID(User.ID);
        Log.Action.setID(1);//Logged in.
        Log.setTargetID(User.ID)
            .setNote(User.FirstName & " " & User.LastName);
        LogController.Add(Log);

        return User;
    }

    public function saveUser(a){
        ID = isDefined("a._id") && isNumeric(a._id) && (round(a._id) eq a._id) ? a._id : Session.User.ID;
        if(ID eq 0 && Session.User.Role.ID gt 2){
            return "Unable to create user.";
        }

        if(ID neq Session.User.ID && Session.User.Role.ID gt 2){
            return "Unable to save user, elevated access required.";
        }

        User = getUser(['ID'],[ID]);

        MiddleName  = isDefined("a._middle_name") ? a._middle_name : User.MiddleName;
        Birthday    = isDefined("a._birthday") && IsDate(a._birthday) ? a._birthday : User.Birthday;
        Phone       = isDefined("a._phone") ? a._phone : User.Phone;

        User
            .setMiddleName(MiddleName)
            .setBirthday(Birthday)
            .setPhone(Phone);

        ActionID = User.ID eq 0 ? 3 : 4;//Added/Updated
        User = User.ID eq 0 ? Add(User) : Update(User);

        //Log it.
        Log = CreateObject("Libraries.Models.Log");
        Log.User.setID(User.ID);
        Log.Action.setID(ActionID);//User Object Added/Updated
        Log.setTargetID(User.ID);
        Log.setNote(User.FirstName & " " & User.LastName);
        LogController.Add(Log);

        if(Session.User.ID eq User.ID){
            Session.User = User;
        }

        return User.ID;
    }

    public function getByURL(){
        sqlString = "SELECT " & buildLimit() & buildSelect() & buildWhere() & buildOrderBy();
        query = new Query();
        query.setDataSource(Config.DataSource);
        query.setSQL(sqlString);
        return query.execute().getResult();
    }

    private String function buildLimit(){
        sqlString = "";
        return sqlString;
    }

    private String function buildWhere(){
        sqlString = "";
        return sqlString;
    }

    private String function buildOrderBy(){
        sqlString = "";
        return sqlString;
    }
}