<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<section>
    <h2>게시판</h2>

    <ul class="submenu">
        <li class="on"><a href="list">메인게시판</a></li>
        <li><a href="download">자료실</a></li>
    </ul>

    <div class="boxBtns clearfix">
        <button type="button" onclick="location.href='writeBoardForm'">글쓰기</button>
    </div>

    <div class="table">
        <div class="row head">
            <div class="col">번호</div>
            <div class="col title">제목</div>
            <div class="col">작성자</div>
            <div class="col">작성일</div>
            <div class="col">조회수</div>
        </div>
        <c:choose>
            <c:when test="${empty list}">
                <div class="row empty">
                    <div class="col">게시물이 존재하지 않습니다.</div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${list}" var="item">
                    <div class="row">
                        <div class="col"></div>
                        <div class="col title"><a href="#">${item.title}</a></div>
                        <div class="col">${item.name}</div>
                        <div class="col"><fmt:formatDate value="${item.writedate}" pattern="YYYY-mm-dd" /></div>
                        <div class="col"><fmt:formatNumber value="${item.readcount}" /></div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

</section>

<%@ include file="../footer.jsp" %>