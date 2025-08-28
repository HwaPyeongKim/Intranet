<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">

<style>
    .sub-menu-btn {
        display: inline-block;
        background-color: #8cbad1;
        color: white;
        font-size: 18px;
        border: none;
        border-radius: 6px 6px 0 0;
        cursor: pointer;
        transition: background-color 0.2s ease, transform 0.1s ease;
        font-weight: 400;
        margin-right: 2px;
    }
    .sub-menu-btn a {display: block;padding: 18px 34px;}

    .sub-menu-btn:hover {
        background-color: #3a97b9;
    }

    .sub-menu-btn:active {
        transform: scale(0.97);

    }
    .sub-menu-btn.active {
        background-color: #2973cd;
        font-weight: bold;
    }
</style>
<%
    String path = request.getRequestURI();
%>
<ul id="sub_menu" style="display: flex;">
    <li class="sub-menu-btn"><a href="requests">결재발신함</a></li>
    <li class="sub-menu-btn"><a href="getList">결재수신함</a></li>
</ul>
<script>

    $('.sub-menu-btn').on('click', function (e) {
        e.preventDefault();
        if (!$(this).hasClass('active')) {
            $('.sub-menu-btn').removeClass('active'); // 전체 제거
            $(this).addClass('active');               // 자기만 추가
        } else {
            $(this).removeClass('active'); // 다시 클릭하면 꺼짐 (토글)
        }
    });

</script>

