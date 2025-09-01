<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<section id="adminMemberAttendanceList">
    <h2>근태 현황</h2>

    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <input type="date" name="startdate" value="${startdate}">
                <input type="date" name="enddate" value="${enddate}">
                <select name="type">
                    <option value="name"<c:if test="${type == 'name'}"> selected</c:if>>이름</option>
                </select>
                <input type="text" name="key" value="${key}" />
                <button>검색</button>
            </div>
            <c:if test="${loginUser.level > 2}">
                <div class="boxBtns clearfix">
                    <button type="button" onclick="setMember('attendance')">퇴근처리</button>
                </div>
            </c:if>
        </div>
    </form>

    <form method="post" name="adminMemberAttendanceInfo" id="adminMemberAttendanceInfo">

        <table>
            <thead>
                <tr>
                    <th><input type="checkbox" /></th>
                    <th class="col">
                        <span data-sort="date">날짜<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'date', 'date', 'desc')}"></i></span>
                    </th>
                    <th class="col">
                        <span data-sort="name">이름<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'name', 'date', 'desc')}"></i></span>
                    </th>
                    <th class="col">
                        <span data-sort="starttime">출근시간<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'starttime', 'date', 'desc')}"></i></span>
                    </th>
                    <th class="col">
                        <span data-sort="endtime">퇴근시간<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'endtime', 'date', 'desc')}"></i></span>
                    </th>
                </tr>
            </thead>

            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="4">출/퇴근 이력이 존재하지 않습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${list}" var="item">
                            <tr>
                                <td><input type="checkbox" name="maidx" value="${item.maidx}" /></td>
                                <td><fmt:formatDate value="${item.date}" pattern="yyyy-MM-dd" /></td>
                                <td>${item.name}</td>
                                <td><fmt:formatDate value="${item.starttime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                <td><fmt:formatDate value="${item.endtime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>

        </table>
    </form>

    <c:if test="${not empty list}">
        <div class="paging">
            <c:if test="${paging.prev}"><a href="adminMemberAttendanceList?page=${paging.beginPage-1}&type=${type}&key=${key}&sort=${sort}&dir=${dir}">Prev</a></c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <a href="adminMemberAttendanceList?page=${index}&type=${type}&key=${key}&sort=${sort}&dir=${dir}"<c:if test="${index == paging.page}"> style="color: red;"</c:if>>${index}</a>
            </c:forEach>

            <c:if test="${paging.next}"><a href="adminMemberAttendanceList?page=${paging.endPage+1}&type=${type}&key=${key}&sort=${sort}&dir=${dir}">Next</a></c:if>
        </div>
    </c:if>
</section>

<%@ include file="footer.jsp" %>