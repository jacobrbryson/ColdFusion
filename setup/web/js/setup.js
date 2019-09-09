$(".btn-validate-datasource").on("click", function(e){
    validateDataSource();
});

$("#session_management").on("change", function(){
    $(".session-option").each(function(){
        $(this).prop("disabled",function(i, v) { return !v; });
    });
});

$("#google_auth").on("change", function(){
    $(".google-option").each(function(){
        $(this).prop("disabled",function(i, v) { return !v; });
    });
});

$("#database_type").on("change", function(){
    $("#datasource").prop("disabled",($("#database_type").val() == 0));
    $("#datasource_isvalid").html("<i class='fas fa-times-circle text-danger my-2 fa-lg'></i>");
    $("#datasource").val("");

    if($("#database_type").val() == 0){
        if(!$("#btn_validate").hasClass("disabled")){
            $("#btn_validate").addClass("disabled");
        }
        $("#button_submit_config").prop("disabled", false);
    }else{
        $("#btn_validate").removeClass("disabled");
        $("#button_submit_config").prop("disabled", true);
    }
});

function validateDataSource(){
    $("#datasource_message").html("");
    $("#button_submit_config").prop("disabled", true);
    $("#datasource_isvalid").html("<div class='loader'></div>");
    $.ajax({
        url: "functions.cfc?method=checkDB",
        data:{
            '_datasource':$("#datasource").val()
        },
        success: function(result){
            if($.isNumeric(result) && result == 1){
                $("#datasource_isvalid").html("<i class='fas fa-check-circle text-success my-2 fa-lg'></i>");
                $("#button_submit_config").prop("disabled", false);
            }else{
                $("#datasource_isvalid").html("<i class='fas fa-times-circle text-danger my-2 fa-lg'></i>");
                $("#datasource_message").html("<small class='text-muted'>" + result + "</small>");
            }
        }
    });
}