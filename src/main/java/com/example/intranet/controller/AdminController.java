package com.example.intranet.controller;

import com.example.intranet.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

    @Autowired
    AdminService as;

    @GetMapping("/admin")
    public String admin(){
        return "admin/adminMain";
    }

}