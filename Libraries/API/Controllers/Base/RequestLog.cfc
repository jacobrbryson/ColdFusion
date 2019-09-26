component extends="_BaseController"{
    public RequestLog function Add(RequestLog RequestLog){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "INSERT INTO RequestLogs (";
        sqlString &= "
                IPv4,
                APIUserID,
                EndPointID,
                Method,
                Data";
        sqlString &= ")VALUES(";
        sqlString &= "
                :IPv4,
                :APIUserID,
                :EndPointID,
                :Method,
                :Data
            )";

        query.setSQL(sqlString);

        addQueryParams(RequestLog);

        result = query.execute();

        genKey = result.getPrefix().generatedkey;

        RequestLog.setID(genKey);

        return RequestLog;
    }
    
    public RequestLog function Update(RequestLog RequestLog){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "
            UPDATE RequestLogs
            SET 
                IPv4        = :IPv4,
                APIUserID   = :APIUserID,
                EndPointID  = :EndPointID,
                Method      = :Method,
                Data        = :Data
            WHERE ID        = :ID
        ";

        query.setSQL(sqlString);

        addQueryParams(RequestLog);

        query.execute();

        return RequestLog;
    }

    public Void function Delete(RequestLog RequestLog){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "
            DELETE FROM RequestLogs
            WHERE ID = :ID
        ";

        query.setSQL(sqlString);
        query = addQueryParams(RequestLog, query);

        query.execute();
    }
    
    public RequestLog function GetObject(filters = [], values = []){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "SELECT " & buildSelect();
        for(i=1;i<=arrayLen(filters);i++){
            sqlString = sqlString & " AND u." & filters[i] & " = :" & filters[i];
            query.addParam(
                name=filters[i],
                value=values[i],
                CFSQLTYPE="CF_SQL_VARCHAR"
            );
        }

        query.setSQL(sqlString);

        result = query.execute().getResult();

        if(result.recordCount eq 1){
            RequestLog = buildObject(result);
        }else{
            RequestLog = CreateObject("Libraries.Models.API.RequestLog");
        }

        return RequestLog;
    }
    
    public Array function GetArray(filters = [], values = []){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "SELECT " & buildSelect();
        for(i=1;i<=arrayLen(filters);i++){
            sqlString = sqlString & " AND u." & filters[i] & " = :" & filters[i];
            query.addParam(
                name=filters[i],
                value=values[i],
                CFSQLTYPE="CF_SQL_VARCHAR"
            );
        }

        query.setSQL(sqlString);

        results = query.execute().getResult();

        RequestLogs = [];

        for(result in results){
            RequestLog = buildObject(result);
            ArrayAppend(RequestLogs, RequestLog);
        }

        return RequestLogs;
    }

    private function addQueryParams(RequestLog RequestLog){
        query.addParam(
            name="ID",
            value=RequestLog.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="IPv4",
            value=RequestLog.IPv4,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="APIUserID",
            value=RequestLog.APIUser.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="EndPointID",
            value=RequestLog.EndPoint.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="Method",
            value=RequestLog.Method,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="Data",
            value=Left(RequestLog.Data, 5000),
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
    }

    private String function buildSelect(){
        sqlString = "
                rl.ID,
                rl.Created,
                rl.IPv4,
                rl.APIUserID,
                rl.EndPointID,
                rl.Method,
                rl.Data
            FROM RequestLogs rl
            WHERE rl.ID IS NOT NULL";

        return sqlString;
    }

    private function buildObject(r){
        RequestLog = CreateObject("Libraries.API.Models.RequestLog");
        RequestLog.setID(r.ID)
            .setCreated(r.Created)
            .setIPv4(r.IPv4)
            .setMethod(r.Method)
            .setData(r.Data);

        RequestLog.APIUser.setID(r.APIUserID);

        RequestLog.EndPoint.setID(r.EndPointID);

        return RequestLog;
    }
}