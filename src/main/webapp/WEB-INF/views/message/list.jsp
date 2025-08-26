<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ include file="../header.jsp" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>--%>

<%--<section>--%>
<%--    <h2>메세지</h2>--%>

<%--    <ul class="submenu">--%>
<%--        <li class="on"><a href="receiveList">받은메시지</a></li>--%>
<%--        <li><a href="sentList">보낸메시지</a></li>--%>
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
<%--            <div class="col">받은 시간</div>--%>
<%--            <div class="col">삭제</div>--%>
<%--        </div>--%>

<%--        <c:choose>--%>
<%--            <c:when test="${empty message}">--%>
<%--                <div class="row empty">--%>
<%--                    <div class="col">받은 메시지가 없습니다.</div>--%>
<%--                </div>--%>
<%--            </c:when>--%>
<%--            <c:otherwise>--%>
<%--                <c:forEach items="${message}" var="msg"  varStatus="status">--%>
<%--                    <div class="row">--%>
<%--                        <div class="col">${status.count}</div>--%>
<%--                        <div class="col">${msg.fromname}</div>--%>
<%--                        <div class="col title">--%>
<%--                        <a href="receiveView?msidx=${msg.msidx}">--%>
<%--                             ${msg.title}--%>
<%--                        </a>--%>
<%--                         </div>--%>

<%--                        <div class="col">${msg.content}</div>--%>
<%--                        <div class="col"><fmt:formatDate value="${msg.writedate}" pattern="yyyy-MM-dd HH:mm"/></div>--%>
<%--                        <div class="col">--%>
<%--                            <form action="deletemsg" method="post" style="margin:0;"--%>
<%--                                    onsubmit="return confirm('메세지를 삭제하시겠습니까?');">--%>
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


<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ include file="../header.jsp" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>--%>

<%--<section>--%>
<%--    <h2>메세지</h2>--%>

<%--    <ul class="submenu">--%>
<%--        <li><a href="receiveList">받은메시지</a></li>--%>
<%--        <li class="on"><a href="sentList">보낸메시지</a></li>--%>
<%--    </ul>--%>

<%--    <div class="boxBtns clearfix">--%>
<%--        <button type="button" onclick="location.href='writemsg?from=sent'">메시지 작성</button>--%>
<%--    </div>--%>

<%--    <div class="table">--%>
<%--        <div class="row head">--%>
<%--            <div class="col">번호</div>--%>
<%--            <div class="col">받는 사람</div>--%>
<%--            <div class="col title">제목</div>--%>
<%--            <div class="col">내용</div>--%>
<%--            <div class="col">보낸 시간</div>--%>
<%--            <div class="col">삭제</div>--%>
<%--        </div>--%>

<%--        <c:choose>--%>
<%--            <c:when test="${empty sentMessages}">--%>
<%--                <div class="row empty">--%>
<%--                    <div class="col">보낸 메시지가 없습니다.</div>--%>
<%--                </div>--%>
<%--            </c:when>--%>
<%--            <c:otherwise>--%>
<%--                <c:forEach items="${sentMessages}" var="msg" varStatus="status">--%>
<%--                    <div class="row">--%>
<%--                        <div class="col">${status.count}</div>--%>
<%--                        <div class="col">${msg.toname}</div>--%>
<%--                        <div class="col title">--%>
<%--                        <a href="sentView?msidx=${msg.msidx}">--%>
<%--                             ${msg.title}--%>
<%--                        </a>--%>
<%--                        </div>--%>

<%--                        <div class="col">${msg.content}</div>--%>
<%--                        <div class="col"><fmt:formatDate value="${msg.writedate}" pattern="yyyy-MM-dd HH:mm"/></div>--%>
<%--                        <div class="col">--%>
<%--                            <form action="deletemsg" method="post" style="margin:0;"--%>
<%--                                    onsubmit="return confirm('메세지를 삭제하시겠습니까?');">--%>
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

