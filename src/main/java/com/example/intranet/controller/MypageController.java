package com.example.intranet.controller;

import com.example.intranet.dto.MemberDto;
import com.example.intranet.service.FileService;
import com.example.intranet.service.MemberService;
import com.example.intranet.service.MypageService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MypageController {

    @Autowired
    MypageService ms;

    @Autowired
    MemberService mes;

    @Autowired
    FileService fs;

    @GetMapping("/workList")
    public String workList(){
        return "mypage/workList";
    }

    @GetMapping("/vacationList")
    public String vacationList(){
        return "mypage/vacationList";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model){
        String url = "member/login";

        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        if (loginUser != null) {
            String filePath = fs.getFile(loginUser.getImage()).getPath();
            model.addAttribute("filePath", filePath);
            url = "mypage/profile";
        }
        return url;
    }

    @GetMapping("/editProfile")
    public String editProfile(){
        return "mypage/editProfile";
    }

    @GetMapping("/changePwdForm")
    public String changePwd(HttpSession session, Model model){
        String url = "member/login";

        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        if (loginUser != null) {
            url = "mypage/chagePwd";
        }
        return url;
    }

    @PostMapping("/changePwd")
    public String changePwd(@RequestParam(value="pwd", required=false, defaultValue="") String pwd, @RequestParam(value="newPwd", required=false, defaultValue="") String newPwd, @RequestParam(value="newPwdChk", required=false, defaultValue="") String newPwdChk, HttpSession session, Model model){
        String url = "member/login";

        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        if (loginUser != null) {
            url = "mypage/chagePwd";
            if (pwd.equals("")) {
                model.addAttribute("msg", "비밀번호를 입력해주세요.");
            } else if (newPwd.equals("")) {
                model.addAttribute("msg", "새 비밀번호를 입력해주세요.");
            } else if (newPwdChk.equals("")) {
                model.addAttribute("msg", "새 비밀번호 확인을 입력해주세요.");
            } else if (!newPwd.equals(newPwdChk)) {
                model.addAttribute("msg", "새 비밀번호가 일치하지 않습니다.");
            } else {
                MemberDto mdto = mes.checkPwd(loginUser.getUserid(), pwd);
                if (mdto == null) {
                    model.addAttribute("msg", "비밀번호를 확인해주세요.");
                } else {
                    mes.changePwd(loginUser.getMidx(), newPwd);
                    model.addAttribute("msg", "비밀번호가 수정되었습니다.");
                    session.removeAttribute("loginUser");
                    session.removeAttribute("profileImg");
                    url = "member/login";
                }
            }
        }

        return url;
    }

    @PostMapping("/checkPwd")
    public String checkPwd(@RequestParam("pwd") String pwd, HttpSession session, Model model){
        String url = "member/login";

        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        if (loginUser != null) {
            MemberDto mdto = mes.checkPwd(loginUser.getUserid(), pwd);
            if (mdto == null) {
                model.addAttribute("msg", "비밀번호를 확인해주세요.");
                url = "mypage/editProfile";
            } else {
                String[] phone = mdto.getPhone().split("-");
                String filePath = fs.getFile(mdto.getImage()).getPath();
                model.addAttribute("dto", mdto);
                model.addAttribute("phone", phone);
                model.addAttribute("filePath", filePath);
                url = "mypage/editProfileForm";
            }
        }

        return url;
    }

    @PostMapping("/updateProfile")
    public String updateProfile(@ModelAttribute("dto") MemberDto memberdto, @RequestParam(value="number1",required=false,defaultValue="") String number1, @RequestParam(value="number2",required=false,defaultValue="") String number2, @RequestParam(value="phone1",required=false,defaultValue="") String phone1, @RequestParam(value="phone2",required=false,defaultValue="") String phone2, @RequestParam(value="phone3",required=false,defaultValue="") String phone3, BindingResult result, HttpSession session, Model model){
        String url = "mypage/editProfileForm";

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
            mes.update(memberdto);
            model.addAttribute("msg", "회원정보수정이 완료되었습니다.");

            session.setAttribute("loginUser", memberdto);
            session.setAttribute("profileImg", fs.getFile(memberdto.getImage()).getPath());

            url = "redirect:/main";
        }

        return url;
    }

}