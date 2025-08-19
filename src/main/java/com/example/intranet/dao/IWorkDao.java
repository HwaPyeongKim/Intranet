package com.example.intranet.dao;

import com.example.intranet.dto.WorkDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IWorkDao {


    ArrayList<WorkDto> selectWorkList();
}