package com.example.intranet.service;

import com.example.intranet.dao.IMemberDao;
import com.example.intranet.dto.MemberAttendanceDto;
import com.example.intranet.dto.MemberDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

    @Autowired
    IMemberDao mdao;

    public void insert(MemberDto memberdto) {
        mdao.insert(memberdto);
    }
    public MemberDto getMember(String userid) {
        return mdao.getMember(userid);
    }
    public void insertAttendance(int midx) {
        mdao.insertAttendance(midx);
    }
    public void workout(int midx, String date) {
        mdao.workout(midx,date);
    }
    public MemberAttendanceDto selectAttendance(int midx, String date) {
        return mdao.selectAttendance(midx,date);
    }
    public MemberAttendanceDto checkWorkout(int midx, String date) {
        return mdao.checkWorkout(midx,date);
    }
}