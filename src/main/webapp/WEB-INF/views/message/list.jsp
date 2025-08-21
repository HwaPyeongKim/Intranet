<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>

<h2>메시지 목록</h2>

<table border="1" cellspacing="0" cellpadding="5">
    <tr style="background-color:#f2f2f2;">
        <th>번호</th>
        <th>보낸사람</th>
        <th>받는사람</th>
        <th>제목</th>
        <th>읽음</th>
        <th>작성일</th>
        <th>삭제</th>
    </tr>

<c:if test="${not empty messages}">
    <c:forEach var="msg" items="${messages}">
        <tr>
            <td>${msg.loopnum}</td>
            <td>${msg.fromname}</td>
            <td>${msg.toname}</td>
            <td><a href="viewmsg?msidx=${msg.msidx}">${msg.title}</a></td>
            <td>${msg.readyn}</td>
            <td>${msg.writedate}</td>
            <td>
                <form action="deletemsg" method="post" style="margin:0;">
                    <input type="hidden" name="msidx" value="${msg.msidx}" />
                    <input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');"/>
                </form>
            </td>
        </tr>
    </c:forEach>
</c:if>

<c:if test="${empty messages}">
    <tr>
        <td colspan="7" style="text-align:center;">메시지가 없습니다.</td>
    </tr>
</c:if>
</table>

<br/>
<a href="writemsg">메시지 작성</a>

<%@ include file="../footer.jsp" %>
