package com.example.intranet.dao;

import com.example.intranet.dto.BoardDto;
import com.example.intranet.dto.Paging;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IBoardDao {

    ArrayList<BoardDto> select();
    BoardDto selectOne(int bidx);
    void insert(BoardDto boarddto);
    int getAllCount();
    boolean addRead(int bidx, int midx, String reader);
    void delete(int bidx);
    BoardDto checkBoardPwd(int bidx, String pwd);
}