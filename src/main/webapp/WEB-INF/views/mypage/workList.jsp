<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<ul class="submenu">
    <li class="on"><a href="workList">나의업무</a></li>
    <li><a href="vacationList">연차/반차 신청</a></li>
    <li><a href="profile">프로필</a></li>
</ul>
<section>
    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <select name="type">
                    <option value="title"<c:if test="${type == 'title'}"> selected</c:if>>업무명</option>
                    <option value="titleContent"<c:if test="${type == 'titleContent'}"> selected</c:if>>업무명+내용</option>
                    <option value="name"<c:if test="${type == 'name'}"> selected</c:if>>요청자</option>
                </select>
                <input type="text" name="key" value="${key}" />
                <button>검색</button>
            </div>
        </div>
    </form>

    <div class="table">
        <div class="row head">
            <div class="col">번호</div>

            <div class="col title">
                <span data-sort="title">제목<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'title', 'writedate', 'desc')}"></i></span>
            </div>
            <div class="col">
                <span data-sort="empname">요청자<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'empname', 'writedate', 'desc')}"></i></span>
            </div>
            <div class="col">
                <span data-sort="writedate">등록일<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'writedate', 'writedate', 'desc')}"></i></span>
            </div>
            <div class="col">
                <span data-sort="completedate">마감일<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'completedate', 'writedate', 'desc')}"></i></span>
            </div>
            <div class="col">
                <span data-sort="status">진행상태<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'status', 'writedate', 'desc')}"></i></span>
            </div>
        </div>
        <c:choose>
            <c:when test="${empty list}">
                <div class="row empty">
                    <div class="col">나의업무가 존재하지 않습니다.</div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${list}" var="item">
                    <div class="row tbody">
                        <div class="col">${item.loopnum}</div>
                        <div class="col title">
                            <a href="workView?widx=${item.widx}" target="_blank">
                                ${item.title}
                                <c:if test="${fn:substring(item.writedate, 0, 10) == today}"><span class="new"> New</span></c:if>
                            </a>
                        </div>
                        <div class="col">${item.empname}</div>
                        <div class="col"><fmt:formatDate value="${item.writedate}" pattern="yyyy-MM-dd" /></div>
                        <div class="col"><fmt:formatDate value="${item.completedate}" pattern="yyyy-MM-dd" /></div>
                        <div class="col">
                            <c:choose>
                                <c:when test='${item.status=="1"}'>대기중</c:when>
                                <c:when test='${item.status=="2"}'>진행중</c:when>
                                <c:when test='${item.status=="3"}'>보류</c:when>
                                <c:when test='${item.status=="4"}'>반려</c:when>
                                <c:when test='${item.status=="5"}'>검토중</c:when>
                                <c:otherwise>완료</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <c:if test="${not empty list}">
        <div class="paging">
            <c:if test="${paging.prev}"><a href="workList?page=${paging.beginPage-1}">Prev</a></c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <a href="workList?page=${index}"<c:if test="${index == paging.page}"> style="color: red;"</c:if>>${index}</a>
            </c:forEach>

            <c:if test="${paging.next}"><a href="workList?page=${paging.endPage+1}">Next</a></c:if>
        </div>
    </c:if>

</section>
<script>
    sessionStorage.setItem('workon', 'left')
</script>
<%@ include file="../footer.jsp" %>