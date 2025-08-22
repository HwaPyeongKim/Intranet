<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<section id="writeVacation">

    <h2>연차/반차 작성</h2>

    <form method="post" action="writeVacation" name="writeVacation" enctype="multipart/form-data" class="form fileForm shadow">
        <%-- <input type="hidden" name="fidx" id="fidx" /> --%>
        <input type="hidden" name="midx" value="${loginUser.midx}" />

        <div class="field">
            <label>분류</label>
            <div>
                <label for="category1">연차</label>
                <input type="radio" name="category" id="category1" value="2" <c:if test="${dto.category == 2}"> checked</c:if> <c:if test="${empty dto}"> checked</c:if> />
                <label for="category2">오전반차</label>
                <input type="radio" name="category" id="category2" value="3" <c:if test="${dto.category == 3}"> checked</c:if> />
                <label for="category3">오후반차</label>
                <input type="radio" name="category" id="category3" value="4" <c:if test="${dto.category == 4}"> checked</c:if> />
            </div>
        </div>

        <div class="field inputDate">
            <label>시작/종료 날짜</label>
            <div>
                <input type="date" name="startdate" value="${dto.startdate}" />
                <span> ~ </span>
                <input type="date" name="enddate" value="${dto.enddate}" />
            </div>
        </div>

        <div class="field">
            <label for="title">제목</label>
            <div>
                <input type="text" name="title" id="title" value="${dto.title}" placeholder="제목" />
            </div>
        </div>

        <div class="field">
            <label for="content">사유</label>
            <div>
                <textarea name="content" id="content">${dto.content}</textarea>
            </div>
        </div>

        <%--
        <div class="field">
            <label for="fileBtn">첨부파일</label>
            <div>
                <input type="file" name="file" id="fileBtn" value="첨부파일 선택" />
            </div>
        </div>
        --%>
        <p class="notice">${msg}</p>
        <div class="btns">
            <input type="submit" value="저장하기" />
            <input type="button" value="뒤로가기" onclick="history.back()" />
        </div>
    </form>

</section>

<%@ include file="../footer.jsp" %>