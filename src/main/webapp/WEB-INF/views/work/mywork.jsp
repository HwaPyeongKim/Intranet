<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<%@ include file="sub_menu.jsp" %>
<style>
  #work {}
  #work .row{
    border: 1px solid #ccc;
    display: flex;
    justify-content: space-around;
    padding: 13px 0;}
  #work .coltitle{font-weight: bold;
      display: flex;
      justify-content: space-around;
      flex:1; }

  #work .col{
      display: flex;
      justify-content: space-around;
      flex:1 }

</style>

<section id="work">
    <form method="get" name="work" class="form shadow">
    <div class="tb">
      <div class="tb_top">
        <div class="col" style="display: flex; align-items: center; justify-content: start">
          업무명&nbsp; <input type="text" name="key" value="${key}"/>&nbsp;&nbsp;
          <input type="button" name="btn_search" value="검색" onclick="go_search('work')"/>
        </div>
      </div>

      <div class="row row_title">
        <div class="coltitle">번호</div>
        <div class="coltitle"><a href="workView?widx=${work.widx}">업무명</a></div>
        <div class="coltitle">요청자</div>
        <div class="coltitle">등록일</div>
        <div class="coltitle">마감일</div>
        <div class="coltitle">진행상태</div>
      </div>

      <c:forEach items="${workList}" var="work">
        <div class="row">
          <div class="col">${work.widx}</div>
          <div class="col" style="cursor:pointer" onClick="">${work.title}</div>
          <div class="col">${work.name}</div>
          <div class="col"><fmt:formatDate value="${work.writedate}" pattern="yyyy-MM-dd" /></div>
          <div class="col"><fmt:formatDate value="${work.completedate}" pattern="yyyy-MM-dd" /></div>
          <div class="col">
            <c:choose>
              <c:when test='${work.status=="1"}'>대기중</c:when>
              <c:when test='${work.status=="2"}'>진행중</c:when>
              <c:when test='${work.status=="3"}'>보류</c:when>
              <c:when test='${work.status=="4"}'>반려</c:when>
              <c:when test='${work.status=="5"}'>검토중</c:when>
              <c:otherwise>완료</c:otherwise>
            </c:choose>
          </div>
        </div>
      </c:forEach>

      <div class="row"> <!-- 페이지의 시작 -->
        <div class="col" style="font-size: 120%; font-weight: bold;">
          <c:if test="${paging.prev}">
            <a href="work?page=${paging.beginPage-1}&key=${key}">PREV</a>&nbsp;
          </c:if>
          <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
            <c:if test="${index!=paging.page}">
              <a href="work?page=${index}&key=${key}">${index}</a>&nbsp;
            </c:if>
            <c:if test="${index==paging.page}">
              <span style="color:red">${index}&nbsp;</span>
            </c:if>
          </c:forEach>
          <c:if test="${paging.next}">
            <a href="work?page=${paging.endPage+1}&key=${key}">NEXT</a>&nbsp;
          </c:if>
        </div>
      </div> <!-- 페이지의 끝 -->


    </div>
  </form>
</section>

<%@ include file="../footer.jsp" %>