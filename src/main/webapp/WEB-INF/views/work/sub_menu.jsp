<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section id="work">

    <h2>업무관리</h2>

    <ul class="submenu">
        <li><a href="work?first=y">요청받은 업무</a></li>
        <li><a href="yourwork?first=y">요청한 업무</a></li>
    </ul>

    <script>
        // 서브메뉴 어느곳에 불들어올지 설정
        if (window.location.pathname == '/work') {  // /work 로 들어왔을때

            document.getElementsByClassName("submenu")[0].firstElementChild.classList.add('on');
            // 왼쪽에 불들어오게 하고
            sessionStorage.setItem('workon', 'left')
            // 세션에 값 left
        } else if (window.location.pathname == '/workView') { // /workView 로 들어왔을때
            if (sessionStorage.getItem('workon') == 'right') { // 세션을 get 했을때 right인 경우
                document.getElementsByClassName("submenu")[0].lastElementChild.classList.add('on');
                // 오른쪽에 불들어오게
            } else {  // 세션을 get했을때 left거나 최초접속인 경우
                document.getElementsByClassName("submenu")[0].firstElementChild.classList.add('on');
                // 왼쪽에 불들어오게
            }
        } else if (window.location.pathname == '/workList') { // mypage/workList 로 들어왔을때
            sessionStorage.setItem('workon', 'left')
        } else {  // /work도 아니고 /workView도 아닌경우 (주로 yourwork에서 접속한 경우)
            document.getElementsByClassName("submenu")[0].lastElementChild.classList.add('on');
            // 오른쪽에 불들어오게
            sessionStorage.setItem('workon', 'right')
            // 세션에 값 right
        }
    </script>
