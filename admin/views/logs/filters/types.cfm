<cfscript>
    query = new Query();
    query.setSQL("
        SELECT DISTINCT 
            l.TypeID, 
            lt.Name
        FROM Logs l
        INNER JOIN LogTypes lt 
        ON l.TypeID = lt.ID
    ");
    results = query.execute().getResult();
</cfscript>
<cfoutput>
    <select name="_type_id" id="type_id" class="form-control chosen-select"<cfif results.recordCount eq 0> disabled</cfif>>
        <option value="0">All Types</option>
        <cfloop query="#results#">
            <option value="#TypeID#">
                #Name#
            </option>
        </cfloop>
    </select>
</cfoutput>