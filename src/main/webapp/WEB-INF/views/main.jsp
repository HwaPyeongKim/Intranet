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
                        <div class="time"><fmt:formatDate value="${madto.starttime}" pattern="HH:mm:ss" /></div>
                    </div>
                    <div class="out_time timebox">
                        <div class="title">퇴근시간</div>
                        <div class="time"><fmt:formatDate value="${madto.endtime}" pattern="HH:mm:ss" /></div>
                    </div>
                </div>
                <div class="main_inout_btnbox">
                    <button type="button" onclick="location.href='logout'" class="logout">로그아웃</button>
                    <button type="button" data-midx="${loginUser.midx}" id="workoutBtn" class="out">퇴근하기</button>
                </div>
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
                <c:choose>
                    <c:when test="${not empty mainNotice && not empty noticeBoard}">
                        <button class="btn-announcement" onclick="location.href='viewBoard?bidx=${mainNotice}'">주요 공지</button>
                        <div class="announcement-text">
                            <a onclick="location.href='viewBoard?bidx=${mainNotice}'">${noticeBoard.title}</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <button class="btn-announcement">주요 공지</button>
                        <div class="announcement-text">
                            <a>주요 공지 없음</a>
                        </div>
                    </c:otherwise>
                </c:choose>
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
                <a class="widget" onclick="location.href='insertWorkForm'">
                    <i class="far fa-file-alt"></i>
                    업무요청
                </a>
                <a class="widget" onclick="location.href='writemsg'">
                    <i class="far fa-envelope"></i>
                    메세지작성
                </a>
            </div>
            <div class="main_apwork_wrap">
                <div class="approval-docs">
                    <h4 class="title">결재할 문서</h4>
                    <ul class="approval-list">
                        <c:forEach items="${mrdtoList}" var="item">
                                 <li><a href="getListDetail?ridx=${item.ridx}">${item.title}</a></li>
                        </c:forEach>
                    </ul>
                </div>

                <div class="work-status">
                    <h4 class="title">처리할 업무</h4>
                    <ul class="work-list">
                        <c:forEach items="${workList}" var="item">
                             <li>
                                 <a href="workView?widx=${item.widx}">
                                     <c:if test="${item.cdate == today}">
                                        <span class="dot red"></span>
                                    </c:if>
                                    <span class="worktitle">${item.title}</span>

                                 </a>
                                 <span class="enddate">~&nbsp;<fmt:formatDate value="${item.completedate}" pattern="MM-dd" /></span>
                             </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="main_cal_week">

            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>