<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<section id="login">
    <form method="post" action="login" class="form shadow">
        <div class="logo">
            <img src="/images/logo.png">
        </div>
        <div class="field">
            <div>
                <input type="text" name="userid" id="userid" value="${dto.userid}" placeholder="아이디" />
            </div>
        </div>
        <div class="field">
            <div>
                <input type="password" name="pwd" id="pwd" placeholder="패스워드" />
            </div>
        </div>
        <p class="notice">${msg}</p>
        <div class="btns">
            <input type="submit" value="로그인" />
            <input type="button" value="회원가입" onclick="location.href='joinForm'" />
        </div>
    </form>
</section>

<%@ include file="../footer.jsp" %>