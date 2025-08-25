<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ include file="../header.jsp" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>--%>

<%--<section>--%>
<%--    <h2>메신저</h2>--%>

<%--    <ul class="submenu">--%>
<%--        <li class="on"><a href="message">받은메시지</a></li>--%>
<%--        <li><a href="message/sent">보낸메시지</a></li>--%>
<%--    </ul>--%>

<%--    <div class="boxBtns clearfix">--%>
<%--        <button type="button" onclick="location.href='writemsg'">메시지 작성</button>--%>
<%--    </div>--%>

<%--    <div class="table">--%>
<%--        <div class="row head">--%>
<%--            <div class="col">번호</div>--%>
<%--            <div class="col">보낸 사람</div>--%>
<%--            <div class="col title">제목</div>--%>
<%--            <div class="col">내용</div>--%>
<%--            <div class="col">보낸 시간</div>--%>
<%--            <div class="col">삭제</div>--%>
<%--        </div>--%>

<%--        <c:choose>--%>
<%--            <c:when test="${empty message}">--%>
<%--                <div class="row empty">--%>
<%--                    <div class="col">받은 메시지가 없습니다.</div>--%>
<%--                </div>--%>
<%--            </c:when>--%>
<%--            <c:otherwise>--%>
<%--                <c:forEach items="${message}" var="msg">--%>
<%--                    <div class="row">--%>
<%--                        <div class="col">${msg.msidx}</div>--%>
<%--                        <div class="col">${msg.frommidx}</div>--%>
<%--                        <div class="col title">${msg.title}</div>--%>
<%--                        <div class="col">${msg.content}</div>--%>
<%--                        <div class="col"><fmt:formatDate value="${msg.senddate}" pattern="yyyy-MM-dd HH:mm"/></div>--%>
<%--                        <div class="col">--%>
<%--                            <form action="deletemsg" method="post" style="margin:0;">--%>
<%--                                <input type="hidden" name="msidx" value="${msg.msidx}">--%>
<%--                                <button type="submit">삭제</button>--%>
<%--                            </form>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </c:forEach>--%>
<%--            </c:otherwise>--%>
<%--        </c:choose>--%>
<%--    </div>--%>
<%--</section>--%>

<%--<%@ include file="../footer.jsp" %>--%>

<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<h2>메세지 상세보기</h2>--%>

<%--<p><strong>보낸사람:</strong> ${message.fromname} (${message.fromuserid})</p>--%>
<%--<p><strong>받는사람:</strong> ${message.toname} (${message.touserid})</p>--%>
<%--<p><strong>제목:</strong> ${message.title}</p>--%>
<%--<p><strong>내용:</strong></p>--%>
<%--<p>${message.content}</p>--%>
<%--<p><strong>보낸날짜:</strong> ${message.writedate}</p>--%>

<%--<a href="${pageContext.request.contextPath}/message/receiveList">받은 메세지함</a> |--%>
<%--<a href="${pageContext.request.contextPath}/message/sentList">보낸 메세지함</a>--%>

