<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/requests.css">

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


<section id="form-container" class="section_wrap">
    <form method="post" action="requestsWrite" name="requestsWrite" class="fileForm" enctype="multipart/form-data">
        <input type="hidden" name="fidx" id="fidx">
        <input type="hidden" name="midx" value="${loginUser.midx}">

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
                <label>구분</label>
                <div>
                    <select name="category">
                        <option value="1">업무기안</option>
                        <option value="5">증명서/문서</option>
                        <option value="6">품의/지출</option>
                    </select>
                </div>
            </div>



            <div class="form-row">
                <label for="confirm_midx">결재자</label>
                <select id="confirm_midx" name="confirm_midx" required>
                    <option value="">선택하세요</option>
                    <c:forEach var="member" items="${memberList}">
                        <c:if test="${member.team == loginUser.team && member.midx != loginUser.midx}">
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
            <textarea name="content" id="content" style="display: none;"></textarea>
            <div id="editor"></div>
        </div>

        <div class="form-box" style="display: flex;justify-content: space-between;">
            <div class="file_box">
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