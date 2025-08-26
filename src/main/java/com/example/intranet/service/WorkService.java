package com.example.intranet.service;

import com.example.intranet.dao.IWorkDao;
import com.example.intranet.dto.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class WorkService {

    @Autowired
    IWorkDao wdao;

    public HashMap<String, Object> selectWork(HttpServletRequest request, MemberDto mdto) {
        HashMap<String, Object> result = new HashMap<>();

        HttpSession session = request.getSession();

        if( request.getParameter("first") != null ) {
            session.removeAttribute("page");
            session.removeAttribute("key");
        }

        int page=1;
        if(request.getParameter("page") != null){
            page = Integer.parseInt(request.getParameter("page"));
            session.setAttribute("page", page);
        }else if( session.getAttribute("page") != null){
            page = (Integer) session.getAttribute("page");
        }
        String key="";
        if( request.getParameter("key") != null){
            key=request.getParameter("key");
            session.setAttribute("key", key);
        }else if( session.getAttribute("key") != null){
            key = (String)session.getAttribute("key");
        }
        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(10);
        paging.setDisplayRow(10);
        int count = wdao.getAllCountForWork( key, mdto.getMidx() );
        paging.setTotalCount(count);
        paging.calPaging();

        if( page > paging.getEndPage() ) {
            paging.setPage( paging.getEndPage() );
            paging.calPaging();
        }
        if(paging.getPage()==0) paging.setStartNum(0);

        ArrayList<WorkDto> list = wdao.selectWork( paging, key, mdto.getMidx() );
        result.put("workList", list);
        result.put("paging", paging);
        result.put("key", key);
        return result;
    }

    public HashMap<String, Object> selectYourWork(HttpServletRequest request, MemberDto mdto) {
        HashMap<String, Object> result = new HashMap<>();

        HttpSession session = request.getSession();

        if( request.getParameter("first") != null ) {
            session.removeAttribute("page");
            session.removeAttribute("key");
        }

        int page=1;
        if(request.getParameter("page") != null){
            page = Integer.parseInt(request.getParameter("page"));
            session.setAttribute("page", page);
        }else if( session.getAttribute("page") != null){
            page = (Integer) session.getAttribute("page");
        }
        String key="";
        if( request.getParameter("key") != null){
            key=request.getParameter("key");
            session.setAttribute("key", key);
        }else if( session.getAttribute("key") != null){
            key = (String)session.getAttribute("key");
        }
        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(10);
        paging.setDisplayRow(10);
        int count = wdao.getAllCountForYourWork( key, mdto.getMidx() );
        paging.setTotalCount(count);
        paging.calPaging();

        if( page > paging.getEndPage() ) {
            paging.setPage( paging.getEndPage() );
            paging.calPaging();
        }
        if(paging.getPage()==0) paging.setStartNum(0);

        ArrayList<WorkDto> list = wdao.selectYourWork( paging, key, mdto.getMidx() );
        result.put("workList", list);
        result.put("paging", paging);
        result.put("key", key);
        return result;
    }

    public void insert(WorkDto workdto) {
        wdao.insert(workdto);
    }


    public WorkDto selectOne(int widx) { return wdao.selectOne(widx); }

    public ArrayList<WorkCommentDto> selectComments(int widx) { return wdao.selectComments(widx); }

    public void delete(int widx) { wdao.delete(widx); }

    public void update(WorkDto workdto) { wdao.update(workdto); }

    public void insertComment(int widx, int midx, String content) {wdao.insertComment(widx, midx, content);}

    public void updateComment(int wcidx, String content) {wdao.updateComment(wcidx, content);}

    public void deleteComment(int wcidx) {wdao.deleteComment(wcidx);}

}
