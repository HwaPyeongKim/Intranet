<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<section id="login">
    <form method="post" action="adminLogin" class="form shadow">
        <h2>관리자 로그인</h2>
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
        </div>
    </form>
</section>

<%@ include file="footer.jsp" %>