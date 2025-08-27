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
        padding: 8px;
        border: 1px solid #ddd;
        text-align: center;
        vertical-align: middle;
    }
    table.tb tbody tr:hover {
        background-color: #f9f9f9;
    }
    table.tb tfoot td {
        font-weight: bold;
        font-size: 120%;
        text-align: center;
    }
    table.tb a {
        text-decoration: none;
        color: inherit;
    }
    table.tb a:hover {
        color: #007BFF;
        text-decoration: underline;
    }
    .empty td {
        text-align: center;
        padding: 12px;
        font-style: italic;
        color: #888;
    }
    .searchBox {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

</style>

<section id="getList">
    <h3>수신 결재 목록</h3><%--    나를 결재자로 선택한 글 목록만 조회.--%>
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
    <table class="tb">
        <thead>
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
                                    <c:when test='${getList.category=="1"}'>업무</c:when>
                                    <c:otherwise>연차/반차</c:otherwise>
                                </c:choose>
                            </td>
                            <td style="cursor:pointer">
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