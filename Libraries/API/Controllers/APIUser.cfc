component extends="Base.APIUser"{
    /*public function Save(a){
        ID = isDefined("a._id") && isNumeric(a._id) && (round(a._id) eq a._id) ? a._id : Session.APIUser.ID;
        if(ID eq 0 && Session.APIUser.Role.ID gt 2){
            return "Unable to create APIUser.";
        }

        if(ID neq Session.APIUser.ID && Session.APIUser.Role.ID gt 2){
            return "Unable to save APIUser, elevated access required.";
        }

        APIUser = getAPIUser(['ID'],[ID]);

        MiddleName  = isDefined("a._middle_name") ? a._middle_name : APIUser.MiddleName;
        Birthday    = isDefined("a._birthday") && IsDate(a._birthday) ? a._birthday : APIUser.Birthday;
        Phone       = isDefined("a._phone") ? a._phone : APIUser.Phone;

        APIUser
            .setMiddleName(MiddleName)
            .setBirthday(Birthday)
            .setPhone(Phone);

        ActionID = APIUser.ID eq 0 ? 3 : 4;//Added/Updated
        APIUser = APIUser.ID eq 0 ? Add(APIUser) : Update(APIUser);

        //Log it.
        Log = CreateObject("Libraries.Models.Log");
        Log.APIUser.setID(APIUser.ID);
        Log.Action.setID(ActionID);//APIUser Object Added/Updated
        Log.setTargetID(APIUser.ID);
        Log.setNote(APIUser.FirstName & " " & APIUser.LastName);
        LogController.Add(Log);

        if(Session.APIUser.ID eq APIUser.ID){
            Session.APIUser = APIUser;
        }

        return APIUser.ID;
    }*/

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