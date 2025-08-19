package com.example.intranet.controller;

import com.example.intranet.dto.BoardDto;
import com.example.intranet.dto.MemberDto;
import com.example.intranet.service.BoardService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashMap;

@Controller
public class BoardController {

    @Autowired
    BoardService bs;

    @GetMapping("/board")
    public String board(HttpServletRequest request, HttpSession session, Model model) {
        String url = "member/login";
        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        if (mdto != null) {
            result = bs.select(request);
            model.addAttribute("list", result.get("list"));
            model.addAttribute("paging", result.get("paging"));

            url = "board/list";
        }

        return url;
    }

    @GetMapping("/writeBoardForm")
    public String writeBoard(HttpSession session, Model model) {
        return "board/write";
    }

    @PostMapping("/writeBoard")
    public String writeBoard(@ModelAttribute("dto") BoardDto boarddto, HttpSession session, Model model) {
        String url = "board/write";

        if (boarddto.getTitle() == null || boarddto.getTitle().equals("")) {
            model.addAttribute("msg", "제목을 입력해주세요.");
        } else if (boarddto.getCategory() == null) {
            model.addAttribute("msg", "분류를 선택해주세요.");
        } else if (boarddto.getContent() == null || boarddto.getContent().equals("")) {
            model.addAttribute("msg", "내용을 입력해주세요.");
        } else if (boarddto.getPwd() == null || boarddto.getPwd().equals("")) {
            model.addAttribute("msg", "비밀번호를 입력해주세요.");
        } else {
            bs.insert(boarddto);
            int bidx = boarddto.getBidx();
            url = "redirect:/viewBoard?bidx="+bidx;
        }
        return url;
    }

    @GetMapping("/viewBoard")
    public String viewBoard(@RequestParam("bidx") int bidx, HttpSession session, Model model) {
        MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
        String url = "redirect:/board";
        if (loginUser != null) {
            bs.addRead(bidx, loginUser.getMidx());
            BoardDto bdto = bs.selectOne(bidx);
            model.addAttribute("item", bdto);
            url = "board/view";
        }
        return url;
    }
}