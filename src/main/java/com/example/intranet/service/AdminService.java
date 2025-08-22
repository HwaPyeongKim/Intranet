package com.example.intranet.service;

import com.example.intranet.dao.IAdminDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {

    @Autowired
    IAdminDao adao;

}