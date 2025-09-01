<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<%@ include file="sub_menu.jsp" %>
<style>
    section#insertWork {margin-top: 50px; display: flex; justify-content: center;}
    label {font-weight: bold; font-size: 110% }
</style>

<section id="insertWork">
<div class="form fileForm shadow" style="width: 100%; padding: 20px; border: 1px solid #000; border-radius: 10px;">
    <div class="field">
        <div>
            <span style="font-size: 30px">업무 내용&nbsp;&nbsp;</span>
            <c:if test="${workitem.status==1 && workitem.worker == loginUser.midx}">
            <button type="button" onclick="changeWorkStatus(${workitem.widx},${workitem.status},2)">진행하기</button>
            <%--  1 -> 2 --%>
            </c:if>
            <c:if test="${(workitem.status==2 || workitem.status==3 || workitem.status==4) && workitem.worker == loginUser.midx}">
            <button type="button" onclick="changeWorkStatus(${workitem.widx},${workitem.status},5)">검토요청</button>
            <%--  2 -> 5 --%>
            </c:if>
            <c:if test="${workitem.status==5 && workitem.midx == loginUser.midx}">
            <button type="button" onclick="changeWorkStatus(${workitem.widx},${workitem.status}, 3)">보류</button>&nbsp;
            <button type="button" onclick="changeWorkStatus(${workitem.widx},${workitem.status}, 4)">반려</button>&nbsp;
            <button type="button" onclick="changeWorkStatus(${workitem.widx},${workitem.status}, 6)">완료</button>
            <%--  2 -> 5 --%>
            </c:if>
        </div>
        <div style="text-align: right">
            <c:if test="${workitem.midx == loginUser.midx}">
                <button type="button" onclick="editWork('${workitem.widx}','update')">수정</button>&nbsp;
                <button type="button" onclick="editWork('${workitem.widx}','delete')">삭제</button>&nbsp;
            </c:if>
                <button type="button" onclick="go_list()">목록으로</button>&nbsp;
       </div>
    </div>

    <div class="field">
        <label>진행상태</label>
        <div>${status}</div>
    </div>

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
        <label style="line-height: 40px;">제목</label>
        <div style="line-height: 40px; border-bottom: 1px dotted gray; width: 100px">${workitem.title}</div>
    </div>

    <div class="field">
        <label style="line-height: 40px;">내용</label>
        <div style="line-height: 40px; border-bottom: 1px dotted gray; width: 100px">
        <div id="viewer"><c:out value="${workitem.content}" escapeXml="false" /></div>
        </div>
    </div>

    <c:if test="${workitem.fidx > 0}">
        <div class="field">
            <label>첨부파일</label>
            <div><a href="${workitem.path}">${workitem.originalname}</a></div>
        </div>
    </c:if>

    <div class="field" style="border-bottom: 1px dotted black; width: 100%; margin: 40px 0px">

    </div>

    <ul class="comments">
        <h3 style="font-weight: bold">댓글 <fmt:formatNumber value="${comments.size()}" /></h3>
        <c:choose>
            <c:when test="${empty comments}"><li class="empty">댓글이 존재하지 않습니다.</li></c:when>
            <c:otherwise>
                <c:forEach items="${comments}" var="comment">
                    <form method="post" action="updateComment">
                        <input type="hidden" name="widx" value="${comment.widx}" />
                        <input type="hidden" name="wcidx" value="${comment.wcidx}" />

                        <li class="commentList">
                            <input type="hidden" name="prevText" value="${comment.content}" />
                            <div class="commentBtns clearfix" style="display: flex; align-items: start">
                                <span>${comment.name}</span>&nbsp;
                                <small>(<fmt:formatDate value="${comment.writedate}" pattern="yyyy-MM-dd HH:mm:ss" />)</small>&nbsp;
                                <c:if test="${comment.midx == loginUser.midx && comment.autoyn == 'N'}">
                                    <button type="button" style="text-decoration: underline; padding: 0px; border: none; border-radius: 0px; background: none; color: black; font-size: 1em; font-weight: normal; cursor: pointer;"
                                    data-widx="${comment.widx}" data-wcidx="${comment.wcidx}" class="deleteComment">삭제</button>&nbsp;
                                    <button type="button" style="text-decoration: underline; padding: 0px; border: none; border-radius: 0px; background: none; color: black; font-size: 1em; font-weight: normal; cursor: pointer;"
                                    data-widx="${comment.widx}" data-wcidx="${comment.wcidx}" class="updateComment">수정</button>
                                </c:if>
                            </div>
                            <c:if test="${comment.autoyn == 'Y'}">
                            <pre style="color: red">${comment.content}</pre>
                            </c:if>
                            <c:if test="${comment.autoyn == 'N'}">
                            <pre>${comment.content}</pre>
                            </c:if>
                        </li>
                    </form>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <form method="post" action="insertComment">
            <input type="hidden" name="widx" value="${workitem.widx}" />
            <input type="hidden" name="midx" value="${loginUser.midx}" />

            <li class="commentList">
                <div class="commentBtns clearfix" style="align-items: center">
                    ${loginUser.name}
                    <div>
                        <button>등록</button>
                    </div>
                </div>
                <textarea name="content"></textarea>
            </li>
        </form>
    </ul>
</div>
</section>


<%@ include file="../footer.jsp" %>
