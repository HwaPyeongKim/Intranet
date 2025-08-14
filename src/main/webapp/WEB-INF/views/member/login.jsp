<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<section id="login">
    <form method="post" action="login" class="form">
        <h2>로그인</h2>
        <div class="field">
            <label for="userid">아이디</label>
            <div>
                <input type="text" name="userid" id="userid" value="${dto.userid}" />
            </div>
        </div>
        <div class="field">
            <label for="pwd">패스워드</label>
            <div>
                <input type="password" name="pwd" id="pwd" />
            </div>
        </div>
        <p class="notice">${msg}</p>
        <div class="btns">
            <input type="submit" value="로그인" />
            <input type="button" value="회원가입" onclick="location.href='join'" />
        </div>
    </form>
</section>

<%@ include file="../footer.jsp" %>