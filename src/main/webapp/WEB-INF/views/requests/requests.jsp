<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/requests.css">
<ul class="submenu">
    <li class="on"><a href="requests">결재발신함</a></li>
    <li><a href="getList">결재수신함</a></li>
</ul>
<section id="requests" class="section_wrap">
    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <select name="type">
                    <option value="title"<c:if test="${type == 'title'}"> selected</c:if>>제목</option>
                    <option value="titleContent"<c:if test="${type == 'titleContent'}"> selected</c:if>>제목+내용</option>
                    <option value="name"<c:if test="${type == 'name'}"> selected</c:if>>결재자</option>
                </select>
                <input type="text" name="key" value="${key}"/>
                <button>검색</button>
            </div>
            <div class="boxBtns clearfix" style="display: flex; align-items: center; justify-content: end">
                <input type="button" name="btn_search" value="기안작성" onclick="location.href='requestsWriteForm'"/>&nbsp;
            </div>
        </div>
    </form>

    <form method="get" name="requests" class="">
        <table class="tb table_default">
            <colgroup>
                <col style="width: 10%;">
                <col style="width: 15%;">
                <col style="">
                <col style="width: 15%;">
                <col style="width: 15%;">
                <col style="width: 15%;">
            </colgroup>
            <thead>
            <tr class="row_title">
                <th>번호</th>
                <th><span data-sort="category">구분<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'category', 'writedate', 'desc')}"></i></span></th>
                <th><span data-sort="title">제목<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'title', 'writedate', 'desc')}"></i></span></th>
                <th><span data-sort="writedate">작성일자<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'writedate', 'writedate', 'desc')}"></i></span></th>
                <th><span data-sort="confirm_midx">결재자<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'confirm_midx', 'writedate', 'desc')}"></i></span></th>
                <th><span data-sort="status">진행상태<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'status', 'writedate', 'desc')}"></i></span></th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty requestsList}">
                    <tr class="empty">
                        <td colspan="6">게시물이 존재하지 않습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${requestsList}" var="requests">
                        <tr>
                            <td>${requests.loopnum}</td>
                            <td>
                                <c:choose>
                                    <c:when test='${requests.category=="1"}'>업무기안</c:when>
                                    <c:when test='${requests.category=="5"}'>증명서/문서</c:when>
                                    <c:when test='${requests.category=="6"}'>품의/지출</c:when>
                                    <c:otherwise>휴가신청</c:otherwise>
                                </c:choose>
                            </td>
                            <td style="cursor:pointer; text-align: left">
                                <a href="requestsDetail?ridx=${requests.ridx}">${requests.title}</a>
                            </td>
                            <td><fmt:formatDate value="${requests.writedate}" pattern="yyyy-MM-dd"/></td>
                            <td>${requests.cname}&nbsp;${requests.cposition}</td>
                            <td>
                                <c:choose>
                                    <c:when test='${requests.status=="1"}'>대기중</c:when>
                                    <c:when test='${requests.status=="2"}'>처리중</c:when>
                                    <c:when test='${requests.status=="3"}'>반려</c:when>
                                    <c:otherwise>승인</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
        <div class="paging"> <!-- 페이지의 시작 -->
            <div class="col" style="font-size: 120%; font-weight: bold;">
                <c:if test="${paging.prev}">
                    <a href="requests?page=${paging.beginPage-1}&type=${type}&key=${key}&sort=${sort}&dir=${dir}">PREV</a>&nbsp;
                </c:if>
                <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                    <c:if test="${index!=paging.page}">
                        <a href="requests?page=${index}&type=${type}&key=${key}&sort=${sort}&dir=${dir}">${index}</a>&nbsp;
                    </c:if>
                    <c:if test="${index==paging.page}">
                        <span style="color:red">${index}&nbsp;</span>
                    </c:if>
                </c:forEach>
                <c:if test="${paging.next}">
                    <a href="requests?page=${paging.endPage+1}&type=${type}&key=${key}&sort=${sort}&dir=${dir}">NEXT</a>&nbsp;
                </c:if>
            </div>
        </div> <!-- 페이지의 끝 -->
<%--            <c:if test="${not empty requests}">--%>
<%--                <div class="paging">--%>
<%--                    <c:if test="${paging.prev}"><a href="requests?page=${paging.beginPage-1}&type=${type}&key=${key}&sort=${sort}&dir=${dir}">Prev</a></c:if>--%>

<%--                    <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">--%>
<%--                        <a href="requests?page=${index}"<c:if test="${index == paging.page}&type=${type}&key=${key}&sort=${sort}&dir=${dir}"> style="color: red;"</c:if>>${index}</a>--%>
<%--                    </c:forEach>--%>

<%--                    <c:if test="${paging.next}"><a href="requests?page=${paging.endPage+1}&type=${type}&key=${key}&sort=${sort}&dir=${dir}">Next</a></c:if>--%>
<%--                </div>--%>
<%--            </c:if>--%>
    </form>
</section>

<%@ include file="../footer.jsp" %>