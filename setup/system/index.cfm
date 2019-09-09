<cfset runtime = CreateObject("java","java.lang.Runtime").getRuntime()>
<cfset freeMemory = runtime.freeMemory() / 1024 / 1024>
<cfset totalMemory = runtime.totalMemory() / 1024 / 1024>
<cfset maxMemory = runtime.maxMemory() / 1024 / 1024>


<div class="card">
    <div class="card-header">System Information</div>
    <div class="card-body">
        <cfoutput>
            Free Allocated Memory: <strong>#Round(freeMemory)#</strong>mb<br>
            Total Memory Allocated: <strong>#Round(totalMemory)#</strong>mb<br>
            Max Memory Available to JVM: <strong>#Round(maxMemory)#</strong>mb<br>
        </cfoutput>



        <cfset percentFreeAllocated = Round((freeMemory / totalMemory) * 100)>
        <cfset percentAllocated = Round((totalMemory / maxMemory ) * 100)>
        <cfoutput>
            % of Free Allocated Memory: <strong>#percentFreeAllocated#</strong>%<br>
            % of Available Memory Allocated: <strong>#percentAllocated#</strong>%<br>
        </cfoutput>
    </div>
</div>