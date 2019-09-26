<cfscript>
    query = new Query();
    query.setSQL("
        SELECT DISTINCT 
            l.LogActionID, 
            la.Name
        FROM Logs l
        INNER JOIN LogActions la 
        ON l.LogActionID = la.ID
    ");
    results = query.execute().getResult();
</cfscript>
<cfoutput>
    <select name="_action_id" id="action_id" class="form-control chosen-select"<cfif results.recordCount eq 0> disabled</cfif>>
        <option value="0">All Actions</option>
        <cfloop query="#results#">
            <option value="#ActionID#">
                #Name#
            </option>
        </cfloop>
    </select>
</cfoutput>