package com.example.intranet.service;

import com.example.intranet.dao.IBoardDao;
import com.example.intranet.dto.BoardDto;
import com.example.intranet.dto.Paging;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class BoardService {

    @Autowired
    IBoardDao bdao;

    public HashMap<String, Object> select(HttpServletRequest request) {

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
        if (request.getParameter("key") != null) {
            key = request.getParameter("key");
            session.setAttribute("key", key);
        } else if (session.getAttribute("key") != null) {
            key = (String) session.getAttribute("key");
        }

//        Paging paging = new Paging();
//        paging.setPage(page);
//        paging.setDisplayPage(10);
//        paging.setDisplayRow(10);
//        int count = bdao.getAllCount(key);
//        paging.setTotalCount(count);
//        paging.calPaging();
//
//        if (page > paging.getEndPage()) {
//            paging.setPage(paging.getEndPage());
//            paging.calPaging();
//        }

        HashMap<String, Object> result = new HashMap<>();
        ArrayList<BoardDto> list = bdao.select();
        result.put("list", list);

        return result;
    }
}