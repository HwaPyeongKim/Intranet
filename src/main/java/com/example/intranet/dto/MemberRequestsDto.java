package com.example.intranet.dto;

import lombok.Data;

import java.sql.Date;
import java.sql.Timestamp;

@Data
public class MemberRequestsDto {
    private int midx;
    private String type;
    private String time;
    private Date startdate;
    private Date enddate;
    private String reason;
    private int status;
    private String confirmyn;
    private String confirm_midx;
    private Timestamp confirmdate;
    private Timestamp writedate;
    private String deleteyn;
    private int loopnum; // 번호를 위한 변수
}