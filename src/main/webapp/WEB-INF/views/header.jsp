<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sort" uri="http://example.com/sort" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Grouping</title>
    <%--초기화 및 공통 css, javascript--%>
    <link rel="stylesheet" type="text/css" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/css/common.css">
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <%--노토산스 폰트--%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">

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
        <a href="main" id="logo"><img src="/images/logo.png"/></a>

        <ul class="nav">

            <li><a href="board" class="boardMenu">게시판</a></li>
            <li><a href="schedule" class="scheduleMenu">일정관리</a></li>
            <li><a href="work" class="workMenu">업무관리</a></li>
            <li><a href="requests" class="requestsMenu">전자결제</a></li>
            <li><a href="workList" class="mypageMenu">마이페이지</a></li>

            <li class="profile">
                <img src="${profileImg}" class="profileImg" />
                <span>${loginUser.name}</span>
                <a href="receiveList" class="messageBox">
                    <img src="/images/message.png" />
                    <i>0</i>
                </a>
                <button type="button" onclick="location.href='logout'" class="logoutBtn"><i class="fa-solid fa-arrow-right-from-bracket"></i></button>
            </li>
        </ul>

    </header>
    </c:if>