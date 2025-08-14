package com.example.intranet.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class MessageDto {
    private int msidx;
    private int frommidx;
    private int tomidx;
    private String title;
    private String content;
    private String readyn;
    private Timestamp readdate;
    private Timestamp writedate;
    private String deleteyn;
    private int loopnum; // 번호를 위한 변수
}