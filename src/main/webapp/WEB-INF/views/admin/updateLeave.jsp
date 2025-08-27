<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ko">
<head>
    <title>Grouping - Admin</title>
    <%--초기화 및 공통 css, javascript--%>
    <link rel="stylesheet" type="text/css" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="admin/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.slim.js" integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc=" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="/scripts/common.js"></script>
    <script src="admin/scripts/member.js"></script>
</head>
<body>
    <div class="container">
        <h2>퇴사 처리</h2>
        <form method="post" action="updateLeave" name="updateLeaveForm" id="updateLeaveForm">
            <table>
                <thead>
                    <tr>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>직급</th>
                        <th>입사일</th>
                        <th>퇴사일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="item">
                        <tr>
                            <td>${item.userid}</td>
                            <td>${item.name}</td>
                            <td>${item.position}</td>
                            <td><fmt:formatDate value="${item.joindate}" pattern="yyyy-MM-dd" /></td>
                            <td><input type="date" name="leavedate" midx="${item.midx}" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="btns">
                <button type="button" onclick="updateLeave()">확인</button>
            </div>
        </form>
    </div>
</body>
</html>
