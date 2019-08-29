component {
    Config = CreateObject("Config");
    public Log function Add(Log Log){
        query = new Query();
        query.setDataSource(Config.Datasource);
        query.setSQL("
            INSERT INTO Logs (
                IPv4,
                UserID,
                ActionID,
                TargetID,
                Note
            )VALUES(
                :IPv4,
                :UserID,
                :ActionID,
                :TargetID,
                :Note
            )
        ");

        addQueryParams(Log);

        result = query.execute();

        genKey = result.getPrefix().generatedkey;

        Log.setID(genKey);

        return Log;
    }
    
    public Log function GetObject(filters = [], values = []){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "SELECT TOP 1 " & buildSelect();
        for(i=1;i<=arrayLen(filters);i++){
            sqlString = sqlString & " AND l." & filters[i] & " = :" & filters[i];
            query.addParam(
                name=filters[i],
                value=values[i],
                CFSQLTYPE="CF_SQL_VARCHAR"
            );
        }

        query.setSQL(sqlString);

        result = query.execute().getResult();

        if(result.recordCount eq 1){
            Log = buildObject(result);
        }else{
            Log = CreateObject("Libraries.Models.Log");
        }

        return Log;
    }
    
    public Array function GetArray(filters = [], values = []){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "SELECT " & buildSelect();
        for(i=1;i<=arrayLen(filters);i++){
            sqlString = sqlString & " AND l." & filters[i] & " = :" & filters[i];
            query.addParam(
                name=filters[i],
                value=values[i],
                CFSQLTYPE="CF_SQL_VARCHAR"
            );
        }

        query.setSQL(sqlString);

        results = query.execute().getResult();

        Logs = [];

        for(result in results){
            Log = buildObject(result);
            ArrayAppend(Logs, Log);
        }

        return Log;
    }

    private function addQueryParams(Log Log){
        query.addParam(
            name="ID",
            value=Log.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="IPv4",
            value=Log.IPv4,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="UserID",
            value=Log.User.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="ActionID",
            value=Log.Action.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="TargetID",
            value=Log.TargetID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="Note",
            value=Log.Note,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
    }
    
    private String function buildSelect(){
        sqlString = "
                l.ID,
                l.IPv4,
                l.Created,
                l.UserID,
                l.ActionID,
                l.TargetID,
                l.Note,
                la.Description as LogType,
                la.TargetURL,
                la.LogTypeID,
                lt.Name as LogType,
                u.FirstName,
                u.LastName
            FROM Logs l
            INNER JOIN LogActions la
            ON l.ActionID = la.ID
            INNER JOIN LogTypes lt
            ON ls.LogTypeID = lt.ID
            LEFT JOIN Users u
            ON l.UserID = u.ID
            WHERE l.ID IS NOT NULL";

        return sqlString;
    }
    
    private Log function buildObject(r){
        Log = CreateObject("Libraries.Models.Log");
        Log.setID(r.ID)
            .setIPv4(r.IPv4)
            .setTargetID(r.TargetID)
            .setNote(r.Note);

        Log.User.setID(r.UserID);

        Log.LogAction
            .setID(r.ActionID)
            .setName(r.LogType)
            .setTargetURL(r.TargetURL);

        Log.LogAction.LogType.setID(r.LogTypeID).setName(r.LogType);
            
        return Log;
    }
}