package com.example.intranet.service;

import com.example.intranet.dao.IMemberDao;
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
}