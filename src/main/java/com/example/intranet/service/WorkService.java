package com.example.intranet.service;

import com.example.intranet.dao.IWorkDao;
import com.example.intranet.dto.WorkDto;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class WorkService {

    @Autowired
    IWorkDao wdao;

    public HashMap<String, Object> selectWorkList() {
        HashMap<String, Object> result = new HashMap<>();
        ArrayList<WorkDto> list = wdao.selectWorkList();
        result.put("workList", list);
        return result;

    }


}
