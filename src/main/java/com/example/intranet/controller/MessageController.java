package com.example.intranet.controller;

import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.MessageDto;
import com.example.intranet.service.MemberService;
import com.example.intranet.service.MessageService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashMap;
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
    public String receiveList(HttpServletRequest request, HttpSession session, Model model) {
        String url = "member/login";

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        session.setAttribute("msgrs", "receive");
        if (mdto != null) {
            int midx = mdto.getMidx();
            result = mgs.selectReceive(request, midx);
            model.addAttribute("message", result.get("message"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("type", result.get("type"));
            model.addAttribute("key", result.get("key"));
            model.addAttribute("sort", result.get("sort"));
            url = "message/receiveList"; // 받은 메세지 JSP 경로

//            int midx = mdto.getMidx();   // 로그인 사용자 midx 사용
//            ArrayList<MessageDto> message = mgs.getMessageReceive(midx);
//            System.out.println(midx);
//            model.addAttribute("message", message);
        }
        return url;
    }

     //받은 메세지 상세보기
    @GetMapping("/receiveView")
    public String receiveView(@RequestParam int msidx, Model model) {
        MessageDto message = mgs.getMessageReceiveView(msidx);
        mgs.updateReadyn(msidx);
        model.addAttribute("message", message);
        model.addAttribute("activeTab", "receive");
        return "message/view";
    }

    // 보낸 메세지
    @GetMapping("/sentList")
    public String sentList(HttpServletRequest request, HttpSession session, Model model) {
        String url = "member/login";

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        HashMap<String, Object> result = null;
        session.setAttribute("msgrs", "sent");
        if (mdto != null) {
            int midx = mdto.getMidx();
            result = mgs.selectSent(request, midx);
            model.addAttribute("message", result.get("message"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("type", result.get("type"));
            model.addAttribute("key", result.get("key"));
            model.addAttribute("sort", result.get("sort"));
            url = "message/sentList"; // 받은 메세지 JSP 경로

//            int midx = mdto.getMidx();   // 로그인 사용자 midx 사용
//            ArrayList<MessageDto> message = mgs.getMessageReceive(midx);
//            System.out.println(midx);
//            model.addAttribute("message", message);
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
                         @RequestParam int msidx, @RequestParam String activeTab) {
        String url = "member/login";

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        if (mdto != null) {
            mgs.deleteMessage(msidx, activeTab);
            // 삭제 후 목록으로 이동
            if (activeTab.equals("receive")) {
                url = "redirect:/receiveList";
            }else if (activeTab.equals("sent")) {
                url = "redirect:/sentList";
            }
        }

        return url;
    }


    // 메세지 여러개 삭제
    @PostMapping("/deletemsgMulti")
    public String deleteMessages(@RequestParam(value="msidxList", required=false) List<Integer> msidxList,
                                 HttpSession session, @RequestParam String activeTab) {

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        if (mdto == null) {
            return "member/login";
        }

        if (msidxList != null && !msidxList.isEmpty()) {
            mgs.deleteMessages(msidxList, activeTab);
        }

        String url = "";

        if (activeTab.equals("receive") || activeTab==null) {
            url = "redirect:/receiveList";
        }else if (activeTab.equals("sent")) {
            url = "redirect:/sentList";
        }

        return url;
    }


    @GetMapping("/writeMessage")
    public String writeMessage(HttpSession session, Model  model) {
        String url = "member/login";

        MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
        if (mdto != null) {
            // 로그인 사용자 정보
            model.addAttribute("userMidx", mdto.getMidx());
            model.addAttribute("userName", mdto.getName());
            model.addAttribute("userPosition", mdto.getPosition());

            // 전체 회원 리스트 조회 (본인 제외해서 JSP에서 필터링)
            List<MemberDto> memberList = mbs.getAllMembers();
            model.addAttribute("memberList", memberList);

            return "message/writeMessage"; // -> writeMessage.jsp
        }
            return url;
    }

    // 메시지 전송
    @PostMapping("/sendMessage")
    public String sendMessage(MessageDto message, HttpSession session) {
        // 보낸사람 ID 세션에서 가져오기
        int frommidx = ((com.example.intranet.dto.MemberDto)session.getAttribute("loginUser")).getMidx();
        message.setFrommidx(frommidx);

        mgs.sendMessage(message);

        // 팝업창에서 다시 JSP 열 때 result=success 전달 → alert + close
        return "redirect:/writeMessage?result=success";
    }


}
