<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<%@ include file="sub_menu.jsp" %>
    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <select name="type">
                    <option value="title"<c:if test="${type == 'title'}"> selected</c:if>>업무명</option>
                    <option value="titleContent"<c:if test="${type == 'titleContent'}"> selected</c:if>>업무명+내용</option>
                    <option value="name"<c:if test="${type == 'name'}"> selected</c:if>>요청자</option>
                </select>
                <input type="text" name="key" value="${key}" />
                <button>검색</button>
            </div>
            <div class="boxBtns clearfix" style="display: flex; align-items: center; justify-content: end">
                <input type="button" name="btn_search" value="업무요청" onclick="location.href='insertWorkForm'"/>
            </div>
<%--            <select name="sort" id="sort" style="margin-right: 10px">--%>
<%--                <option value="desc" <c:if test="${sort == 'desc'}"> selected</c:if>>작성일 최근순</option>--%>
<%--                <option value="asc" <c:if test="${sort == 'asc'}"> selected</c:if>>작성일 오래된순</option>--%>
<%--            </select>--%>
        </div>
    </form>

    <div class="table">
        <div class="row head">
            <div class="col">번호</div>

            <div class="col title">
                <span data-sort="title">제목<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'title', 'writedate', 'desc')}"></i></span>
            </div>
            <div class="col">
                <span data-sort="empname">요청자<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'empname', 'writedate', 'desc')}"></i></span>
            </div>
            <div class="col">
                <span data-sort="writedate">등록일<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'writedate', 'writedate', 'desc')}"></i></span>
            </div>
            <div class="col">
                <span data-sort="deadline">마감일<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'deadline', 'writedate', 'desc')}"></i></span>
            </div>
            <div class="col">
                <span data-sort="status">진행상태<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'status', 'writedate', 'desc')}"></i></span>
            </div>
        </div>
        <c:choose>
            <c:when test="${empty list}">
                <div class="row empty">
                    <div class="col">요청받은 업무가 없습니다.</div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${list}" var="item" varStatus="status">
                    <div class="row" style="cursor:pointer; " onclick="location.href='workView?widx=${item.widx}'">
                        <div class="col">${item.loopnum}</div>
                        <div class="col title" style="cursor:pointer; text-align: left">
                            <a href="workView?widx=${item.widx}" style="text-decoration:none">
                                    ${item.title}
                                <c:if test="${item.status==1}">
                                    <span style="color: red; font-weight: bold">New</span>
                                </c:if>
                                <c:if test="${item.comment_count>0}">
                                    <span style="color: blue">[${item.comment_count}]</span>
                                </c:if>
                            </a>
                        </div>
                        <div class="col">${item.empname}</div>
                        <div class="col"><fmt:formatDate value="${item.writedate}" pattern="yyyy-MM-dd"/></div>
                        <div class="col"><fmt:formatDate value="${item.deadline}" pattern="yyyy-MM-dd"/></div>
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
    </div>
    <c:if test="${not empty list}">
        <div class="paging" style="height: 50px; line-height: 50px">
            <c:if test="${paging.prev}"><a href="work?page=${paging.beginPage-1}">Prev</a></c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <a href="work?page=${index}"<c:if test="${index == paging.page}"> style="color: red;"</c:if>>${index}</a>
            </c:forEach>

            <c:if test="${paging.next}"><a href="work?page=${paging.endPage+1}">Next</a></c:if>
        </div>
    </c:if>
</section>

<%@ include file="../footer.jsp" %>