<cfoutput>
    <div class="card">
        <div class="card-header">
            Create Config.cfc
        </div>
        <div class="card-body">
            <form id="form_create_config" method="POST" action="write_config.cfm">
                <div class="row">
                    <div class="col-12 col-sm-6 pt-2">
                        <label for="name">
                            App Name
                        </label>
                        <input type="text" class="form-control col-12" name="_name" id="name" value="" placeholder="Example" required/>
                    </div>
                    <div class="col-12 col-sm-6 pt-2">
                        <label for="database">
                            Database Type
                        </label>
                        <select class="form-control" name="_database_type" id="database_type">
                            <option value="0">
                                Do not use
                            </option>
                            <option value="1">
                                MS SQL Server
                            </option>
                            <option value="2">
                                MySQL Server
                            </option>
                        </select>
                    </div>
                    <div class="col-12 pt-2">
                        <label for="datasource">
                            Datasource
                        </label>
                        <div class="row">
                            <div class="col-1 pt-2 text-center">
                                <div id="datasource_isvalid">
                                    <i class="fas fa-times-circle text-danger my-2 fa-lg"></i>
                                </div>
                            </div>
                            <div class="col-7 col-sm-8 pt-2">
                                <input type="text" class="form-control col-12 datasource-option" name="_datasource" id="datasource" value="" placeholder="MyDataSource" disabled required/>
                                <div id="datasource_message"></div>
                            </div>
                            <div class="col-4 col-sm-3 pt-2">
                                <a href="javascript:void(0)" class="btn btn-warning col-12 btn-validate-datasource disabled" id="btn_validate" disabled>
                                    Validate
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm-6 pt-2">
                        <label for="baseweburl">
                            Baseweb URL
                        </label>
                        <input type="text" class="form-control col-12" name="_baseweburl" id="baseweburl" value="#cgi.server_port_secure ? "https://" : "http://"##cgi.server_name#" required/>
                    </div>
                    <div class="col-12 col-sm-6 pt-2">
                        <label for="assetsurl">
                            Assets URL
                        </label>
                        <input type="text" class="form-control col-12" name="_assetsurl" id="assetsurl" value="#cgi.server_port_secure ? "https://" : "http://"##cgi.server_name#" required/>
                    </div>
                    <div class="col-12 pt-2">
                        <label for="theme">
                            Theme Color
                        </label>
                        <input type="text" class="form-control col-12" name="_theme" id="theme" value="##FFF"/>
                    </div>
                    <div class="col-12 pt-2">
                        <div class="custom-control custom-switch">
                            <input type="checkbox" class="custom-control-input" id="session_management" name="_session_management">
                            <label class="custom-control-label" for="session_management">Session Management</label>
                        </div>
                    </div>
                    <div class="col-12 col-sm-6 pt-2">
                        <label for="app_timeout">
                            Application Timeout
                        </label>
                        <input type="number" pattern=" 0+\.[0-9]*[1-9][0-9]*$" class="form-control col-12 session-option" name="_app_timeout" id="app_timeout" value="43200" disabled/>
                        <small class="text-muted">minutes</small>
                    </div>
                    <div class="col-12 col-sm-6 pt-2">
                        <label for="session_timeout">
                            Session Timeout
                        </label>
                        <input type="number" pattern=" 0+\.[0-9]*[1-9][0-9]*$" class="form-control col-12 session-option" name="_session_timeout" id="session_timeout" value="10800" disabled/>
                        <small class="text-muted">minutes</small>
                    </div>
                    <div class="col-12 pt-2">
                        <div class="custom-control custom-switch">
                            <input type="checkbox" class="custom-control-input" id="google_auth" name="_google_auth">
                            <label class="custom-control-label" for="google_auth">Google Authentication</label>
                        </div>
                    </div>
                    <div class="col-12 col-sm-6 pt-2">
                        <label for="google_client_id">
                            Google Client ID
                        </label>
                        <input type="text" class="form-control col-12 google-option" name="_google_client_id" id="google_client_id" value="" disabled/>
                        <small class="text-muted"><a href="https://developers.google.com/identity/protocols/OAuth2WebServer" target="_blank">Link to set this up</a></small>
                    </div>
                    <div class="col-12 col-sm-6 pt-2">
                        <label for="google_client_id_secret">
                            Google Client ID Secret
                        </label>
                        <input type="text" class="form-control col-12 google-option" name="_google_client_id_secret" id="google_client_id_secret" value="" disabled/>
                        <small class="text-muted"><a href="https://developers.google.com/identity/protocols/OAuth2WebServer" target="_blank">Link to set this up</a></small>
                    </div>
                    <div class="col-12 pt-2">
                        <button class="btn btn-success col-12" id="button_submit_config">
                            <cfif Writable>
                                Build SQL tables and remove setup files
                            <cfelse>
                                Build SQL tables and download Config.cfc
                            </cfif>
                        </button>
                    </div>
                </div>
                <input type="hidden" name="_csrf_token" value="#CSRFGenerateToken()#"/> 
            </form>
        </div>
    </div>
</cfoutput>