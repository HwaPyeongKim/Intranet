package com.example.intranet.service;

import com.example.intranet.dao.IWorkDao2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WorkService2 {

    @Autowired
    IWorkDao2 wdao;
}
