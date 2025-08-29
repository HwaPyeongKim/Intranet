package com.example.intranet.dao;

import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.MemberRequestsDto;
import com.example.intranet.dto.WorkDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IMypageDao {
    ArrayList<WorkDto> selectWork(String type, String key, String sort, String dir, int midx);
    ArrayList<MemberRequestsDto> selectRequests(String type, String key, String sort, String dir, int midx);
    void insertRequests(MemberRequestsDto mrdto);
    ArrayList<MemberDto> selectConfirm(int midx);
}