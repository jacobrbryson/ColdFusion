component extends="_BaseController"{
    public LogAction function Add(LogAction LogAction){
        query = new Query();
        query.setDataSource(Config.Datasource);
        query.setSQL("
            INSERT INTO LogActions (
                Name,
                LogTypeID,
                TargtURL
            )VALUES(
                :Name,
                :LogTypeID,
                :TargetURL
            )
        ");

        addQueryParams(LogAction);

        result = query.execute();

        genKey = result.getPrefix().generatedkey;

        LogAction.setID(genKey);

        return LogAction;
    }
    
    public LogAction function Update(LogAction LogAction){
        query = new Query();
        query.setDataSource(Config.Datasource);
        query.setSQL("
            UPDATE LogActions
            SET 
                Name        = :Name
                LogTypeID   = :LogTypeID
                TargetURL   = :TargetURL
            WHERE ID        = :ID
        ");

        addQueryParams(LogAction);

        query.execute();

        return LogAction;
    }
    
    public LogAction function GetObject(filters = [], values = []){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "SELECT TOP 1 " & buildSelect();
        for(i=1;i<=arrayLen(filters);i++){
            sqlString = sqlString & " AND " & filters[i] & " = :" & filters[i];
            query.addParam(
                name=filters[i],
                value=values[i],
                CFSQLTYPE="CF_SQL_VARCHAR"
            );
        }

        query.setSQL(sqlString);

        result = query.execute().getResult();

        if(result.recordCount eq 1){
            LogAction = BuildObject(result);
        }else{
            LogAction = CreateObject("Libraries.Models.LogAction");
        }

        return LogAction;
    }
    
    public Array function GetArray(filters = [], values = []){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "SELECT " & buildSelect();
        for(i=1;i<=arrayLen(filters);i++){
            sqlString = sqlString & " AND " & filters[i] & " = :" & filters[i];
            query.addParam(
                name=filters[i],
                value=values[i],
                CFSQLTYPE="CF_SQL_VARCHAR"
            );
        }

        query.setSQL(sqlString);

        results = query.execute().getResult();

        LogActions = [];

        for(result in results){
            LogAction = BuildObject(result);
            ArrayAppend(LogActions, LogAction);
        }

        return LogActions;
    }
    
    private String function buildSelect(){
        sqlString = "
                ID,
                Name,
                LogTypeID,
                TargetURL
            FROM LogActions
            WHERE ID IS NOT NULL";

        return sqlString;
    }
    
    private function addQueryParams(LogAction LogAction){
        query.addParam(
            name="ID",
            value=LogAction.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="Name",
            value=LogAction.Name,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="TypeID",
            value=LogAction.Type.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="TargetURL",
            value=LogAction.TargetURL,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
    }

    private LogAction function BuildObject(r){
        LogAction = CreateObject("Libraries.Models.LogAction");
        LogAction.setID(r.ID)
            .setName(r.Name)
            .setTargetURL(r.TargetURL);

        LogAction.LogType.setID(r.LogTypeID)
            
        return LogAction;
    }
}