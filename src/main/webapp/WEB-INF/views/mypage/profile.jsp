<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<section>

    <ul class="submenu">
        <li><a href="workList">나의업무</a></li>
        <li><a href="vacationList">연차/반차 신청</a></li>
        <li class="on"><a href="profile">프로필</a></li>
    </ul>

    <h2>프로필</h2>

    <div class="boxBtns clearfix">
        <button type="button" onclick="location.href='changePwdForm'">비밀번호 수정</button>
        <button type="button" onclick="location.href='editProfile'">프로필 수정</button>
    </div>

    <div class="container">
        <div class="profileInfo">
            <div class="imgBox">
                <img src="${filePath}" alt="프로필 이미지">
            </div>
            <div class="profileBox">
                <div class="field">
                    <label>이름</label>
                    <div>${loginUser.name}</div>
                </div>

                <div class="field">
                    <label>아이디</label>
                    <div>${loginUser.userid}</div>
                </div>

                <div class="field">
                    <label>이메일</label>
                    <div>${loginUser.email}</div>
                </div>

                <div class="field">
                    <label>휴대전화 번호</label>
                    <div>${loginUser.phone}</div>
                </div>

                <div class="field">
                    <label>직급</label>
                    <div>${loginUser.position}</div>
                </div>

                <div class="field">
                    <label>부서</label>
                    <div>${loginUser.team}</div>
                </div>

                <div class="field">
                    <label>입사일</label>
                    <div><fmt:formatDate value="${loginUser.joindate}" pattern="yyyy-MM-dd" /></div>
                </div>

                <div class="field">
                    <label>주소</label>
                    <div>(${loginUser.postcode}) ${loginUser.address1} ${loginUser.address2}</div>
                </div>
            </div>
        </div>
    </div>

</section>

<%@ include file="../footer.jsp" %>