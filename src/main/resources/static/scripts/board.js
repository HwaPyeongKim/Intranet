function editBoard(bidx, action) {
    var pwd = prompt("비밀번호를 입력해주세요.","");

    $.ajax({
        url: "checkBoardPwd",
        type: "POST",
        data: {bidx: bidx, pwd: pwd},
        success: function(response) {
            if (response.result == 1) {
                if (action == "delete") {
                    if (!confirm("게시물을 삭제하시겠습니까?")) {
                        return;
                    }
                }
                location.href = "editBoard?bidx="+bidx+"&action="+action;
            } else {
                alert("비밀번호가 일치하지 않습니다.");
            }
        },
        error: function() {
            alert("오류가 발생했습니다. 관리자에게 문의해주세요.");
        }
    })

}

$(function (){
    $(document).on('click', '.updateBoardComment', function() {
        var bidx = $(this).attr("data-bidx");
       var bcidx = $(this).attr("data-bcidx");
       var li = $(this).closest(".commentList");
       var commentBtns = li.find(".commentBtns div");
       var content = li.find("pre").text();

       var btn_html = '<button>수정완료</button>';
       btn_html += '<button type="button" data-bidx="'+bidx+'" data-bcidx="'+bcidx+'" class="cancelBtn">수정취소</button>';
       commentBtns.html(btn_html);
       li.find("pre").remove();
       li.append("<textarea name='content'>"+content+"</textarea>");
   });

    $(document).on('click', '.cancelBtn', function() {
        var bidx = $(this).attr("data-bidx");
        var bcidx = $(this).attr("data-bcidx");
        var li = $(this).closest(".commentList");
        var commentBtns = li.find(".commentBtns div");
        var content = li.find("textarea").val();

        var btn_html = '<button type="button" data-bidx="'+bidx+'" data-bcidx="'+bcidx+'" class="deleteBoardComment">댓글삭제</button>';
        btn_html += '<button type="button" data-bidx="'+bidx+'" data-bcidx="'+bcidx+'" class="updateBoardComment">댓글수정</button>';

        commentBtns.html(btn_html);
        li.find("textarea").remove();
        li.append("<pre>"+content+"</pre>");
    });

    $(document).on('click','.deleteBoardComment',function (){
        var bidx = $(this).attr("data-bidx");
        var bcidx = $(this).attr("data-bcidx");
        if (confirm("댓글을 삭제하시겠습니까?")) {
            location.href = "deleteBoardComment?bidx="+bidx+"&bcidx="+bcidx;
        }
    });
});