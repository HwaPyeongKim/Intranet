<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<%@ include file="sub_menu.jsp" %>
<style>

    table.tb {
        width: 100%;
        border-collapse: collapse;
        font-family: Arial, sans-serif;
    }

    table.tb thead tr.row_title {
        background-color: #f2f2f2;
    }

    table.tb th, table.tb td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }

    table.tb tbody tr:hover {
        background-color: #f9f9f9;
    }

    table.tb tbody tr.empty td {
        text-align: center;
        font-style: italic;
        color: #888;
    }

    table.tb td a {
        color: #007bff;
        text-decoration: none;
        cursor: pointer;
    }

    table.tb td a:hover {
        text-decoration: underline;
    }

    tfoot td {
        font-weight: bold;
        font-size: 1.2em;
        padding: 10px 0;
    }

    /* 페이징 링크 스타일 */
    tfoot td a {
        margin: 0 5px;
        /*color: #007bff;*/
        text-decoration: none;
    }

    tfoot td a:hover {
        text-decoration: underline;
    }

    tfoot td span {
        color: red;
    }

    .searchBox {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

</style>

<section id="requests">
    <h3>발신 결재 목록</h3>
    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <select name="type">
                    <option value="title"<c:if test="${type == 'title'}"> selected</c:if>>제목</option>
                    <option value="titleContent"<c:if test="${type == 'titleContent'}"> selected</c:if>>제목+내용</option>
                    <option value="name"<c:if test="${type == 'comfirm_midx'}"> selected</c:if>>결재자</option>
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


    <form method="get" name="requests" class="">
        <table class="tb">
            <thead>
            <tr class="row_title">
                <th>번호</th>
                <th>구분</th>
                <th>제목</th>
                <th>작성일자</th>
                <th>결재자</th>
                <th>진행상태</th>
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
                                    <c:when test='${requests.category=="1"}'>업무</c:when>
                                    <c:otherwise>연차/반차</c:otherwise>
                                </c:choose>
                            </td>
                            <td style="cursor:pointer">
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
                    <a href="requests?page=${paging.beginPage-1}&key=${key}">PREV</a>&nbsp;
                </c:if>
                <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                    <c:if test="${index!=paging.page}">
                        <a href="requests?page=${index}&key=${key}">${index}</a>&nbsp;
                    </c:if>
                    <c:if test="${index==paging.page}">
                        <span style="color:red">${index}&nbsp;</span>
                    </c:if>
                </c:forEach>
                <c:if test="${paging.next}">
                    <a href="requests?page=${paging.endPage+1}&key=${key}">NEXT</a>&nbsp;
                </c:if>
            </div>
        </div> <!-- 페이지의 끝 -->
    </form>
</section>

<%@ include file="../footer.jsp" %>