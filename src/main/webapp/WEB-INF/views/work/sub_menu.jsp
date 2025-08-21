<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">


<nav id="sub_menu" style="display: flex; ">
    <div style="width:180px; text-align:center; padding: 25px; border: 1px solid #32a2c6; border-radius: 10px; background: #50bde2; color: #fff; font-size: 1.2em; font-weight: bold; cursor: pointer;"><a href="work?first=y">요청받은 업무</a></div>
    <div style="width:180px; text-align:center; padding: 25px; border: 1px solid #32a2c6; border-radius: 10px; background: #50bde2; color: #fff; font-size: 1.2em; font-weight: bold; cursor: pointer;"><a href="yourwork?first=y">요청한 업무</a></div>
    ${pageContext.request.requestURL}
</nav>

