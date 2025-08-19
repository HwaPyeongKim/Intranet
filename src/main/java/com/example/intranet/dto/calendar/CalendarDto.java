package com.example.intranet.dto.calendar;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CalendarDto {

    // 원본 https://greed-yb.tistory.com/274
    /*
        수정사항
        CalendarVo -> CalendarDto 로 변경
        패키지명 변경
        로그인 전용 기능으로 만들기 위해 midx 추가
     */

    private Long calendarNo;
    private String title;
    private String start1;
    private String end;
    private boolean allDay;
    private int midx;
}