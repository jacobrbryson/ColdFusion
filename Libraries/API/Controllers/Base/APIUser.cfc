component extends="_BaseController"{
    public APIUser function Add(APIUser APIUser){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "INSERT INTO APIUsers (";
        sqlString &= "
                Name,
                SecretKey,
                APIAuthorization,
                EncryptionKey,
                IsEnabled";
        sqlString &= ")VALUES(";
        sqlString &= "
                :Name,
                :SecretKey,
                :APIAuthorization,
                :EncryptionKey,
                :IsEnabled
            )";

        query.setSQL(sqlString);

        addQueryParams(APIUser);

        result = query.execute();

        genKey = result.getPrefix().generatedkey;

        APIUser.setID(genKey);

        return APIUser;
    }
    
    public APIUser function Update(APIUser APIUser){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "
            UPDATE APIUsers
            SET 
                Name                = :Name,
                SecretKey           = :SecretKey,
                APIAuthorization    = :APIAuthorization,
                EncryptionKey       = :EncryptionKey,
                IsEnabled           = :IsEnabled
            WHERE ID = :ID
        ";

        query.setSQL(sqlString);

        addQueryParams(APIUser);

        query.execute();

        return APIUser;
    }

    public Void function Delete(APIUser APIUser){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "
            DELETE FROM APIUsers
            WHERE ID = :ID
        ";

        query.setSQL(sqlString);
        query = addQueryParams(APIUser, query);

        query.execute();
    }
    
    public APIUser function GetObject(filters = [], values = []){
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
            APIUser = buildObject(result);
        }else{
            APIUser = CreateObject("Libraries.API.Models.APIUser");
        }

        return APIUser;
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

        APIUsers = [];

        for(result in results){
            APIUser = buildObject(result);
            ArrayAppend(APIUsers, APIUser);
        }

        return APIUsers;
    }

    private function addQueryParams(APIUser APIUser){
        query.addParam(
            name="ID",
            value=APIUser.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="Name",
            value=APIUser.Name,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="SecretKey",
            value=APIUser.SecretKey,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="APIAuthorization",
            value=APIUser.APIAuthorization,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="EncryptionKey",
            value=APIUser.EncryptionKey,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="IsEnabled",
            value=APIUser.IsEnabled,
            CFSQLTYPE="CF_SQL_BIT"
        );
    }

    private String function buildSelect(){
        sqlString = "
                u.ID,
                u.Created,
                u.Name,
                u.SecretKEy,
                u.APIAuthorization,
                u.EncryptionKey,
                u.IsEnabled
            FROM APIUsers u
            WHERE u.ID IS NOT NULL";

        return sqlString;
    }

    private function buildObject(r){
        APIUser = CreateObject("Libraries.API.Models.APIUser");
        APIUser.setID(r.ID)
            .setName(r.Name)
            .setSecretKey(r.SecretKey)
            .setAPIAuthorization(r.APIAuthorization)
            .setEncryptionKey(r.EncryptionKey)
            .setIsEnabled(r.IsEnabled);

        return APIUser;
    }
}