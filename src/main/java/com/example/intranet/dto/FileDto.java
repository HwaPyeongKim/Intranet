package com.example.intranet.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class FileDto {
    private int fidx;
    private String title;
    private String path;
    private int size;
    private String extension;
    private Timestamp writedate;
    private int loopnum; // 번호를 위한 변수
}