package com.example.intranet.service;

import com.example.intranet.dao.IAdminDao;
import com.example.intranet.dto.MemberDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {

    @Autowired
    IAdminDao adao;

    public void confirmJoin(String[] midxes) {
        for(String midx : midxes){
            adao.confirmJoin(midx);
        }
    }
    public void updateMember(MemberDto memberdto) {
        adao.updateMember(memberdto);
    }
}