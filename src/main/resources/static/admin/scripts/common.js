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
        alert("가입 승인할 회원을 선택해주세요.");
        return;
    } else {
        document.adminMemberInfo.action = 'confirmJoin';
        document.adminMemberInfo.submit();
    }

}


$(function(){
   $(".gnb > li > span").click(function(){
        $(this).closest("li").find("ul").slideToggle();
   });
});