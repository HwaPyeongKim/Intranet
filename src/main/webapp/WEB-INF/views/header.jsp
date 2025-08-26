<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Grouping</title>
    <%--초기화 및 공통 css, javascript--%>
    <link rel="stylesheet" type="text/css" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.slim.js" integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc=" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="/scripts/common.js"></script>

    <%--개별 링크--%>
    <link rel="stylesheet" type="text/css" href="/css/member.css">
    <link rel="stylesheet" type="text/css" href="/css/board.css">
    <link rel="stylesheet" type="text/css" href="/css/mypage.css">
    <link rel="stylesheet" type="text/css" href="/css/main.css">

    <script src="/scripts/member.js"></script>
    <script src="/scripts/board.js"></script>
    <script src="/scripts/work.js"></script>
    <script src="/scripts/mypage.js"></script>
    <script src="/scripts/request.js"></script>

</head>
<body>

<div id="wrap"> <!--wrap 시작-->

    <c:if test="${loginUser != null}">
    <header>
        <a href="/" id="logo"><img src="/images/logo.png"/></a>

        <ul class="nav">
            <c:if test="${loginUser.level > 1}">
                <li><a href="adminLoginForm">관리자</a></li>
            </c:if>
            <li><a href="board">게시판</a></li>
            <li><a href="schedule">일정관리</a></li>
            <li><a href="work">업무관리</a></li>
            <li><a href="requests">전자결제</a></li>
            <li><a href="message">메세지</a></li>
            <li><a href="workList">마이페이지</a></li>
            <li class="profile">
                <img src="${profileImg}" class="profileImg" />
                <span>${loginUser.name}</span>
                <a href="#" class="messageBox">
                    <img src="/images/message.png" />
                    <i>0</i>
                </a>
                <button type="button" onclick="location.href='logout'">로그아웃</button>
                <button type="button" data-midx="${loginUser.midx}" id="workoutBtn">퇴근</button>
            </li>
        </ul>

    </header>
    </c:if>