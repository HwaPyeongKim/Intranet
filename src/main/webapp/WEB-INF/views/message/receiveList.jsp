<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
    #search {}
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
        flex:1; }

    #work .tb{
        padding: 20px;
    }

</style>

<section id="work">
    <h2>메세지</h2>

    <ul class="submenu">
        <li class="on"><a href="receiveList">받은메시지</a></li>
        <li><a href="sentList">보낸메시지</a></li>
    </ul>

<div class="form shadow">
    <div class="tb">
        <div class="tb_top" style="display: flex; align-items: center; justify-content: end; ">
            <div class="searchBox">
<%--                <input type="button" name="btn_search" value="업무요청" onclick="location.href='insertWorkForm'"/>&nbsp;--%>
                <button type="button" id="deleteSelected" style="margin-right:10px;" onclick="deleteSelected()">삭제</button>
                <button type="button" onclick="location.href='writemsg'">메시지 작성</button>
            </div>
        </div>
        <form method="get" name="search" id="searchForm" >
        <div class="searchBox" style="margin-bottom: 20px">
            <div class="input">
                &nbsp;&nbsp;<select name="type">
                    <option value="titleContent"<c:if test="${type == 'titleContent'}"> selected</c:if>>내용</option>
                    <option value="name"<c:if test="${type == 'name'}"> selected</c:if>>보낸사람</option>
                </select>
                <input type="text" name="key" value="${key}"/>
                <button>검색</button>
            </div>
            <select name="sort" id="sort" style="margin-right: 10px">
                <option value="desc" <c:if test="${sort == 'desc'}"> selected</c:if>>최신순</option>
                <option value="asc" <c:if test="${sort == 'asc'}"> selected</c:if>>작성순</option>
            </select>
        </div>
        </form>
        <form id="multiDeleteForm" action="deletemsgMulti" method="post" name="multiDeleteForm">
        <input type="hidden" name="activeTab" value="receive">

        <div class="row row_title">
            <div style="width: 50px; display: flex; justify-content: space-around">
                <!-- ✅ 전체 선택 체크박스 (맨 뒤) -->
                <input type="checkbox" id="checkAll">
            </div>
            <div class="coltitle">보낸 사람</div>
            <div class="coltitle">내용</div>
            <div class="coltitle">받은 시간</div>
        </div>

        <c:choose>
                    <c:when test="${empty message}">
                        <div class="row empty">
                            <div class="col">받은 메시지가 없습니다.</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${message}" var="msg" varStatus="status">
                            <div class="row">
                                <div style="width: 50px; display: flex; justify-content: space-around" >
                                    <input type="checkbox" name="msidxList" value="${msg.msidx}">
                                </div>
    <%--                            <div class="col">${status.count}</div>--%>
                            <c:choose>
                            <c:when test="${msg.readyn=='Y'}" >
                                <div class="col" style="color: grey">${msg.fromname}&nbsp;${msg.fromposition}</div>
                            </c:when>
                            <c:otherwise>
                                 <div class="col" style="background: rgba(103, 195, 225, 0.2); ">${msg.fromname}&nbsp;${msg.fromposition}</div>
                            </c:otherwise>
                            </c:choose>

                            <c:choose>
                            <c:when test="${msg.readyn=='Y'}" >
                                <div class="col" style="color: grey">
                                    <a href="receiveView?msidx=${msg.msidx}">
                                            ${msg.content}
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                 <div class="col" style="background: rgba(103, 195, 225, 0.2); ">
                                    <a href="receiveView?msidx=${msg.msidx}">
                                            ${msg.content}
                                    </a>
                                </div>
                            </c:otherwise>
                            </c:choose>

                            <c:choose>
                            <c:when test="${msg.readyn=='Y'}" >
                                 <div class="col" style="color: grey">
                                    <fmt:formatDate value="${msg.writedate}" pattern="yyyy-MM-dd HH:mm"/>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="col" style="background: rgba(103, 195, 225, 0.2); ">
                                    <fmt:formatDate value="${msg.writedate}" pattern="yyyy-MM-dd HH:mm"/>
                                </div>
                            </c:otherwise>
                            </c:choose>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>

                <c:if test="${not empty message}">
                <div class="paging" style="height: 50px; line-height: 50px">
                    <c:if test="${paging.prev}"><a href="receiveList?page=${paging.beginPage-1}">Prev</a></c:if>

                    <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                        <a href="receiveList?page=${index}"<c:if test="${index == paging.page}"> style="color: red;"</c:if>>${index}</a>
                    </c:forEach>

                    <c:if test="${paging.next}"><a href="receiveList?page=${paging.endPage+1}">Next</a></c:if>
                </div>
                </c:if>

        </form>
    </div>
</div>
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
