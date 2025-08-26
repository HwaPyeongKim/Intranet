$(function(){
   $(".gnb > li > span").click(function(){
        $(this).closest("li").find("ul").slideToggle();
   });
});