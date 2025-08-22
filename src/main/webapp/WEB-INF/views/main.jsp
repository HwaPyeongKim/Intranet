<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<%@ include file="calendar/main_calendar.jsp" %>
<main>
    <h1>메인페이지 입니다</h1>

    <div class="form-group">
        <div id='calendar-container' style="width: 350px"><%--  여기에 캘린더 스타일 적용(가로크기 등)       --%>
            <div id="calendar"></div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>