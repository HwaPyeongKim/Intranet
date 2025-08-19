<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <!-- Tyhmeleaf 미적용 -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
    <script
            src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous"></script>
    <script>
        // 원본 https://greed-yb.tistory.com/274
        // 수정사항 없음
        $(document).ready(function () {
            let calendarTag = $('#calendar')[0];                    // full-calendar 생성하기
            let calendar = new FullCalendar.Calendar(calendarTag, {
                height: '550px',                        // calendar 높이 설정
                expandRows: true,                       // 화면에 맞게 높이 재설정
                slotMinTime: '00:00',                   // Day 캘린더에서 시작 시간
                slotMaxTime: '23:59',                   // Day 캘린더에서 종료 시간

                customButtons: {                        // 사용자가 만드는 버튼
                    testButton: {
                        text: "테스트버튼"
                    }
                },
                // 해더에 표시할 툴바
                headerToolbar: {                                // customButton 은 left 또는 right 안에 넣으면 적용 된다
                    left: 'prevYear,prev,next,nextYear today',  // today는 , 와 띄어쓰기에 따라서 위치가 바뀐다
                    // left: 'prev,next,today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                },
                initialView: 'dayGridMonth',    // 로드 될때 캘린더 화면 기본 설정
                // initialDate: '2024-07-23',      // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
                navLinks: true,                 // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
                editable: true,                 // default : false 이벤트 드래그 등의 편집여부를 설정함
                selectable: true,               // 일자 드래그 설정
                nowIndicator: true,             // 현재 시간 마크
                dayMaxEvents: true,             // 이벤트가 많아지면 + 로 이벤트 표시
                locale: 'ko',                   // 한국어 설정
                eventAdd: function (obj) {      // 이벤트 추가 시 발생
                    console.log("eventAdd : " + obj);
                },
                eventChange: function (obj) {    // 이벤트 수정 시 발생
                    console.log("eventChange : " + obj);
                },
                eventRemove: function (obj) {     // 이벤트 삭제 시 발생
                    console.log("eventRemove : " + obj);
                },
                select: function (arg) {          // 일자를 드래그하면 실행됨
                    let title = prompt('일정 입력');
                    if (title) {
                        let newData = {
                            title: title,
                            start: arg.start,
                            end: arg.end,
                            allDay: arg.allDay
                        }

                        $.ajax({
                            url: "/calendarSave",
                            method: "POST",
                            dataType: "json",
                            data: JSON.stringify(newData),
                            contentType: 'application/json',
                            success:function (data){
                                if(data != null){
                                    calendar.addEvent({
                                        id: data.calendarNo,
                                        title: data.title,
                                        start: data.start1,
                                        end: data.end,
                                        allDay: data.allDay,
                                        editable: true                 // default : false 이벤트 드래그 등의 편집여부를 설정함
                                    });
                                }
                            }
                        })
                    }
                    calendar.unselect()
                },
                eventClick: function (arg) {
                    // 일정 클릭 시
                    if (confirm("선택한 일정을 삭제하시겠습니까?")) {
                        $.ajax({
                            type: "DELETE",
                            url: "/calendarDelete",
                            data: {"no" : arg.event.id},
                            success: function (data) {
                                if (data == "success") {
                                    alert("삭제하였습니다.");
                                    arg.event.remove();
                                }else{
                                    alert("오류가 발생하였습니다");
                                }
                            }
                        })
                    }
                },
                eventDrop: function(arg) {              // 일정을 이동시킬때, 드래그하여 시작일과 종료일이 변경되는 경우 동작
                    let event = {
                        id: arg.event.id,
                        title: arg.event.title,
                        start1: arg.event._instance.range.start,
                        end: arg.event._instance.range.end ? arg.event._instance.range.end : null,
                        allDay: arg.event.allDay
                    };
                    $.ajax({
                        url: '/eventUpdate/' + arg.event.id,
                        method: 'PUT',
                        contentType: 'application/json',
                        data: JSON.stringify(event)
                    });
                },
                eventResize: function(arg) {            // 일정의 크기를 변경시킬때 동작(일정을 늘릴때)
                    let event = {
                        id: arg.event.id,
                        title: arg.event.title,
                        start1: arg.event._instance.range.start,
                        end: arg.event._instance.range.end ? arg.event._instance.range.end : null,
                        allDay: arg.event.allDay
                    };
                    $.ajax({
                        url: '/eventUpdate/' + arg.event.id,
                        method: 'PUT',
                        contentType: 'application/json',
                        data: JSON.stringify(event)
                    });
                },
                // 이벤트
                events: [
                    $.ajax({
                        type: "get",
                        url: "/calendarList",
                        success: function (data) {
                            if (data != null) {
                                for (let i = 0; i < data.length; i++) {
                                    calendar.addEvent({
                                        id: data[i].calendarNo,
                                        title: data[i].title,
                                        start: data[i].start1,
                                        end: data[i].end,
                                        allDay: data[i].allDay,
                                        editable: true                 // default : false 이벤트 드래그 등의 편집여부를 설정함
                                    })
                                }
                            }
                        }
                    })
                ]
            });
            // 캘린더 랜더링
            calendar.render();

        });
    </script>

</head>
<body>
<div class="form-group">
    <div id='calendar-container'>
        <div id="calendar"></div>
    </div>
</div>

</body>
</html>