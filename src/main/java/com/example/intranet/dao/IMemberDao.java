package com.example.intranet.dao;

import com.example.intranet.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface IMemberDao {
    void insert(MemberDto memberdto);
    MemberDto getMember(String userid);
    MemberDto selectMember(int midx);
    void insertAttendance(int midx);
    void workout(int midx, String date);
    MemberAttendanceDto selectAttendance(int midx, String date);
    MemberAttendanceDto checkWorkout(int midx, String date);
    ArrayList<MemberDto> getAllMembers();
    MemberDto checkPwd(String userid, String pwd);
    void update(MemberDto memberdto);
    void changePwd(int midx, String pwd);
    ArrayList<MemberDto> selectMembers(String type, String key, String sort, int midx, int level);
    int checkNewMessage(int midx);
    ArrayList<MemberAttendanceDto> selectMemberAttendances(String type, String key, String sort, int midx, int level, String startdate, String enddate);



    //@@@@@@@main
    MemberAttendanceDto selectInOutTime(int midx, String today);

    List<MemberRequestsDto> selectMyReqList(int midx);

    List<WorkDto> selectMyWorkList(int midx);


    BoardDto selectMainNotice();
}