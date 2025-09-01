package com.example.intranet.service;

import com.example.intranet.dao.IMemberDao;
import com.example.intranet.dao.IWorkDao;
import com.example.intranet.dao.calendar.ICalendarDao;
import com.example.intranet.dto.*;
import com.example.intranet.dto.calendar.CalendarDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

@Service
public class WorkService {

    @Autowired
    IWorkDao wdao;

    @Autowired
    ICalendarDao cdao;

    @Autowired
    IMemberDao mdao;

    public HashMap<String, Object> selectWork(HttpServletRequest request, int midx) {
        HttpSession session = request.getSession();

        if (request.getParameter("first") != null) {
            session.removeAttribute("page");
            session.removeAttribute("key");
            session.removeAttribute("sort");
            session.removeAttribute("dir");
        }

        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
            session.setAttribute("page", page);
        } else if (session.getAttribute("page") != null) {
            page = (Integer) session.getAttribute("page");
        }

        String key = "";
        String type = "";
        if (request.getParameter("key") != null) {
            type =  request.getParameter("type");
            key = request.getParameter("key");
            session.setAttribute("type", type);
            session.setAttribute("key", key);
        } else if (session.getAttribute("key") != null) {
            type = (String) session.getAttribute("type");
            key = (String) session.getAttribute("key");
        }

        String sort = "writedate";
        if (request.getParameter("sort") != null) {
            sort = request.getParameter("sort");
            session.setAttribute("sort", sort);
        }

        String dir = "desc";
        if (request.getParameter("dir") != null) {
            dir = request.getParameter("dir");
            session.setAttribute("dir", dir);
        }

        HashMap<String, Object> result = new HashMap<>();
        ArrayList<WorkDto> lists = wdao.selectWork(type, key, sort, dir, midx);
        ArrayList<WorkDto> list = new ArrayList<>();

        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(10);
        paging.setDisplayRow(10);
        int count = lists.size();
        paging.setTotalCount(count);
        paging.calPaging();

        if (page > paging.getEndPage()) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }

        if (lists.size() > 0) {
            for (int i=paging.getStartNum(); i<lists.size(); i++) {
                WorkDto bdto = lists.get(i);
                bdto.setLoopnum(i+1);
                list.add(bdto);
                if (i == paging.getStartNum() + paging.getDisplayRow() - 1) {
                    break;
                }
            }
        }

        for (WorkDto workdto : list) {
            int comment_count = wdao.selectComments(workdto.getWidx()).size();

            workdto.setComment_count(comment_count);
        }

        result.put("list", list);
        result.put("paging", paging);
        result.put("type", type);
        result.put("key", key);
        result.put("sort", sort);

        return result;
    }

//    public HashMap<String, Object> selectWork(HttpServletRequest request, MemberDto mdto) {
//        HashMap<String, Object> result = new HashMap<>();
//
//        HttpSession session = request.getSession();
//
//        if( request.getParameter("first") != null ) {
//            session.removeAttribute("page");
//            session.removeAttribute("key");
//        }
//
//        int page=1;
//        if(request.getParameter("page") != null){
//            page = Integer.parseInt(request.getParameter("page"));
//            session.setAttribute("page", page);
//        }else if( session.getAttribute("page") != null){
//            page = (Integer) session.getAttribute("page");
//        }
//        String key="";
//        if( request.getParameter("key") != null){
//            key=request.getParameter("key");
//            session.setAttribute("key", key);
//        }else if( session.getAttribute("key") != null){
//            key = (String)session.getAttribute("key");
//        }
//        Paging paging = new Paging();
//        paging.setPage(page);
//        paging.setDisplayPage(10);
//        paging.setDisplayRow(10);
//        int count = wdao.getAllCountForWork( key, mdto.getMidx() );
//        paging.setTotalCount(count);
//        paging.calPaging();
//
//        if( page > paging.getEndPage() ) {
//            paging.setPage( paging.getEndPage() );
//            paging.calPaging();
//        }
//        if(paging.getPage()==0) paging.setStartNum(0);
//
//        ArrayList<WorkDto> list = wdao.selectWork( paging, key, mdto.getMidx() );
//        for (WorkDto workdto : list) {
//            int comment_count = wdao.selectComments(workdto.getWidx()).size();
//
//            workdto.setComment_count(comment_count);
//        }
//        result.put("workList", list);
//        result.put("paging", paging);
//        result.put("key", key);
//        return result;
//    }

    public HashMap<String, Object> selectYourWork(HttpServletRequest request, int midx) {
        HttpSession session = request.getSession();

        if (request.getParameter("first") != null) {
            session.removeAttribute("page");
            session.removeAttribute("key");
            session.removeAttribute("sort");
            session.removeAttribute("dir");
        }

        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
            session.setAttribute("page", page);
        } else if (session.getAttribute("page") != null) {
            page = (Integer) session.getAttribute("page");
        }

        String key = "";
        String type = "";
        if (request.getParameter("key") != null) {
            type =  request.getParameter("type");
            key = request.getParameter("key");
            session.setAttribute("type", type);
            session.setAttribute("key", key);
        } else if (session.getAttribute("key") != null) {
            type = (String) session.getAttribute("type");
            key = (String) session.getAttribute("key");
        }

        String sort = "writedate";
        if (request.getParameter("sort") != null) {
            sort = request.getParameter("sort");
            session.setAttribute("sort", sort);
        }

        String dir = "desc";
        if (request.getParameter("dir") != null) {
            dir = request.getParameter("dir");
            session.setAttribute("dir", dir);
        }

        HashMap<String, Object> result = new HashMap<>();
        ArrayList<WorkDto> lists = wdao.selectYourWork(type, key, sort, dir, midx);
        ArrayList<WorkDto> list = new ArrayList<>();

        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(10);
        paging.setDisplayRow(10);
        int count = lists.size();
        paging.setTotalCount(count);
        paging.calPaging();

        if (page > paging.getEndPage()) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }

        if (lists.size() > 0) {
            for (int i=paging.getStartNum(); i<lists.size(); i++) {
                WorkDto bdto = lists.get(i);
                bdto.setLoopnum(i+1);
                list.add(bdto);
                if (i == paging.getStartNum() + paging.getDisplayRow() - 1) {
                    break;
                }
            }
        }

        for (WorkDto workdto : list) {
            int comment_count = wdao.selectComments(workdto.getWidx()).size();

            workdto.setComment_count(comment_count);
        }

        result.put("list", list);
        result.put("paging", paging);
        result.put("type", type);
        result.put("key", key);
        result.put("sort", sort);

        return result;
    }


//    public HashMap<String, Object> selectYourWork(HttpServletRequest request, MemberDto mdto) {
//        HashMap<String, Object> result = new HashMap<>();
//
//        HttpSession session = request.getSession();
//
//        if( request.getParameter("first") != null ) {
//            session.removeAttribute("page");
//            session.removeAttribute("key");
//        }
//
//        int page=1;
//        if(request.getParameter("page") != null){
//            page = Integer.parseInt(request.getParameter("page"));
//            session.setAttribute("page", page);
//        }else if( session.getAttribute("page") != null){
//            page = (Integer) session.getAttribute("page");
//        }
//        String key="";
//        if( request.getParameter("key") != null){
//            key=request.getParameter("key");
//            session.setAttribute("key", key);
//        }else if( session.getAttribute("key") != null){
//            key = (String)session.getAttribute("key");
//        }
//        Paging paging = new Paging();
//        paging.setPage(page);
//        paging.setDisplayPage(10);
//        paging.setDisplayRow(10);
//        int count = wdao.getAllCountForYourWork( key, mdto.getMidx() );
//        paging.setTotalCount(count);
//        paging.calPaging();
//
//        if( page > paging.getEndPage() ) {
//            paging.setPage( paging.getEndPage() );
//            paging.calPaging();
//        }
////        if(paging.getPage()==0) paging.setStartNum(0);
//
//        ArrayList<WorkDto> list = wdao.selectYourWork( paging, key, mdto.getMidx() );
//        for (WorkDto workdto : list) {
//            int comment_count = wdao.selectComments(workdto.getWidx()).size();
//
//            workdto.setComment_count(comment_count);
//        }
//        result.put("workList", list);
//        result.put("paging", paging);
//        result.put("key", key);
//        return result;
//    }

    public void insert(WorkDto workdto) {
        // 업무에 insert
        wdao.insert(workdto);

        // insert 직후 가장 최근 work를 가져옵니다(widx를 가져오기 위해)
        workdto = wdao.getRecentWork(workdto.getMidx());

        // 일정에 insert
        String title = "(업무) " + workdto.getTitle();

        // 시작일, 종료일은 Timestamp형 시간을 String으로 변환
        String writedate = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(workdto.getWritedate());
        String deadline = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(workdto.getDeadline());

        // 요청자와 수신자 양쪽 모두 CalendarDto 객체 생성하고 DB에 추가
        // new CalendarDto( 일정제목, 일정시작일, 일정종료일, 멤버dto, 사용용도, 용도에 맞는 idx );
        CalendarDto calendardto1 =  new CalendarDto(title, writedate, deadline, mdao.selectMember(workdto.getMidx()), "work", workdto.getWidx());
        CalendarDto calendardto2 =  new CalendarDto(title, writedate, deadline, mdao.selectMember(workdto.getWorker()), "work", workdto.getWidx());

        try {
            // 요청자와 수신자 양쪽 모두에 일정이 생성됩니다
            cdao.calendarSave(calendardto1);
            cdao.calendarSave(calendardto2);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    public WorkDto selectOne(int widx) { return wdao.selectOne(widx); }

    public ArrayList<WorkCommentDto> selectComments(int widx) { return wdao.selectComments(widx); }

    public void delete(int widx) {
        // 업무 delete
        wdao.delete(widx);

        // 일정 delete
        ArrayList<CalendarDto> calendarList = cdao.getEventForWork(widx);
        // 업무의 widx로 calendarList를 가져옵니다
        // 가져오는 일정 : 요청자의일정 worker의일정 총 두개의 일정
        try {
            for (CalendarDto calendardto : calendarList) {
                // calendarDelete 가 String을 사용하기 때문에 long->String 변환이 필요함
                cdao.calendarDelete(Long.toString(calendardto.getCalendarNo()));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void update(WorkDto workdto) {
        // 업무 update
        wdao.update(workdto);

        // 일정 update
        ArrayList<CalendarDto> calendarList = cdao.getEventForWork(workdto.getWidx());
        // 업무의 widx로 calendarList를 가져옵니다
        // 가져오는 일정 : 요청자의일정 worker의일정 총 두개의 일정
        try {
            for (CalendarDto calendardto : calendarList) {
                // 수정되는 사항 : title, deadline
                calendardto.setTitle("(업무) "+workdto.getTitle());
                calendardto.setEnd(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(workdto.getDeadline()));
                cdao.eventUpdate(calendardto);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void insertComment(int widx, int midx, String content, String autoyn) {wdao.insertComment(widx, midx, content, autoyn);}

    public void updateComment(int wcidx, String content) {wdao.updateComment(wcidx, content);}

    public void deleteComment(int wcidx) {wdao.deleteComment(wcidx);}

    public void changeStatus(int widx, int status, int next) {

        wdao.changeStatus(widx, status, next);
        if(next == 6) {
            wdao.updateCompletedate(widx);
        }
    }

    public WorkDto myCompleteWork(int midx, LocalDate today) {
        return wdao.myCompleteWork(midx, today);
    }
}
