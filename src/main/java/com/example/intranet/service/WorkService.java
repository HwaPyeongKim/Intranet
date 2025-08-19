package com.example.intranet.service;

import com.example.intranet.dao.IWorkDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WorkService {

    @Autowired
    IWorkDao wdao;
}
