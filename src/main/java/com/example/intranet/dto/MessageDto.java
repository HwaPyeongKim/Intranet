package com.example.intranet.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class MessageDto {
    private int msidx;       // 메시지 고유번호
    private int frommidx;    // 보낸 사람 회원번호
    private int tomidx;      // 받는 사람 회원번호
    private String title;    // 제목
    private String content;  // 내용
    private String readyn;   // 읽음 여부
    private Timestamp readdate;  // 읽은 날짜
    private Timestamp writedate; // 작성일
    private String todeleteyn;     // 삭제 여부 받는메세지
    private String fromdeleteyn; // 삭제 여부 보내는 메세지
    private int loopnum; // 번호 매기기용

    private String toname;
    private String touserid;
    private String fromname;
    private String fromuserid;
    private String fromposition;
    private String toposition;

}


