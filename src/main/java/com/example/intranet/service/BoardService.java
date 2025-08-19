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

        Paging paging = new Paging();
        paging.setPage(page);
        paging.setDisplayPage(10);
        paging.setDisplayRow(10);
        int count = bdao.getAllCount();
        paging.setTotalCount(count);
        paging.calPaging();

        if (page > paging.getEndPage()) {
            paging.setPage(paging.getEndPage());
            paging.calPaging();
        }

        HashMap<String, Object> result = new HashMap<>();
        ArrayList<BoardDto> lists = bdao.select();
        ArrayList<BoardDto> list = new ArrayList<>();

        if (lists.size() > 0) {
            for (int i=paging.getStartNum(); i<lists.size(); i++) {
                BoardDto bdto = lists.get(i);
                bdto.setLoopnum(i+1);
                list.add(bdto);
                if (i == paging.getStartNum() + paging.getDisplayRow() - 1) {
                    break;
                }
            }
        }

        result.put("list", list);
        result.put("paging", paging);

        return result;
    }
    public BoardDto selectOne(int bidx) {
        return bdao.selectOne(bidx);
    }

    public void insert(BoardDto boarddto) {
        bdao.insert(boarddto);
    }

    public void addRead(int bidx, int midx) {
        BoardDto bdto = selectOne(bidx);
        String reader = bdto.getReader();
        if (reader != null) {
            reader += ", " + midx;
        } else {
            reader = ""+midx;
        }
        System.out.println("reader:"+reader);
        bdao.addRead(bidx,midx,reader);
    }

    public void delete(int bidx) {
        bdao.delete(bidx);
    }

    public BoardDto checkBoardPwd(int bidx, String pwd) {
        return bdao.checkBoardPwd(bidx,pwd);
    }
}