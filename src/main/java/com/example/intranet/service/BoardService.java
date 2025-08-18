package com.example.intranet.service;

import com.example.intranet.dao.IBoardDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class BoardService {

    @Autowired
    IBoardDao bdao;

    public HashMap<String, Object> selectProduct() {
        return bdao.selectProduct();
    }
}