function confirmJoin() {
    var count = 0;
    var midxes = document.adminMemberInfo.midx;
    if (midxes.length == undefined) {
        if (midxes.checked == true) {
            count++;
        }
    } else if (midxes.length > 1) {
        for (i=0; i<midxes.length; i++) {
            if (midxes[i].checked == true) {
                count++;
            }
        }
    }
    if (count == 0) {
        alert("가입 승인할 직원을 선택해주세요.");
        return;
    } else {
        document.adminMemberInfo.action = 'confirmJoin';
        document.adminMemberInfo.submit();
    }
}

function checkLeave() {
    var c_midx = "";
    var midxes = document.adminMemberInfo.midx;
    if (midxes.length == undefined) {
        if (midxes.checked == true) {
            c_midx = midx.value;
        }
    } else if (midxes.length > 1) {
        for (i=0; i<midxes.length; i++) {
            if (midxes[i].checked == true) {
                c_midx += c_midx === "" ? midxes[i].value : "," + midxes[i].value;
            }
        }
    }
    if (c_midx == "") {
        alert("퇴사 처리할 직원을 선택해주세요.");
        return;
    } else {
        var url = "updateLeaveForm?midxes=" + c_midx;
        var option = "width=500, height=400, left=100, top=100, menubar=no, location=no, status=no, resizable=no, scrollbars=yes";
        window.open(url,"updateLeaveForm",option);
    }
}

function updateLeave() {
    if (confirm("정말로 퇴사처리 하시겠습니까?")) {
        var leavedate = document.updateLeaveForm.leavedate;
        var datas = [];
        if (leavedate.length == undefined) {
            if (!leavedate.value) {
                alert("퇴사일을 선택해주세요.");
                return;
            }
            var data = [leavedate.attributes.midx.value, leavedate.value];
            datas.push(data);
        } else if (leavedate.length > 1) {
            for (i=0; i<leavedate.length; i++) {
                if (!leavedate[i].value) {
                    alert("퇴사일을 선택해주세요.");
                    return;
                }
                var data = [leavedate[i].attributes.midx.value, leavedate[i].value];
                datas.push(data);
            }
        }

        if (datas.length > 0) {
            $.ajax({
                url: "updateLeave",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(datas),
                success: function(response) {
                    confirm("퇴사처리되었습니다.");
                    if (window.opener && !window.opener.closed) {
                        window.opener.location.reload();
                    }
                    window.close();
                },
                error: function() {
                    alert("오류가 발생했습니다. 관리자에게 문의해주세요.");
                }
            })
        }
    } else {
        return;
    }
}


$(function(){
   $(".gnb > li > span").click(function(){
        $(this).closest("li").find("ul").slideToggle();
   });
});