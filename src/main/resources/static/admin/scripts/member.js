function confirmJoin() {
    var count = 0;
    var midxes = document.adminMemberInfo.midx;
    if (midxes.length == undefined) {
        if (midxes.checked == true) {
            count++;
        }
    } else if (midxes.length > 1) {
        for (i=0; i<midxes.length; i++) {
            if (midxes[i].checked == true) {
                count++;
            }
        }
    }
    if (count == 0) {
        alert("가입 승인할 직원을 선택해주세요.");
        return;
    } else {
        document.adminMemberInfo.action = 'confirmJoin';
        document.adminMemberInfo.submit();
    }
}

function checkLeave() {
    var c_midx = "";
    var midxes = document.adminMemberInfo.midx;
    if (midxes.length == undefined) {
        if (midxes.checked == true) {
            c_midx = midx.value;
        }
    } else if (midxes.length > 1) {
        for (i=0; i<midxes.length; i++) {
            if (midxes[i].checked == true) {
                c_midx += c_midx === "" ? midxes[i].value : "," + midxes[i].value;
            }
        }
    }
    if (c_midx == "") {
        alert("퇴사 처리할 직원을 선택해주세요.");
        return;
    } else {
        var url = "updateLeaveForm?midxes=" + c_midx;
        var option = "width=500, height=400, left=100, top=100, menubar=no, location=no, status=no, resizable=no, scrollbars=yes";
        window.open(url,"updateLeaveForm",option);
    }
}

function updateLeave() {
    if (confirm("정말로 퇴사처리 하시겠습니까?")) {
        var leavedate = document.updateLeaveForm.leavedate;
        var datas = [];
        if (leavedate.length == undefined) {
            if (!leavedate.value) {
                alert("퇴사일을 선택해주세요.");
                return;
            }
            var data = [leavedate.attributes.midx.value, leavedate.value];
            datas.push(data);
        } else if (leavedate.length > 1) {
            for (i=0; i<leavedate.length; i++) {
                if (!leavedate[i].value) {
                    alert("퇴사일을 선택해주세요.");
                    return;
                }
                var data = [leavedate[i].attributes.midx.value, leavedate[i].value];
                datas.push(data);
            }
        }

        if (datas.length > 0) {
            $.ajax({
                url: "updateLeave",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(datas),
                success: function(response) {
                    alert("퇴사처리되었습니다.");
                    if (window.opener && !window.opener.closed) {
                        window.opener.location.reload();
                    }
                    window.close();
                },
                error: function() {
                    alert("오류가 발생했습니다. 관리자에게 문의해주세요.");
                }
            })
        }
    } else {
        return;
    }
}

function setPosition() {
    var c_midx = "";
    var midxes = document.adminMemberInfo.midx;
    if (midxes.length == undefined) {
        if (midxes.checked == true) {
            c_midx = midxes.value;
        }
    } else if (midxes.length > 1) {
        for (i=0; i<midxes.length; i++) {
            if (midxes[i].checked == true) {
                c_midx += c_midx === "" ? midxes[i].value : "," + midxes[i].value;
            }
        }
    }
    if (c_midx == "") {
        alert("직급을 설정할 직원을 선택해주세요.");
        return;
    } else {
        var url = "updatePositionForm?midxes=" + c_midx;
        var option = "width=500, height=400, left=100, top=100, menubar=no, location=no, status=no, resizable=no, scrollbars=yes";
        window.open(url,"updatePositionForm",option);
    }
}

function updatePosition() {
    var position = document.updatePositionForm.position;
    var datas = [];
    if (position.length == undefined) {
        if (!position.value) {
            alert("직급을 입력해주세요.");
            return;
        }
        var data = [position.attributes.midx.value, position.value];
        datas.push(data);
    } else if (position.length > 1) {
        for (i=0; i<position.length; i++) {
            if (!position[i].value) {
                alert("직급을 입력해주세요.");
                return;
            }
            var data = [position[i].attributes.midx.value, position[i].value];
            datas.push(data);
        }
    }

    if (datas.length > 0) {
        $.ajax({
            url: "updatePosition",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(datas),
            success: function(response) {
                alert("직급을 설정했습니다.");
                if (window.opener && !window.opener.closed) {
                    window.opener.location.reload();
                }
                window.close();
            },
            error: function() {
                alert("오류가 발생했습니다. 관리자에게 문의해주세요.");
            }
        })
    }
}

function createTeamForm() {
    var url = "createTeamForm";
    var option = "width=500, height=300, left=100, top=100, menubar=no, location=no, status=no, resizable=no, scrollbars=yes";
    window.open(url,"createTeamForm",option);
}

function createTeam() {
    var name = document.createTeamForm.name.value;
    $.ajax({
        url: "createTeam",
        type: "POST",
        data: {name: name},
        success: function(response) {
            if (response.result == 1) {
                alert(name + " 팀이 생성되었습니다.");
                if (window.opener && !window.opener.closed) {
                    window.opener.location.reload();
                }
                window.close();
            } else {
                document.getElementById("notice_p").innerText = response.msg;
            }
        },
        error: function() {
            alert("오류가 발생했습니다. 관리자에게 문의해주세요.");
        }
    })
}

function addTeamMember() {
    var datas = [];
    var midxes = document.adminNoTeam.midx;
    var tidx = $("#selectTeam").val();

    if (tidx == 0) {
        alert("이동할 팀을 선택해주세요.");
        return;
    }

    if (midxes.length == undefined) {
        if (midxes.checked == true) {
            var data = [midxes.value, tidx];
            datas.push(data);
        }
    } else if (midxes.length > 1) {
        for (i=0; i<midxes.length; i++) {
            if (midxes[i].checked == true) {
                var data = [midxes[i].value, tidx];
                datas.push(data);
            }
        }
    }

    if (datas.length == 0) {
        alert("이동할 직원을 선택해주세요.");
        return;
    } else {
        $.ajax({
            url: "addTeamMember",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(datas),
            success: function(response) {
                $("#teamTableBody").empty();
                var c_html = "";
                if (response.teamMemberList.length > 0) {
                    for (i=0; i<response.teamMemberList.length; i++) {
                        c_html += "<tr>";
                        c_html += "<td><input type='checkbox' name='midx' value='"+response.teamMemberList[i].midx+"'></td>";
                        c_html += "<td>"+response.teamMemberList[i].muserid+"</td>";
                        c_html += "<td>"+response.teamMemberList[i].mposition+"</td>";
                        c_html += "<td>"+response.teamMemberList[i].mname+"</td>";
                        c_html += "</tr>";
                    }
                } else {
                    c_html = "<tr><td colspan='4'>구성원이 존재하지 않습니다.</td></tr>";
                }
                $("#teamTableBody").append(c_html);

                $("#noTeamTableBody").empty();
                c_html = "";
                if (response.noTeamList.length > 0) {
                    for (i=0; i<response.noTeamList.length; i++) {
                        c_html += "<tr>";
                        c_html += "<td><input type='checkbox' name='midx' value='"+response.noTeamList[i].midx+"'></td>";
                        c_html += "<td>"+response.noTeamList[i].userid+"</td>";
                        c_html += "<td>"+response.noTeamList[i].position+"</td>";
                        c_html += "<td>"+response.noTeamList[i].name+"</td>";
                        c_html += "</tr>";
                    }
                } else {
                    c_html = "<tr><td colspan='4'>팀이 없는 직원이 존재하지 않습니다.</td></tr>";
                }
                $("#noTeamTableBody").append(c_html);
            },
            error: function() {
                alert("오류가 발생했습니다. 관리자에게 문의해주세요.");
            }
        })
    }
}

function deleteTeamMember() {
    var datas = [];
    var midxes = document.adminYesTeam.midx;
    var tidx = $("#selectTeam").val();

    if (midxes.length == undefined) {
        if (midxes.checked == true) {
            var data = [midxes.value, tidx];
            datas.push(data);
        }
    } else if (midxes.length > 1) {
        for (i=0; i<midxes.length; i++) {
            if (midxes[i].checked == true) {
                var data = [midxes[i].value, tidx];
                datas.push(data);
            }
        }
    }

    if (datas.length == 0) {
        alert("이동할 직원을 선택해주세요.");
        return;
    } else {
        $.ajax({
            url: "deleteTeamMember",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(datas),
            success: function(response) {
                $("#teamTableBody").empty();
                var c_html = "";
                if (response.teamMemberList.length > 0) {
                    for (i=0; i<response.teamMemberList.length; i++) {
                        c_html += "<tr>";
                        c_html += "<td><input type='checkbox' name='midx' value='"+response.teamMemberList[i].midx+"'></td>";
                        c_html += "<td>"+response.teamMemberList[i].muserid+"</td>";
                        c_html += "<td>"+response.teamMemberList[i].mposition+"</td>";
                        c_html += "<td>"+response.teamMemberList[i].mname+"</td>";
                        c_html += "</tr>";
                    }
                } else {
                    c_html = "<tr><td colspan='4'>구성원이 존재하지 않습니다.</td></tr>";
                }
                $("#teamTableBody").append(c_html);

                $("#noTeamTableBody").empty();
                c_html = "";
                if (response.noTeamList.length > 0) {
                    for (i=0; i<response.noTeamList.length; i++) {
                        c_html += "<tr>";
                        c_html += "<td><input type='checkbox' name='midx' value='"+response.noTeamList[i].midx+"'></td>";
                        c_html += "<td>"+response.noTeamList[i].userid+"</td>";
                        c_html += "<td>"+response.noTeamList[i].position+"</td>";
                        c_html += "<td>"+response.noTeamList[i].name+"</td>";
                        c_html += "</tr>";
                    }
                } else {
                    c_html = "<tr><td colspan='4'>팀이 없는 직원이 존재하지 않습니다.</td></tr>";
                }
                $("#noTeamTableBody").append(c_html);
            },
            error: function() {
                alert("오류가 발생했습니다. 관리자에게 문의해주세요.");
            }
        })
    }
}

$(function (){
    $("#adminYesTeam #selectTeam").change(function(){
        var tidx = $(this).val();
        $.ajax({
            url: "selectTeam",
            type: "POST",
            data: {tidx: tidx},
            success: function(response) {
                $("#teamName").text(response.teamName);
                if (response.result == 1) {
                    $("#teamTableBody").empty();
                    var c_html = "";
                    for (i=0; i<response.list.length; i++) {
                        c_html += "<tr>";
                        c_html += "<td><input type='checkbox' name='midx' value='"+response.list[i].midx+"'></td>";
                        c_html += "<td>"+response.list[i].muserid+"</td>";
                        c_html += "<td>"+response.list[i].mposition+"</td>";
                        c_html += "<td>"+response.list[i].mname+"</td>";
                        c_html += "</tr>";
                    }
                    $("#teamTableBody").append(c_html);

                } else {
                    $("#teamTableBody").empty();
                    c_html = "<tr><td colspan='4'>구성원이 존재하지 않습니다.</td></tr>";
                    $("#teamTableBody").append(c_html);
                }
            },
            error: function() {
                alert("오류가 발생했습니다. 관리자에게 문의해주세요.");
            }
        })
    });

    $("#chkNoTeamAll").on("change", function() {
        $("#noTeamTableBody input[name=midx]").prop("checked", $(this).prop("checked"));
    });

    $("#noTeamTableBody input[name=midx]").on("change", function() {
        var allChecked = $("#noTeamTableBody input[name=midx]").length === $("#noTeamTableBody input[name=midx]:checked").length;
        $("#chkNoTeamAll").prop("checked", allChecked);
    });

    $("#chkTeamAll").on("change", function() {
        $("#teamTableBody input[name=midx]").prop("checked", $(this).prop("checked"));
    });

    $(document).on("change", "#teamTableBody input[name=midx]", function() {
        var allChecked = $("#teamTableBody input[name=midx]").length === $("#teamTableBody input[name=midx]:checked").length;
        $("#chkTeamAll").prop("checked", allChecked);
    });
})