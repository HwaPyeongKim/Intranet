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
    #requestsWriteForm { font-size: 20px; }
    .req_write_info, .req_write_w, .req_file {
        border: 1px solid #ccc;
        padding: 32px;
        margin-bottom: 30px;
    }
    .req_write_info > div, .req_write_w > div, .req_file > div {
        padding: 10px;
    }
    .req_write_w > .textbox { width: 100%; height: 350px; }
</style>

<section id="requestsWriteForm">
  <form method="post" action="requestsWrite" name="requestsWrite" class="fileForm" enctype="multipart/form-data">
      <input type="hidden" name="fidx" id="fidx">
      <input type="hidden" name="midx" value="${loginUser.midx}">

      <div class="requests_wrap">
        <h3>기안 작성 폼</h3>
        <div class="req_write_info">
            <div>작성자 : ${loginUser.name}</div>
            <div>제목 : <input type="text" name="title" placeholder="제목을 입력하세요" required/></div>
            <div>승인자 :
              <select name="confirm_midx" required>
                <option value="">선택하세요</option>
                <c:forEach var="member" items="${memberList}">
                    <c:if test="${member.level > loginUser.level}">
                        <option value="${member.midx}">${member.name}&nbsp;${member.position}</option>
                    </c:if>
                </c:forEach>
              </select>
            </div>
            <div>날짜 : ${today}</div>
        </div>

        <div class="req_write_w">
          <textarea class="textbox" name="content" placeholder="내용을 입력하세요" required></textarea>
        </div>

        <div class="req_file">
            <label for="fileBtn">파일첨부 :</label>
            <input type="file" name="file" id="fileBtn">
            <button type="button" id="deleteBtn" style="display:none;">삭제</button>
        </div>
        <div>${message}</div>
      </div>

    <div class="req_btn">
        <input type="button" value="목록으로" onclick="location.href='requests'">
        <input type="submit" value="작성완료">
    </div>
  </form>
</section>

<%@ include file="../footer.jsp" %>