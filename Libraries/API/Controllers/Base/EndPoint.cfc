component extends="_BaseController"{
    public EndPoint function Add(EndPoint EndPoint){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "INSERT INTO EndPoints (";
        sqlString &= "
                EndPointURL,
                IsEnabled";
        sqlString &= ")VALUES(";
        sqlString &= "
                :EndPointURL,
                :IsEnabled
            )";

        query.setSQL(sqlString);

        addQueryParams(EndPoint);

        result = query.execute();

        genKey = result.getPrefix().generatedkey;

        EndPoint.setID(genKey);

        return EndPoint;
    }
    
    public EndPoint function Update(EndPoint EndPoint){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "
            UPDATE EndPoints
            SET 
                EndPointURL = :EndPointURL,
                IsEnabled   = :IsEnabled
            WHERE ID = :ID
        ";

        query.setSQL(sqlString);

        addQueryParams(EndPoint);

        query.execute();

        return EndPoint;
    }

    public Void function Delete(EndPoint EndPoint){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "
            DELETE FROM EndPoints
            WHERE ID = :ID
        ";

        query.setSQL(sqlString);
        query = addQueryParams(EndPoint, query);

        query.execute();
    }
    
    public EndPoint function GetObject(filters = [], values = []){
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
            EndPoint = buildObject(result);
        }else{
            EndPoint = CreateObject("Libraries.Models.API.EndPoint");
        }

        return EndPoint;
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

        EndPoints = [];

        for(result in results){
            EndPoint = buildObject(result);
            ArrayAppend(EndPoints, EndPoint);
        }

        return EndPoints;
    }

    private function addQueryParams(EndPoint EndPoint){
        query.addParam(
            name="ID",
            value=EndPoint.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="EndPointURL",
            value=EndPoint.EndPointURL,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="IsEnabled",
            value=EndPoint.IsEnabled,
            CFSQLTYPE="CF_SQL_BIT"
        );
    }

    private String function buildSelect(){
        sqlString = "
                u.ID,
                u.Created,
                u.EndPointURL,
                u.IsEnabled
            FROM EndPoints u
            WHERE u.ID IS NOT NULL";

        return sqlString;
    }

    private function buildObject(r){
        EndPoint = CreateObject("Libraries.API.Models.EndPoint");
        EndPoint.setID(r.ID)
            .setCreated(r.Created)
            .setEndPointURL(r.EndPointURL)
            .setIsEnabled(r.IsEnabled);

        return EndPoint;
    }
}