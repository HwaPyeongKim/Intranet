function deleteBoard() {
    var bidx = document.adminBoardInfo.bidx;
    var datas = [];
    if (bidx.length == undefined) {
        if (bidx.checked == true) {
            datas.push(bidx.value);
        }
    } else if (bidx.length > 1) {
        for (i=0; i<bidx.length; i++) {
            if (bidx[i].checked == true) {
                datas.push(bidx[i].value);
            }
        }
    }

    if (datas.length > 0) {
        if (confirm("선택한 게시글을 삭제하시겠습니까?")) {
            $.ajax({
                url: "deleteBoard",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(datas),
                success: function(response) {
                    alert("게시글이 삭제되었습니다.");
                    window.location.reload();
                },
                error: function() {
                    alert("오류가 발생했습니다. 관리자에게 문의해주세요.");
                }
            })
        }
    } else {
        alert("삭제할 게시글을 선택해주세요.");
    }
}

function showBoard(showyn) {
    var c_showyn = showyn == 'Y' ? '노출' : '미노출';
    var bidx = document.adminBoardInfo.bidx;
    var datas = [];
    if (bidx.length == undefined) {
        if (bidx.checked == true) {
            var data = [bidx.value, showyn];
            datas.push(data);
        }
    } else if (bidx.length > 1) {
        for (i=0; i<bidx.length; i++) {
            if (bidx[i].checked == true) {
                var data = [bidx[i].value, showyn];
                datas.push(data);
            }
        }
    }

    if (datas.length > 0) {
        if (confirm("선택한 게시글을 "+c_showyn+" 처리하시겠습니까?")) {
            $.ajax({
                url: "showBoard",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(datas),
                success: function(response) {
                    alert("게시글이 "+c_showyn+" 처리되었습니다.");
                    window.location.reload();
                },
                error: function() {
                    alert("오류가 발생했습니다. 관리자에게 문의해주세요.");
                }
            })
        }
    } else {
        alert(c_showyn + "처리할 게시글을 선택해주세요.");
    }
}