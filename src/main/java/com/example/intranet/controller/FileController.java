package com.example.intranet.controller;

import com.example.intranet.dto.FileDto;
import com.example.intranet.service.FileService;
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
    ServletContext context;


    @PostMapping("/fileup")
    @ResponseBody
    public HashMap<String, Object> fileup(@RequestParam("imgPrev") MultipartFile file, HttpServletRequest request, Model model){
        HashMap<String, Object> result = new HashMap<String, Object>();

        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String path = context.getRealPath("/images/"+date);
        File folder = new File(path);
        if (!folder.exists()){
            folder.mkdirs();
        }

        String filename = file.getOriginalFilename();
        long size = file.getSize();
        FileDto fdto = new FileDto();
        fdto.setOriginalname(filename);
        fdto.setPath(path);
        fdto.setSize((int) size);
        fs.insert(fdto);
        int fidx = fdto.getFidx();

        String uploadPath = path + "/" + filename;
        try {
            file.transferTo(new File(uploadPath));
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        result.put("fidx", fidx);
        result.put("filename", filename);
        result.put("url", "/images/"+date+"/"+filename);

        return result;
    }
}