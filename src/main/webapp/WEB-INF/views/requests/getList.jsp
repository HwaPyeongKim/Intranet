<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/requests.css">

<ul id="sub_menu" style="display: flex;">
    <li class="sub-menu-btn"><a href="requests">결재발신함</a></li>
    <li class="sub-menu-btn active"><a href="getList">결재수신함</a></li>
</ul>

<section id="getList" class="section_wrap">
    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <select name="type">
                    <option value="title"<c:if test="${type == 'title'}"> selected</c:if>>제목</option>
                    <option value="titleContent"<c:if test="${type == 'titleContent'}"> selected</c:if>>제목+내용</option>
                    <option value="name"<c:if test="${type == 'comfirm_midx'}"> selected</c:if>>작성자</option>
                </select>
                <input type="text" name="key" value="${key}"/>
                <button>검색</button>
            </div>
            <div class="boxBtns clearfix" style="display: flex; align-items: center; justify-content: end">
                <input type="button" name="btn_search" value="기안작성" onclick="location.href='requestsWriteForm'"/>&nbsp;
            </div>
<%--            <select name="sort" id="sort">--%>
<%--                <option value="desc" <c:if test="${sort == 'desc'}"> selected</c:if>>작성일 최근순</option>--%>
<%--                <option value="asc" <c:if test="${sort == 'asc'}"> selected</c:if>>작성일 오래된순</option>--%>
<%--            </select>--%>
        </div>
    </form>


    <form method="get" name="getList" class="">
    <table class="tb table_default">
        <thead>
            <colgroup>
                <col style="width: 10%;">
                <col style="width: 15%;">
                <col style="">
                <col style="width: 15%;">
                <col style="width: 15%;">
                <col style="width: 15%;">
            </colgroup>
            <tr class="row_title">
                <th>번호</th>
                <th>구분</th>
                <th>제목</th>
                <th>작성일자</th>
                <th>작성자</th>
                <th>진행상태</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty getList}">
                    <tr class="empty">
                        <td colspan="6">게시물이 존재하지 않습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${getList}" var="getList">
                        <tr>
                            <td>${getList.loopnum}</td>
                            <td>
                                <c:choose>
                                    <c:when test='${getList.category=="1"}'>업무기안</c:when>
                                    <c:when test='${getList.category=="5"}'>증명서/문서</c:when>
                                    <c:when test='${getList.category=="6"}'>품의/지출</c:when>
                                    <c:otherwise>휴가신청</c:otherwise>
                                </c:choose>
                            </td>
                            <td style="cursor:pointer;text-align: left">
                                <a href="getListDetail?ridx=${getList.ridx}">
                                    ${getList.title}
                                </a>
                            </td>
                            <td><fmt:formatDate value="${getList.writedate}" pattern="yyyy-MM-dd"/></td>
                            <td>${getList.mname}&nbsp;${getList.mposition}</td>
                            <td>
                                <c:choose>
                                    <c:when test='${getList.status=="1"}'>대기중</c:when>
                                    <c:when test='${getList.status=="2"}'>처리중</c:when>
                                    <c:when test='${getList.status=="3"}'>반려</c:when>
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
                <a href="getList?page=${paging.beginPage-1}&key=${key}">PREV</a>&nbsp;
              </c:if>
              <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <c:if test="${index!=paging.page}">
                  <a href="getList?page=${index}&key=${key}">${index}</a>&nbsp;
                </c:if>
                <c:if test="${index==paging.page}">
                  <span style="color:red">${index}&nbsp;</span>
                </c:if>
              </c:forEach>
              <c:if test="${paging.next}">
                <a href="getList?page=${paging.endPage+1}&key=${key}">NEXT</a>&nbsp;
              </c:if>
            </div>
        </div> <!-- 페이지의 끝 -->
</form>
</section>

<%@ include file="../footer.jsp" %>