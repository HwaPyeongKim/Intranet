$(function(){
    // 퇴근 처리
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

    // 이미지 업로드
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
                $("#imgPrev").attr("display","block").html("<img src='"+response.url+"' alt='"+response.filename+"' />");
                $("#image").val(response.fidx);
            },
            error: function() {
                alert("이미지 업로드에 실패했습니다.");
            }
        })
    });

    // 파일 업로드
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
                $("#prevFile").remove();
                $("#fidx").val(response.fidx);
            },
            error: function() {
                alert("첨부파일 업로드에 실패했습니다.");
            }
        })
    });

    // 검색 정렬 select
    $("#searchForm #sort").change(function (){
        var searchbox = $(this).closest(".searchBox");
        var type = searchbox.find("select[name=type]").val();
        var key = searchbox.find("input[name=key]").val();
        var sort = $(this).val();
        url = new URL(window.location.href);
        url.searchParams.set("type", type);
        url.searchParams.set("key", key);
        url.searchParams.set("sort", sort);
        location.href = url;
    })

    $("#postcode").click(function(){
        $("#findAddress").trigger(findAddress());
    });

    $("#address1").click(function(){
        $("#findAddress").trigger(findAddress());
    });
});

$(document).ready(function() {
    $.ajax({
        url: "checkNewMessage",
        type: "POST",
        success: function(response) {
            if (response.count > 0) {
                var count = response.count;
                if (count > 9) {
                    count = "9+";
                }
                $(".profile .messageBox i").css("display","inline-block").text(count);
            } else {
                $(".profile .messageBox i").css("display","none").text("0");
            }
        },
        error: function() {
            console.log("새로운 메세지를 가져오는데 실패했습니다.");
        }
    })
});