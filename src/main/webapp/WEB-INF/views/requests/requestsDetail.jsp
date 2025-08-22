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

</style>

<section id="requestsDetail">
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
            <div>작성자 : ${loginUser.name}</div>
            <div>제목 : ${rdto.title}</div>
            <div>승인자 : ${user.name}</div>
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
        <div><button onclick="location.href='/requests'">목록으로</button></div>
    </div>


</section>

<%@ include file="../footer.jsp" %>