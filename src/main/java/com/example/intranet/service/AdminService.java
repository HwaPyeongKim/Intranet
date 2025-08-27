package com.example.intranet.service;

import com.example.intranet.dao.IAdminDao;
import com.example.intranet.dto.MemberAttendanceDto;
import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.Paging;
import com.example.intranet.dto.TeamDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class AdminService {

    @Autowired
    IAdminDao adao;

    public void confirmJoin(String[] midxes) {
        for(String midx : midxes){
            adao.confirmJoin(midx);
        }
    }
    public void updateMember(MemberDto memberdto) {
        adao.updateMember(memberdto);
    }

    public void updateLeave(List<List<String>> datas) {
        for (List<String> data : datas) {
            adao.updateLeave(data.get(0), data.get(1)); // midx, leavedate
        }
    }

    public void updatePosition(List<List<String>> datas) {
        for (List<String> data : datas) {
            adao.updatePosition(data.get(0), data.get(1)); // midx, position
        }
    }

    public void updateLevel(List<List<String>> datas) {
        for (List<String> data : datas) {
            adao.updateLevel(data.get(0), data.get(1)); // midx, level
        }
    }

    public void updateAttendance(List<List<String>> datas) {
        for (List<String> data : datas) {
            adao.updateAttendance(data.get(0), data.get(1)); // maidx, endtime
        }
    }

    public HashMap<String, Object> selectTeamMembers(HttpServletRequest request, int midx, int level) {
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
        ArrayList<TeamDto> lists = adao.selectTeamMembers(type, key, sort, midx, level);
        ArrayList<TeamDto> list = new ArrayList<>();

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
            int loopnum = 0;
            for (int i=paging.getStartNum(); i<lists.size(); i++) {
                TeamDto tdto = lists.get(i);
                if (i==paging.getStartNum()) {
                    loopnum = i+1;
                    tdto.setLoopnum(loopnum);
                } else {
                    TeamDto prevTdto = lists.get(i-1);
                    if (tdto.getTidx() == prevTdto.getTidx()) {
                        tdto.setLoopnum(loopnum);
                    } else {
                        loopnum += 1;
                        tdto.setLoopnum(loopnum);
                    }
                }
                list.add(tdto);
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
    public TeamDto checkTeamName(String name) {
        return adao.checkTeamName(name);
    }
    public void insertTeam(String name) {
        adao.insertTeam(name);
    }

    public HashMap<String, Object> selectMemberNoTeam(HttpServletRequest request) {
        HttpSession session = request.getSession();

        if (request.getParameter("first") != null) {
            session.removeAttribute("page");
            session.removeAttribute("key");
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

        HashMap<String, Object> result = new HashMap<>();
        ArrayList<MemberDto> list = adao.selectMemberNoTeam(type, key);
        result.put("list", list);
        result.put("type", type);
        result.put("key", key);

        return result;
    }

    public ArrayList<TeamDto> selectTeams(int tidx) {
        ArrayList<TeamDto> list = adao.selectTeams(tidx);
        return list;
    }

    public ArrayList<TeamDto> selectTeamList() {
        return adao.selectTeamList();
    }
    public ArrayList<TeamDto> addTeamMember(List<List<String>> datas) {
        int tidx = 0;
        for (List<String> data : datas) {
            tidx = Integer.parseInt(data.get(1));
            adao.addTeamMember(data.get(0), data.get(1)); // midx, tidx
        }
        return selectTeams(tidx);
    }

    public ArrayList<MemberDto> deleteTeamMember(List<List<String>> datas) {
        for (List<String> data : datas) {
            adao.addTeamMember(data.get(0), "0"); // midx, tidx
        }

        return adao.selectMemberNoTeam();
    }

    public String getTeamName(int tidx) {
        return adao.getTeamName(tidx);
    }
    public ArrayList<MemberAttendanceDto> getMemberAttendances(String maidxes) {
        ArrayList<MemberAttendanceDto> list = new ArrayList<>();
        String [] maidx = maidxes.split(",");
        for (int i=0; i<maidx.length; i++) {
            MemberAttendanceDto mdto = adao.getMemberAttendances(Integer.parseInt(maidx[i]));
            list.add(mdto);
        }
        return list;
    }
}