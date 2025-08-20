package com.example.intranet.controller;

import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.MessageDto;
import com.example.intranet.service.MessageService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class MessageController {

    @Autowired
    MessageService ms;


    // 메시지 목록
    @GetMapping("/message")
    public String list(HttpSession session, Model model) {
        String url = "member/login";

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        if (mdto != null) {
            int userId = mdto.getMidx();   // 로그인 사용자 midx 사용
            List<MessageDto> messages = ms.getMessages(userId);
            model.addAttribute("messages", messages);
            url = "message/list";
        }

        return url;
    }

    // 메시지 상세
    @GetMapping("/viewmsg")
    public String view(HttpSession session, Model model,
                       @RequestParam int msidx) {

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        if (mdto == null) return "member/login";

        MessageDto message = ms.getMessage(msidx);
        if (message == null) {
            model.addAttribute("error", "해당 메시지를 찾을 수 없습니다.");
            return "message/list"; // 또는 에러 페이지
        }

        model.addAttribute("message", message);
        return "message/view";
    }


    // 메시지 작성 폼
    @GetMapping("/writemsg")
    public String writeForm(HttpSession session, Model  model) {
        String url = "member/login";

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        if (mdto != null) {
            // 로그인 사용자 정보
            model.addAttribute("userId", mdto.getMidx());
            model.addAttribute("userName", mdto.getName());

            // 전체 회원 리스트 조회 (본인 제외해서 JSP에서 필터링)
            // List<MemberDto> memberList = ms.getAllMembers();
           // model.addAttribute("memberList", memberList);

            url = "message/write";
        }

        return url;
    }

    // 메시지 작성 처리
    @PostMapping("/writemsg")
    public String write(HttpSession session, MessageDto message) {
        String url = "member/login";

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        if (mdto != null) {
            // 보낸 사람 정보 세션에서 세팅
            message.setFrommidx(mdto.getMidx());
            ms.sendMessage(message);
            // 작성 후 목록으로 이동
            url = "redirect:/message";
        }

        return url;
    }

    // 메시지 삭제
    @PostMapping("/deletemsg")
    public String delete(HttpSession session,
                         @RequestParam int msidx) {
        String url = "member/login";

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        if (mdto != null) {
            ms.deleteMessage(msidx);
            // 삭제 후 목록으로 이동
            url = "redirect:/message";
        }

        return url;
    }
}
