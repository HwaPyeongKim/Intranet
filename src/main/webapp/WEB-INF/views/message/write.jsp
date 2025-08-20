<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>

<h2>메시지 작성</h2>

<form action="writemsg" method="post">
    <!-- 보낸 사람: 로그인 사용자 -->
    <input type="hidden" name="frommidx" value="${userId}" />
    <p>보낸 사람: ${userName}</p>

    <!-- 받는 사람 선택 -->
    <label for="tomidx">받는 사람:</label>
    <select name="tomidx" id="tomidx">
        <c:forEach var="member" items="${memberList}">
            <c:if test="${member.midx ne userId}">
                <option value="${member.midx}">${member.name}</option>
            </c:if>
        </c:forEach>
    </select>
    <br/><br/>

    <!-- 제목 -->
    제목: <input type="text" name="title" required /><br/><br/>

    <!-- 내용 -->
    내용: <textarea name="content" rows="5" cols="50" required></textarea><br/><br/>

    <input type="submit" value="보내기" />
    <input type="button" onclick="location.href='message'" value="뒤로가기"/>
</form>

<%@ include file="../footer.jsp" %>
