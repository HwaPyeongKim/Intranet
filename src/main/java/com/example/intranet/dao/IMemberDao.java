package com.example.intranet.dao;

import com.example.intranet.dto.MemberDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMemberDao {
    void insert(MemberDto memberdto);
}