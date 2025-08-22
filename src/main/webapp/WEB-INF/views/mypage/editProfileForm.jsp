<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<section id="mypage">

    <ul class="submenu">
        <li><a href="workList">나의업무</a></li>
        <li><a href="vacationList">연차/반차 신청</a></li>
        <li class="on"><a href="profile">프로필 수정</a></li>
    </ul>

    <h2>프로필 수정</h2>

    <div class="container">
        <div id="profileForm" class="shadow">
            <form method="post" action="updateProfile" class="form imageForm">
                <input type="hidden" name="image" id="image" value="${dto.image}" />
                <input type="hidden" name="midx" value="${dto.midx}" />

                <h2>프로필 수정</h2>
                <div class="field">
                    <div class="userid">
                        <input type="text" name="userid" id="userid" value="${dto.userid}" placeholder="아이디" readonly />
                    </div>
                </div>
                <div class="field">
                    <div>
                        <input type="text" name="name" value="${dto.name}" placeholder="이름" />
                    </div>
                </div>
                <div class="field">
                    <div>
                        <input type="email" name="email" value="${dto.email}" placeholder="이메일" />
                    </div>
                </div>
                <div class="field">
                    <div class="phone">
                        <select name="phone1">
                            <option value="">휴대전화번호</option>
                            <option value="010"<c:if test="${phone[0] == '010'}"> selected</c:if>>010</option>
                            <option value="011"<c:if test="${phone[0] == '011'}"> selected</c:if>>011</option>
                            <option value="016"<c:if test="${phone[0] == '016'}"> selected</c:if>>016</option>
                            <option value="017"<c:if test="${phone[0] == '017'}"> selected</c:if>>017</option>
                        </select>
                        <span>-</span>
                        <input type="text" name="phone2" value="${phone[1]}" maxlength="4" />
                        <span>-</span>
                        <input type="text" name="phone3" value="${phone[2]}" maxlength="4" />
                    </div>
                </div>
                <div class="field">
                    <div class="address">
                        <input type="text" name="postcode" id="postcode" value="${dto.postcode}" placeholder="우편번호" readonly />
                        <button type="button" id="btn_findAddress" onclick="findAddress()">검색</button>
                    </div>
                </div>
                <div class="field">
                    <div>
                        <input type="text" name="address1" id="address1" value="${dto.address1}" placeholder="주소" readonly />
                    </div>
                </div>
                <div class="field">
                    <div>
                        <input type="text" name="address2" value="${dto.address2}" placeholder="상세주소" />
                    </div>
                </div>
                <div class="field">
                    <label for="imgPrevBtn">프로필 이미지</label>
                    <div>
                        <div id="imgPrev" style="display: block !important;">
                            <img src="${filePath}" />
                        </div>
                        <input type="file" name="imgPrev" id="imgPrevBtn" value="이미지 선택" />
                    </div>
                </div>
                <p class="notice">${msg}</p>
                <div class="btns">
                    <input type="submit" value="수정하기" />
                </div>
            </form>
        </div>
    </div>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script type="text/javascript">
        function findAddress(){
            new daum.Postcode( {
                oncomplete: function(data) {
                    var addr = ''; // 주소 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("address1").value = addr;
                }
            }).open();
        }
    </script>

</section>

<%@ include file="../footer.jsp" %>