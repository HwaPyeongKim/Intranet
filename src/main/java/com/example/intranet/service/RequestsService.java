package com.example.intranet.service;

import com.example.intranet.dao.IMemberDao;
import com.example.intranet.dao.IRequestsDao;
import com.example.intranet.dao.calendar.ICalendarDao;
import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.MemberRequestsDto;
import com.example.intranet.dto.Paging;
import com.example.intranet.dto.calendar.CalendarDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class RequestsService {

    @Autowired
    IRequestsDao rdao;

    @Autowired
    IMemberDao mdao;

    @Autowired
    ICalendarDao cdao;

    public HashMap<String, Object> selectRequestsList(HttpServletRequest request, int midx) {
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
        ArrayList<MemberRequestsDto> lists = rdao.selectRequestsList(midx, type, key, sort, dir);
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
                MemberRequestsDto mrdto = lists.get(i);
                mrdto.setLoopnum(i+1);
                list.add(mrdto);
                if (i == paging.getStartNum() + paging.getDisplayRow() - 1) {
                    break;
                }
            }
        }

        result.put("requestsList", list);
        result.put("paging", paging);
        result.put("type", type);
        result.put("key", key);
        result.put("sort", sort);

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
        ArrayList<MemberRequestsDto> lists = rdao.selectGetList(midx, type, key, sort, dir);
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
        result.put("type", type);
        result.put("key", key);
        result.put("sort", sort);

        return result;
    }

    public MemberRequestsDto selectGetDetail(int ridx) {
        return rdao.selectGetDetail(ridx);
    }

    // 휴가 승인시 일정 자동생성을 위해 수정되었음
    @Transactional
    public int updateChangeStatus(int status, int ridx) {

        // category를 가져오기 위해 requestsdto를 가져옴
        MemberRequestsDto requestsdto = rdao.selectRequestsDetail(ridx);
        int category = requestsdto.getCategory();

        // 휴가(requestsdto.getCategory()==2,3,4)가 승인(status==4)되는 경우 일정 생성
        if( status==4 && ( category == 2 || category == 3 ||  category == 4 ) ) {

            // CalendarDto 객체생성 전 startdate, enddate String 형변환 필요
            SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
            String startdate = transFormat.format(requestsdto.getStartdate());
            String enddate = transFormat.format(requestsdto.getEnddate());

            // 현재 추가될 일정 제목 : (휴가) 사원명
            MemberDto mdto = mdao.selectMember(requestsdto.getMidx());
            String title = "(휴가) "+mdto.getName();

            // 휴가 유형에 따라 시분초 데이터 넣음
            switch (category) {
                case 2:
                    startdate += " 00:00:00";
                    enddate += " 23:59:59";
                    title += " 연차";
                    break;
                case 3:
                    startdate += " 00:00:00";
                    enddate += " 12:00:00";
                    title += " 오전반차";
                    break;
                case 4:
                    startdate += " 12:00:00";
                    enddate += " 23:59:59";
                    title += " 오후반차";
                    break;
            }

            // new CalendarDto( 일정제목, 일정시작일, 일정종료일, 멤버dto, 사용용도, 용도에 맞는 idx );
            CalendarDto cdto = new CalendarDto(title, startdate, enddate, mdto, "vacation", ridx);

            try {
                // 이후 cdao.calendarSave(cdto) 로 일정생성
                cdao.calendarSave(cdto);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
        return rdao.updateChangeStatus(status, ridx);
    }

    public void deleteRequests(int ridx) {
        rdao.deleteRequests(ridx);
    }
}
