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

    <link rel="stylesheet" type="text/css" href="admin/css/member.css">
    <script src="admin/scripts/member.js"></script>
</head>
<body>
<div class="container">
    <h2>팀 생성</h2>
    <form method="post" action="createTeam" name="createTeamForm" id="createTeamForm">
        <div class="field">
            <input type="text" name="name" id="name" value="${dto.name}" placeholder="팀명을 입력해주세요.">
        </div>
        <p class="notice" id="notice_p">${msg}</p>
        <div class="btns">
            <button type="button" onclick="createTeam()">확인</button>
        </div>
    </form>
</div>
</body>
</html>
