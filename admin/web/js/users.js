$(document).ready(function(){
    getUsers();
});

function getUsers(){
    var Search      = $("#search").val();
    Search          = (typeof Search != 'undefined') ? Search : "";
    var StartDate   = $("#start_date").val();
    var EndDate     = $("#end_date").val();
    var Limit       = $("#limit").val();

    $("#loader-system").removeClass('hide');
    url = "views/users/table.cfm?_search="+encodeURI(Search)+"&_start_date="+StartDate+"&_end_date="+EndDate+"&_limit="+Limit;

    $("#container_users").load(url, function(responseTxt, statusTxt, xhr){
        if(statusTxt == "success"){
            $("#loader-system").addClass('hide');
        }
    });
}

$(".form-control").on("change", function(){
    getUsers();
});

$("#search").on("keyup", function(){
    getUsers();
});

function setDateRange(range = 1){
    var date = new Date();
    date.setDate(date.getDate() + range);

    var month = date.getMonth()+1;
    var day = date.getDate();

    var output = (month<10 ? '0' : '') + month + '/' +
        (day<10 ? '0' : '') + day + '/' +
        date.getFullYear();

    return output;
}
$("#start_date").val(setDateRange(-365));
$("#end_date").val(setDateRange());