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