package com.example.intranet.service;

import com.example.intranet.dao.IMemberDao;
import com.example.intranet.dto.MemberAttendanceDto;
import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.Paging;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;

@Service
public class MemberService {

    @Autowired
    IMemberDao mdao;

    public void insert(MemberDto memberdto) {
        mdao.insert(memberdto);
    }
    public MemberDto getMember(String userid) {
        return mdao.getMember(userid);
    }
    public MemberDto selectMember(int midx) {
        return mdao.selectMember(midx);
    }
    public void insertAttendance(int midx) {
        mdao.insertAttendance(midx);
    }
    public void workout(int midx, String date) {
        mdao.workout(midx,date);
    }
    public MemberAttendanceDto selectAttendance(int midx, String date) {
        return mdao.selectAttendance(midx,date);
    }
    public MemberAttendanceDto checkWorkout(int midx, String date) {
        return mdao.checkWorkout(midx,date);
    }
    public ArrayList<MemberDto> getAllMembers() {
        return mdao.getAllMembers();
    }
    public MemberDto checkPwd(String userid, String pwd) {
        return mdao.checkPwd(userid, pwd);
    }
    public void update(MemberDto memberdto) {
        mdao.update(memberdto);
    }
    public void changePwd(int midx, String pwd) {
        mdao.changePwd(midx,pwd);
    }
    public HashMap<String, Object> selectMembers(HttpServletRequest request, int midx, int level) {
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
        ArrayList<MemberDto> lists = mdao.selectMembers(type, key, sort, midx, level);
        ArrayList<MemberDto> list = new ArrayList<>();

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
                MemberDto mdto = lists.get(i);
                mdto.setLoopnum(i+1);
                mdto.setNumber(mdto.getNumber().substring(0, 8) + "******");
                list.add(mdto);
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
    public int checkNewMessage(int midx) {
        return mdao.checkNewMessage(midx);
    }

    public HashMap<String, Object> selectMemberAttendances(HttpServletRequest request, int midx, int level) {
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

        String startdate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        if (request.getParameter("startdate") != null) {
            startdate = request.getParameter("startdate");
            session.setAttribute("startdate", startdate);
        } else if (session.getAttribute("startdate") != null) {
            startdate = (String) session.getAttribute("startdate");
        }

        String enddate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        if (request.getParameter("enddate") != null) {
            enddate = request.getParameter("enddate");
            session.setAttribute("enddate", enddate);
        } else if (session.getAttribute("enddate") != null) {
            enddate = (String) session.getAttribute("enddate");
        }

        HashMap<String, Object> result = new HashMap<>();
        ArrayList<MemberAttendanceDto> lists = mdao.selectMemberAttendances(type, key, sort, midx, level, startdate, enddate);
        ArrayList<MemberAttendanceDto> list = new ArrayList<>();

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
                MemberAttendanceDto madto = lists.get(i);
                madto.setLoopnum(i+1);
                list.add(madto);
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

}
