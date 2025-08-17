package com.example.intranet.controller;

import com.example.intranet.dto.MemberDto;
import com.example.intranet.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
public class MemberController {

    @Autowired
    MemberService ms;

    @GetMapping("/")
    public String index(HttpSession session) {
        String url = "member/login";
        if (session.getAttribute("loginUser") != null) {
            url = "redirect:/main";
        }
        return url;
    }

    @GetMapping("/loginForm")
    public String loginForm() {
        return "member/login";
    }

    @PostMapping("login")
    public String login(@RequestParam("userid") String userid, @RequestParam("pwd") String pwd) {
        return "main";
    }

    @GetMapping("joinForm")
    public String joinForm() {
        return "member/join";
    }

    @PostMapping("/join")
    public String joinForm(@ModelAttribute("dto") MemberDto memberdto, @RequestParam(value="pwdChk",required=false,defaultValue="") String pwdChk, @RequestParam(value="number1",required=false,defaultValue="") String number1, @RequestParam(value="number2",required=false,defaultValue="") String number2, @RequestParam(value="phone1",required=false,defaultValue="") String phone1, @RequestParam(value="phone2",required=false,defaultValue="") String phone2, @RequestParam(value="phone3",required=false,defaultValue="") String phone3, BindingResult result, Model model) {
        String url = "member/join";

        if (memberdto.getUserid().equals("")) {
            model.addAttribute("msg", "아이디를 입력해주세요.");
        } else if (memberdto.getPwd().equals("")) {
            model.addAttribute("msg", "패스워드를 입력해주세요.");
        } else if (!memberdto.getPwd().equals(pwdChk)) {
            model.addAttribute("msg", "패스워드가 일치하지 않습니다.");
        } else if (memberdto.getName().equals("")) {
            model.addAttribute("msg", "이름을 입력해주세요.");
        } else if (number1.equals("")) {
            model.addAttribute("msg", "주민등록번호를 입력해주세요.");
        } else if (number2.equals("")) {
            model.addAttribute("msg", "주민등록번호를 입력해주세요.");
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
        } else if (memberdto.getImage().equals("")) {
            model.addAttribute("msg", "프로필 이미지를 입력해주세요.");
        } else {
            memberdto.setNumber(number1+"-"+number2);
            memberdto.setPhone(phone1+"-"+phone2+"-"+phone3);
            ms.insert(memberdto);
            model.addAttribute("msg", "회원가입이 완료되었습니다.");
            url = "member/login";
        }
        model.addAttribute("number1", number1);
        model.addAttribute("number2", number2);
        model.addAttribute("phone1", phone1);
        model.addAttribute("phone2", phone2);
        model.addAttribute("phone3", phone3);

        return url;
    }

    @GetMapping("/chkIdForm")
    public String chkId(@RequestParam("userid") String userid, Model model) {
        return "member/chkId";
    }
}