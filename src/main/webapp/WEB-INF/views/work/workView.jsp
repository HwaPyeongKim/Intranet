<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<%@ include file="sub_menu.jsp" %>
<style>
    section#insertWork {margin-top: 50px; display: flex; justify-content: center;}
</style>

<section id="insertWork">
    <form class="form fileForm shadow" style="width: 100%; padding: 20px; border: 1px solid #000; border-radius: 10px;">

    <h2>업무 내용</h2>

    <div class="field">
        <label>요청자</label>
        <div>${workitem.empname}</div>
    </div>

    <div class="field">
        <label>수신자</label>
        <div>${workitem.workername}</div>
    </div>

    <div class="field">
        <label>등록일</label>
        <div><fmt:formatDate value="${workitem.writedate}" pattern="yyyy-MM-dd HH:mm:ss" /> </div>
    </div>

    <div class="field">
        <label>제목</label>
        <div>${workitem.title}</div>
    </div>

    <div class="field">
        <label>내용</label>
        <div><pre>${workitem.content}</pre></div>
    </div>

    <c:if test="${workitem.fidx > 0}">
        <div class="field">
            <label>첨부파일</label>
            <div><a href="${workitem.path}">${workitem.originalname}</a></div>
        </div>
    </c:if>

    <div class="btns">
        <c:if test="${workitem.midx == loginUser.midx}">
            <button type="button" onclick="editWork('${workitem.widx}','update')">수정</button>
            <button type="button" onclick="editWork('${workitem.widx}','delete')">삭제</button>
        </c:if>
            <button type="button" onclick="go_list()">목록으로</button>
    </div>


    <ul class="comments">
        <h3>댓글 <fmt:formatNumber value="${comments.size()}" /></h3>
        <c:choose>
            <c:when test="${empty comments}"><li class="empty">댓글이 존재하지 않습니다.</li></c:when>
            <c:otherwise>
                <c:forEach items="${comments}" var="comment">
                    <form method="post" action="updateComment">
                        <input type="hidden" name="widx" value="${comment.widx}" />
                        <input type="hidden" name="wcidx" value="${comment.wcidx}" />

                        <li class="commentList">
                            <div class="commentBtns clearfix">
                                <span>${comment.name}</span>
                                <small>(<fmt:formatDate value="${comment.writedate}" pattern="yyyy-MM-dd HH:mm:ss" />)</small>
                                <c:if test="${comment.midx == loginUser.midx}">
                                    <div>
                                        <button type="button" data-widx="${comment.widx}" data-wcidx="${comment.wcidx}" class="deleteComment">댓글삭제</button>
                                        <button type="button" data-widx="${comment.widx}" data-wcidx="${comment.wcidx}" class="updateComment">댓글수정</button>
                                    </div>
                                </c:if>
                            </div>
                            <pre>${comment.content}</pre>
                        </li>
                    </form>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <form method="post" action="insertComment">
            <input type="hidden" name="widx" value="${workitem.widx}" />
            <input type="hidden" name="midx" value="${loginUser.midx}" />

            <li class="commentList">
                <div class="commentBtns clearfix">
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
