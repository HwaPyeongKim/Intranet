package com.example.intranet.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.sql.Date;
import java.sql.Timestamp;

@Data
public class MemberRequestsDto {
    private int ridx;
    private int category;
    private int midx;
    @NotNull
    private String title;
    @NotNull
    private String content;
    private Date startdate;
    private Date enddate;
    private int status; //처리상태(1.대기중 2.처리중...)
    private int fidx;
    @NotNull
    private int confirm_midx;
    private Timestamp confirmdate;
    private Timestamp writedate;
    private String deleteyn;
    private int loopnum; // 번호를 위한 변수

    private String name;

    //조인
    private String mname;
    private String mposition;
    private String cname;
    private String cposition;
    private String path;
    private String originalname;
}