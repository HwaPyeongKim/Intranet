<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<ul class="submenu">
    <li><a href="workList">나의업무</a></li>
    <li class="on"><a href="vacationList">연차/반차 신청</a></li>
    <li><a href="profile">프로필</a></li>
</ul>
<section>
    <div class="boxBtns clearfix">
        <button type="button" onclick="location.href='writeVacationForm'">신청하기</button>
    </div>

    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <select name="type">
                    <option value="title"<c:if test="${type == 'title'}"> selected</c:if>>제목</option>
                    <option value="titleContent"<c:if test="${type == 'titleContent'}"> selected</c:if>>제목+사유</option>
                    <option value="cname"<c:if test="${type == 'cname'}"> selected</c:if>>결재자</option>
                </select>
                <input type="text" name="key" value="${key}" />
                <button>검색</button>
            </div>
            <select name="sort" id="sort">
                <option value="desc" <c:if test="${sort == 'desc'}"> selected</c:if>>작성일 최근순</option>
                <option value="asc" <c:if test="${sort == 'asc'}"> selected</c:if>>작성일 오래된순</option>
            </select>
        </div>
    </form>

    <div class="table">
        <div class="row head">
            <div class="col">번호</div>
            <div class="col">종류</div>
            <div class="col title">제목</div>
            <div class="col">결재자</div>
            <div class="col">시작/종료일</div>
            <div class="col">작성일</div>
            <div class="col">처리상태</div>
        </div>
        <c:choose>
            <c:when test="${empty list}">
                <div class="row empty">
                    <div class="col">연차/반차 신청이 존재하지 않습니다.</div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${list}" var="item">
                    <div class="row">
                        <div class="col">${item.loopnum}</div>
                        <div class="col">
                            <c:choose>
                                <c:when test="${item.category == 2}">연차</c:when>
                                <c:when test="${item.category == 3}">오전반차</c:when>
                                <c:when test="${item.category == 4}">오후반차</c:when>
                                <c:otherwise>기타</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col title">
                            <a href="requestsDetail?ridx=${item.ridx}">
                                ${item.title}
                                <c:if test="${fn:substring(item.writedate, 0, 10) == today}"><span class="new"> New</span></c:if>
                            </a>
                        </div>
                        <div class="col">${item.cname}</div>
                        <div class="col"><fmt:formatDate value="${item.startdate}" pattern="yyyy-MM-dd" /><br /><fmt:formatDate value="${item.enddate}" pattern="yyyy-MM-dd" /></div>
                        <div class="col"><fmt:formatDate value="${item.writedate}" pattern="yyyy-MM-dd" /></div>
                        <div class="col">
                            <c:choose>
                                <c:when test="${item.status == 1}">대기중</c:when>
                                <c:when test="${item.status == 2}">처리중</c:when>
                                <c:when test="${item.status == 3}">반려</c:when>
                                <c:when test="${item.status == 4}">승인</c:when>
                                <c:otherwise>기타</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <c:if test="${not empty list}">
        <div class="paging">
            <c:if test="${paging.prev}"><a href="vacationList?page=${paging.beginPage-1}">Prev</a></c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <a href="vacationList?page=${index}"<c:if test="${index == paging.page}"> style="color: red;"</c:if>>${index}</a>
            </c:forEach>

            <c:if test="${paging.next}"><a href="vacationList?page=${paging.endPage+1}">Next</a></c:if>
        </div>
    </c:if>

</section>

<%@ include file="../footer.jsp" %>