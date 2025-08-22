package com.example.intranet.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminDao {
    void confirmJoin(String midx);
}