package com.example.intranet.dao;

import com.example.intranet.dto.BoardDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IBoardDao {

    ArrayList<BoardDto> select();
}