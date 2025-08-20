package com.example.intranet.dto.calendar;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CalendarDto {

    // 원본 https://greed-yb.tistory.com/274
    /*
        수정사항
        클래스명 CalendarVo -> CalendarDto 로 변경
        패키지명 변경

        로그인 전용 기능으로 만들기 위해 midx 추가

        일정의 분류기능 추가 위해 category 추가, 1:개인, 2:부서, 3:전체
        부서일정, 전체일정은 개인의 수정 막기위해 editable 추가
        분류별로 다른색상이 나오기 위해 eventColor 추가
     */

    private Long calendarNo;
    private String title;
    private String start1;
    private String end;
    private boolean allDay;
    private int midx;
    private int category;
    private boolean editable;
    private String eventColor;
}