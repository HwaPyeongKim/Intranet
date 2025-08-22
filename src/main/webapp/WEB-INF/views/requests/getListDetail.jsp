<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>

<style>

    h3{text-align: center;font-weight: bold;font-size: 30px;}
    #requestsWriteForm {
        font-size: 20px;
    }

    .req_write_info {
        border: 1px solid #ccc;
        padding: 32px;
        margin-bottom: 30px;
    }

    .req_write_info > div {
        padding: 10px;
    }

    .req_write_w {
        border: 1px solid #ccc;
        padding: 32px;
        margin-bottom: 30px;
    }

    .req_write_w > div {
        padding: 10px;
    }

    .req_file {
        border: 1px solid #ccc;
        padding: 32px;
        margin-bottom: 30px;
    }

    .req_file > div {
        padding: 10px;
    }

    .req_write_w > .textbox {
        width: 100%;
        height: 350px;
    }

    .modal {
        display: none; /* 숨김 */
        position: fixed;
        z-index: 1000;
        left: 0; top: 0; width: 100%; height: 100%;
        background-color: rgba(0,0,0,0.4); /* 반투명 검정 배경 */
    }

    .modal-content {
        background-color: white;
        margin: 15% auto;
        padding: 40px;
        width: 300px;
        border-radius: 8px;
        text-align: center;
        box-shadow: 0 2px 10px rgba(0,0,0,0.5);
    }

    #modalMessage {margin-bottom: 40px;}

    .modal-content button {
        margin: 10px;
        padding: 8px 16px;
        cursor: pointer;
    }

</style>
<section id="getListDetail">
    <div class="requests_wrap">
        <h3>
          <c:choose>
            <c:when test="${rdto.status == '1'}">
              결재요청문서
            </c:when>
            <c:when test="${rdto.status == '2'}">
              처리중문서
            </c:when>
            <c:when test="${rdto.status == '3'}">
              반려 문서
            </c:when>
            <c:when test="${rdto.status == '4'}">
              승인 문서
            </c:when>
          </c:choose>
        </h3>
        <div class="req_write_info">
            <div>작성자 : ${rdto.mname} ${rdto.mposition}</div>
            <div>제목 : ${rdto.title}</div>
            <div>기안날짜 : ${rdto.writedate}</div>
        </div>
        <div class="req_write_w">
            <div>${rdto.content}</div>
        </div>
        <div class="req_file">
            <c:if test="${rdto.fidx > 0}">
                <div class="field">
                    <label>첨부파일</label>
                    <div><a href="${rdto.path}">${rdto.originalname}</a></div>
                </div>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${rdto.status == '1' || rdto.status == '2'}">
                <div>
                    <button onclick="openConfirmModal('${rdto.ridx}', 3)">반려</button>
                    <button onclick="openConfirmModal('${rdto.ridx}', 4)">승인</button>
                </div>
            </c:when>
            <c:otherwise>
                <div><button onclick="location.href='/getList'">목록으로</button></div>
            </c:otherwise>
        </c:choose>


        <!-- 확인 팝업 -->
        <div id="confirmModal" class="modal">
            <div class="modal-content">
                <p id="modalMessage"></p>
                <button id="confirmBtn">확인</button>
                <button onclick="closeConfirmModal()">취소</button>
            </div>
        </div>
    </div>


</section>

<%@ include file="../footer.jsp" %>