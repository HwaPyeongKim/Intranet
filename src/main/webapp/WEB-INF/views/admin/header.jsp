<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <script src="admin/scripts/common.js"></script>

    <%--개별 링크--%>
    <link rel="stylesheet" type="text/css" href="admin/css/member.css">
    <script src="admin/scripts/member.js"></script>
</head>
<body>

<c:if test="${loginUser != null && loginUser.level > 1}">

<header>
    <div class="nav">
        <a href="#" id="logo">로고</a>
        <ul class="gnb">
            <li>
                <span>직원 관리</span>
                <ul class="lnb">
                    <li><a href="adminMemberList?first=Y">직원 목록</a></li>
                    <li><a href="adminMemberAttendanceList?first=Y">직원 근태현황</a></li>
                    <li><a href="adminTeamList?first=Y">팀 목록</a></li>
                </ul>
            </li>
            <li>
                <span>게시판 관리</span>
                <ul class="lnb">
                    <li><a href="adminBoardList?first=Y">게시판 목록 수정/삭제</a></li>
                    <li><a href="adminDownloadList?first=Y">자료실 목록 수정/삭제</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <div class="loginProfile">
        <img src="${profileImg}" />
        <span>${loginUser.name}</span>
        <a href="receiveList" class="messageBox">
            <img src="/images/message.png" />
            <i>0</i>
        </a>
        <a href="main" id="tomain">사용자 페이지로 이동</a>
        <button type="button" onclick="location.href='logout'">로그아웃</button>
        <button type="button" data-midx="${loginUser.midx}" id="workoutBtn">퇴근</button>
    </div>
</header>
</c:if>

<div id="wrap"> <!--wrap 시작-->