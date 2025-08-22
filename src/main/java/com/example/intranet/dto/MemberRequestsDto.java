package com.example.intranet.dto;

import lombok.Data;

import java.sql.Date;
import java.sql.Timestamp;

@Data
public class MemberRequestsDto {
    private int ridx;
    private int category;
    private int midx;
    private String title;
    private String content;
    private Date startdate;
    private Date enddate;
    private int status;
    private int fidx;
    private String confirm_midx;
    private Timestamp confirmdate;
    private Timestamp writedate;
    private String deleteyn;
    private int loopnum; // 번호를 위한 변수

    private String name;
    private String cname;
}