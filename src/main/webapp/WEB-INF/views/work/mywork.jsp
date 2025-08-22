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


    <form method="get" name="work" class="form shadow">
    <div class="tb" >
      <div class="tb_top" style="display: flex">
        <div class="col" style="display: flex; align-items: center; justify-content: start">
          &nbsp;업무명&nbsp; <input type="text" name="key" value="${key}"/>&nbsp;&nbsp;
          <input type="button" name="btn_search" value="검색" onclick="go_search('work')"/>
        </div>
        <div class="boxBtns clearfix" style="display: flex; align-items: center; justify-content: end">
          <input type="button" name="btn_search" value="업무요청" onclick="location.href='insertWorkForm'" />&nbsp;
        </div>
      </div>

      <div class="row row_title">
        <div class="coltitle">번호</div>
        <div class="coltitle">업무명</div>
        <div class="coltitle">요청자</div>
        <div class="coltitle">등록일</div>
        <div class="coltitle">마감일</div>
        <div class="coltitle">진행상태</div>
      </div>

      <c:forEach items="${workList}" var="work" varStatus="status">
        <div class="row">
          <div class="col">
          ${(paging.page-1)*(paging.displayRow)+status.count}
          </div>
          <div class="col" style="cursor:pointer">
          <a href="workView?widx=${work.widx}" style="text-decoration:none">
          ${work.title}
          </a>
          </div>
          <div class="col">${work.empname}</div>
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

          <c:if test="${not empty workList}">
            <div class="paging" style="height: 50px; line-height: 50px">
            <c:if test="${paging.prev}"><a href="mywork?page=${paging.beginPage-1}">Prev</a></c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <a href="mywork?page=${index}"<c:if test="${index == paging.page}"> style="color: red;"</c:if>>${index}</a>
            </c:forEach>

            <c:if test="${paging.next}"><a href="mywork?page=${paging.endPage+1}">Next</a></c:if>
            </div>
            </c:if>

    </div>

  </form>
</section>

<%@ include file="../footer.jsp" %>