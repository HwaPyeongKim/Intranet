package com.example.intranet.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.sql.Date;
import java.sql.Timestamp;

@Data
public class MemberRequestsDto {

    @NotNull
    private int ridx; //전자결재고유번호 primarykey
    @NotNull
    private int category; //1.업무결재2.연차3.오전반차 4.오후반차,5.기타
    @NotNull
    private int midx;
    @NotNull
    private String title; //제목
    @NotNull
    private String content; //내용
    private Date startdate; //연차반차 시작시간
    private Date enddate; //연차반차 종료시간
    private int status; //처리상태(1.대기중 2.처리중...)
    private Integer fidx; //파일번호
    @NotNull
    private int confirm_midx; //결재자 고유번호
    private Timestamp confirmdate; //결재일

    private Timestamp writedate; //작성일now()
    private String deleteyn; // 삭제여부 기본n

    private int loopnum; // 번호를 위한 변수


    //조인
    private String mname;
    private String mposition;
    private String cname;
    private String cposition;
    private String path;
    private String originalname;
}