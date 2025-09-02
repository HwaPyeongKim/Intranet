package com.example.intranet.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.sql.Timestamp;

@Data
public class WorkDto {
    private int widx;
    private int midx;
    private int worker;
    private String fidx;
    @NotEmpty(message="업무명을 입력하세요")    @NotNull(message="업무명을 입력하세요")
    private String title;
    @NotEmpty(message="내용을 입력하세요")    @NotNull(message="내용을 입력하세요")
    private String content;
    private int status;
    private Timestamp writedate;
    private Timestamp deadline;
    private Timestamp completedate;
    private String deleteyn;
    private int loopnum;// 번호를 위한 변수

    private String empname;
    private String workername;

    private String originalname; // file 테이블 조인
    private String path; // file 테이블 조인
    private int comment_count; // board_comment 조인
    private Timestamp ddate;

    private int totalCount;
    private int completeCount;
}