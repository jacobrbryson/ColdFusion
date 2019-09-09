component{
    Config = CreateObject("setup.Config");
    remote any function checkDB() returnformat="JSON" {
        try{
            DataSource = IsDefined("arguments._datasource") && Trim(arguments._datasource) neq "" ? Trim(arguments._datasource) : "";
            if(DataSource eq ""){
                return "Invalid datasource or datasource not given.";
            }
            query = new Query();
            query.setDataSource(DataSource);
            TableName = DateTimeFormat(now(), "yyyymmddHHnnss") & "_cf_bt_temp";
            query.setSQL("CREATE TABLE " & TableName & "(ID INT);INSERT INTO " & TableName & " (ID) VALUES (1);");
            query.execute();
            query.setSQL("DROP TABLE " & TableName);
            query.execute();

            for(Table in Config.sqlTables){
                Exists = checktableExists(Table);
                if(Exists neq 0){
                    return "Table conflict (" & Table & ") found within datasource";
                }
            }

            return 1;
        }catch(any e){
            return "Generic Datasource error, please check your datasource settings.  Common cause: Allow multiple Queries is disabled.";
        }
    }

    private function checktableExists(TableName){
        query = new Query();
        query.setDataSource(DataSource);
        query.setSQL("SELECT ID FROM " & TableName);

        try{
            query.execute();
            return TableName;
        }catch(any e){
            return 0;
        }
    }
}