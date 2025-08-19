package com.example.intranet.dao;

import com.example.intranet.dto.FileDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IFileDao {
    void insert(FileDto fdto);
    FileDto getFile(int image);
}