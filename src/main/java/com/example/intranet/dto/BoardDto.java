package com.example.intranet.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class BoardDto {
    private int bidx;
    private String category;
    private String title;
    private String content;
    private String pwd;
    private Integer fidx;
    private int midx;
    private Timestamp updatedate;
    private Timestamp writedate;
    private int readcount;
    private String reader;
    private String noticeyn;
    private String showyn;
    private String deleteyn;
    private int loopnum; // 번호를 위한 변수

    private String name; // member 테이블 조인
    private String originalname; // file 테이블 조인
    private String path; // file 테이블 조인
    private int comment_count; // board_comment 조인
}