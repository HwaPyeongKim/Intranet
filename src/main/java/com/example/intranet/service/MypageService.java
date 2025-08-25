package com.example.intranet.service;

import com.example.intranet.dao.IMypageDao;
import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.MemberRequestsDto;
import com.example.intranet.dto.WorkDto;
import com.example.intranet.dto.Paging;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class MypageService {

    @Autowired
    IMypageDao mdao;

    public HashMap<String, Object> selectWork(HttpServletRequest request, int midx) {
        HttpSession session = request.getSession();

        if (request.getParameter("first") != null) {
            session.removeAttribute("page");
            session.removeAttribute("key");
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

        String sort = "desc";
        if (request.getParameter("sort") != null) {
            sort = request.getParameter("sort");
        }

        HashMap<String, Object> result = new HashMap<>();
        ArrayList<WorkDto> lists = mdao.selectWork(type, key, sort, midx);
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

        result.put("list", list);
        result.put("paging", paging);
        result.put("type", type);
        result.put("key", key);
        result.put("sort", sort);

        return result;
    }

    public HashMap<String, Object> selectRequests(HttpServletRequest request, int midx) {
        HttpSession session = request.getSession();

        if (request.getParameter("first") != null) {
            session.removeAttribute("page");
            session.removeAttribute("key");
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

        String sort = "desc";
        if (request.getParameter("sort") != null) {
            sort = request.getParameter("sort");
        }

        HashMap<String, Object> result = new HashMap<>();
        ArrayList<MemberRequestsDto> lists = mdao.selectRequests(type, key, sort, midx);
        ArrayList<MemberRequestsDto> list = new ArrayList<>();

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
                MemberRequestsDto mrdto = lists.get(i);
                mrdto.setLoopnum(i+1);
                list.add(mrdto);
                if (i == paging.getStartNum() + paging.getDisplayRow() - 1) {
                    break;
                }
            }
        }

        result.put("list", list);
        result.put("paging", paging);
        result.put("type", type);
        result.put("key", key);
        result.put("sort", sort);

        return result;
    }
    public void insertRequests(MemberRequestsDto mrdto) {
        mdao.insertRequests(mrdto);
    }
    public ArrayList<MemberDto> selectConfirm(int midx) {
        return mdao.selectConfirm(midx);
    }
}