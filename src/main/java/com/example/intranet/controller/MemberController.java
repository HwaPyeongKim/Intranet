package com.example.intranet.controller;

import com.example.intranet.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

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

    @PostMapping("/login")
    public String login() {
        return "redirect:/main";
    }

    @GetMapping("join")
    public String join() {
        return "member/join";
    }

}