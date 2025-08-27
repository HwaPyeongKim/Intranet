$(function(){
   $(".gnb > li > span").click(function(){
        $(this).closest("li").find("ul").slideToggle();
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
                $(".loginProfile .messageBox i").css("display","inline-block").text(count);
            } else {
                $(".loginProfile .messageBox i").css("display","none").text("0");
            }
        },
        error: function() {
            console.log("새로운 메세지를 가져오는데 실패했습니다.");
        }
    })
});