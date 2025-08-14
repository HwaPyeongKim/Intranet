package com.example.intranet.dto;

import lombok.Data;

import java.sql.Date;
import java.sql.Timestamp;

@Data
public class MemberAttendanceDto {
    private int midx;
    private Date date;
    private Timestamp starttime;
    private Timestamp endtime;
    private int loopnum; // 번호를 위한 변수
}