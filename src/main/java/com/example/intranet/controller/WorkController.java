package com.example.intranet.controller;

import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.WorkDto;
import com.example.intranet.service.WorkService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.jsp.tagext.TagInfo;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

@Controller
public class WorkController {

    @Autowired
    WorkService ws;

    @GetMapping("work")
    public String work( HttpServletRequest request, Model model ){

        HttpSession session = request.getSession();
        MemberDto mdto = (MemberDto)session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        String url = "member/login";
        if( mdto != null ){
            url = "work/mywork";
            result = ws.selectWork( request, mdto );
            model.addAttribute("workList", result.get("workList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("key", result.get("key"));

        }
        return url;
    }

    @GetMapping("yourwork")
    public String yourwork( HttpServletRequest request, Model model ){

        HttpSession session = request.getSession();
        MemberDto mdto = (MemberDto)session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        String url = "member/login";
        if( mdto != null ){
            url = "work/youwork";
            result = ws.selectYourWork( request, mdto );
            model.addAttribute("workList", result.get("workList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("key", result.get("key"));

        }
        return url;
    }

    @GetMapping("/insertWorkForm")
    public String insertWorkForm() {
        return "work/insertWork";
    }

    @PostMapping("/insertWork")
    public String insertWork(@ModelAttribute("dto") @Valid WorkDto workdto, BindingResult result, Model model,
                             @RequestParam String completedate) {
        String url = "work/insertWork";
        if(result.hasFieldErrors("title"))
            model.addAttribute("msg", result.getFieldError("title").getDefaultMessage() );
        else if(result.hasFieldErrors("worker"))
            model.addAttribute("msg", result.getFieldError("worker").getDefaultMessage() );
        else if(result.hasFieldErrors("content"))
            model.addAttribute("msg", result.getFieldError("content").getDefaultMessage() );
        else {
            url = "redirect:/main";
            System.out.println(completedate);
            // String now = "2009-03-20 10:20:30.0"; // 형식을 지켜야 함
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
            System.out.println("Ss");

            try {
                Date date = df.parse(completedate);
                workdto.setCompletedate(new Timestamp(date.getTime()));
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
            ws.insert(workdto);
        }
        return url;
    }




}
