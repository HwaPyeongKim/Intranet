package com.example.intranet.controller;

import com.example.intranet.dto.FileDto;
import com.example.intranet.service.FileService;
import com.example.intranet.service.S3UploadService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.HashMap;

@Controller
public class FileController {

    @Autowired
    FileService fs;

    @Autowired
    S3UploadService sus;

    @Autowired
    ServletContext context;


    @PostMapping("/imgup")
    @ResponseBody
    public HashMap<String, Object> imgup(@RequestParam("imgPrev") MultipartFile file, HttpServletRequest request, Model model){
        HashMap<String, Object> result = new HashMap<String, Object>();

        HashMap<String, Object> s3file = null;
        try {
            s3file = sus.saveFile(file);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

//        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
//        String path = context.getRealPath("/images/"+date);
//        File folder = new File(path);
//        if (!folder.exists()){
//            folder.mkdirs();
//        }
//
//        String filename = file.getOriginalFilename();
//        long size = file.getSize();
//        FileDto fdto = new FileDto();
//        fdto.setOriginalname(filename);
//        // fdto.setPath(path);
//        fdto.setPath("/images/"+date+"/"+filename);
//        fdto.setSize((int) size);
//        fs.insert(fdto);
//        int fidx = fdto.getFidx();
//
//        String uploadPath = path + "/" + filename;
//        try {
//            file.transferTo(new File(uploadPath));
//        } catch (IllegalStateException e) {
//            e.printStackTrace();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }

        result.put("fidx", s3file.get("fidx"));
        result.put("filename", s3file.get("filename"));
        result.put("url", s3file.get("url"));

        return result;
    }

    @PostMapping("/fileup")
    @ResponseBody
    public HashMap<String, Object> fileup(@RequestParam("file") MultipartFile file, HttpServletRequest request, Model model){
        HashMap<String, Object> result = new HashMap<String, Object>();

        HashMap<String, Object> s3file = null;
        try {
            s3file = sus.saveFile(file);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

//        String filename = file.getOriginalFilename();
//        long size = file.getSize();
//        FileDto fdto = new FileDto();
//        fdto.setOriginalname(filename);
//        // fdto.setPath(path);
//        fdto.setPath("/files/"+date+"/"+filename);
//        fdto.setSize((int) size);
//        fs.insert(fdto);
//        int fidx = fdto.getFidx();
//
//        String uploadPath = path + "/" + filename;
//        try {
//            file.transferTo(new File(uploadPath));
//        } catch (IllegalStateException e) {
//            e.printStackTrace();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }

        result.put("fidx", s3file.get("fidx"));
        result.put("filename", s3file.get("filename"));
        result.put("url", s3file.get("url"));

        return result;
    }
}