<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>

<style>

    .request-detail-container {
        max-width: 700px;
        margin: 40px auto;
        padding: 40px 50px;
        background-color: #fafafa;
        border-radius: 8px;
        font-family: "Noto Sans KR", "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    }

    .page-title {
        text-align: center;
        font-weight: 700;
        font-size: 32px;
        margin-bottom: 40px;
    }

    .request-info-box {
        border: 1px solid #ccc;
        padding: 28px 30px;
        margin-bottom: 30px;
        background-color: #fff;
        border-radius: 6px;
    }

    .info-row {
        font-size: 18px;
        line-height: 42px;
    }

    .info-row .label {
        display: inline-block;
        width: 160px;
        font-weight: 600;
    }

    .request-content-box {
        border: 1px solid #ccc;
        padding: 28px 30px;
        background-color: #fff;
        border-radius: 6px;
        margin-bottom: 30px;
        min-height: 300px;
    }

    .request-content {
        white-space: pre-wrap;
        font-size: 17px;
        line-height: 1.6;
        color: #444;
    }

    .request-file-box {
        border: 1px solid #ccc;
        padding: 20px 30px;
        background-color: #fff;
        border-radius: 6px;
        margin-bottom: 30px;
    }

    .request-file-box label {
        font-weight: 600;
        margin-right: 15px;
        color: #555;
    }

    .file-link {
        color: #2980b9;
        text-decoration: none;
        font-size: 16px;
    }

    .file-link:hover {
        text-decoration: underline;
    }

    .button-group {
        text-align: center;
        margin-top: 15px;
    }

    .btn {
        display: inline-block;
        font-size: 16px;
        font-weight: 600;
        padding: 10px 28px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.25s ease;
        margin: 0 10px;
    }

    .btn-delete {
        background-color: #e74c3c;
        color: white;
    }

    .btn-delete:hover {
        background-color: #c0392b;
    }

    .btn-list {
        background-color: #3498db;
        color: white;
    }

    .btn-list:hover {
        background-color: #2980b9;
    }

    /* Modal styles */
    .modal {
        display: none;
        position: fixed;
        z-index: 1500;
        left: 0; top: 0;
        width: 100%; height: 100%;
        background-color: rgba(0,0,0,0.45);
    }

    .modal-content {
        background: white;
        width: 320px;
        margin: 15% auto;
        padding: 40px 25px;
        border-radius: 10px;
        text-align: center;
        box-shadow: 0 3px 15px rgba(0,0,0,0.3);
        font-size: 18px;
    }

    .modal-content p {
        margin-bottom: 35px;
        color: #333;
    }

    .btn-confirm {
        background-color: #27ae60;
        color: white;
        margin-right: 12px;
    }

    .btn-confirm:hover {
        background-color: #1e8449;
    }

    .btn-cancel {
        background-color: #bdc3c7;
        color: #2c3e50;
    }

    .btn-cancel:hover {
        background-color: #95a5a6;
    }

</style>

<section class="request-detail-container">
    <h2 class="page-title">
        <c:choose>
            <c:when test="${rdto.status == '1'}">결재요청문서</c:when>
            <c:when test="${rdto.status == '2'}">처리중문서</c:when>
            <c:when test="${rdto.status == '3'}">반려 문서</c:when>
            <c:when test="${rdto.status == '4'}">승인 문서</c:when>
        </c:choose>
    </h2>

    <section class="request-info-box">
        <div class="info-row"><span class="label">작성자</span> ${rdto.mname} ${rdto.mposition}</div>
        <div class="info-row"><span class="label">제목</span> ${rdto.title}</div>

        <c:if test="${rdto.category != 1}">
            <div class="info-row"><span class="label">구분</span>
                <c:choose>
                    <c:when test="${rdto.category == '2'}">연차</c:when>
                    <c:when test="${rdto.category == '3'}">오전반차</c:when>
                    <c:when test="${rdto.category == '4'}">오후반차</c:when>
                </c:choose>
            </div>
            <div class="info-row"><span class="label">휴가 희망일자</span>
                <c:choose>
                    <c:when test="${rdto.category == '2'}">${rdto.startdate}&nbsp;~&nbsp;${rdto.enddate}
                    </c:when>
                    <c:when test="${rdto.category == '3'}">${rdto.startdate}</c:when>
                    <c:when test="${rdto.category == '4'}">${rdto.startdate}</c:when>
                </c:choose>
            </div>
        </c:if>

        <div class="info-row"><span class="label">작성일자</span> ${rdto.writedate}</div>
        <c:if test="${rdto.status == '3' || rdto.status == '4'}">
            <div class="info-row"><span class="label">처리일자</span> ${rdto.confirmdate}</div>
        </c:if>
    </section>

    <section class="request-content-box">
        <pre class="request-content">${rdto.content}</pre>
    </section>

    <c:if test="${rdto.fidx > 0}">
        <section class="request-file-box">
            <label>첨부파일:</label>
            <a href="${rdto.path}" class="file-link">${rdto.originalname}</a>
        </section>
    </c:if>

    <section class="button-group">
        <c:choose>
            <c:when test="${rdto.status == '1' || rdto.status == '2'}">
                <button type="button" class="btn btn-reject" onclick="openConfirmModal('${rdto.ridx}', 3)">반려</button>
                <button type="button" class="btn btn-approve" onclick="openConfirmModal('${rdto.ridx}', 4)">승인</button>
            </c:when>
            <c:otherwise>
                <button type="button" class="btn btn-list" onclick="location.href='/getList'">목록으로</button>
            </c:otherwise>
        </c:choose>
    </section>

    <!-- 확인 모달 -->
    <div id="confirmModal" class="modal">
        <div class="modal-content">
            <p id="modalMessage">처리하시겠습니까?</p>
            <button id="confirmBtn" class="btn btn-confirm">확인</button>
            <button type="button" class="btn btn-cancel" onclick="closeConfirmModal()">취소</button>
        </div>
    </div>
</section>

<%@ include file="../footer.jsp" %>