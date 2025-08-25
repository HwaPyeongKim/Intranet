<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<section id="adminMemberList">
    <h2>회원 목록</h2>

    <form method="post" name="adminMemberInfo" id="adminMemberInfo">
        <div class="boxBtns clearfix">
            <button type="button" onclick="confirmJoin()">가입승인</button>
        </div>

        <table>
            <thead>
                <tr>
                    <th></th>
                    <th>번호</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>직급</th>
                    <th>주민등록번호</th>
                    <th>이메일</th>
                    <th>휴대전화번호</th>
                    <th>주소</th>
                    <th>입사일</th>
                    <th>퇴사일</th>
                    <c:if test="${loginUser.level > 2}">
                    <th>가입승인여부</th>
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
                                <td>${item.loopnum}</td>
                                <td>${item.userid}</td>
                                <td>${item.name}</td>
                                <td>${item.position}</td>
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
            <c:if test="${paging.prev}"><a href="board?page=${paging.beginPage-1}">Prev</a></c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <a href="board?page=${index}"<c:if test="${index == paging.page}"> style="color: red;"</c:if>>${index}</a>
            </c:forEach>

            <c:if test="${paging.next}"><a href="board?page=${paging.endPage+1}">Next</a></c:if>
        </div>
    </c:if>
</section>

<%@ include file="footer.jsp" %>