package com.example.intranet.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.example.intranet.dto.FileDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;

@Service
@RequiredArgsConstructor
public class S3UploadService {
    private final AmazonS3 amazonS3;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    @Autowired
    FileService fs;

    public HashMap<String, Object> saveFile(MultipartFile file) throws IOException {
        HashMap<String, Object> result = new HashMap<String, Object>();
        String filename = file.getOriginalFilename();

        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(file.getSize());
        metadata.setContentType(file.getContentType());

        amazonS3.putObject(bucket, filename, file.getInputStream(), metadata);

        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

        long size = file.getSize();
        FileDto fdto = new FileDto();
        fdto.setOriginalname(filename);
        fdto.setPath(amazonS3.getUrl(bucket, filename).toString());
        fdto.setSize((int) size);
        fs.insert(fdto);
        int fidx = fdto.getFidx();

        result.put("fidx", fidx);
        result.put("filename", filename);
        result.put("size", size);
        result.put("url", amazonS3.getUrl(bucket, filename).toString());

        return result;
    }
}