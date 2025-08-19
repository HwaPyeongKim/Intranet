package com.example.intranet.controller;

import com.example.intranet.service.WorkService2;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WorkController2 {

    @Autowired
    WorkService2 ws;

    @GetMapping("/work")
    public String work(HttpSession session){
        return "work/mywork";

    }
}
