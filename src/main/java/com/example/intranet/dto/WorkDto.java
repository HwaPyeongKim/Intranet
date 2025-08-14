package com.example.intranet.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class WorkDto {
    private int widx;
    private int midx;
    private int worker;
    private String fidx;
    private String title;
    private String content;
    private int status;
    private Timestamp writedate;
    private Timestamp completedate;
    private String deleteyn;
    private int loopnum; // 번호를 위한 변수
}