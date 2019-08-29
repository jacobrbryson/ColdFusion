component extends="_BaseController"{
    public User function Add(User User){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "INSERT INTO Users (";
        sqlString &= User.Birthday eq "" ? "" : "Birthday";
        sqlString &= "
                UUID,
                GoogleID,
                FirstName,
                LastName,
                Phone,
                Email,
                Avatar,
                RoleID";
        sqlString &= ")VALUES(";
        sqlString &= User.Birthday eq "" ? "" : ":Birthday";
        sqlString &= "
                :UUID,
                :GoogleID,
                :FirstName,
                :LastName,
                :Phone,
                :Email,
                :Avatar,
                :RoleID
            )";

        query.setSQL(sqlString);

        addQueryParams(User);

        result = query.execute();

        genKey = result.getPrefix().generatedkey;

        User.setID(genKey);

        return User;
    }
    
    public User function Update(User User){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "
            UPDATE Users
            SET 
                FirstName       = :FirstName,
                LastName        = :LastName,
                MiddleName      = :MiddleName,
                Email           = :Email,
                Phone           = :Phone,
	            Avatar          = :Avatar,";
        sqlString &= User.Birthday eq "" ? "" : " Birthday        = :Birthday,";
        sqlString &= "
	            IsEnabled       = :IsEnabled,
                RoleID          = :RoleID
            WHERE ID = :ID
        ";

        query.setSQL(sqlString);
        addQueryParams(User);

        query.execute();

        return User;
    }

    public Void function Delete(User User){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "
            DELETE FROM Users
            WHERE ID = :ID
        ";

        query.setSQL(sqlString);
        query = addQueryParams(User, query);

        query.execute();
    }
    
    public User function GetObject(filters = [], values = []){
        query = new Query();
        query.setDataSource(Config.Datasource);
        sqlString = "SELECT TOP 1 " & buildSelect();
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
            User = buildObject(result);
        }else{
            User = CreateObject("Libraries.Models.User");
        }

        return User;
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

        Users = [];

        for(result in results){
            User = buildObject(result);
            ArrayAppend(Users, User);
        }

        return Users;
    }

    private function addQueryParams(User User){
        query.addParam(
            name="ID",
            value=User.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
        query.addParam(
            name="UUID",
            value=CreateUUID(),
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="GoogleID",
            value=User.GoogleID,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="FirstName",
            value=User.FirstName,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="LastName",
            value=User.LastName,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="MiddleName",
            value=User.MiddleName,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="Avatar",
            value=User.Avatar,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="Birthday",
            value=User.Birthday,
            CFSQLTYPE="CF_SQL_VARCHAR"
        );
        query.addParam(
            name="IsEnabled",
            value=User.IsEnabled,
            CFSQLTYPE="CF_SQL_BIT"
        query.addParam(
            name="RoleID",
            value=User.Role.ID,
            CFSQLTYPE="CF_SQL_INTEGER"
        );
    }

    private String function buildSelect(){
        sqlString = "
                u.ID,
                u.Created,
                u.UUID,
                u.GoogleID,
                u.NickName,
                u.FirstName,
                u.LastName,
                u.Phone,
                u.Email,
                u.MiddleName,
                u.Avatar,
                u.Birthday,
                u.IsEnabled,
                u.RoleID,
                r.Name as Role,
                (
                    SELECT 
                        MAX(h.Tick) 
                    FROM Heartbeat h
                    WHERE UserID = u.ID 
                    AND h.Tick > DATEADD(minute, -1, GETDATE())
                ) as online
            FROM Users u
            INNER JOIN Roles r
            ON u.RoleID = r.ID
            WHERE u.ID IS NOT NULL";

        return sqlString;
    }

    private function buildObject(r){
        User = CreateObject("Libraries.Models.User");
        User.setID(r.ID)
            .setCreated(r.Created)
            .setUUID(r.UUID)
            .setGoogleID(r.GoogleID)
            .setFirstName(r.FirstName)
            .setLastName(r.LastName)
            .setMiddleName(r.MiddleName)
            .setPhone(r.Phone)
            .setEmail(r.Email)
            .setAvatar(r.Avatar)
            .setBirthday(r.Birthday)
            .setIsEnabled(r.IsEnabled)
            .setEmail(r.Email);

        User.Role
            .setID(r.RoleID)
            .setName(r.Role);

        return User;
    }
}