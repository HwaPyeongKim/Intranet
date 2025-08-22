package com.example.intranet.controller;

import com.example.intranet.dto.*;
import com.example.intranet.service.MemberService;
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

    @Autowired
    MemberService ms;

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
    public String insertWorkForm(Model model) {
        ArrayList<MemberDto> members = ms.getAllMembers();
        model.addAttribute("members", members);

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
            url = "redirect:/yourwork";
            System.out.println(completedate);
            // String now = "2009-03-20 10:20:30.0"; // 형식을 지켜야 함
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");

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

    @GetMapping("/workView")
    public String workView(@RequestParam("widx") int widx, HttpSession session, Model model) {
        MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
        String url = "redirect:/work";
        if (loginUser != null) {
            WorkDto wdto = ws.selectOne(widx);
            ArrayList<WorkCommentDto> comments = ws.selectComments(widx);
           
            model.addAttribute("workitem", wdto);
            model.addAttribute("comments", comments);
            url = "work/workView";
        }
        return url;

    }

    @GetMapping("/editWork")
    public String editWork(@RequestParam("widx") int widx, @RequestParam("action") String action, HttpSession session, Model model) {
        String url = "redirect:/workView?widx="+widx;

        if (action.equals("update")) {
            url = "redirect:/updateWorkForm?widx="+widx;
        } else if (action.equals("delete")) {
            ws.delete(widx);
            url = "redirect:/work";
        }

        return url;
    }

    @GetMapping("/updateWorkForm")
    public String updateWorkForm(@RequestParam("widx") int widx, HttpSession session, Model model) {
        WorkDto wdto = ws.selectOne(widx);
        model.addAttribute("workitem", wdto);
        return "work/updateWork";
    }

    @PostMapping("/updateWork")
    public String updateWork(@ModelAttribute("dto") @Valid WorkDto workdto, BindingResult result, Model model,
                             @RequestParam String completedate) {
        String url = "redirect:/updateWorkForm?bidx="+workdto.getWidx();
        System.out.println("ss");

        if (workdto.getTitle() == null || workdto.getTitle().equals("")) {
            model.addAttribute("msg", "업무명을 입력하세요");
        } else if (workdto.getContent() == null || workdto.getContent().equals("")) {
            model.addAttribute("msg", "내용을 입력하세요");
        } else {
            System.out.println(completedate);
            // String now = "2009-03-20 10:20:30.0"; // 형식을 지켜야 함
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");

            try {
                Date date = df.parse(completedate);
                workdto.setCompletedate(new Timestamp(date.getTime()));
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
            ws.update(workdto);
            url = "redirect:/workView?widx="+workdto.getWidx();
        }
        return url;
    }

    @PostMapping("/insertComment")
    public String insertComment(@RequestParam("widx") int widx, @RequestParam("midx") int midx, @RequestParam("content") String content, Model model) {
        if (content == null || content.equals("")) {
            model.addAttribute("msg", "댓글을 입력하세요");
        } else {
            ws.insertComment(widx, midx, content);
        }
        return "redirect:/workView?widx="+widx;
    }

    @PostMapping("/updateComment")
    public String updateComment(@RequestParam("widx") int widx, @RequestParam("wcidx") int wcidx, @RequestParam("content") String content, Model model) {
        if (content == null || content.equals("")) {
            model.addAttribute("msg", "댓글을 입력하세요");
        } else {
            ws.updateComment(wcidx, content);
        }
        return "redirect:/workView?widx="+widx;
    }

    @GetMapping("/deleteComment")
    public String deleteComment(@RequestParam("widx") int widx, @RequestParam("wcidx") int wcidx) {
        ws.deleteComment(wcidx);
        return "redirect:/workView?widx="+widx;
    }


}
