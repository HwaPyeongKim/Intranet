$(function(){
    $("#imgPrevBtn").change(function(){
        var form = $(".imageForm")[0];
        var formData = new FormData(form);
        $.ajax({
            url: "fileup",
            type: "POST",
            enctype: "multipart/form-data",
            data: formData,
            timeout: 10000,
            contentType: false,
            processData: false,
            success: function(response) {
                $("#imgPrev").html("<img src='"+response.url+"' alt='"+response.filename+"' />");
                $("#image").val(response.fidx);
            },
            error: function() {
                alert("이미지 업로드에 실패했습니다.");
            }
        })
    });

    $("#postcode").click(function(){
        $("#findAddress").trigger(findAddress());
    });

    $("#address1").click(function(){
        $("#findAddress").trigger(findAddress());
    });
})