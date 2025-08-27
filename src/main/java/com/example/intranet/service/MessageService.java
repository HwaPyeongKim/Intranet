package com.example.intranet.service;

import com.example.intranet.dao.IMessageDao;
import com.example.intranet.dto.BoardDto;
import com.example.intranet.dto.MessageDto;
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
public class MessageService {

    @Autowired
    IMessageDao msdao;

    public void sendMessage(MessageDto message) {
        msdao.insertMessage(message);
    }

    public void deleteMessage(int msidx) {
        msdao.deleteMessage(msidx);
    }
//
//    public ArrayList<MessageDto> getMessageReceive(int midx) {
//        ArrayList<MessageDto> message = msdao.getMessageReceive(midx);
//        return message;
//    }
//
//
//
//    public ArrayList<MessageDto> getMessageSent(int midx) {
//        ArrayList<MessageDto> message = msdao.getMessageSent(midx);
//        return message;
//    }

    public MessageDto getMessageReceiveView(int msidx) {
        return msdao.getMessageReceiveView(msidx);
    }

    public MessageDto getMessageSentView(int msidx) {
        return msdao.getMessageSentView(msidx); // 리턴 필요
    }

    @Transactional  // 안전하게 트랜잭션 처리 (선택)
    public void deleteMessages(List<Integer> msidxList) {
        if (msidxList == null || msidxList.isEmpty()) return;
        msdao.deleteMessages(msidxList);
    }

    public HashMap<String, Object> selectSent(HttpServletRequest request, int midx) {
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

            /// //////////
            HashMap<String, Object> result = new HashMap<>();
            ArrayList<MessageDto> lists = msdao.selectSent(midx, type, key, sort);
            ArrayList<MessageDto> list = new ArrayList<>();
            /// /////////////////

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
                    MessageDto msdto = lists.get(i);
                    msdto.setLoopnum(i+1);
                    list.add(msdto);
                    if (i == paging.getStartNum() + paging.getDisplayRow() - 1) {
                        break;
                    }
                }
            }

            result.put("message", list);
            result.put("paging", paging);
            result.put("type", type);
            result.put("key", key);
            result.put("sort", sort);

            return result;

    }
    public HashMap<String, Object> selectReceive(HttpServletRequest request, int midx) {
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

        /// //////////
        HashMap<String, Object> result = new HashMap<>();
        ArrayList<MessageDto> lists = msdao.selectReceive(midx, type, key, sort);
        ArrayList<MessageDto> list = new ArrayList<>();
        /// /////////////////

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
                MessageDto msdto = lists.get(i);
                msdto.setLoopnum(i+1);
                list.add(msdto);
                if (i == paging.getStartNum() + paging.getDisplayRow() - 1) {
                    break;
                }
            }
        }

        result.put("message", list);
        result.put("paging", paging);
        result.put("type", type);
        result.put("key", key);
        result.put("sort", sort);

        return result;

    }
}
