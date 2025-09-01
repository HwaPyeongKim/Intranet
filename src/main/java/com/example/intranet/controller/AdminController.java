package com.example.intranet.controller;

import com.example.intranet.dto.*;
import com.example.intranet.service.AdminService;
import com.example.intranet.service.BoardService;
import com.example.intranet.service.FileService;
import com.example.intranet.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class AdminController {

    @Autowired
    AdminService as;

    @Autowired
    MemberService ms;

    @Autowired
    BoardService bs;

    @Autowired
    FileService fs;

    @GetMapping("/adminLoginForm")
    public String adminLogin(HttpSession session, Model model){
        String url = "admin/login";
        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        if (mdto != null) {
            if (mdto.getLevel() > 1) {
                url = "redirect:/adminMemberList";
            }
        }
        return url;
    }

    @PostMapping("/adminLogin")
    public String adminLogin(@RequestParam("userid") String userid, @RequestParam("pwd") String pwd, HttpSession session, Model model){
        String url = "admin/login";

        if (userid.equals("")) {
            model.addAttribute("msg", "아이디를 입력해주세요.");
        } else if (pwd.equals("")) {
            model.addAttribute("msg", "비밀번호를 입력해주세요.");
        } else {
            MemberDto mdto = ms.getMember(userid);
            if (mdto == null) {
                model.addAttribute("msg", "아이디와 패스워드를 확인해주세요.");
            } else if (!mdto.getPwd().equals(pwd)) {
                model.addAttribute("msg", "아이디와 패스워드를 확인해주세요.");
            } else if (mdto.getLevel() == 1) {
                model.addAttribute("msg", "관리자 접근권한이 없는 아이디입니다.");
            } else {
                session.setAttribute("loginUser", mdto);
                session.setAttribute("profileImg", fs.getFile(mdto.getImage()).getPath());
                String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                MemberAttendanceDto madto = ms.selectAttendance(mdto.getMidx(),date);
                if (madto == null) {
                    ms.insertAttendance(mdto.getMidx());
                }
                url = "redirect:/adminMemberList";
            }
        }

        return url;
    }

    @GetMapping("/admin")
    public String admin(HttpSession session, Model model){
        String url = "admin/login";
        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        if (mdto != null) {
            if (mdto.getLevel() > 1) {
                url = "admin/adminMain";
            }
        }
        return url;
    }

    @GetMapping("/adminMemberList")
    public String memberList(HttpServletRequest request, HttpSession session, Model model){
        String url = "admin/login";
        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        if (mdto != null) {
            if (mdto.getLevel() > 1) {
                result = ms.selectMembers(request, mdto.getMidx(), mdto.getLevel());
                model.addAttribute("list", result.get("list"));
                model.addAttribute("paging", result.get("paging"));
                model.addAttribute("type", result.get("type"));
                model.addAttribute("key", result.get("key"));
                model.addAttribute("sort", result.get("sort"));
                url = "admin/memberList";
            }
        }
        return url;
    }

    @PostMapping("/confirmJoin")
    public String confirmJoin(@RequestParam("midx") String [] midxes, HttpSession session, Model model){
        as.confirmJoin(midxes);
        return "redirect:/adminMemberList";
    }

    @GetMapping("/adminMemberUpdateForm")
    public String adminMemberUpdateForm(@RequestParam("midx") int midx, HttpSession session, Model model){
        MemberDto mdto = ms.selectMember(midx);
        String[] phone = mdto.getPhone().split("-");
        String filePath = fs.getFile(mdto.getImage()).getPath();
        model.addAttribute("dto", mdto);
        model.addAttribute("phone", phone);
        model.addAttribute("filePath", filePath);
        return "admin/memberUpdate";
    }

    @PostMapping("/adminMemberUpdate")
    public String adminMemberUpdate(@ModelAttribute("dto") MemberDto memberdto, @RequestParam(value="number1",required=false,defaultValue="") String number1, @RequestParam(value="number2",required=false,defaultValue="") String number2, @RequestParam(value="phone1",required=false,defaultValue="") String phone1, @RequestParam(value="phone2",required=false,defaultValue="") String phone2, @RequestParam(value="phone3",required=false,defaultValue="") String phone3, BindingResult result, HttpSession session, Model model){
        String url = "admin/memberUpdate";

        if (memberdto.getName().equals("")) {
            model.addAttribute("msg", "이름을 입력해주세요.");
        } else if (memberdto.getEmail().equals("")) {
            model.addAttribute("msg", "이메일을 입력해주세요.");
        } else if (phone1.equals("")) {
            model.addAttribute("msg", "휴대전화번호를 입력해주세요.");
        } else if (phone2.equals("")) {
            model.addAttribute("msg", "휴대전화번호를 입력해주세요.");
        } else if (phone3.equals("")) {
            model.addAttribute("msg", "휴대전화번호를 입력해주세요.");
        } else if (memberdto.getPostcode().equals("")) {
            model.addAttribute("msg", "우편번호를 입력해주세요.");
        } else if (memberdto.getAddress1().equals("")) {
            model.addAttribute("msg", "주소를 입력해주세요.");
        } else if (memberdto.getImage() == 0) {
            model.addAttribute("msg", "프로필 이미지를 입력해주세요.");
        } else {
            memberdto.setNumber(number1+"-"+number2);
            memberdto.setPhone(phone1+"-"+phone2+"-"+phone3);
            as.updateMember(memberdto);
            model.addAttribute("msg", "회원정보수정이 완료되었습니다.");

            url = "redirect:/adminMemberList";
        }
        return url;
    }

    @GetMapping("/adminMemberAttendanceList")
    public String adminMemberAttendanceList(HttpServletRequest request, HttpSession session, Model model){
        String url = "admin/login";
        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        if (mdto != null) {
            if (mdto.getLevel() > 1) {
                String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                String startdate = request.getParameter("startdate");
                if (request.getParameter("startdate") == null) {
                    startdate = date;
                }
                String enddate = request.getParameter("enddate");
                if (request.getParameter("enddate") == null) {
                    enddate = date;
                }

                result = ms.selectMemberAttendances(request, mdto.getMidx(), mdto.getLevel());
                model.addAttribute("list", result.get("list"));
                model.addAttribute("paging", result.get("paging"));
                model.addAttribute("type", result.get("type"));
                model.addAttribute("key", result.get("key"));
                model.addAttribute("startdate", startdate);
                model.addAttribute("enddate", enddate);

                url = "admin/memberAttendanceList";
            }
        }
        return url;
    }

    @GetMapping("/adminBoardList")
    public String adminBoardList(HttpServletRequest request, HttpSession session, Model model) {
        String url = "admin/login";
        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        if (mdto != null) {
            result = bs.select(request, "main");
            model.addAttribute("notice", result.get("notice"));
            model.addAttribute("list", result.get("list"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("type", result.get("type"));
            model.addAttribute("key", result.get("key"));
            model.addAttribute("sort", result.get("sort"));
            LocalDate today = LocalDate.now();
            model.addAttribute("today", today);
            url = "admin/boardList";
        }
        return url;
    }

    @GetMapping("/adminDownloadList")
    public String adminDownloadList(HttpServletRequest request, HttpSession session, Model model) {
        String url = "admin/login";
        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        if (mdto != null) {
            result = bs.select(request,"download");
            model.addAttribute("list", result.get("list"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("type", result.get("type"));
            model.addAttribute("key", result.get("key"));
            model.addAttribute("sort", result.get("sort"));
            LocalDate today = LocalDate.now();
            model.addAttribute("today", today);
            url = "admin/boardDownloadList";
        }
        return url;
    }

    @GetMapping("/updateForm")
    public String updateForm(@RequestParam("midxes") String midxes, @RequestParam("type") String type, HttpSession session, Model model) {
        String url = "admin/login";
        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        if (type.equals("Attendance")) {
            ArrayList<MemberAttendanceDto> list = as.getMemberAttendances(midxes); // midxes = maidx
            model.addAttribute("list", list);
        } else {
            ArrayList<MemberDto> list = ms.getMembers(midxes);
            model.addAttribute("list", list);
        }

        if (mdto != null && mdto.getLevel() > 2) {
            url = "admin/update"+type;
        }
        return url;
    }

    @PostMapping("/updateLeave")
    @ResponseBody
    public HashMap<String, Object> updateLeave(@RequestBody List<List<String>> datas, HttpSession session, Model model) {
        HashMap<String, Object> result = new HashMap<>();
        as.updateLeave(datas);
        return result;
    }

    @PostMapping("/updatePosition")
    @ResponseBody
    public HashMap<String, Object> updatePosition(@RequestBody List<List<String>> datas) {
        HashMap<String, Object> result = new HashMap<>();
        as.updatePosition(datas);
        return result;
    }

    @PostMapping("/updateLevel")
    @ResponseBody
    public HashMap<String, Object> updateLevel(@RequestBody List<List<String>> datas) {
        HashMap<String, Object> result = new HashMap<>();
        as.updateLevel(datas);
        return result;
    }

    @PostMapping("/updateAttendance")
    @ResponseBody
    public HashMap<String, Object> updateAttendance(@RequestBody List<List<String>> datas) {
        HashMap<String, Object> result = new HashMap<>();
        as.updateAttendance(datas);
        return result;
    }

    @GetMapping("/adminTeamList")
    public String adminTeamList(HttpServletRequest request, HttpSession session, Model model) {
        String url = "admin/login";
        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        if (mdto != null) {
            if (mdto.getLevel() > 1) {
                result = as.selectTeamMembers(request, mdto.getMidx(), mdto.getLevel());
                model.addAttribute("list", result.get("list"));
                model.addAttribute("paging", result.get("paging"));
                model.addAttribute("type", result.get("type"));
                model.addAttribute("key", result.get("key"));
                url = "admin/teamList";
            }
        }
        return url;
    }

    @GetMapping("/createTeamForm")
    public String createTeamForm(HttpServletRequest request, HttpSession session, Model model) {
        String url = "admin/login";
        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        result = as.selectTeamMembers(request, mdto.getMidx(), mdto.getLevel());
        model.addAttribute("list", result.get("list"));
        url = "admin/createTeam";

        return url;
    }

    @PostMapping("/createTeam")
    @ResponseBody
    public HashMap<String, Object> createTeam(@RequestParam("name") String name) {
        HashMap<String, Object> result = new HashMap<>();
        if (name == null || name.equals("")) {
            result.put("result", 0);
            result.put("msg", "팀명을 입력해주세요.");
        } else {
            TeamDto tdto = as.checkTeamName(name);
            if (tdto != null) {
                result.put("result", 0);
                result.put("msg", "이미 존재하는 팀명입니다.");
            } else {
                result.put("result", 1);
                as.insertTeam(name);
            }
        }
        return result;
    }

    @GetMapping("/setTeamMemberForm")
    public String setTeamMemberForm(HttpServletRequest request, Model model) {
        HashMap<String, Object> result = new HashMap<>();
        ArrayList<TeamDto> teamList = as.selectTeamList();
        HashMap<String, Object> memberList = as.selectMemberNoTeam(request);
        ArrayList<TeamDto> teamMemberList = as.selectTeams(0);
        model.addAttribute("teamList", teamList);
        model.addAttribute("memberList", memberList.get("list"));
        model.addAttribute("teamMemberList", teamMemberList);
        model.addAttribute("type", memberList.get("type"));
        model.addAttribute("key", memberList.get("key"));
        return "admin/teamSetList";
    }

    @PostMapping("/selectTeam")
    @ResponseBody
    public HashMap<String, Object> selectTeam(@RequestParam("tidx") int tidx) {
        HashMap<String, Object> result = new HashMap<>();
        ArrayList<TeamDto> list = as.selectTeams(tidx);
        String teamName = as.getTeamName(tidx);
        result.put("teamName", teamName);
        if (list.size() > 0) {
            result.put("result", 1);
            result.put("list", list);
        } else {
            result.put("result", 0);
        }
        return result;
    }

    @PostMapping("/addTeamMember")
    @ResponseBody
    public HashMap<String, Object> addTeamMember(@RequestBody List<List<String>> datas, HttpServletRequest request) {
        HashMap<String, Object> result = new HashMap<>();
        ArrayList<TeamDto> teamMemberList = as.addTeamMember(datas);
        HashMap<String, Object> noTeamList = as.selectMemberNoTeam(request);
        result.put("teamMemberList", teamMemberList);
        result.put("noTeamList", noTeamList.get("list"));
        return result;
    }

    @PostMapping("/deleteTeamMember")
    @ResponseBody
    public HashMap<String, Object> deleteTeamMember(@RequestBody List<List<String>> datas) {
        HashMap<String, Object> result = new HashMap<>();
        int tidx = Integer.parseInt(datas.get(0).get(1));
        ArrayList<MemberDto> noTeamList = as.deleteTeamMember(datas);
        ArrayList<TeamDto> teamMemberList = as.selectTeams(tidx);
        result.put("teamMemberList", teamMemberList);
        result.put("noTeamList", noTeamList);
        return result;
    }

    @PostMapping("/deleteBoard")
    @ResponseBody
    public HashMap<String, Object> deleteBoard(@RequestBody List<String> datas) {
        HashMap<String, Object> result = new HashMap<>();
        as.deleteBoard(datas);
        return result;
    }

    @PostMapping("/showBoard")
    @ResponseBody
    public void showBoard(@RequestBody List<List<String>> datas) {
        as.showBoard(datas);
    }

//    @GetMapping("/adminViewBoard")
//    public String adminViewBoard(@RequestParam("bidx") int bidx, HttpSession session, Model model) {
//        MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
//        String url = "admin/login";
//        if (loginUser != null) {
//            bs.addRead(bidx, loginUser.getMidx());
//            BoardDto bdto = bs.selectOne(bidx);
//            ArrayList<BoardCommentDto> bcdto = bs.selectComments(bidx);
//            model.addAttribute("item", bdto);
//            model.addAttribute("comments", bcdto);
//            url = "admin/viewBoard";
//        }
//        return url;
//    }

}