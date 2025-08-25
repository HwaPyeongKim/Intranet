<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<section id="adminBoardList">
    <h2>게시판</h2>

    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <select name="type">
                    <option value="title"<c:if test="${type == 'title'}"> selected</c:if>>제목</option>
                    <option value="titleContent"<c:if test="${type == 'titleContent'}"> selected</c:if>>제목+내용</option>
                    <option value="name"<c:if test="${type == 'name'}"> selected</c:if>>작성자</option>
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

    <form method="post" name="adminBoardInfo" id="adminBoardInfo">
        <table>
            <thead>
                <tr>
                    <th></th>
                    <th class="col">번호</th>
                    <th class="col title">제목</th>
                    <th class="col">작성자</th>
                    <th class="col">작성일</th>
                    <th class="col">조회수</th>
                    <c:if test="${loginUser.level > 2}">
                    <th>노출여부</th>
                    </c:if>
                </tr>
            </thead>

            <tbody>
                <c:choose>
                    <c:when test="${empty list && empty notice}">
                        <tr>
                            <c:choose>
                                <c:when test="${loginUser.level > 2}">
                                    <td colspan="7">게시물이 존재하지 않습니다.</td>
                                </c:when>
                                <c:otherwise>
                                    <td colspan="6">게시물이 존재하지 않습니다.</td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${notice}" var="item">
                            <tr class="row notice">
                                <td><input type="checkbox" name="bidx" value="${item.bidx}" /></td>
                                <td class="col">공지</td>
                                <td class="col title">
                                    <a href="adminViewBoard?bidx=${item.bidx}">
                                        ${item.title}
                                        <span class="main_color"><c:if test="${item.comment_count > 0}">[<fmt:formatNumber value="${item.comment_count}" />]</c:if></span>
                                    </a>
                                </td>
                                <td class="col">${item.name}</td>
                                <td class="col"><fmt:formatDate value="${item.writedate}" pattern="yyyy-MM-dd" /></td>
                                <td class="col"><fmt:formatNumber value="${item.readcount}" /></td>
                                <c:if test="${loginUser.level > 2}">
                                <td>
                                    <c:choose>
                                        <c:when test="${item.showyn == 'Y'}">노출</c:when>
                                        <c:otherwise>노출안함</c:otherwise>
                                    </c:choose>
                                </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                        <c:forEach items="${list}" var="item">
                            <tr>
                                <td><input type="checkbox" name="bidx" value="${item.bidx}" /></td>
                                <td class="col">${item.loopnum}</td>
                                <td class="col title">
                                    <a href="adminViewBoard?bidx=${item.bidx}">
                                        ${item.title}
                                        <span class="main_color"><c:if test="${item.comment_count > 0}">[<fmt:formatNumber value="${item.comment_count}" />]</c:if></span>
                                    </a>
                                </td>
                                <td class="col">${item.name}</td>
                                <td class="col"><fmt:formatDate value="${item.writedate}" pattern="yyyy-MM-dd" /></td>
                                <td class="col"><fmt:formatNumber value="${item.readcount}" /></td>
                                <c:if test="${loginUser.level > 2}">
                                <td>
                                    <c:choose>
                                        <c:when test="${item.showyn == 'Y'}">노출</c:when>
                                        <c:otherwise>노출안함</c:otherwise>
                                    </c:choose>
                                </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>

        </table>
    </form>

    <c:if test="${not empty list}">
        <div class="paging">
            <c:if test="${paging.prev}"><a href="adminBoardList?page=${paging.beginPage-1}">Prev</a></c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <a href="adminBoardList?page=${index}"<c:if test="${index == paging.page}"> style="color: red;"</c:if>>${index}</a>
            </c:forEach>

            <c:if test="${paging.next}"><a href="adminBoardList?page=${paging.endPage+1}">Next</a></c:if>
        </div>
    </c:if>
</section>

<%@ include file="footer.jsp" %>