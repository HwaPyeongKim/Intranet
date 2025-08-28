package com.example.intranet.dto;

import lombok.Data;

import java.sql.Timestamp;
import java.util.Date;

@Data
public class MemberDto {
    private int midx;
    private String userid;
    private String name;
    private int level;
    private int team;
    private String position;
    private String pwd;
    private String number;
    private String email;
    private String phone;
    private int image;
    private String postcode;
    private String address1;
    private String address2;
    private Timestamp joindate;
    private Timestamp leavedate;
    private String confirmyn;
    private String deleteyn;
    private int loopnum; // 번호를 위한 변수

    private String teamname; // team 테이블 조인
}