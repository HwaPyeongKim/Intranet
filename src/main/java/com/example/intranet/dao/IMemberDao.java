package com.example.intranet.dao;

import com.example.intranet.dto.MemberAttendanceDto;
import com.example.intranet.dto.MemberDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IMemberDao {
    void insert(MemberDto memberdto);
    MemberDto getMember(String userid);
    void insertAttendance(int midx);
    void workout(int midx, String date);
    MemberAttendanceDto selectAttendance(int midx, String date);
    MemberAttendanceDto checkWorkout(int midx, String date);

    ArrayList<MemberDto> getAllMembers();
}