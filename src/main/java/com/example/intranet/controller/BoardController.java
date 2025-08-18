package com.example.intranet.controller;

import com.example.intranet.dto.MemberDto;
import com.example.intranet.service.BoardService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.HashMap;

@Controller
public class BoardController {

    @Autowired
    BoardService bs;

    @GetMapping("board")
    public String board(HttpSession session, Model model) {
        String url = "member/login";
        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        if (mdto != null) {
            result.put("list", bs.selectProduct());

            url = "board/list";
        }

        return url;
    }

}