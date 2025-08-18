package com.example.intranet.dao;

import com.example.intranet.dto.MemberAttendanceDto;
import com.example.intranet.dto.MemberDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMemberDao {
    void insert(MemberDto memberdto);
    MemberDto getMember(String userid);
    void insertAttendance(int midx);
    void workout(int midx, String date);
    MemberAttendanceDto selectAttendance(int midx, String date);
    MemberAttendanceDto checkWorkout(int midx, String date);
}