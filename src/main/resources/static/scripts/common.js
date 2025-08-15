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
                $("#image").val(response.fidx);
                $("#imgPrev").html("<img src='"+response.url+"' alt='"+response.filename+"' />");
                $("#image").val(response.url);
            },
            error: function() {
                alert("이미지 업로드에 실패했습니다.");
            }
        })
    });
})