package com.example.intranet.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class WorkCommentDto {
    private int wcidx;
    private int widx;
    private int midx;
    private String content;
    private String autoyn;
    private Timestamp writedate;
    private String deleteyn;
    private int loopnum; // 번호를 위한 변수

    private String name; // member 테이블 조인
}
