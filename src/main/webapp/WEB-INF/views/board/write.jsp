<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<section id="writeBoard">

    <form method="post" action="writeBoard" name="writeBoard" enctype="multipart/form-data" class="form fileForm shadow">
        <input type="hidden" name="fidx" id="fidx" />
        <input type="hidden" name="midx" value="${loginUser.midx}" />

        <h2>게시글 작성</h2>

        <c:choose>
            <c:when test="${category == 'download'}">
            <input type="hidden" name="category" value="download" />
            </c:when>
            <c:when test="${loginUser.level == 3}">
            <div class="field">
                <label>분류</label>
                <div>
                    <label for="notice">공지사항</label>
                    <input type="radio" name="category" id="notice" value="notice" />
                    <label for="main">일반</label>
                    <input type="radio" name="category" id="main" value="main" />
                </div>
            </div>
            </c:when>
            <c:otherwise>
            <input type="hidden" name="category" value="main" />
            </c:otherwise>
        </c:choose>

        <div class="field">
            <div>
                <input type="text" name="userid" id="userid" value="${loginUser.userid}" readonly placeholder="아이디" />
            </div>
        </div>
        <div class="field">
            <div>
                <input type="text" name="title" value="${dto.title}" placeholder="제목" />
            </div>
        </div>
        <div class="field">
            <div>
                <input type="password" name="pwd" placeholder="패스워드" />
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
            <input type="submit" value="저장하기" />
            <input type="button" value="뒤로가기" onclick="history.back()" />
        </div>
    </form>

</section>

<%@ include file="../footer.jsp" %>