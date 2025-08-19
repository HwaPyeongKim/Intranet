function workout(midx) {
    $()

    if (confirm("정말로 퇴근하시겠습니까?")) {
        location.href = "workout?midx="+midx;
    }
}

$(function(){
    $("#workoutBtn").click(function(){
        var midx = $(this).attr("data-midx");
        $.ajax({
            url: "checkWorkout",
            type: "POST",
            data: {midx: midx},
            success: function(response) {
                if (response.result == 1) {
                    alert("이미 퇴근처리가 되었습니다.\n퇴근시간 : "+response.endtime);
                } else {
                    location.href = "workout?midx="+midx;
                }
            },
            error: function() {
                alert("오류가 발생했습니다. 관리자에게 문의해주세요.");
            }
        })
    });

    $("#imgPrevBtn").change(function(){
        var form = $(".imageForm")[0];
        var formData = new FormData(form);
        $.ajax({
            url: "imgup",
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

    $("#fileBtn").change(function(){
        var form = $(".fileForm")[0];
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
                $("#fidx").val(response.fidx);
            },
            error: function() {
                alert("첨부파일 업로드에 실패했습니다.");
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