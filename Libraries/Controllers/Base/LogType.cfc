component extends="_BaseController"{
    public LogType function Add(LogType LogType){
        query = new Query();
        query.setDataSource(Config.Datasource);
        query.setSQL("
            INSERT INTO LogTypes (
                Name
            )VALUES(
                :Name
            )
        ");

        addQueryParams(LogType);

        result = query.execute();

        genKey = result.getPrefix().generatedkey;

        LogType.setID(genKey);

        return LogType;
    }
    
    public LogType function Update(LogType LogType){
        query = new Query();
        query.setDataSource(Config.Datasource);
        query.setSQL("
            UPDATE LogTypes
            SET 
                Name = :Name
            WHERE ID = :ID
        ");

        addQueryParams(LogType);

        query.execute();

        return LogType;
    }
    
    public LogType function GetObject(filters = [], values = []){
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
            LogType = BuildObject(result);
        }else{
            LogType = CreateObject("Libraries.Models.LogType");
        }

        return LogType;
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

        LogTypes = [];

        for(result in results){
            LogType = BuildObject(result);
            ArrayAppend(LogTypes, LogType);
        }

        return LogTypes;
    }
    
    private String function buildSelect(){
        sqlString = "
                ID,
                Name
            FROM LogTypes
            WHERE ID IS NOT NULL";

        return sqlString;
    }
    
    private function addQueryParams(LogType LogType){
        query.addParam(
            name="ID",
            value=LogType.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="Name",
            value=LogType.Name,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
    }

    private LogType function BuildObject(r){
        LogType = CreateObject("Libraries.Models.LogType");
        LogType.setID(r.ID)
            .setName(r.Name);
            
        return LogType;
    }
}