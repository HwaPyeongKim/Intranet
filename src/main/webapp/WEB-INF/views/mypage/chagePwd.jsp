<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<ul class="submenu">
    <li><a href="workList">나의업무</a></li>
    <li><a href="vacationList">연차/반차 신청</a></li>
    <li class="on"><a href="profile">프로필 수정</a></li>
</ul>

<section id="mypage">

    <h2>비밀번호 수정</h2>

    <div class="container">
        <div id="profileForm" class="">
            <form method="post" action="changePwd" class="form">
                <div class="field">
                    <div>
                        <input type="password" name="pwd" placeholder="현재 비밀번호" />
                    </div>
                </div>
                <div class="field">
                    <div>
                        <input type="password" name="newPwd" placeholder="새 비밀번호" />
                    </div>
                </div>
                <div class="field">
                    <div>
                        <input type="password" name="newPwdChk" placeholder="새 비밀번호 확인" />
                    </div>
                </div>
                <p class="notice">${msg}</p>
                <div class="btns">
                    <input type="submit" value="수정" />
                    <input type="button" value="뒤로가기" onclick="history.back()" />
                </div>
            </form>
        </div>
    </div>

</section>

<%@ include file="../footer.jsp" %>