<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<ul class="submenu">
    <li><a href="receiveList">받은메시지</a></li>
    <li class="on"><a href="sentList">보낸메시지</a></li>
</ul>
<section>
    <div class="boxBtns clearfix">
        <!-- 삭제 버튼과 작성 버튼 간격 -->
        <button type="button" id="deleteSelected" style="margin-right:10px;" onclick="deleteSelected()">삭제</button>
         <button type="button" onclick="window.open('writeMessage', 'msgWrite', 'width=600,height=700');">메세지 작성</button>
    </div>
    <form method="get" name="search" id="searchForm">
        <div class="searchBox">
            <div class="input">
                <select name="type">
                    <option value="titleContent"<c:if test="${type == 'titleContent'}"> selected</c:if>>내용</option>
                    <option value="name"<c:if test="${type == 'name'}"> selected</c:if>>수신자</option>
                </select>
                <input type="text" name="key" value="${key}"/>
                <button>검색</button>
            </div>
<%--            <select name="sort" id="sort">--%>
<%--                <option value="desc" <c:if test="${sort == 'desc'}"> selected</c:if>>최신순</option>--%>
<%--                <option value="asc" <c:if test="${sort == 'asc'}"> selected</c:if>>작성순</option>--%>
<%--            </select>--%>
        </div>
    </form>

    <form id="multiDeleteForm" action="deletemsgMulti" method="post" name="multiDeleteForm">
        <input type="hidden" name="activeTab" value="sent">
        <div class="table">
            <div class="row head">
                <div style="width: 50px; display: flex; justify-content: space-around">
                    <input type="checkbox" id="checkAll">
                </div>
            <div class="col">
                <span data-sort="toname">수신자<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'toname', 'writedate', 'desc')}"></i></span>
            </div>

            <div class="col">
                <span data-sort="content">내용<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'content', 'writedate', 'desc')}"></i></span>
            </div>

            <div class="col">
                <span data-sort="writedate">보낸시간<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'writedate', 'writedate', 'desc')}"></i></span>
            </div>

            <div class="col">
                <span data-sort="readyn">수신확인<i class="fa-solid ${sort:getSortIcon(param.sort, param.dir, 'readyn', 'writedate', 'desc')}"></i></span>
            </div>
            </div>

            <c:choose>
                <c:when test="${empty message}">
                    <div class="row empty">
                        <div class="col">보낸 메시지가 없습니다.</div>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${message}" var="msg" varStatus="status">
                        <div class="row">
                            <div style="width: 50px; display: flex; justify-content: space-around" >
                                <input type="checkbox" name="msidxList" value="${msg.msidx}">
                            </div>
<%--                            <div class="col">${status.count}</div>--%>
                            <div class="col">${msg.toname}&nbsp;${msg.toposition}</div>
                            <div class="col">
                                <a href="sentView?msidx=${msg.msidx}">
                                        ${msg.content}
                                </a>
                            </div>
                            <div class="col">
                                <fmt:formatDate value="${msg.writedate}" pattern="yyyy-MM-dd HH:mm"/>
                            </div>
                            <div class="col">
                                <c:choose>
                                <c:when test="${msg.readyn=='Y'}" >
                                    <div class="col" style="color: grey">${msg.readyn}</div>
                                </c:when>
                                <c:otherwise>
                                     <div class="col">
                                     <span style="background-color: rgba(103, 195, 225, 0.2); padding: 2px 6px; border-radius: 4px; ">${msg.readyn}</span>
                                     </div>
                                </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </form>
    <c:if test="${not empty message}">
        <div class="paging" style="height: 50px; line-height: 50px">
            <c:if test="${paging.prev}"><a href="sentList?page=${paging.beginPage-1}">Prev</a></c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <a href="sentList?page=${index}"<c:if
                        test="${index == paging.page}"> style="color: red;"</c:if>>${index}</a>
            </c:forEach>

            <c:if test="${paging.next}"><a href="sentList?page=${paging.endPage+1}">Next</a></c:if>
        </div>
    </c:if>
</section>

<script>
    // 전체선택 체크박스
    document.getElementById("checkAll").addEventListener("change", function () {
        document.querySelectorAll("input[name='msidxList']")
            .forEach(cb => cb.checked = this.checked);
    });

    // 폼 제출 전에 확인 및 선택 여부 검사
    // document.getElementById("multiDeleteForm").addEventListener("submit", function (e) {
    //     console.log("테스트");
    //     const anyChecked = Array.from(document.querySelectorAll("input[name='msidxList']")).some(cb => cb.checked);
    //     if (!anyChecked) {
    //         alert("삭제할 메시지를 선택하세요.");
    //         e.preventDefault();
    //         return;
    //     }
    //     if (!confirm("선택한 메시지를 삭제하시겠습니까?")) {
    //         e.preventDefault();
    //     }
    // });

    function deleteSelected() {
        const anyChecked = Array.from(document.querySelectorAll("input[name='msidxList']")).some(cb => cb.checked);
        if (!anyChecked) {
            alert("삭제할 메시지를 선택하세요.");
            return;
        }
        if (!confirm("선택한 메시지를 삭제하시겠습니까?")) {
            return;
        }
        document.multiDeleteForm.submit()
    }

</script>

<%@ include file="../footer.jsp" %>
