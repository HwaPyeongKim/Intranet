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
    <h2>퇴근 처리</h2>
    <form method="post" action="updateAttendance" name="updateAttendanceForm" id="updateAttendanceForm">
        <table>
            <thead>
            <tr>
                <th>아이디</th>
                <th>이름</th>
                <th>직급</th>
                <th>날짜</th>
                <th>출근시간</th>
                <th>퇴근시간</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="item">
                <tr>
                    <td>${item.userid}</td>
                    <td>${item.name}</td>
                    <td>${item.position}</td>
                    <td>${item.date}</td>
                    <td><fmt:formatDate value="${item.starttime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <td><input type="datetime-local" name="endtime" maidx="${item.maidx}" /></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="btns">
            <button type="button" onclick="updateAttendance()">확인</button>
        </div>
    </form>
</div>
</body>
</html>
