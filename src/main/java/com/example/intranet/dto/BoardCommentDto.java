package com.example.intranet.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class BoardCommentDto {
    private int bcidx;
    private int bidx;
    private int midx;
    private String content;
    private Timestamp writedate;
    private String deleteyn;
    private int loopnum; // 번호를 위한 변수
}