package com.example.intranet.dao;

import com.example.intranet.dto.MemberDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminDao {
    void confirmJoin(String midx);
    void updateMember(MemberDto memberdto);
}