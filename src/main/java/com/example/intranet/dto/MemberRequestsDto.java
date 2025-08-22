package com.example.intranet.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.sql.Date;
import java.sql.Timestamp;

@Data
public class MemberRequestsDto {
    private int ridx;
    private int category;
    @NotNull
    private int midx; //회원번호
    @NotNull
    private String title; //제목
    @NotNull
    private String content; //사유
    private Date startdate;
    private Date enddate;
    private int status; //처리상태(1.대기중 2.처리중...)
    @NotNull
    private int confirm_midx; //확인자 고유번호
    private Timestamp writedate; //작성일now()
    private String deleteyn; // 삭제여부
    private int loopnum; // 번호를 위한 변수
    private Integer fidx; //파일번호

    //조인
    private String mname;
    private String mposition;
    private String cname;
    private String cposition;
    private String path;
    private String originalname;
}