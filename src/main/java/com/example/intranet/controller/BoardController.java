package com.example.intranet.controller;

import com.example.intranet.dto.BoardCommentDto;
import com.example.intranet.dto.BoardDto;
import com.example.intranet.dto.MemberDto;
import com.example.intranet.service.BoardService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
            model.addAttribute("notice", result.get("notice"));
            model.addAttribute("list", result.get("list"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("type", result.get("type"));
            model.addAttribute("key", result.get("key"));
            model.addAttribute("sort", result.get("sort"));
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
            ArrayList<BoardCommentDto> bcdto = bs.selectComments(bidx);
            model.addAttribute("item", bdto);
            model.addAttribute("comments", bcdto);
            url = "board/view";
        }
        return url;
    }

    @PostMapping("/checkBoardPwd")
    @ResponseBody
    public HashMap<String, Object> checkBoardPwd(@RequestParam("bidx") int bidx, @RequestParam("pwd") String pwd) {
        HashMap<String, Object> result = new HashMap<>();
        BoardDto bdto = bs.checkBoardPwd(bidx,pwd);
        if (bdto != null){
            result.put("result", 1);
        }else{
            result.put("result", 0);
        }
        return result;
    }

    @GetMapping("/editBoard")
    public String editBoard(@RequestParam("bidx") int bidx, @RequestParam("action") String action, HttpSession session, Model model) {
        String url = "redirect:/viewBoard?bidx="+bidx;

        if (action.equals("update")) {
            url = "redirect:/updateBoardForm?bidx="+bidx;
        } else if (action.equals("delete")) {
            bs.delete(bidx);
            url = "redirect:/board";
        }

        return url;
    }

    @GetMapping("/updateBoardForm")
    public String updateBoardForm(@RequestParam("bidx") int bidx, HttpSession session, Model model) {
        BoardDto bdto = bs.selectOne(bidx);
        model.addAttribute("item", bdto);
        return "board/update";
    }

    @PostMapping("/updateBoard")
    public String updateBoard(@ModelAttribute("dto") BoardDto boarddto, HttpSession session, Model model) {
        String url = "redirect:/updateBoardForm?bidx="+boarddto.getBidx();

        if (boarddto.getTitle() == null || boarddto.getTitle().equals("")) {
            model.addAttribute("msg", "제목을 입력해주세요.");
        } else if (boarddto.getCategory() == null) {
            model.addAttribute("msg", "분류를 선택해주세요.");
        } else if (boarddto.getContent() == null || boarddto.getContent().equals("")) {
            model.addAttribute("msg", "내용을 입력해주세요.");
        } else {
            bs.update(boarddto);
            url = "redirect:/viewBoard?bidx="+boarddto.getBidx();
        }
        return url;
    }

    @PostMapping("/insertBoardComment")
    public String insertBoardComment(@RequestParam("bidx") int bidx, @RequestParam("midx") int midx, @RequestParam("content") String content, Model model) {
        if (content == null || content.equals("")) {
            model.addAttribute("msg", "제목을 입력해주세요.");
        } else {
            bs.insertComment(bidx, midx, content);
        }
        return "redirect:/viewBoard?bidx="+bidx;
    }

    @PostMapping("/updateBoardComment")
    public String updateBoardComment(@RequestParam("bidx") int bidx, @RequestParam("bcidx") int bcidx, @RequestParam("content") String content, Model model) {
        if (content == null || content.equals("")) {
            model.addAttribute("msg", "제목을 입력해주세요.");
        } else {
            bs.updateComment(bcidx, content);
        }
        return "redirect:/viewBoard?bidx="+bidx;
    }

    @GetMapping("/deleteBoardComment")
    public String deleteBoardComment(@RequestParam("bidx") int bidx, @RequestParam("bcidx") int bcidx) {
        bs.deleteComment(bcidx);
        return "redirect:/viewBoard?bidx="+bidx;
    }

}