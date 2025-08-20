package com.example.intranet.dao;

import com.example.intranet.dto.BoardCommentDto;
import com.example.intranet.dto.BoardDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IBoardDao {

    ArrayList<BoardDto> select();
    BoardDto selectOne(int bidx);
    void insert(BoardDto boarddto);
    boolean addRead(int bidx, int midx, String reader);
    void delete(int bidx);
    BoardDto checkBoardPwd(int bidx, String pwd);
    ArrayList<BoardDto> selectNotice();
    ArrayList<BoardDto> select(String type, String key, String sort);
    void update(BoardDto boarddto);
    ArrayList<BoardCommentDto> selectComments(int bidx);
    void insertComment(int bidx, int midx, String content);
    void updateComment(int bcidx, String content);
    void deleteComment(int bcidx);
}