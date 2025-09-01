<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<%@ include file="sub_menu.jsp" %>
<style>
    section#insertWork {margin-top: 50px; display: flex; justify-content: center;}
    section#insertWork form {
        width: 100%; padding: 20px; border: 1px solid #000; border-radius: 10px;}
</style>

<section id="insertWork">

    <form method="post" action="insertWork" name="insertWork" enctype="multipart/form-data" class="form fileForm shadow">
        <input type="hidden" name="fidx" id="fidx" />

        <h2>업무 요청</h2>

        <div class="field">
            <div>
                <label for="title">업무명</label>
                <input type="text" name="title" value="${dto.title}" />
            </div>
        </div>
        <div class="field">
            <div>
                <label for="name">요청자</label>
                <input type="text" name="name" id="name" value="${loginUser.name}" readonly />
                <input type="hidden" name="midx" value="${loginUser.midx}">
                <input type="hidden" name="status" value="1">
            </div>
        </div>
        <div class="field">
            <div>
                <label for="worker">수신자</label>
                    <select name="worker" id="worker">
                        <option value="">수신자를 선택하세요</option>
                        <%-- 모델에서 멤버 목록을 반복문으로 출력 --%>
                        <c:forEach var="member" items="${members}">
                            <c:if test="${member.midx ne loginUser.midx}">
                                <c:choose>
                                    <c:when test="${dto.worker eq member.midx}"> <%-- 필드값 오류로 다시 돌아올 때 수신자 정보 비교 --%>
                                        <option value="${member.midx}" selected>${member.name}</option>  <%-- 기존에 선택했던 값 --%>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${member.midx}">${member.name}</option>  <%-- member.id와 member.name을 사용 --%>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:forEach>
                    </select>
            </div>
        </div>
        <div class="field">
            <div>
                <label for="completedate">마감기한 &nbsp;&nbsp;</label>
                <jsp:useBean id="now" class="java.util.Date"/>
                <fmt:formatDate value="${now}" pattern="yyyy-MM-dd'T'HH:mm" var="now" />
                <input type="datetime-local"
                min="${now}"
                name="completedate" value="${completedate}" style="width: 250px"/>
            </div>
        </div>
        <div class="field">
            <label>내용</label>
            <div>
                <textarea name="content" id="content" style="display: none;"></textarea>
                <div id="editor"></div>
            </div>
        </div>
        <div class="field">
            <label for="fileBtn">첨부파일</label>
            <div>
                <input type="file" name="file" id="fileBtn" value="첨부파일 선택" />
            </div>
        </div>
        <p class="notice">${msg}</p>

        <div class="btns">
            <input type="submit" value="요청하기" />
            <input type="button" value="뒤로가기" onclick="history.back()" />
        </div>
    </form>

</section>
<%@ include file="../footer.jsp" %>
