<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/requests.css">
<ul class="submenu">
    <li><a href="requests">결재발신함</a></li>
    <li class="on"><a href="getList">결재수신함</a></li>
</ul>
<section id="request-detail-container" class="section_wrap">
    <h2 class="page-title">
        <c:choose>
            <c:when test="${rdto.status == '1'}">결재요청문서</c:when>
            <c:when test="${rdto.status == '2'}">처리중문서</c:when>
            <c:when test="${rdto.status == '3'}">반려 문서</c:when>
            <c:when test="${rdto.status == '4'}">승인 문서</c:when>
        </c:choose>
    </h2>

    <div class="request-info-box">
        <div class="info-row"><span class="label">작성자</span> ${rdto.mname} ${rdto.mposition}</div>
        <div class="info-row"><span class="label">제목</span> ${rdto.title}</div>


            <div class="info-row"><span class="label">구분</span>
                <c:choose>
                    <c:when test="${rdto.category == '1'}">업무기안</c:when>
                    <c:when test="${rdto.category == '2'}">연차</c:when>
                    <c:when test="${rdto.category == '3'}">오전반차</c:when>
                    <c:when test="${rdto.category == '4'}">오후반차</c:when>
                    <c:when test="${rdto.category == '5'}">증명서/문서</c:when>
                    <c:when test="${rdto.category == '6'}">품의/지출</c:when>
                </c:choose>
            </div>
            <c:if test="${rdto.category == 2 || rdto.category == 3 || rdto.category == 4}">
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
    </div>

    <div class="request-content-box">
        <pre class="request-content">${rdto.content}</pre>
    </div>

    <c:if test="${rdto.fidx > 0}">
        <section class="request-file-box">
            <label>첨부파일:</label>
            <a href="${rdto.path}" class="file-link">${rdto.originalname}</a>
        </section>
    </c:if>

    <div class="button-group">
        <c:choose>
            <c:when test="${rdto.status == '1' || rdto.status == '2'}">
                <button type="button" class="btn btn-reject" onclick="openConfirmModal('${rdto.ridx}', 3)">반려</button>
                <button type="button" class="btn btn-approve" onclick="openConfirmModal('${rdto.ridx}', 4)">승인</button>
            </c:when>
            <c:otherwise>
                <button type="button" class="btn btn-list" onclick="location.href='/getList'">목록으로</button>
            </c:otherwise>
        </c:choose>
    </div>

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