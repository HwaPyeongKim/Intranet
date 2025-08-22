package com.example.intranet.dao;

import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.MemberRequestsDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface IRequestsDao {

    ArrayList<MemberRequestsDto> selectRequestsList(int midx);

    void insertRquests(MemberRequestsDto requestsdto);

    MemberRequestsDto selectRequestsDetail(int ridx);

    List<MemberDto> getAllMembers();

    MemberDto getUser4(int confirm_midx);

    ArrayList<MemberRequestsDto> selectGetList(int midx);


    MemberRequestsDto selectGetDetail(int ridx);

    int updateChangeStatus(@Param("status") int status, @Param("ridx") int ridx);//@Param 없이 두 개 이상의 기본 타입 파라미터를 넘기면, MyBatis가 쿼리 매핑 시 이름을 못 찾아서 업데이트가 안 될 수 있어요.
}
