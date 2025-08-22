package com.example.intranet.controller;

import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.MemberRequestsDto;
import com.example.intranet.service.MemberService;
import com.example.intranet.service.RequestsService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
public class RequestsController {

    @Autowired
    RequestsService rs;

    @Autowired
    MemberService ms;
    private MemberDto loginUser;

    @GetMapping("/requests")
    public String requests(HttpServletRequest request, Model model,HttpSession session) {
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        if (loginUser != null) {
            // 로그인한 사용자에 해당하는 요청만 가져오기
            HashMap<String, Object> result = rs.selectRequestsList(request, loginUser.getMidx());
            model.addAttribute("requestsList", result.get("requestsList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("key", result.get("key"));
        }
        return "requests/requests";


    }

    @GetMapping("/requestsWriteForm")
    public String requestsWriteForm(@ModelAttribute("dto") MemberRequestsDto requestsdto, HttpSession session, Model model) {
        String url = "member/login";
        MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
        if(loginUser != null){
            System.out.println(1556);
            // 1. 현재 날짜와 시간을 가져와서 SimpleDateFormat으로 포맷팅
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String todayDate = sdf.format(new Date(System.currentTimeMillis()));

            // 2. 포맷팅된 날짜 문자열을 "today"라는 이름으로 모델에 추가
            model.addAttribute("today", todayDate);

            // 전체 회원 목록을 가져와서 모델에 추가
            List<MemberDto> memberList = rs.getAllMembers();

            model.addAttribute("requestsdto", new MemberRequestsDto());
            model.addAttribute("memberList", memberList);
            url = "requests/requestsWriteForm";
        }
        return url;
    }

    @PostMapping("/requestsWrite")
    public String requestsWrite(
            @ModelAttribute("dto") @Valid MemberRequestsDto requestsdto, HttpSession session, BindingResult result, Model model) {
        String url = "requests/requestsWriteForm";

        if(result.hasFieldErrors("title")) {
            model.addAttribute("message","제목을 입력하세요");
        }else if(result.hasFieldErrors("confirm_midx")){
            model.addAttribute("message","승인자를 선택하세요");
        }else if(result.hasFieldErrors("content")){
            model.addAttribute("message","내용을 입력하세요");
        }else{
            // 레코드를 리퀘스트 테이블에 추가
            rs.insertRquests( requestsdto );

            // 목록으로 돌아갑니다.
            url = "redirect:/requests";
        }

        return url;
    }

    @GetMapping("/requestsDetail")
    public String requestsDetail(@RequestParam("ridx") int ridx, HttpSession session, Model model) {
        MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
        List<MemberDto> memberList = rs.getAllMembers();
        model.addAttribute("memberList", memberList);
        MemberRequestsDto rdto = rs.selectRequestsDetail(ridx);
        model.addAttribute("rdto", rdto);

        MemberDto user = rs.getUser4(rdto.getConfirm_midx());
        model.addAttribute("user", user);

        return "requests/requestsDetail";

    }

    @GetMapping("/getList")
    public String getList(HttpServletRequest request, Model model,HttpSession session) {
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        if (loginUser != null) {

            HashMap<String, Object> result = rs.selectGetList(request, loginUser.getMidx());
            model.addAttribute("getList", result.get("getList"));
            model.addAttribute("paging", result.get("paging"));
            model.addAttribute("key", result.get("key"));
        }
        return "requests/getList";
    }

    @GetMapping("/getListDetail")
    public String getListDetail(@RequestParam("ridx") int ridx, HttpSession session, Model model) {
        MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
        if (loginUser != null) {
            MemberRequestsDto rdto = rs.selectGetDetail(ridx);
            model.addAttribute("rdto",rdto);

//            진행상태가 대기중일때만 진행중으로 바꾸기

        }
        return "requests/getListDetail";

    }

    @GetMapping("/changeStatus")
    public String changeStatus(
            @RequestParam("ridx") int ridx,
            @RequestParam("status") int status, HttpSession session) {
        String url = "redirect:/getListDetail?ridx=" + ridx;
        // 로그인된 사용자 정보 가져오기
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");

        if (loginUser != null) {
            // 요청 ID와 상태 값을 이용하여 해당 요청의 상태 업데이트
            rs.updateChangeStatus(status, ridx);  // 상태 업데이트 서비스 메서드 호출
        }

        return url;
    }


}
