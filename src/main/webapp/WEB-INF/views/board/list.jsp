<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<section>
    <h2>게시판</h2>

    <ul class="nav">
        <li><a href="list">메인게시판</a></li>
        <li><a href="download">자료실</a></li>
    </ul>

    <div class="table">
        <div class="row head">
            <div class="col">번호</div>
            <div class="col">제목</div>
            <div class="col">작성자</div>
            <div class="col">작성일</div>
            <div class="col">조회수</div>
        </div>
        <c:choose>
            <c:when test="${empty list}">
                <c:forEach items="${list}" var="item">
                    <div class="row">
                        <div class="col"></div>
                        <div class="col">${item.title}</div>
                        <div class="col">${item.name}</div>
                        <div class="col"><fmt:formatDate value="${item.writedate}" pattern="YYYY-mm-dd" /></div>
                        <div class="col"><fmt:formatNumber value="${item.readcount}" /></div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
            <div class="row">
                <div class="col">게시물이 존재하지 않습니다.</div>
            </div>
            </c:otherwise>
        </c:choose>
    </div>

</section>

<%@ include file="../footer.jsp" %>