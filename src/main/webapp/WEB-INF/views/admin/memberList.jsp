<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<section id="adminMemberList">
    <h2>직원 목록</h2>

    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <select name="type">
                    <option value="userid"<c:if test="${type == 'userid'}"> selected</c:if>>아이디</option>
                    <option value="name"<c:if test="${type == 'name'}"> selected</c:if>>이름</option>
                    <option value="email"<c:if test="${type == 'email'}"> selected</c:if>>이메일</option>
                </select>
                <input type="text" name="key" value="${key}" />
                <button>검색</button>
            </div>
            <c:if test="${loginUser.level > 2}">
                <div class="boxBtns clearfix">
                    <button type="button" onclick="confirmJoin()">가입승인</button>
                    <button type="button" onclick="setMember('leave')">퇴사처리</button>
                    <button type="button" onclick="setMember('position')">직급설정</button>
                    <button type="button" onclick="setMember('level')">권한설정</button>
                </div>
            </c:if>
        </div>
    </form>

    <form method="post" name="adminMemberInfo" id="adminMemberInfo">

        <table>
            <thead>
                <tr>
                    <th><input type="checkbox" /></th>
                    <th>아이디</th>
                    <th>
                        <span data-sort="position">직급<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'position', 'joindate', 'desc')}"></i></span>
                    </th>
                    <th>
                        <span data-sort="name">이름<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'name', 'joindate', 'desc')}"></i></span>
                    </th>
                    <th>주민등록번호</th>
                    <th>이메일</th>
                    <th>휴대전화번호</th>
                    <th class="address">주소</th>
                    <th>
                        <span data-sort="joindate">입사일<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'joindate', 'joindate', 'desc')}"></i></span>
                    </th>
                    <th>
                        <span data-sort="leavedate">퇴사일<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'leavedate', 'joindate', 'desc')}"></i></span>
                    </th>
                    <c:if test="${loginUser.level > 2}">
                    <th>
                        <span data-sort="confirmyn">가입승인여부<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'confirmyn', 'joindate', 'desc')}"></i></span>
                    </th>
                    <th>정보수정</th>
                    </c:if>
                </tr>
            </thead>

            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <c:choose>
                                <c:when test="${loginUser.level > 2}">
                                    <td colspan="13">게시물이 존재하지 않습니다.</td>
                                </c:when>
                                <c:otherwise>
                                    <td colspan="11">게시물이 존재하지 않습니다.</td>
                                </c:otherwise>
                            </c:choose>

                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${list}" var="item">
                            <tr>
                                <td><input type="checkbox" name="midx" value="${item.midx}" /></td>
                                <td>${item.userid}</td>
                                <td>${item.position}</td>
                                <td>${item.name}</td>
                                <td>${item.number}</td>
                                <td>${item.email}</td>
                                <td>${item.phone}</td>
                                <td class="address">(${item.postcode}) ${item.address1} ${item.address2}</td>
                                <td><fmt:formatDate value="${item.joindate}" pattern="yyyy-MM-dd" /></td>
                                <td><fmt:formatDate value="${item.leavedate}" pattern="yyyy-MM-dd" /></td>
                                <c:if test="${loginUser.level > 2}">
                                <td>
                                    <c:choose>
                                        <c:when test="${item.confirmyn == 'Y'}">승인</c:when>
                                        <c:otherwise>대기</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="adminMemberUpdateForm?midx=${item.midx}" class="updateMemberBtn">정보수정</a>
                                </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>

        </table>
    </form>

    <c:if test="${not empty list}">
        <div class="paging">
            <c:if test="${paging.prev}"><a href="adminMemberList?page=${paging.beginPage-1}&type=${type}&key=${key}&sort=${sort}&dir=${dir}">Prev</a></c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <a href="adminMemberList?page=${index}&type=${type}&key=${key}&sort=${sort}&dir=${dir}"<c:if test="${index == paging.page}"> style="color: red;"</c:if>>${index}</a>
            </c:forEach>

            <c:if test="${paging.next}"><a href="adminMemberList?page=${paging.endPage+1}&type=${type}&key=${key}&sort=${sort}&dir=${dir}">Next</a></c:if>
        </div>
    </c:if>
</section>

<%@ include file="footer.jsp" %>