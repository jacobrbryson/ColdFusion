component extends="Base.Log"{
    public function getByURL(){
        sqlString = "SELECT " & buildLimit() & buildSelect() & buildWhere() & buildOrderBy();
        query = new Query();
        query.setDataSource(Config.DataSource);
        query.setSQL(sqlString);
        return query.execute().getResult();
    }

    private String function buildLimit(){
        sqlString = "";
        return sqlString;
    }

    private String function buildWhere(){
        sqlString = "";
        return sqlString;
    }

    private String function buildOrderBy(){
        sqlString = " ORDER BY ID DESC";
        return sqlString;
    }
}