<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<section id="viewBoard">

    <form method="post">
        <h2>게시글 보기</h2>


        <div class="field">
            <label>작성자</label>
            <div>${item.name}</div>
        </div>

        <div class="field">
            <label>등록일</label>
            <div><fmt:formatDate value="${item.writedate}" pattern="YYYY-mm-dd HH:mm:ss" /> </div>
        </div>

        <div class="field">
            <label>조회수</label>
            <div><fmt:formatNumber value="${item.readcount}" /></div>
        </div>

        <div class="field">
            <label>제목</label>
            <div>${item.title}</div>
        </div>

        <div class="field">
            <label>내용</label>
            <div><pre>${item.content}</pre></div>
        </div>

        <c:if test="${item.fidx > 0}">
            <div class="field">
                <label>첨부파일</label>
                <div><a href="${item.path}">${item.originalname}</a></div>
            </div>
        </c:if>

        <div class="btns">
            <c:if test="${item.midx == loginUser.midx}">
                <button type="button" onclick="editBoard('${item.bidx}','update')">수정</button>
                <button type="button" onclick="editBoard('${item.bidx}','delete')">삭제</button>
            </c:if>
            <button type="button" onclick="location.href='board'">목록으로</button>
        </div>

    </form>

</section>

<%@ include file="../footer.jsp" %>