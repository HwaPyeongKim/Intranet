<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<section id="adminTeamList">
    <h2>팀 편성</h2>

    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <select name="type">
                    <option value="muserid"<c:if test="${type == 'muserid'}"> selected</c:if>>아이디</option>
                    <option value="mname"<c:if test="${type == 'mname'}"> selected</c:if>>이름</option>
                </select>
                <input type="text" name="key" value="${key}" />
                <button>검색</button>
            </div>
        </div>
    </form>

    <div class="separator">
        <form method="post" name="adminNoTeam" id="adminNoTeam" class="shadow">
            <h3>팀이 없는 직원</h3>
            <table>
                <thead>
                    <tr>
                        <th>아이디</th>
                        <th>직급</th>
                        <th>이름</th>
                    </tr>
                </thead>
                <tbody ondragover="allowDrop()" ondrop="drop()">
                    <c:choose>
                        <c:when test="${empty memberList}">
                            <tr>
                                <td colspan="3">팀이 없는 직원이 존재하지 않습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${memberList}" var="item">
                                <tr id="member-${item.midx}" draggable="true" ondragstart="drag()">
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
                        <th>아이디</th>
                        <th>직급</th>
                        <th>이름</th>
                    </tr>
                </thead>
                <tbody id="teamTableBody" ondragover="allowDrop()" ondrop="drop()">
                    <td colspan="3">팀을 선택해주세요.</td>
                </tbody>
            </table>
        </form>
    </div>

</section>

<%@ include file="footer.jsp" %>