<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<%@ include file="sub_menu.jsp" %>

<form method="get" name="search" class="form shadow" id="searchForm">
    <div class="tb">
        <div class="tb_top" style="display: flex; align-items: center; justify-content: end; ">
<%--            <div class="col" style="display: flex; align-items: center; justify-content: start">--%>
<%--                &nbsp;업무명&nbsp; <input type="text" name="key" value="${key}"/>&nbsp;&nbsp;--%>
<%--                <input type="button" name="btn_search" value="검색" onclick="go_search('work')"/>--%>
<%--            </div>--%>
            <div class="searchBox">
                <input type="button" name="btn_search" value="업무요청" onclick="location.href='insertWorkForm'"/>&nbsp;
            </div>
        </div>

        <div class="searchBox" style="margin-bottom: 20px">
            <div class="input">
                &nbsp;&nbsp;<select name="type">
                    <option value="title"<c:if test="${type == 'title'}"> selected</c:if>>업무명</option>
                    <option value="titleContent"<c:if test="${type == 'titleContent'}"> selected</c:if>>업무명+내용</option>
                    <option value="name"<c:if test="${type == 'name'}"> selected</c:if>>수신자</option>
                </select>
                <input type="text" name="key" value="${key}" />
                <button>검색</button>
            </div>
            <select name="sort" id="sort" style="margin-right: 10px">
                <option value="desc" <c:if test="${sort == 'desc'}"> selected</c:if>>작성일 최근순</option>
                <option value="asc" <c:if test="${sort == 'asc'}"> selected</c:if>>작성일 오래된순</option>
            </select>
        </div>

        <div class="row row_title">
            <div class="coltitle">번호</div>
            <div class="coltitle">업무명</div>
            <div class="coltitle">수신자</div>
            <div class="coltitle">등록일</div>
            <div class="coltitle">마감일</div>
            <div class="coltitle">진행상태</div>
        </div>

        <c:choose>
            <c:when test="${empty list}">
                <div class="row empty">
                    <div class="col">요청한 업무가 없습니다.</div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${list}" var="item" varStatus="status">
                    <div class="row" style="cursor:pointer; " onclick="location.href='workView?widx=${item.widx}'">
                        <div class="col">
                                ${(paging.page-1)*(paging.displayRow)+status.count}
                        </div>
                        <div class="col" style="cursor:pointer; ">
                            <a href="workView?widx=${item.widx}" style="text-decoration:none">
                                ${item.title}
                                <c:if test="${item.status==5}">
                                    <span style="color: red">(new!)</span>
                                </c:if>
                                <c:if test="${item.comment_count>0}">
                                    <span style="color: blue">[${item.comment_count}]</span>
                                </c:if>
                            </a>
                        </div>
                        <div class="col">${item.workername}</div>
                        <div class="col"><fmt:formatDate value="${item.writedate}" pattern="yyyy-MM-dd"/></div>
                        <div class="col"><fmt:formatDate value="${item.completedate}" pattern="yyyy-MM-dd"/></div>
                        <div class="col">
                            <c:choose>
                                <c:when test='${item.status=="1"}'>대기중</c:when>
                                <c:when test='${item.status=="2"}'>진행중</c:when>
                                <c:when test='${item.status=="3"}'>보류</c:when>
                                <c:when test='${item.status=="4"}'>반려</c:when>
                                <c:when test='${item.status=="5"}'>검토중</c:when>
                                <c:otherwise>완료</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <c:if test="${not empty list}">
        <div class="paging" style="height: 50px; line-height: 50px">
            <c:if test="${paging.prev}"><a href="yourwork?page=${paging.beginPage-1}">Prev</a></c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <a href="yourwork?page=${index}"<c:if test="${index == paging.page}"> style="color: red;"</c:if>>${index}</a>
            </c:forEach>

            <c:if test="${paging.next}"><a href="yourwork?page=${paging.endPage+1}">Next</a></c:if>
        </div>
    </c:if>
    </div>
</form>
</section>


<%@ include file="../footer.jsp" %>