<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<%@ include file="calendar/main_calendar.jsp" %>
<main>

    <div class="dashboard-container">
        <!-- 왼쪽 사이드 -->
        <div class="left-section">
            <div class="profile-section">
                <div class="profile-card">
                    <div class="profile-image">
                        <img src="${profileImg}" class="profileImg" />
                    </div>
                    <div class="profile-name">${loginUser.name}&nbsp;${loginUser.position}</div>
                </div>

                <div class="inout-info">
                    <div class="in_time timebox">
                        <div class="title">출근시간</div>
                        <div class="time">${starttime}</div>
                    </div>
                    <div class="out_time timebox">
                        <div class="title">퇴근시간</div>
                        <div class="time">18:50:02</div>
                    </div>
                </div>
<%--                <div class="main_btn_out">퇴근하기</div>--%>
            </div>


            <div class="calendar-section">
                <div id='calendar-container' style=""><%--  여기에 캘린더 스타일 적용(가로크기 등) --%>
                    <div id="calendar"></div>
                </div>
            </div>
        </div>


        <!-- 메인 콘텐츠 -->
        <div class="main-section">

            <div class="announcement">
                <button class="btn-announcement">오늘의공지</button>
                <div class="announcement-text"><a>오늘의공지제목들어감</a></div>
            </div>
            <div class="main_widget_box">
                <a class="widget" onclick="location.href='writeVacationForm'">
                    <i class="far fa-calendar"></i>
                    휴가신청
                </a>
                <a class="widget" onclick="location.href='requestsWriteForm'">
                    <i class="far fa-edit"></i>
                    기안작성
                </a>
                <a class="widget" onclick="location.href='requestsWriteForm'">
                    <i class="far fa-file-alt"></i>
                    업무요청
                </a>
                <a class="widget" onclick="location.href='requestsWriteForm'">
                    <i class="far fa-envelope"></i>
                    메세지작성
                </a>
            </div>
            <div class="main_apwork_wrap">
                <div class="approval-docs">
                    <h4 class="title">결재할 문서</h4>
                    <ul class="approval-list">
                        <li><span class="dot blue"></span> 하루 - 경비신청서</li>
                        <li><span class="dot green"></span> 일주일 - 인사평형</li>
                        <li><span class="dot orange"></span> 완료 - 휴가신청서</li>
                        <li><span class="dot red"></span> 이후 - 경비신청서</li>
                    </ul>
                </div>

                <div class="work-status">
                    <h4 class="title">처리할 업무</h4>
                    <ul class="work-list">
                        <li>(급급) KT Cloud 연결 중...</li>
                        <li>비즈오피스 정기 업데이트...</li>
                        <li>비즈오피스 정기 업데이트...</li>
                    </ul>
                </div>
            </div>
            <div class="main_cal_week">

            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>