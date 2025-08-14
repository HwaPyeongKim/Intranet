package com.example.intranet.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class Schedule {
    private int sidx;
    private int midx;
    private String category;
    private String title;
    private String content;
    private Timestamp startdate;
    private Timestamp enddate;
    private Timestamp writedate;
    private String deleteyn;
    private int loopnum; // 번호를 위한 변수
}