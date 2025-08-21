<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="../header.jsp"%>
<link rel="stylesheet" href="/css/calendar.css">
<%-- 달력 출력을 위해 밑 두개 스크립트 실행 필요 --%>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script>
    // 원본 https://greed-yb.tistory.com/274
    /*
        수정사항
        로그인 유저만 일정을 볼수있고 추가할수 있음
    */

    $(document).ready(function () {
        let calendarTag = $('#calendar')[0];                    // full-calendar 생성하기
        let calendar = new FullCalendar.Calendar(calendarTag, {
            height: '550px',                        // calendar 높이 설정
            expandRows: true,                       // 화면에 맞게 높이 재설정
            slotMinTime: '00:00',                   // Day 캘린더에서 시작 시간
            slotMaxTime: '23:59',                   // Day 캘린더에서 종료 시간

            customButtons: {                        // 사용자가 만드는 버튼
                allSchedule: {
                    text: "전체일정",
                    click: function (){
                        var events = calendar.getEvents();
                        for(var i=0; i<events.length; i++){
                            events[i].setProp('display', 'auto');
                        }
                    }
                },
                mySchedule: {
                    text: "나의일정",
                    click: function (){
                        var events = calendar.getEvents();
                        for(var i=0; i<events.length; i++){
                            if(events[i].extendedProps.category==1){
                                events[i].setProp('display', 'auto');
                            }else{
                                events[i].setProp('display', 'none');
                            }
                        }
                    }
                },
                teamSchedule: {
                    text: "부서일정",
                    click: function (){
                        var events = calendar.getEvents();
                        for(var i=0; i<events.length; i++){
                            if(events[i].extendedProps.category==2){
                                events[i].setProp('display', 'auto');
                            }else{
                                events[i].setProp('display', 'none');
                            }
                        }
                    }
                },
                comSchedule: {
                    text: "회사일정",
                    click: function (){
                        var events = calendar.getEvents();
                        for(var i=0; i<events.length; i++){
                            if(events[i].extendedProps.category==3){
                                events[i].setProp('display', 'auto');
                            }else{
                                events[i].setProp('display', 'none');
                            }
                        }
                    }
                }
            },
            // 해더에 표시할 툴바
            headerToolbar: {                                // customButton 은 left 또는 right 안에 넣으면 적용 된다
                left: 'prevYear,prev,next,nextYear today',  // today는 , 와 띄어쓰기에 따라서 위치가 바뀐다
                // left: 'prev,next,today',
                center: 'title',
                right: 'allSchedule,mySchedule,teamSchedule,comSchedule'
            },
            footerToolbar: {                                // customButton 은 left 또는 right 안에 넣으면 적용 된다
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
            select: function (arg) {
                // 일자를 드래그하면 실행됨
                // 비로그인시 일정추가 기능 사용 불가능
                if(${empty loginUser}){
                    alert('로그인이 필요합니다');
                    return;
                }
                // 일정 제목 외에 일정의 분류가 추가되야함
                // 프롬프트가 아니라 팝업창이 떠야함
                // 임시로 그냥 프롬프트 두개로 분류를 입력받음

                let title = prompt('일정과 분류를 입력하세요.\n\n일정 입력');
                if(!title){
                    return; // 일정 제목을 입력하지 않으면 취소
                }
                let category = prompt('일정과 분류를 입력하세요.\n\n분류 입력, 1:개인, 2:부서, 3:회사');

                // 일정은 1, 2, 3중에 입력, 권한기능이 필요할것 같음
                // 부서일정, 전체일정은 개인이 수정할수 없음 (editable 속성)

                if(!(category==1||category==2||category==3)){
                    alert('일정의 분류가 잘못 입력되었습니다.');
                    return;
                }
                if (title) {
                    let newData = {
                        title: title,
                        start: arg.start,
                        end: arg.end,
                        allDay: arg.allDay,
                        category: category
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
                                    editable: data.editable,
                                    category: data.category,
                                    backgroundColor: data.eventColor,
                                    borderColor: data.eventColor
                                });
                            }else{
                                alert('로그인이 필요합니다');
                            }
                        }
                    })
                }
                calendar.unselect()
            },
            eventClick: function (arg) {
                console.log(arg.event);
                // 일정 클릭 시
                if(!arg.event.startEditable){
                    return; // 수정 불가능한 일정이면 동작하지 않음
                }
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
                        // 부서 분류별로 수정가능여부, 색상 추가
                        if (data != null) {
                            for (let i = 0; i < data.length; i++) {
                                calendar.addEvent({
                                    id: data[i].calendarNo,
                                    title: data[i].title,
                                    start: data[i].start1,
                                    end: data[i].end,
                                    allDay: data[i].allDay,
                                    editable: data[i].editable,
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
<div class="form-group">
    <div id='calendar-container'><%--  여기에 스타일 적용       --%>
        <div id="calendar"></div>
    </div>
</div>

<%@ include file="../footer.jsp"%>
