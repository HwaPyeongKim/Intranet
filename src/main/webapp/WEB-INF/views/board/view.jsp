<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<section id="viewBoard">

    <h2>게시글 보기</h2>

    <div class="field">
        <label>작성자</label>
        <div>${item.name}</div>
    </div>

    <div class="field">
        <label>등록일</label>
        <div><fmt:formatDate value="${item.writedate}" pattern="yyyy-MM-dd HH:mm:ss" /> </div>
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

    <ul class="comments">
        <h3>댓글 <fmt:formatNumber value="${comments.size()}" /></h3>
        <c:choose>
            <c:when test="${empty comments}"><li class="empty">댓글이 존재하지 않습니다.</li></c:when>
            <c:otherwise>
                <c:forEach items="${comments}" var="comment">
                    <form method="post" action="updateBoardComment">
                        <input type="hidden" name="bidx" value="${comment.bidx}" />
                        <input type="hidden" name="bcidx" value="${comment.bcidx}" />

                        <li class="commentList">
                            <div class="commentBtns clearfix">
                                <span>${comment.name}</span>
                                <small>(<fmt:formatDate value="${comment.writedate}" pattern="yyyy-MM-dd HH:mm:ss" />)</small>
                                <c:if test="${comment.midx == loginUser.midx}">
                                    <div>
                                        <button type="button" data-bidx="${comment.bidx}" data-bcidx="${comment.bcidx}" class="updateBoardComment">댓글수정</button>
                                        <button type="button" data-bidx="${comment.bidx}" data-bcidx="${comment.bcidx}" class="deleteBoardComment">댓글삭제</button>
                                    </div>
                                </c:if>
                            </div>
                            <pre>${comment.content}</pre>
                        </li>
                    </form>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <form method="post" action="insertBoardComment">
            <input type="hidden" name="bidx" value="${item.bidx}" />
            <input type="hidden" name="midx" value="${loginUser.midx}" />

            <li>
                <div class="clearfix">
                    <div>
                        <button>등록</button>
                    </div>
                </div>
                <textarea name="content"></textarea>
            </li>
        </form>
    </ul>
</section>

<%@ include file="../footer.jsp" %>