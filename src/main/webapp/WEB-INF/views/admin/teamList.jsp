<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.intranet.dto.TeamDto" %>

<section id="adminTeamList">
    <h2>팀 목록</h2>

    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <select name="type">
                    <option value="name"<c:if test="${type == 'name'}"> selected</c:if>>팀명</option>
                    <option value="mname"<c:if test="${type == 'mname'}"> selected</c:if>>구성원 이름</option>
                </select>
                <input type="text" name="key" value="${key}" />
                <button>검색</button>
            </div>
            <c:if test="${loginUser.level > 2}">
                <div class="boxBtns clearfix">
                    <button type="button" onclick="createTeamForm()">팀 생성</button>
                    <button type="button" onclick="location.href='setTeamMemberForm'">팀 편성</button>
                </div>
            </c:if>
        </div>
    </form>

    <form method="post" name="adminTeamInfo" id="adminTeamInfo">

        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>팀명</th>
                    <th>구성원 직급</th>
                    <th>구성원 이름</th>
                </tr>
            </thead>

            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="5">팀이 존재하지 않습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <%
                            List<TeamDto> list = (List<TeamDto>) request.getAttribute("list");
                            for (int i = 0; i < list.size(); i++) {
                                TeamDto tdto = list.get(i);
                        %>
                            <tr>
                                <%
                                    if (i == 0) {
                                        int rowspan = tdto.getRowspan();
                                %>
                                    <td rowspan="<%=rowspan %>"><%=tdto.getLoopnum() %></td>
                                    <td rowspan="<%=rowspan %>"><%=tdto.getName() %></td>
                                <%
                                    } else {
                                        TeamDto prevTdto = list.get(i-1);
                                        if (tdto.getTidx() == prevTdto.getTidx()) {
                                        } else {
                                            int rowspan = tdto.getRowspan();
                                %>
                                    <td rowspan="<%=rowspan %>"><%=tdto.getLoopnum() %></td>
                                    <td rowspan="<%=rowspan %>"><%=tdto.getName() %></td>
                                <%
                                        }
                                    }
                                %>
                                <td><%=tdto.getMposition() %></td>
                                <td><%=tdto.getMname() %></td>
                            </tr>
                        <%
                            }
                        %>
                    </c:otherwise>
                </c:choose>
            </tbody>

        </table>
    </form>

    <c:if test="${not empty list}">
        <div class="paging">
            <c:if test="${paging.prev}"><a href="adminTeamList?page=${paging.beginPage-1}">Prev</a></c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <a href="adminTeamList?page=${index}"<c:if test="${index == paging.page}"> style="color: red;"</c:if>>${index}</a>
            </c:forEach>

            <c:if test="${paging.next}"><a href="adminTeamList?page=${paging.endPage+1}">Next</a></c:if>
        </div>
    </c:if>
</section>

<%@ include file="footer.jsp" %>