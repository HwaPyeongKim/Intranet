package com.example.intranet.dao;

import com.example.intranet.dto.Paging;
import com.example.intranet.dto.WorkDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IWorkDao {
    ArrayList<WorkDto> selectWork(Paging paging, String key, int midx);

    int getAllCountForWork(String key, int midx);

    ArrayList<WorkDto> selectYourWork(Paging paging, String key, int midx);

    int getAllCountForYourWork(String key, int midx);

    void insert(WorkDto workdto);
}
