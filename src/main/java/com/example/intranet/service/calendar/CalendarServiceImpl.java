package com.example.intranet.service.calendar;

import com.example.intranet.dao.calendar.ICalendarDao;
import com.example.intranet.dto.calendar.CalendarDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CalendarServiceImpl implements CalendarService {
    // 원본 https://greed-yb.tistory.com/274
    // 수정사항 calendarList에 midx 추가

    @Autowired
    private ICalendarDao calendarMapper;

    @Override
    public List<CalendarDto> calendarList(int midx) throws Exception {
        return calendarMapper.calendarList(midx);
    }

    @Override
    public void calendarSave(CalendarDto vo) throws Exception {
        calendarMapper.calendarSave(vo);
    }

    @Override
    public void calendarDelete(String no) throws Exception {
        calendarMapper.calendarDelete(no);
    }

    @Override
    public void eventUpdate(CalendarDto vo) throws Exception {
        calendarMapper.eventUpdate(vo);
    }
}