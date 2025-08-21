<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>

<h2>메시지 상세</h2>

<table border="0" cellspacing="5" cellpadding="5">
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
<a href="message">목록으로</a>

<%@ include file="../footer.jsp" %>
