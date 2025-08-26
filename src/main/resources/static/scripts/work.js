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

function changeWorkStatus(widx, status, next) {
    if (status == 1) {
        if (!confirm("업무를 진행하시겠습니까?")) {
            return;
        }
    } else if (next == 5) {
        if (!confirm("검토 요청하시겠습니까?")) {
            return;
        }
    } else if (status == 5 && next == 3) {
        if (!confirm("보류하시겠습니까?")) {
            return;
        }
    } else if (status == 5 && next == 4) {
        if (!confirm("반려하시겠습니까?")) {
            return;
        }
    } else if (status == 5 && next == 6) {
        if (!confirm("승인하시겠습니까?")) {
            return;
        }
    }  location.href = "changeWorkStatus?widx="+widx+"&status="+status+"&next="+next;

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
        li.find("input[name=prevText]").val(content);
        li.find("pre").remove();
        li.append("<textarea name='content'>"+content+"</textarea>");
    });

    $(document).on('click', '.cancelBtn', function() {
        var widx = $(this).attr("data-widx");
        var wcidx = $(this).attr("data-wcidx");
        var li = $(this).closest(".commentList");
        var commentBtns = li.find(".commentBtns div");
        var content = li.find("input[name=prevText]").val();

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