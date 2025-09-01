
let currentRidx = null;
let currentStatus = null;

function openConfirmModal(ridx, status) {
    currentRidx = ridx;
    currentStatus = status;

    let message = "";
    if (status === 3) {
        message = "반려하시겠습니까?";
    } else if (status === 4) {
        message = "승인하시겠습니까?";
    }

    document.getElementById("modalMessage").innerText = message;
    document.getElementById("confirmModal").style.display = "block";

    // 확인 버튼 클릭 이벤트 세팅 (한번만)
    const confirmBtn = document.getElementById("confirmBtn");
    confirmBtn.onclick = function () {
        location.href = `/changeStatus?ridx=${currentRidx}&status=${currentStatus}`; //여기 주소만 바꿔서 사용하면됨.
    };
}


function openDeleteModal(ridx) {
    currentRidx = ridx;
    console.log(ridx);
    let message = "정말 삭제하시겠습니까?";

    document.getElementById("modalMessage").innerText = message;
    document.getElementById("confirmModal").style.display = "block";

    // 확인 버튼 클릭 이벤트 세팅 (한번만)
    const confirmBtn = document.getElementById("confirmBtn");
    confirmBtn.onclick = function () {
        location.href = `/deleteRequests?ridx=${currentRidx}`;
    };
}

function closeConfirmModal() {
    document.getElementById("confirmModal").style.display = "none";
}

$(document).ready(function() {
    $(".table_default .row_title span[data-sort]").click(function () {
        var searchBox = $(".searchBox");
        var type = searchBox.find("select[name=type]").val();
        var key = searchBox.find("input[name=key]").val();
        var sort = $(this).attr("data-sort");
        var dir = "desc";
        var status = $(this).find("i").hasClass("fa-arrow-down");
        $("table .row_title span[data-sort] i").removeClass("fa-arrow-down fa-arrow-up");
        if (status) {
            dir = "asc";
            $(this).find("i").addClass("fa-arrow-up");
        } else {
            dir = "desc";
            $(this).find("i").addClass("fa-arrow-down");
        }

        url = new URL(window.location.href);
        url.searchParams.set("type", type);
        url.searchParams.set("key", key);
        url.searchParams.set("sort", sort);
        url.searchParams.set("dir", dir);
        location.href = url;
    });
});