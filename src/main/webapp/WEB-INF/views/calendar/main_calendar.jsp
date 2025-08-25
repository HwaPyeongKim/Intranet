<%--
  Created by IntelliJ IDEA.
  User: JAVA
  Date: 2025-08-22
  Time: 오후 3:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 달력 출력을 위해 밑 두개 스크립트 실행 필요 --%>
<%-- calendar.jsp 와는 내용이 다름에 주의 --%>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script>
    // 원본 https://greed-yb.tistory.com/274
    /*
        메인페이지에서는 일정의 추가 수정 삭제가 불가능, 버튼 삭제
        달력 클릭시 일정관리 페이지로 진입
    */

    $(document).ready(function () {
        let calendarTag = $('#calendar')[0];                    // full-calendar 생성하기
        let calendar = new FullCalendar.Calendar(calendarTag, {
            height: '350px',                        // calendar 높이 설정
            expandRows: true,                       // 화면에 맞게 높이 재설정
            slotMinTime: '00:00',                   // Day 캘린더에서 시작 시간
            slotMaxTime: '23:59',                   // Day 캘린더에서 종료 시간

            customButtons: {                        // 사용자가 만드는 버튼
            //    일정관리 버튼 없음
            },
            // 해더에 표시할 툴바
            headerToolbar: {                                // customButton 은 left 또는 right 안에 넣으면 적용 된다
                // 달력으로만 볼수있고(주단위, 일단위 불가능) 다른달로의 이동 불가능
                left: '',
                center: 'title',
                right: ''
            },
            initialView: 'dayGridMonth',    // 로드 될때 캘린더 화면 기본 설정
            // initialDate: '2024-07-23',      // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
            navLinks: false,                 // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
            editable: false,                 // default : false 이벤트 드래그 등의 편집여부를 설정함
            selectable: true,               // 일자 드래그 설정
            nowIndicator: true,             // 현재 시간 마크
            dayMaxEvents: true,             // 이벤트가 많아지면 + 로 이벤트 표시
            locale: 'ko',                   // 한국어 설정
            dayCellContent: function(info){
                var number = document.createElement("a");
                number.classList.add("fc-daygrid-day-number");
                number.innerHTML=info.dayNumberText.replace("일",'');// 한국어 설정시 날짜 뒤에 붙는 '일' 제거
                if(info.view.type === "dayGridMonth"){
                    return{
                        html: number.outerHTML
                    };
                }
                return{
                    domNodes:[]
                };
            },
            eventAdd: function (obj) {      // 이벤트 추가 시 발생
                console.log("eventAdd : " + obj);
            },
            eventChange: function (obj) {    // 이벤트 수정 시 발생
                console.log("eventChange : " + obj);
            },
            eventRemove: function (obj) {     // 이벤트 삭제 시 발생
                console.log("eventRemove : " + obj);
            },
            select: function () {
                console.log(location.href="/schedule");
                location.href="/schedule";
            },
            eventClick: function (arg) {
            },
            eventDrop: function(arg) {              // 일정을 이동시킬때, 드래그하여 시작일과 종료일이 변경되는 경우 동작
            },
            eventResize: function(arg) {            // 일정의 크기를 변경시킬때 동작(일정을 늘릴때)
            },
            // 이벤트
            events: [
                $.ajax({
                    type: "get",
                    url: "/calendarList",
                    success: function (data) {
                        // 부서 분류별로 수정가능여부, 색상 추가
                        if (data != null) {
                            for (let i = 0; i < data.length; i++) {
                                calendar.addEvent({
                                    id: data[i].calendarNo,
                                    title: data[i].title,
                                    start: data[i].start1,
                                    end: data[i].end,
                                    allDay: data[i].allDay,
                                    editable: false, // 메인페이지에선 수정불가
                                    category: data[i].category,
                                    backgroundColor: data[i].eventColor,
                                    borderColor: data[i].eventColor
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
