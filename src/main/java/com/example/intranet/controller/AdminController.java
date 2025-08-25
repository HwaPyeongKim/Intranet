package com.example.intranet.controller;

import com.example.intranet.dto.FileDto;
import com.example.intranet.dto.MemberAttendanceDto;
import com.example.intranet.dto.MemberDto;
import com.example.intranet.service.AdminService;
import com.example.intranet.service.FileService;
import com.example.intranet.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;

@Controller
public class AdminController {

    @Autowired
    AdminService as;

    @Autowired
    MemberService ms;

    @Autowired
    FileService fs;

    @GetMapping("/adminLoginForm")
    public String adminLogin(HttpSession session, Model model){
        String url = "admin/login";
        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        if (mdto != null) {
            if (mdto.getLevel() > 1) {
                url = "redirect:/admin";
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
                url = "redirect:/admin";
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
}