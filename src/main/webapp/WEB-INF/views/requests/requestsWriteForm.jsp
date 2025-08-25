<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        // 파일 첨부 필드와 삭제 버튼
        const fileInput = document.getElementById('fileBtn');
        const deleteBtn = document.getElementById('deleteBtn');

        // 파일이 첨부되면 삭제 버튼 표시
        fileInput.addEventListener('change', function() {
            if (fileInput.files.length > 0) {
                deleteBtn.style.display = 'inline';  // 파일이 있으면 삭제 버튼 표시
            } else {
                deleteBtn.style.display = 'none';   // 파일이 없으면 삭제 버튼 숨기기
            }
        });

        // 삭제 버튼 클릭 시 파일 삭제
        deleteBtn.addEventListener('click', function() {
            fileInput.value = '';  // 파일 필드 값 초기화 (파일 삭제)
            deleteBtn.style.display = 'none';  // 삭제 버튼 숨기기
        });
    });
</script>

<style>
    .form-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 40px 50px;
        background-color: #f9f9f9;
        border-radius: 8px;
    }

    .form-title {
        text-align: center;
        font-size: 28px;
        font-weight: bold;
        margin-bottom: 30px;
    }

    .form-box {
        background: #fff;
        border: 1px solid #ddd;
        padding: 24px;
        margin-bottom: 25px;
        border-radius: 5px;
    }

    .form-row {
        display: flex;
        align-items: center;
        margin-bottom: 18px;
    }

    .form-row label {
        flex: 0 0 120px;
        font-weight: 600;
    }

    .form-row input[type="text"],
    .form-row select {
        flex: 1;
        padding: 8px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
    }

    .textbox {
        width: 100%;
        min-height: 400px;
        padding: 12px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 4px;
        resize: vertical;
    }

    .form-message {
        color: #e74c3c;
        font-weight: bold;
        text-align: center;
        margin-bottom: 20px;
    }

    .form-buttons {
        text-align: center;
    }

    .form-buttons button {
        padding: 10px 20px;
        margin: 0 10px;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        background-color: #3498db;
        color: #fff;
        transition: background-color 0.3s;
    }

    .form-buttons button:hover {
        background-color: #2980b9;
    }

    .delete-btn {
        margin-left: 10px;
        background-color: #b7b7b7;
        font-size: 16px;
        padding: 6px 10px;
        border: none;
    }
</style>

<section class="form-container">
    <form method="post" action="requestsWrite" name="requestsWrite" class="fileForm" enctype="multipart/form-data">
        <input type="hidden" name="fidx" id="fidx">
        <input type="hidden" name="midx" value="${loginUser.midx}">
        <input type="hidden" name="category" value="1">

        <h2 class="form-title">기안 작성</h2>

        <div class="form-box">
            <div class="form-row">
                <label>작성자</label>
                <div>${loginUser.name}</div>
            </div>

            <div class="form-row">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required />
            </div>

            <div class="form-row">
                <label for="confirm_midx">결재자</label>
                <select id="confirm_midx" name="confirm_midx" required>
                    <option value="">선택하세요</option>
                    <c:forEach var="member" items="${memberList}">
                        <c:if test="${member.level > loginUser.level}">
                            <option value="${member.midx}">
                                ${member.name}&nbsp;${member.position}
                            </option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>

            <div class="form-row">
                <label>작성일자</label>
                <div>${today}</div>
            </div>
        </div>

        <div class="form-box">
            <textarea id="content" class="textbox" name="content" placeholder="내용을 입력하세요" required></textarea>
        </div>

        <div class="form-box" style="display: flex;justify-content: space-between;">
            <div>
                <label for="fileBtn">파일 첨부</label>
                <input type="file" name="file" id="fileBtn">
            </div>
            <button type="button" id="deleteBtn" class="delete-btn" style="display:none;">삭제</button>
        </div>

        <div class="form-message">${message}</div>

        <div class="form-buttons">
            <button type="button" onclick="location.href='requests'">목록으로</button>
            <button type="submit">작성 완료</button>
        </div>
    </form>
</section>

<%@ include file="../footer.jsp" %>