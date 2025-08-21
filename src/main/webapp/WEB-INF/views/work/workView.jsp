<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<style>
    section#insertWork {margin-top: 50px; display: flex; justify-content: center;}
    section#insertWork form {
        width: 80%; padding: 20px; border: 1px solid #000; border-radius: 10px;}
</style>

<section id="workView">

    <form name="workView">
        <input type="hidden" name="fidx" id="fidx" />

        <h2>업무 상세보기</h2>

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
                <input type="text" name="worker" id="worker" value="${dto.worker}" />
                <select name="worker">
                    <option value="${dto.worker}">${member.name}</option>
                </select>
            </div>
        </div>
        <div class="field">
            <div>
                <label for="completedate">마감기한 &nbsp;&nbsp;</label>
                <input type="datetime-local" name="completedate" value="${dto.completedate}" style="width: 250px"/>
            </div>
        </div>
        <div class="field">
            <label for="content">내용</label>
            <div>
                <textarea name="content" id="content"></textarea>
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
