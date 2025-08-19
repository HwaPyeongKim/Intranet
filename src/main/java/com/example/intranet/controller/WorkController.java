package com.example.intranet.controller;

import com.example.intranet.dto.WorkDto;
import com.example.intranet.service.MemberService;
import com.example.intranet.service.WorkService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.HashMap;
import java.util.List;

@Controller
public class WorkController {

    @Autowired
    WorkService ws;

    @GetMapping("/work")
    public String work(Model model) {

        HashMap<String, Object> result = ws.selectWorkList();
        model.addAttribute("workList", result.get("workList"));
        model.addAttribute("paging", result.get("paging"));
        model.addAttribute("key", result.get("key"));
        return "mypage/work";
    }


}
