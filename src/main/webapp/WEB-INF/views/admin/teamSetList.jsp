<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<section id="adminTeamList">
    <h2>팀 편성</h2>

    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <select name="type">
                    <option value="userid"<c:if test="${type == 'userid'}"> selected</c:if>>아이디</option>
                    <option value="name"<c:if test="${type == 'name'}"> selected</c:if>>이름</option>
                </select>
                <input type="text" name="key" value="${key}" />
                <button>검색</button>
            </div>
        </div>
    </form>

    <div class="separator">
        <form method="post" name="adminNoTeam" id="adminNoTeam" class="shadow">
            <div class="boxBtns">
                <h3>팀이 없는 직원</h3>
            </div>
            <table>
                <thead>
                    <tr>
                        <th><input type="checkbox" id="chkNoTeamAll" /></th>
                        <th>아이디</th>
                        <th>직급</th>
                        <th>이름</th>
                    </tr>
                </thead>
                <tbody id="noTeamTableBody">
                    <c:choose>
                        <c:when test="${empty memberList}">
                            <tr>
                                <td colspan="4">팀이 없는 직원이 존재하지 않습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${memberList}" var="item">
                                <tr>
                                    <td><input type="checkbox" name="midx" value="${item.midx}" /></td>
                                    <td>${item.userid}</td>
                                    <td>${item.position}</td>
                                    <td>${item.name}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </form>

        <ul class="arrow">
            <li>
                <button type="button" onclick="addTeamMember()"><i class="fa-solid fa-arrow-right"></i></button>
            </li>
            <li>
                <button type="button" onclick="deleteTeamMember()"><i class="fa-solid fa-arrow-left"></i></button>
            </li>
        </ul>

        <form method="post" name="adminYesTeam" id="adminYesTeam" class="shadow">
            <div class="boxBtns">
                <h3 id="teamName">팀명</h3>
                <select name="tidx" id="selectTeam">
                    <option value="0">팀을 선택해주세요.</option>
                    <c:if test="${not empty teamList}">
                        <c:forEach items="${teamList}" var="item">
                            <option value="${item.tidx}">${item.name}</option>
                        </c:forEach>
                    </c:if>
                </select>
            </div>
            <table>
                <thead>
                    <tr>
                        <th><input type="checkbox" id="chkTeamAll" /></th>
                        <th>아이디</th>
                        <th>직급</th>
                        <th>이름</th>
                    </tr>
                </thead>
                <tbody id="teamTableBody">
                    <td colspan="4">팀을 선택해주세요.</td>
                </tbody>
            </table>
        </form>
    </div>

</section>

<%@ include file="footer.jsp" %>