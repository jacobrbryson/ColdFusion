<form id="form_filters_logs">
    <div class="row d-flex mt-2">
        <div class="justify-content-between align-items-center col-12 col-sm-6 mb-4">
            <h6>
                Search
            </h6>
            <input type="text"
                class="form-control"
                name="_search"
                id="search"
                placeholder="Name, Email"
                autocomplete="off"
                required>
        </div>
        <div class="justify-content-between align-items-center col-12 col-sm-3 mb-4">
            <h6>
                Online
            </h6>
            <select class="form-control">
                <option value="-1">
                    All
                </option>
                <option value="1">
                    Online
                </option>
                <option value="0">
                    Offline
                </option>
            </select>
        </div>
        <div class="justify-content-between align-items-center col-12 col-sm-3 mb-4">
            <h6>
                Enabled
            </h6>
            <select class="form-control">
                <option value="-1">
                    All
                </option>
                <option value="1">
                    Enabled
                </option>
                <option value="0">
                    Disabled
                </option>
            </select>
        </div>
        <div class="justify-content-between align-items-center col-6 col-sm-4 mb-4">
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
        <div class="justify-content-between align-items-center col-6 col-sm-4 mb-4">
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
        <div class="justify-content-between align-items-center col-12 col-sm-4 mb-4">
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