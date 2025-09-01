package com.example.intranet.dao;

import com.example.intranet.dto.Paging;
import com.example.intranet.dto.WorkCommentDto;
import com.example.intranet.dto.WorkDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IWorkDao {
    ArrayList<WorkDto> selectWork(String type, String key, String sort, String dir, int midx);

//    int getAllCountForWork(String key, int midx);

    ArrayList<WorkDto> selectYourWork(String type, String key, String sort, String dir, int midx);

//    int getAllCountForYourWork(String key, int midx);

    void insert(WorkDto workdto);

    Object getWork(int widx);

    WorkDto selectOne(int widx);

    ArrayList<WorkCommentDto> selectComments(int widx);

    void delete(int widx);

    void update(WorkDto workdto);

    void insertComment(int widx, int midx, String content, String autoyn);

    void updateComment(int wcidx, String content);

    void deleteComment(int wcidx);

    void changeStatus(int widx, int status, int next);
    
    //  일정관리 수정중 추가
    WorkDto getRecentWork(int midx);

    WorkDto myCompleteWork(int midx);

    void updateCompletedate(int widx);
}
