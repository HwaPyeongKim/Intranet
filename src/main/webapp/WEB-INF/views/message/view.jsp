<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>

<h2>메시지 상세</h2>

<table>
    <tr>
        <td>보낸사람</td>
        <td>${message.fromname}</td>
    </tr>
    <tr>
        <td>받는사람</td>
        <td>${message.toname}</td>
    </tr>
    <tr>
        <td>제목</td>
        <td>${message.title}</td>
    </tr>
    <tr>
        <td>내용</td>
        <td>${message.content}</td>
    </tr>
    <tr>
        <td>작성일</td>
        <td>${message.writedate}</td>
    </tr>
    <tr>
        <td>읽음</td>
        <td>${message.readyn}</td>
    </tr>
</table>

<br/>

<%--<c:choose>--%>
<%--    <c:when test="${activeTab eq 'receive'}">--%>
<%--        <a href="${pageContext.request.contextPath}/message/receiveList">받은메시지 목록</a>--%>
<%--    </c:when>--%>

<%--    <c:when test="${activeTab eq 'sent'}">--%>
<%--        <a href="${pageContext.request.contextPath}/message/sentList">보낸메시지 목록</a>--%>
<%--    </c:when>--%>
<%--</c:choose>--%>


<c:choose>
    <c:when test="${activeTab eq 'receive'}">
        <a href="receiveList">받은 메시지 목록</a>
    </c:when>
    <c:otherwise>
        <a href="sentList">보낸 메시지 목록</a>
    </c:otherwise>
</c:choose>


<form method="post" action="deletemsg" onsubmit="return confirm('메세지를 삭제하시겠습니까?');">
    <input type="hidden" name="msidx" value="${message.msidx}">
    <button type="submit">삭제</button>
</form>





<%@ include file="../footer.jsp" %>
