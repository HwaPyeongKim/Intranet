package com.example.intranet.service.calendar;

import com.example.intranet.dao.calendar.ICalendarDao;
import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.calendar.CalendarDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CalendarServiceImpl implements CalendarService {
    // 원본 https://greed-yb.tistory.com/274
    // 수정사항 calendarList()에 midx 추가

    @Autowired
    private ICalendarDao calendarMapper;

    @Override
    public List<CalendarDto> calendarList(MemberDto mdto) throws Exception {
        return calendarMapper.calendarList(mdto);
    }

    @Override
    public void calendarSave(CalendarDto dto) throws Exception {
        calendarMapper.calendarSave(dto);
    }

    @Override
    public void calendarDelete(String no) throws Exception {
        calendarMapper.calendarDelete(no);
    }

    @Override
    public void eventUpdate(CalendarDto dto) throws Exception {
        calendarMapper.eventUpdate(dto);
    }

    @Override
    public void deleteOldEvent(){
        calendarMapper.deleteOldEvent();
    };
}