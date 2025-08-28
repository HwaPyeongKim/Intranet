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

    /*
CalendarDto dto = new CalendarDto(workDto.title, workDto.writedate, workDto.completedate, workDto.midx)

calendarService.calendarSave(dto);*/
    private Long calendarNo;
    private String title;
    private String start1;
    private String end;
    private boolean allDay;
    private int midx;
    private int category;
    private boolean editable;
    private String eventColor;


    public CalendarDto() {}

    public CalendarDto(String title, String start1, String end, int midx){

        // 일정관리창 외의 다른 곳에서 일정을 자동생성 하게 할 경우 사용하게될 생성자

        // 일정명, 일정시작일, 일정종료일, 멤버idx 만 입력받고,
        // 그외 설정은 하루종일일정, 개인일정, 수정불가 설정으로 자동 생성함

        this.title = title;             // 일정명
        this.start1 = start1;           // 일정시작일
        this.end = end;                 // 일정종료일
        this.midx = midx;               // 멤버idx


        this.allDay = true;             // 하루종일 여부, true로 설정
        this.editable = false;          // 수정가능 여부, 수정불가

        this.setCategory(1);
    }

    public void setCategory(int category) {
        this.category = category;

        // 카테고리를 입력할때 수정가능 여부와 색상을 자동으로 넣습니다.

        switch (category) {
            case 1: // 개인: 수정가능, 색상 분홍색
                this.setEditable(true);
                this.setEventColor("#FF9E9B");
                break;
            case 2: // 부서: 수정불가, 색상 파란색
                this.setEditable(false);
                this.setEventColor("#32AAFF");
                break;
            case 3: // 회사: 수정불가, 색상 초록색
                this.setEditable(false);
                this.setEventColor("#54BD54");
                break;
        }
    }
}