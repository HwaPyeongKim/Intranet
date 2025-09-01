<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<%@ include file="sub_menu.jsp" %>
<style>
    section#insertWork {margin-top: 50px; display: flex; justify-content: center;}
    section#insertWork form {
        width: 100%; padding: 20px; border: 1px solid #000; border-radius: 10px;}
</style>

<section id="insertWork">

    <form method="post" action="updateWork" name="updateWork" enctype="multipart/form-data" class="form fileForm shadow">
        <input type="hidden" name="fidx" id="fidx" value="${workitem.fidx}" />
        <input type="hidden" name="widx" value="${workitem.widx}" />
        <input type="hidden" name="midx" value="${workitem.midx}" />

        <h2>업무 수정</h2>

        <div class="field">
            <div>
                <label for="title">업무명</label>
                <input type="text" name="title" value="${workitem.title}" />
            </div>
        </div>
        <div class="field">
            <div>
                <label for="name">요청자</label>
                <input type="text" name="name" id="name" value="${loginUser.name}" readonly />
            </div>
        </div>
        <div class="field">
            <div>
                <label for="worker">수신자</label>
                <input type="text" name="workername" id="workername" value="${workitem.workername}" readonly />
                <input type="hidden" name="worker" value="${workitem.worker}">
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
            <label for="content">내용</label>
            <div>
                <textarea name="content" id="content" style="display: none;"></textarea>
                <div id="editor">${workitem.content}</div>
            </div>
        </div>
        <div class="field">
            <label for="fileBtn">첨부파일</label>
            <div class="prevFile">
                <c:if test="${workitem.fidx > 0}"><a href="${workitem.path}">${workitem.originalname}</a></c:if>
                <input type="file" name="file" id="fileBtn" value="첨부파일 선택" />
            </div>
        </div>
        <p class="notice">${msg}</p>

        <div class="btns">
            <input type="submit" value="수정하기" />
            <input type="button" value="뒤로가기" onclick="history.back()" />
        </div>
    </form>

</section>
<%@ include file="../footer.jsp" %>
