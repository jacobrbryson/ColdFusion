<form id="form_filters_logs">
    <div class="row d-flex mt-2">
        <div class="justify-content-between align-items-center col-6 col-sm-2 mb-4">
            <h6>
                Search
            </h6>
            <input type="text"
                class="form-control"
                name="_search"
                id="search"
                placeholder="Name, Email, IP Address..."
                autocomplete="off"
                required>
        </div>
        <!---div class="justify-content-between align-items-center col-12 col-sm-3 mb-4">
            <h6>
                Action
            </h6>
            <cfinclude template="filters/actions.cfm"/>
        </div--->
        <div class="justify-content-between align-items-center col-6 col-sm-2 mb-4">
            <h6>
                Type
            </h6>
            <select class="form-control" name="_type_id" id="type_id">
                <option value="0">
                    All Types
                </option>
                <option value="1">
                    Information
                </option>
                <option value="2">
                    Error
                </option>
            </select>
        </div>
        <div class="justify-content-between align-items-center col-6 col-sm-3 mb-4">
            <h6>Start Date</h6>
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text"
                        id="StartPrepend">
                        <i class="fas fa-calendar-alt"></i>
                    </span>
                </div>
                <input type="text"
                    class="form-control date-picker"
                    id="start_date"
                    aria-describedby="StartPrepend">
            </div>
        </div>
        <div class="justify-content-between align-items-center col-6 col-sm-3 mb-4">
            <h6>End Date</h6>
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text"
                        id="EndPrepend">
                        <i class="fas fa-calendar-alt"></i>
                    </span>
                </div>
                <input type="text"
                    class="form-control date-picker"
                    id="end_date"
                    aria-describedby="EndPrepend">
            </div>
        </div>
        <div class="justify-content-between align-items-center col-12 col-sm-2 mb-4">
            <h6>
                Limit
            </h6>
            <select class="form-control" name="_limit" id="limit">
                <option value="125">125</option>
                <option value="250">250</option>
                <option value="500">500</option>
                <option value="500">1000</option>
                <option value="500">2000</option>
                <option value="500">4000</option>
                <option value="0">&infin;</option>
            </select>
        </div>
    </div>
</form>