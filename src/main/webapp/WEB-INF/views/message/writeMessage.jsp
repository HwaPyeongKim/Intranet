<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
  <title>메세지 작성</title>
</head>
<style>
  .form-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 40px 50px;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
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
    flex: 0 0 60px;
    font-weight: bold;

  }

  .select-row label{
    flex: 0 0 60px;
    font-weight: bold;
  }

  .form-row input[type="text"],
  .form-row select {
    flex: 1;
    padding: 8px 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
  }

  .textbox2 {
    width: 500px;
    min-height: 150px;
    padding: 20px;
    margin-top: 20px;
    font-size: 16px;
    border-radius: 10px;
    resize: vertical;
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

  .form-row button {
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

  .select-row {
    width:100%; max-width:400px;
    display: flex;
  }

  select {
    width: 100%;     /* 부모 컨테이너 기준으로 꽉 채움 */
    max-width: 100%; /* 영역 넘지 않도록 제한 */
    box-sizing: border-box; /* 패딩 포함한 크기 계산 */
  }

</style>

<section class="form-container">
  <form action="sendMessage" method="post" onsubmit="return validateForm()">
    <input type="hidden" name="frommidx" value="${loginUser.midx}"/>
    <h2 class="form-title">메세지 보내기</h2>

    <div class="form-box">
      <div class="form-row">
        <label>발신자</label>
        <div>${userName}&nbsp;${userPosition}</div>
      </div>

      <div class="select-row">
        <label>수신자</label>
        <select name="tomidx" id="tomidx">
          <option value="">수신자를 선택하세요</option>
          <c:forEach var="member" items="${memberList}">
            <c:if test="${member.midx ne loginUser.midx}">
              <option value="${member.midx}">${member.name}&nbsp;${member.position}</option>
            </c:if>
          </c:forEach>
        </select>
      </div>
      <div class="form-row">
        <textarea id="content" class="textbox2" name="content" placeholder="내용을 입력하세요" required></textarea>
      </div>
      <div class="form-row" style="justify-content: end">
        <button type="submit">전송</button>
      </div>
      ${msg}
    </div>
  </form>
</section>

<script>
  function validateForm() {
    const selectBox = document.getElementById("tomidx");
    if (selectBox.value === "") {
      alert("수신자를 선택하세요");
      return false; // 전송 막기
    }
    return true;
  }
</script>

<%
  String result = request.getParameter("result");
  if("success".equals(result)){
%>
<script>
  alert("메세지가 전송되었습니다.");
  window.close();
</script>
<% } %>
</body>

