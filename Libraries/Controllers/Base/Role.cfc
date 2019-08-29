component extends="_BaseController"{
    public Role function Add(Role Role){
        query = new Query();
        query.setDataSource(Config.Datasource);
        query.setSQL("
            INSERT INTO Roles (
                Name
            )VALUES(
                :Name
            )
        ");

        addQueryParams(Role);

        result = query.execute();

        genKey = result.getPrefix().generatedkey;

        Role.setID(genKey);

        return Role;
    }
    
    public Role function Update(Role Role){
        query = new Query();
        query.setDataSource(Config.Datasource);
        query.setSQL("
            UPDATE Roles
            SET 
                Name = :Name
            WHERE ID      = :ID
        ");

        addQueryParams(Role);

        query.execute();

        return Role;
    }
    
    public Role function GetObject(filters = [], values = []){
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
            Role = buildObject(result);
        }else{
            Role = CreateObject("Libraries.Models.Role");
        }

        return Role;
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

        Roles = [];

        for(result in results){
            Role = buildObject(result);
            ArrayAppend(Roles, Role);
        }

        return Roles;
    }
    
    private String function buildSelect(){
        sqlString = "
                ID,
                Name
            FROM Roles
            WHERE ID IS NOT NULL";

        return sqlString;
    }
    
    private function addQueryParams(Role Role){
        query.addParam(
            name="ID",
            value=Role.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="Name",
            value=Role.Name,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
    }

    private Role function buildObject(r){
        Role = CreateObject("Libraries.Models.Role");
        Role.setID(r.ID)
            .setName(r.Name);
            
        return Role;
    }
}