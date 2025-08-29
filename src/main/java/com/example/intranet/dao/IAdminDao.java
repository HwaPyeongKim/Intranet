package com.example.intranet.dao;

import com.example.intranet.dto.MemberAttendanceDto;
import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.TeamDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface IAdminDao {
    void confirmJoin(String midx);
    void updateMember(MemberDto memberdto);
    void updateLeave(String midx, String leavedate);
    void updatePosition(String midx, String position);
    void updateLevel(String midx, String level);
    void updateAttendance(String maidx, String endtime);
    ArrayList<TeamDto> selectTeamMembers(String type, String key, int midx, int level);
    TeamDto checkTeamName(String name);
    void insertTeam(String name);
    ArrayList<MemberDto> selectMemberNoTeam();
    ArrayList<TeamDto> selectTeams(int tidx);
    ArrayList<TeamDto> selectTeamList();
    void addTeamMember(String midx, String tidx);
    String getTeamName(int tidx);
    MemberAttendanceDto getMemberAttendances(int maidx);
    ArrayList<MemberDto> selectMemberNoTeam(String type, String key);
    void deleteBoard(String bidx);
    void showBoard(String bidx, String showyn);
}