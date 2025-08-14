package com.example.intranet.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class MemberDto {
    private int midx;
    private String name;
    private int level;
    private int team;
    private String position;
    private String pwd;
    private String number;
    private String email;
    private String phone;
    private String image;
    private String postcode;
    private String address1;
    private String address2;
    private Timestamp joindate;
    private Timestamp leavedate;
    private String confirmyn;
    private String deleteyn;
    private int loopnum; // 번호를 위한 변수
}