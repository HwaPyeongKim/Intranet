package com.example.intranet.service;

import com.example.intranet.dao.IMemberDao;
import com.example.intranet.dao.IRequestsDao;
import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.MemberRequestsDto;
import com.example.intranet.dto.Paging;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class RequestsService {

    @Autowired
    IRequestsDao rdao;

    @Autowired
    IMemberDao mdao;

    public HashMap<String, Object> selectRequestsList(HttpServletRequest request, int midx) {
        HttpSession session = request.getSession();

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


        System.out.println("Query String: " + request.getQueryString());

        HashMap<String, Object> result = new HashMap<>();
        ArrayList<MemberRequestsDto> lists = new ArrayList<>();
        if ("title".equals(type)) {
            lists = rdao.selectRequestsListTitle(midx, type, key, sort);
        } else if ("titleContent".equals(type)) {
            lists = rdao.selectRequestsListTitleContent(midx, type, key, sort);
        } else if ("name".equals(type)) {
            lists = rdao.selectRequestsListName(midx, type, key, sort);
        } else {
            lists = rdao.selectRequestsList(midx, type, key, sort);
        }


        ArrayList<MemberRequestsDto> list = new ArrayList<>();

        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(10);
        paging.setDisplayRow(10);
        int count = lists.size();
        if(count < 1) count = 1;
        paging.setTotalCount(count);
        paging.calPaging();

        if (page > paging.getEndPage()) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }

        if (lists.size() > 0) {
            for (int i=paging.getStartNum(); i<lists.size(); i++) {
                MemberRequestsDto bdto = lists.get(i);
                bdto.setLoopnum(i+1);
                list.add(bdto);
                if (i == paging.getStartNum() + paging.getDisplayRow() - 1) {
                    break;
                }
            }
        }

        result.put("requestsList", list);
        result.put("paging", paging);
        result.put("key", key);
        return result;

    }


    public void insertRquests(MemberRequestsDto requestsdto) {
        rdao.insertRquests(requestsdto);
    }


    public MemberRequestsDto selectRequestsDetail(int ridx) {
        return rdao.selectRequestsDetail(ridx);
    }

    public List<MemberDto> getAllMembers() {
        return rdao.getAllMembers();
    }

    public MemberDto getUser4(int confirm_midx)
    {
        return rdao.getUser4(confirm_midx);
    }

    public HashMap<String, Object> selectGetList(HttpServletRequest request, int midx) {
        HttpSession session = request.getSession();

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
        ArrayList<MemberRequestsDto> lists = new ArrayList<>();

        if ("title".equals(type)) {
            lists = rdao.searchGetListTitle(midx, type, key, sort);
        } else if ("titleContent".equals(type)) {
            lists = rdao.searchGetListContent(midx, type, key, sort);
        } else if ("name".equals(type)) {
            lists = rdao.searchGetListName(midx, type, key, sort);
        } else {
            lists = rdao.selectGetList(midx, type, key, sort);
        }


        ArrayList<MemberRequestsDto> list = new ArrayList<>();

        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(10);
        paging.setDisplayRow(10);
        int count = lists.size();
        if(count < 1) count = 1;
        paging.setTotalCount(count);
        paging.calPaging();

        if (page > paging.getEndPage()) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }

        if (lists.size() > 0) {
            for (int i=paging.getStartNum(); i<lists.size(); i++) {
                MemberRequestsDto bdto = lists.get(i);
                bdto.setLoopnum(i+1);
                list.add(bdto);
                if (i == paging.getStartNum() + paging.getDisplayRow() - 1) {
                    break;
                }
            }
        }

        result.put("getList", list);
        result.put("paging", paging);
        result.put("key", key);
        return result;
    }

    public MemberRequestsDto selectGetDetail(int ridx) {
        return rdao.selectGetDetail(ridx);
    }

    @Transactional
    public int updateChangeStatus(int status, int ridx) {
        return rdao.updateChangeStatus(status, ridx);
    }

    public void deleteRequests(int ridx) {
        rdao.deleteRequests(ridx);
    }
}
