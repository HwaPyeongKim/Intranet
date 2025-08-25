function go_search( url ){
    document.work.action = url;
    document.work.submit();
}

function editWork(widx, action) {
        if (action == "delete") {
            if (!confirm("게시물을 삭제하시겠습니까?")) {
                return;
            }
        }
        location.href = "editWork?widx="+widx+"&action="+action;
}

function go_list(){
    if(sessionStorage.getItem('workon')=='right'){
        location.href = "yourwork";
    }else{
        sessionStorage.setItem('workon', 'left')
        location.href = "work";
    }
}

$(function (){
    $(document).on('click', '.updateComment', function() {
        var widx = $(this).attr("data-widx");
        var wcidx = $(this).attr("data-wcidx");
        var li = $(this).closest(".commentList");
        var commentBtns = li.find(".commentBtns div");
        var content = li.find("pre").text();

        var btn_html = '<button>수정완료</button>';
        btn_html += '<button type="button" data-widx="'+widx+'" data-wcidx="'+wcidx+'" class="cancelBtn">수정취소</button>';
        commentBtns.html(btn_html);
        li.find("pre").remove();
        li.append("<textarea name='content'>"+content+"</textarea>");
    });

    $(document).on('click', '.cancelBtn', function() {
        var widx = $(this).attr("data-widx");
        var wcidx = $(this).attr("data-wcidx");
        var li = $(this).closest(".commentList");
        var commentBtns = li.find(".commentBtns div");
        var content = li.find("textarea").val();

        var btn_html = '<button type="button" data-widx="'+widx+'" data-wcidx="'+wcidx+'" class="deleteComment">댓글삭제</button>';
        btn_html += '<button type="button" data-widx="'+widx+'" data-wcidx="'+wcidx+'" class="updateComment">댓글수정</button>';

        commentBtns.html(btn_html);
        li.find("textarea").remove();
        li.append("<pre>"+content+"</pre>");
    });

    $(document).on('click','.deleteComment',function (){
        var widx = $(this).attr("data-widx");
        var wcidx = $(this).attr("data-wcidx");
        if (confirm("댓글을 삭제하시겠습니까?")) {
            location.href = "deleteComment?widx="+widx+"&wcidx="+wcidx;
        }
    });
});