<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>

<h2>메시지 작성</h2>

<form action="writemsg" method="post">
    <!-- 보낸 사람: 로그인 사용자 -->
    <input type="hidden" name="frommidx" value="${userid}" />
    <p>보낸 사람: ${userName}</p>

    <!-- 받는 사람 선택 -->
    <label for="tomidx">받는 사람:</label>
    <select name="tomidx" id="tomidx">
        <option>수신자를 선택하세요</option>
        <c:forEach var="member" items="${memberList}">
            <c:if test="${member.midx ne userid}">
                <option value="${member.midx}">${member.name}</option>
            </c:if>
        </c:forEach>
    </select>
    <br/><br/>


    <!-- 내용 -->
    내용: <textarea name="content" rows="5" cols="50" required></textarea><br/><br/>

    <input type="submit" value="보내기" />


    <input type="button" onclick="location.href='receiveList'" value="취소"/>



<%--    <c:choose>--%>
<%--    <c:when test="${from eq 'sent'}">--%>
<%--        <button type="button" onclick="location.href='<c:url value="/sentList"/>'">뒤로가기</button>--%>
<%--    </c:when>--%>
<%--    <c:otherwise>--%>
<%--        <button type="button" onclick="location.href='<c:url value="/receiveList"/>'">뒤로가기</button>--%>
<%--    </c:otherwise>--%>
<%--</c:choose>--%>




</form>


<%@ include file="../footer.jsp" %>
