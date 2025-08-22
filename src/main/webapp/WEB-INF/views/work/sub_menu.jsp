<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section id="work">

    <h2>업무관리</h2>

    <ul class="submenu">
        <li><a href="work?first=y">요청받은 업무</a></li>
        <li><a href="yourwork?first=y">요청한 업무</a></li>
    </ul>

    <script>
        if(window.location.pathname=='/work'){
            document.getElementsByClassName("submenu")[0].firstElementChild.classList.add('on');
            sessionStorage.setItem('workon','left')
        }else if(window.location.pathname=='/workView'){
            if(sessionStorage.getItem('workon')=='left'){
                document.getElementsByClassName("submenu")[0].firstElementChild.classList.add('on');
            }else{
                document.getElementsByClassName("submenu")[0].lastElementChild.classList.add('on');
            }
        }else{
            document.getElementsByClassName("submenu")[0].lastElementChild.classList.add('on');
            sessionStorage.setItem('workon','right')
        }

    </script>