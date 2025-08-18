package com.example.intranet.dao;

import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;

@Mapper
public interface IBoardDao {
    HashMap<String, Object> selectProduct();
}
