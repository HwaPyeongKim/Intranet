<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<ul class="submenu">
    <li <c:if test="${param.category != 'download'}"> class="on"</c:if>><a href="board">메인게시판</a></li>
    <li <c:if test="${param.category == 'download'}"> class="on"</c:if>><a href="download">자료실</a></li>
</ul>
<section id="writeBoard">

    <form method="post" action="writeBoard" name="writeBoard" enctype="multipart/form-data" class="form fileForm">
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
                    <input type="radio" name="category" id="notice" value="notice" <c:if test="${dto.category == 'notice'}"> checked</c:if> />
                    <label for="notice">공지사항</label>
                    <input type="radio" name="category" id="main" value="main" <c:if test="${dto.category == 'main' || empty dto}"> checked</c:if> />
                    <label for="main">일반</label>
                </div>
            </div>

            <div class="field">
                <label>노출여부</label>
                <div>
                    <input type="radio" name="showyn" id="showyn_y" value="Y" <c:if test="${dto.showyn == 'Y' || empty dto}"> checked</c:if> />
                    <label for="showyn_y">노출</label>
                    <input type="radio" name="showyn" id="showyh_n" value="N" <c:if test="${dto.showyn == 'N'}"> checked</c:if> />
                    <label for="showyh_n">미노출</label>
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
            <label>내용</label>
            <textarea name="content" id="content" style="display: none;"></textarea>
            <div id="editor"></div>
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