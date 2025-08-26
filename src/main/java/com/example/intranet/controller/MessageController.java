package com.example.intranet.controller;

import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.MessageDto;
import com.example.intranet.service.MemberService;
import com.example.intranet.service.MessageService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class MessageController {

    @Autowired
    MessageService mgs;

    @Autowired
    MemberService mbs;



     //메시지 목록
//    @GetMapping("/message")
//    public String list(@RequestParam int userid, Model model) {
//        List<MessageDto> messages = mgs.getMessages(userid);
//        model.addAttribute("messages", messages);
//        return "message";
//    }


    // 받은 메세지
    @GetMapping("/receiveList")
    public String receiveList(HttpSession session, Model model) {
        String url = "member/login";

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        session.setAttribute("msgrs", "receive");
        if (mdto != null) {

            int midx = mdto.getMidx();   // 로그인 사용자 midx 사용
            ArrayList<MessageDto> message = mgs.getMessageReceive(midx);
            System.out.println(midx);
            model.addAttribute("message", message);

            url = "message/receiveList"; // 받은 메세지 JSP 경로
        }

        return url;
    }

     //받은 메세지 상세보기
    @GetMapping("/receiveView")
    public String receiveView(@RequestParam int msidx, Model model) {
        MessageDto message = mgs.getMessageReceiveView(msidx);
        model.addAttribute("message", message);
        model.addAttribute("activeTab", "receive");
        return "message/view";
    }



    // 보낸 메세지
    @GetMapping("/sentList")
    public String sentList(HttpSession session, Model model) {
        String url = "member/login";

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        session.setAttribute("msgrs", "sent");
        if (mdto != null) {
            int midx = mdto.getMidx();   // 로그인 사용자 midx 사용
            ArrayList<MessageDto> sentMessages = mgs.getMessageSent(midx);
            System.out.println(midx);
            model.addAttribute("sentMessages", sentMessages);
            url = "message/sentList";  // 보낸 메시지 JSP 경로
        }

        return url;
    }

    // 보낸 메세지 상세보기
    @GetMapping("/sentView")
    public String sentView(@RequestParam int msidx, Model model) {
        MessageDto message = mgs.getMessageSentView(msidx);
        model.addAttribute("message", message);
        model.addAttribute("activeTab", "sent");
        return "message/view";
    }



    // 메시지 작성 폼
    @GetMapping("/writemsg")
    public String writeForm(HttpSession session, Model  model) {
        String url = "member/login";

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        if (mdto != null) {
            // 로그인 사용자 정보
            model.addAttribute("userid", mdto.getMidx());
            model.addAttribute("userName", mdto.getName());

            // 전체 회원 리스트 조회 (본인 제외해서 JSP에서 필터링)
             List<MemberDto> memberList = mbs.getAllMembers();
            model.addAttribute("memberList", memberList);

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
            mgs.sendMessage(message);
            // 작성 후 목록으로 이동
            url = "redirect:/sentList";
        }

        return url;
    }

    // 메시지 삭제
    @PostMapping("/deletemsg")
    public String delete(HttpSession session,
                         @RequestParam int msidx) {
        String url = "member/login";

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        String msgrs = (String) session.getAttribute("msgrs");
        if (mdto != null) {
            mgs.deleteMessage(msidx);
            // 삭제 후 목록으로 이동
            if (msgrs.equals("receive")) {
                url = "redirect:/receiveList";
            }else if (msgrs.equals("sent")) {
                url = "redirect:/sentList";
            }
        }

        return url;
    }
}
