<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Intranet</title>
    <%--초기화 및 공통 css, javascript--%>
    <link rel="stylesheet" type="text/css" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.slim.js" integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc=" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="/scripts/common.js"></script>

    <%--개별 링크--%>
    <link rel="stylesheet" type="text/css" href="/css/member.css">
    <script src="/scripts/member.js"></script>
</head>
<body>

<div id="wrap"> <!--wrap 시작-->

    <c:if test="${loginUser != null}">
    <header>
        <a href="/" id="logo">로고</a>
        <ul class="nav">
            <li><a href="board">게시판ss</a></li>
            <li><a href="schedule">일정관리di</a></li>
            <li><a href="work">업무관리</a></li>
            <li><a href="requests">전자결제</a></li>
            <li><a href="mypage">마이페이지</a></li>
            <li class="profile">#프로필테스트테스트</li>
        </ul>
    </header>
    </c:if>