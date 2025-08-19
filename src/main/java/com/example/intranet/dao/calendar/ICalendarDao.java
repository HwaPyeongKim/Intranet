package com.example.intranet.dao.calendar;

import com.example.intranet.dto.calendar.CalendarDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ICalendarDao {
    // 원본 https://greed-yb.tistory.com/274
    /*
        수정사항
        CalendarMapper -> ICalendarDao
        패키지명 변경
    */

    /**
     * 캘린더 일정 조회하기
     * @return
     * @throws Exception
     */
    List<CalendarDto> calendarList(int midx) throws Exception;

    /**
     * 캘린더 일정 저장하기
     * @param vo
     * @throws Exception
     */
    void calendarSave(CalendarDto vo) throws Exception;

    /**
     * 캘린더 일정 삭제하기
     * @param no
     * @throws Exception
     */
    void calendarDelete(String no) throws Exception;

    /**
     * 캘린더 일정 수정하기
     * @param vo
     * @throws Exception
     */
    void eventUpdate(CalendarDto vo) throws Exception;
}