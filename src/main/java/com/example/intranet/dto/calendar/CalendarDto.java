package com.example.intranet.dto.calendar;

import com.example.intranet.dto.MemberDto;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

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

    private Long calendarNo;        // 일정 번호
    private String title;           // 일정 제목
    private String start1;          // 일정 시작시간
    private String end;             // 일정 종료시간
    private boolean allDay;         // 하루종일 일정인지?
    private int midx;               // 일정을 만든 유저
    private int category;           // 일정의 카테고리, 1: 개인, 2: 부서, 3: 회사
    private boolean editable;       // 일정을 수정할수 있는지?
    private String eventColor;      // 일정의 색깔
    private int widx;               // 업무와 관련된 일정인지
    private int tidx;               // 부서와 관련된 일정인지
    private int ridx;               // 휴가의 경우 결재서류 번호
    private String deleteyn;        // 삭제여부

    public CalendarDto() {}

    // 일정관리창 외의 다른 곳에서 일정을 자동생성 하게 할 경우 사용하게될 생성자
    public CalendarDto(String title, String start1, String end, MemberDto mdto, String use, int idx){


        // 입력해야할것 : 일정명, 일정시작일, 일정종료일, 멤버dto, 사용목적, 사용하고자 하는곳의 idx
        // 사용목적에 따라 일정의 카테고리가 결정, 사용목적에 맞는 idx가 입력
        // 그외 설정은 하루종일x, 수정불가로 자동 생성한 채로 CalendarDto가 만들어짐

        // CalendarDto만 만들어지면 calendarSave(CalendarDto dto), eventUpdate(CalendarDto dto) 등의 메소드를 사용할수 있습니다

        // 시작일 종료일이 String 형태임에 주의

        if(use.equals("work")){         // 사용목적에 따라 변하는 사항들
            this.widx = idx;            // 사용목적이 work 인 경우 widx 값 추가되고
            this.setCategory(1);        // 개인일정으로 생성됨

        }else if(use.equals("vacation")){
            this.ridx = idx;            // 사용목적이 vacation 인 경우 ridx 값 추가되고
            this.setCategory(2);        // 부서일정으로 생성됨
            this.tidx = mdto.getTeam(); // 부서 추가
        }else{
            return;                     // 사용목적을 잘못 입력한 경우 return
        }

        // 그외 기본설정 입력됨

        this.title = title;             // 일정명
        this.start1 = start1;           // 일정시작일
        this.end = end;                 // 일정종료일
        this.midx = mdto.getMidx();     // 멤버idx
        this.allDay = false;            // 하루종일 여부, false로 설정
        this.editable = false;          // 수정가능 여부, 수정불가

    }

    // setCategory 할때 수정가능 여부와 색상을 자동으로 넣습니다.
    public void setCategory(int category) {
        this.category = category;

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