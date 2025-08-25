<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<%@ include file="sub_menu.jsp" %>
<%--<script src="/scripts/request.js"></script>--%>
<style>
  #requests{border: solid #ccc;}
  #requests .row{
    border: 1px solid #ccc;
    display: flex;
    justify-content: space-around;
    padding: 13px 0;}
  #requests .coltitle{font-weight: bold;}

</style>

<section id="requests">
    <h3>보낸 결재 목록</h3>
    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <select name="type">
                    <option value="title"<c:if test="${type == 'title'}"> selected</c:if>>제목</option>
                    <option value="titleContent"<c:if test="${type == 'titleContent'}"> selected</c:if>>제목+내용</option>
                    <option value="name"<c:if test="${type == 'comfirm_midx'}"> selected</c:if>>승인자</option>
                </select>
                <input type="text" name="key" value="${key}" />
                <button>검색</button>
            </div>
            <select name="sort" id="sort">
                <option value="desc" <c:if test="${sort == 'desc'}"> selected</c:if>>작성일 최근순</option>
                <option value="asc" <c:if test="${sort == 'asc'}"> selected</c:if>>작성일 오래된순</option>
            </select>
        </div>
    </form>


    <form method="get" name="requests" class="">
    <div class="tb">

      <div class="row row_title">
        <div class="coltitle">번호</div>
        <div class="coltitle">제목</div>
        <div class="coltitle">보낸날짜</div>
        <div class="coltitle">승인자</div>
        <div class="coltitle">진행상태</div>
      </div>

      <c:choose>
        <c:when test="${empty requestsList}">
            <div class="row empty">
                <div class="col">게시물이 존재하지 않습니다.</div>
            </div>
        </c:when>

        <c:otherwise>
              <c:forEach items="${requestsList}" var="requests">
                <div class="row">
                  <div class="col">${requests.loopnum}</div>
                  <div class="col" style="cursor:pointer" onClick="">
                    <a href="requestsDetail?ridx=${requests.ridx}">
                    ${requests.title}</a></div>

                  <div class="col"><fmt:formatDate value="${requests.writedate}" pattern="yyyy-MM-dd" /></div>
                  <div class="col">${requests.cname}&nbsp;${requests.cposition}</div>
                  <div class="col">
                    <c:choose>
                      <c:when test='${requests.status=="1"}'>대기중</c:when>
                      <c:when test='${requests.status=="2"}'>처리중</c:when>
                      <c:when test='${requests.status=="3"}'>반려</c:when>
                      <c:otherwise>승인</c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </c:forEach>
        </c:otherwise>
      </c:choose>

      <div class="row"> <!-- 페이지의 시작 -->
        <div class="col" style="font-size: 120%; font-weight: bold;">
          <c:if test="${paging.prev}">
            <a href="requests?page=${paging.beginPage-1}&key=${key}">PREV</a>&nbsp;
          </c:if>
          <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
            <c:if test="${index!=paging.page}">
              <a href="requests?page=${index}&key=${key}">${index}</a>&nbsp;
            </c:if>
            <c:if test="${index==paging.page}">
              <span style="color:red">${index}&nbsp;</span>
            </c:if>
          </c:forEach>
          <c:if test="${paging.next}">
            <a href="requests?page=${paging.endPage+1}&key=${key}">NEXT</a>&nbsp;
          </c:if>
        </div>
      </div> <!-- 페이지의 끝 -->

    </div>
  </form>
</section>

<%@ include file="../footer.jsp" %>