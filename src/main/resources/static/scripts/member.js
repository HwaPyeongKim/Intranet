function idChk() {
    var userid = document.join.userid.value;
    if (userid.trim() == "") {
        alert("아이디를 입력해주세요.");
        return;
    }
    var url = "chkIdForm?userid="+userid;
    var option = "width=500, height= 300, left=100, top=100, menubar=no, location=no, status=no, resizable=no, scrollbars=no";
    window.open(url,"chkId",option);
}

$(function(){
    $("#chkUserid").click(function (){
        var userid = document.join.userid.value;
        if (userid.trim() == "") {
            alert("아이디를 입력해주세요.");
            return;
        }

        var Form = $('.form')[0];
        var formData = new FormData(Form);

        $.ajax(
            {
                url: "/idcheck",
                type: "POST",
                enctype: "multipart/form-data",
                data: formData,
                timeout: 10000,
                contentType: false,
                processData: false,
                success:function( response ){
                    if( response.result == 1){
                        $('#idcheck').text("사용가능한 아이디입니다.");
                        $('#useridChk').val(response.userid);
                    }else{
                        $('#idcheck').text("이미 사용중인 아이디입니다.");
                        $('#useridChk').val("");
                    }
                },
                error:function(){
                    alert('중복조회 중 에러가 발생했습니다. 관리자에게 문의하세요');
                }
            }
        );
    });
})