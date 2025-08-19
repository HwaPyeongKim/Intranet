package com.example.intranet.service;

import com.example.intranet.dao.IFileDao;
import com.example.intranet.dto.FileDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FileService {

    @Autowired
    IFileDao fdao;

    public void insert(FileDto fdto) {
        fdao.insert(fdto);
    }

    public FileDto getFile(int image) {
        return fdao.getFile(image);
    }
}