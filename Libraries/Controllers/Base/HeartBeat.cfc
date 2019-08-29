component extends="_BaseController"{
    public HeartBeat function Add(HeartBeat HeartBeat){
        query = new Query();
        query.setDataSource(Config.Datasource);
        query.setSQL("
            INSERT INTO HeartBeat (
                UserID,
                Tick
            )VALUES(
                :UserID,
                CURRENT_TIMESTAMP
            )
        ");

        addQueryParams(HeartBeat);

        result = query.execute();

        genKey = result.getPrefix().generatedkey;

        HeartBeat.setID(genKey);

        return HeartBeat;
    }
    
    public HeartBeat function Update(HeartBeat HeartBeat){
        query = new Query();
        query.setDataSource(Config.Datasource);
        query.setSQL("
            UPDATE HeartBeat
            SET 
                UserID   = :UserID,
                Tick     = CURRENT_TIMESTAMP
            WHERE ID     = :ID
        ");

        addQueryParams(HeartBeat);

        query.execute();

        return HeartBeat;
    }
    
    public Heartbeat function GetObject(filters = [], values = []){
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
            HeartBeat = buildObject(result);
        }else{
            HeartBeat = CreateObject("Libraries.Models.HeartBeat");
        }

        return HeartBeat;
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

        HeartBeats = [];

        for(result in results){
            HeartBeat = buildObject(result);
            ArrayAppend(HeartBeats, HeartBeat);
        }

        return HeartBeats;
    }
    
    private String function buildSelect(){
        sqlString = "
                ID,
                UserID,
                Tick
                FROM HeartBeat
            WHERE ID IS NOT NULL";

        return sqlString;
    }
    
    private function addQueryParams(HeartBeat HeartBeat){
        query.addParam(
            name="ID",
            value=HeartBeat.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="UserID",
            value=HeartBeat.User.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="Tick",
            value=HeartBeat.Tick,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
    }

    private Heartbeat function buildObject(r){
        HeartBeat = CreateObject("Libraries.Models.HeartBeat");
        HeartBeat
            .setID(r.ID)
            .setTick(r.Tick);
        HeartBeat.User.setID(r.UserID);
            
        return HeartBeat;
    }
}