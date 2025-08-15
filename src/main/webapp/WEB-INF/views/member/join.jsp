<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<section id="join">
    <form method="post" action="join" enctype="multipart/form-data" class="form imageForm shadow">
        <input type="hidden" name="image" id="image" value="${dto.image}" />

        <h2>회원가입</h2>
        <div class="field">
            <div>
                <input type="text" name="userid" value="${dto.userid}" placeholder="아이디" />
            </div>
        </div>
        <div class="field">
            <div>
                <input type="password" name="pwd" placeholder="패스워드" />
            </div>
        </div>
        <div class="field">
            <div>
                <input type="password" name="pwdChk" placeholder="패스워드 확인" />
            </div>
        </div>
        <div class="field">
            <div>
                <input type="text" name="name" value="${dto.name}" placeholder="주민등록번호" maxlength="13" />
            </div>
        </div>
        <div class="field">
            <div>
                <input type="email" name="email" value="${dto.email}" placeholder="이메일" />
            </div>
        </div>
        <div class="field">
            <div>
                <input type="text" name="phone" value="${dto.phone}" placeholder="휴대전화번호" />
            </div>
        </div>
        <div class="field">
            <div>
                <input type="text" name="postcode" value="${dto.postcode}" placeholder="우편번호" readonly />
                <button type="button" onclick="postcode()">검색</button>
            </div>
        </div>
        <div class="field">
            <div>
                <input type="text" name="address1" value="${dto.address1}" placeholder="주소" readonly />
            </div>
        </div>
        <div class="field">
            <div>
                <input type="text" name="address2" value="${dto.address2}" placeholder="상세주소" />
            </div>
        </div>
        <div class="field">
            <label for="imgPrevBtn">Image</label>
            <div>
                <div id="imgPrev">
                    <c:if test="${not empty dto.image}">
                        <img src="${dto.image}" />
                    </c:if>
                </div>
                <input type="file" name="imgPrev" id="imgPrevBtn" value="이미지 선택" />
            </div>
        </div>
        <p class="notice">${msg}</p>
        <div class="btns">
            <input type="submit" value="회원가입" />
            <input type="button" value="뒤로가기" onclick="history.back()" />
        </div>
    </form>
</section>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
    function postcode(){
        new daum.Postcode( {
            oncomplete: function(data) {
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address1").value = addr;
            }
        }).open();
    }
</script>

<%@ include file="../footer.jsp" %>