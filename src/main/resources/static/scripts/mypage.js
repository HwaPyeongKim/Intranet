$(function (){

    $("#writeVacation input[name=category]").change(function(){
        var val_category = $(this).val();
        var inputDate = $("#writeVacation .inputDate");

        if (val_category == 2) {
            var c_html = '<label>시작/종료날짜</label>';
            c_html += '<div><input type="date" name="startdate" /><span> ~ </span><input type="date" name="enddate" /></div>';
            inputDate.html(c_html);
        } else {
            var c_html = '<label>날짜</label>';
            c_html += '<div><input type="date" name="startdate" /><input type="hidden" name="enddate" /></div>';
            inputDate.html(c_html);
        }
    });

});