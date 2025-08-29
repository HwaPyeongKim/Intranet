<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<ul class="submenu">
    <li class="on"><a href="board">메인게시판</a></li>
    <li><a href="download">자료실</a></li>
</ul>
<section>

    <div class="boxBtns clearfix">
        <button type="button" onclick="location.href='writeBoardForm?category=main'">글쓰기</button>
    </div>

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

    <div class="table">
        <div class="row head">
            <div class="col">번호</div>
            <div class="col title">제목</div>
            <div class="col">작성자</div>
            <div class="col">작성일</div>
            <div class="col">조회수</div>
        </div>
        <c:choose>
            <c:when test="${empty list && empty notice}">
                <div class="row empty">
                    <div class="col">게시물이 존재하지 않습니다.</div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${notice}" var="item">
                    <div class="row notice">
                        <div class="col">공지 <i class="fa-solid fa-bullhorn"></i></div>
                        <div class="col title">
                            <a href="viewBoard?bidx=${item.bidx}">
                                ${item.title}
                                <span class="main_color"><c:if test="${item.comment_count > 0}">[<fmt:formatNumber value="${item.comment_count}" />]</c:if></span>
                                <c:if test="${fn:substring(item.writedate, 0, 10) == today}"><span class="new"> New</span></c:if>
                            </a>
                        </div>
                        <div class="col">${item.name}</div>
                        <div class="col"><fmt:formatDate value="${item.writedate}" pattern="yyyy-MM-dd" /></div>
                        <div class="col"><fmt:formatNumber value="${item.readcount}" /></div>
                    </div>
                </c:forEach>
                <c:forEach items="${list}" var="item">
                    <div class="row">
                        <div class="col">${item.loopnum}</div>
                        <div class="col title" style="text-align: left">
                            <a href="viewBoard?bidx=${item.bidx}">
                                ${item.title}
                                <span class="main_color"><c:if test="${item.comment_count > 0}">[<fmt:formatNumber value="${item.comment_count}" />]</c:if></span>
                                <c:if test="${fn:substring(item.writedate, 0, 10) == today}"><span class="new"> New</span></c:if>
                            </a>
                        </div>
                        <div class="col">${item.name}</div>
                        <div class="col"><fmt:formatDate value="${item.writedate}" pattern="yyyy-MM-dd" /></div>
                        <div class="col"><fmt:formatNumber value="${item.readcount}" /></div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <c:if test="${not empty list}">
        <div class="paging">
            <c:if test="${paging.prev}"><a href="board?page=${paging.beginPage-1}">Prev</a></c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <a href="board?page=${index}"<c:if test="${index == paging.page}"> style="color: red;"</c:if>>${index}</a>
            </c:forEach>

            <c:if test="${paging.next}"><a href="board?page=${paging.endPage+1}">Next</a></c:if>
        </div>
    </c:if>

</section>

<%@ include file="../footer.jsp" %>