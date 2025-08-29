<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>

<style>
    .form-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 40px 50px;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }

    .form-title {
        text-align: center;
        font-size: 28px;
        font-weight: bold;
        margin-bottom: 30px;
    }

    .form-box {
        background: #fff;
        border: 1px solid #ddd;
        padding: 24px;
        margin-bottom: 25px;
        border-radius: 5px;
    }

    .form-row {
        display: flex;
        align-items: center;
        margin-bottom: 18px;
    }

    .form-row label {
        flex: 0 0 120px;
        font-weight: 600;
    }

    .form-row input[type="text"],
    .form-row select {
        flex: 1;
        padding: 8px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
    }

    .textbox1 {
        width: 500px;
        min-height: 100px;
        padding: 20px;
        margin-top: 20px;
        font-size: 16px;
        background: rgba(103, 195, 225, 0.2);
        border-radius: 10px;
        resize: vertical;
    }

    .textbox2 {
        width: 500px;
        min-height: 150px;
        padding: 20px;
        margin-top: 20px;
        font-size: 16px;
        border-radius: 10px;
        resize: vertical;
    }

    .form-message {
        color: #e74c3c;
        font-weight: bold;
        text-align: center;
        margin-bottom: 20px;
    }

    .form-buttons {
        text-align: center;
    }

    .form-buttons button {
        padding: 10px 20px;
        margin: 0 10px;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        background-color: #3498db;
        color: #fff;
        transition: background-color 0.3s;
    }

    .form-row button {
        padding: 10px 20px;
        margin: 0 10px;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        background-color: #3498db;
        color: #fff;
        transition: background-color 0.3s;
    }

    .form-buttons button:hover {
        background-color: #2980b9;
    }

    .delete-btn {
        margin-left: 10px;
        background-color: #b7b7b7;
        font-size: 16px;
        padding: 6px 10px;
        border: none;
    }
</style>

<section class="form-container">
    <form action="writemsg" method="post">
    <input type="hidden" name="frommidx" value="${loginUser.midx}" />
        <c:choose>
            <c:when test="${activeTab eq 'receive'}">
                <h2 class="form-title">받은 메세지</h2>
            </c:when>
            <c:otherwise>
                <h2 class="form-title">보낸 메세지</h2>
            </c:otherwise>
        </c:choose>


        <div class="form-box">
            <div class="form-row">
                <label>발신자</label>
                <div>${message.fromname}&nbsp;${message.fromposition}</div>
                <input type="hidden" name="tomidx" id="tomidx" value="${message.frommidx}">
            </div>
            <div class="form-row">
                <label>수신자</label>
                <div>${message.toname}&nbsp;${message.toposition}</div>
            </div>
            <div class="form-row">
                <label>보낸 시간</label>
                <div>${message.writedate}</div>
            </div>
            <c:choose>
            <c:when test="${activeTab eq 'receive'}">
                <div class="form-row">
                <div class="textbox1">${message.content}</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="form-row" style="display: flex; justify-content: end">
                <div class="textbox1">${message.content}</div>
                </div>
            </c:otherwise>
            </c:choose>
            <c:if test="${activeTab eq 'receive'}">
                <div class="form-row" style="justify-content: end">
                    <textarea id="content" class="textbox2" name="content" placeholder="내용을 입력하세요" required></textarea>
                </div>
            </c:if>
            <c:if test="${activeTab eq 'receive'}">
                <div class="form-row" style="justify-content: end">
                    <button type="submit" onclick="">보내기</button>
                </div>
            </c:if>
        </div>

    </form>

        <div class="form-buttons" style="display: flex; justify-content: end">
            <c:choose>
            <c:when test="${activeTab eq 'receive'}">
                <button type="button" onclick="location.href='receiveList'">받은 메시지 목록</button>
            </c:when>
            <c:otherwise>
                <button type="button" onclick="location.href='sentList'">보낸 메시지 목록</button>
            </c:otherwise>
            </c:choose>
            <form method="post" action="deletemsg" onsubmit="return confirm('메세지를 삭제하시겠습니까?');">
                 <input type="hidden" name="msidx" value="${message.msidx}">
                 <input type="hidden" name="activeTab" value="${activeTab}">
                 <button type="submit">삭제</button>
            </form>
        </div>
</section>
<%@ include file="../footer.jsp" %>