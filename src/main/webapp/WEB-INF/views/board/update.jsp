<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<section id="writeBoard">

    <form method="post" action="updateBoard" name="updateBoard" enctype="multipart/form-data" class="form fileForm">
        <input type="hidden" name="fidx" id="fidx" value="${item.fidx}" />
        <input type="hidden" name="bidx" value="${item.bidx}" />
        <input type="hidden" name="midx" value="${item.midx}" />

        <h2>게시글 수정</h2>

        <c:choose>
            <c:when test="${item.category == 'download'}">
            <input type="hidden" name="category" value="download" />
            </c:when>
            <c:when test="${loginUser.level == 3}">
            <div class="field">
                <label>분류</label>
                <div>
                    <input type="radio" name="category" id="notice" value="notice" <c:if test="${item.category == 'notice'}"> checked</c:if> />
                    <label for="notice">공지사항</label>
                    <input type="radio" name="category" id="main" value="main" <c:if test="${item.category == 'main'}"> checked</c:if> />
                    <label for="main">일반</label>
                </div>
            </div>

            <div class="field">
                <label>노출여부</label>
                <div>
                    <input type="radio" name="showyn" id="showyn_y" value="Y" <c:if test="${item.showyn == 'Y'}"> checked</c:if> />
                    <label for="showyn_y">노출</label>
                    <input type="radio" name="showyn" id="showyh_n" value="N" <c:if test="${item.showyn == 'N'}"> checked</c:if> />
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
                <input type="text" name="title" value="${item.title}" placeholder="제목" />
            </div>
        </div>

        <div class="field">
            <label>내용</label>
            <textarea name="content" id="content"></textarea>
            <div id="editor">${item.content}</div>
        </div>

        <div class="field">
            <label for="fileBtn">첨부파일</label>
            <div class="prevFile">
                <c:if test="${item.fidx > 0}"><a href="${item.path}">${item.originalname}</a></c:if>
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