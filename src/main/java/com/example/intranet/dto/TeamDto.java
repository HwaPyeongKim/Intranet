package com.example.intranet.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class TeamDto {
    private int tidx;
    private String name;
    private Timestamp writedate;
    private String deletyn;
    private int loopnum;
    private int rowspan;

    private String mname; // member 테이블 조인
    private String mposition; // member 테이블 조인
}
