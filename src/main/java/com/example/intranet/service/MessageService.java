package com.example.intranet.service;

import com.example.intranet.dao.IMessageDao;
import com.example.intranet.dto.MessageDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MessageService {

    @Autowired
    IMessageDao msdao;

    public void sendMessage(MessageDto message) {

        msdao.insertMessage(message);
    }


    public void deleteMessage(int msidx) {

        msdao.deleteMessage(msidx);

    }


    public ArrayList<MessageDto> getMessageReceive(int midx) {
        ArrayList<MessageDto> message = msdao.getMessageReceive(midx);
        return message;
    }

    public ArrayList<MessageDto> getMessageSent(int midx) {
        ArrayList<MessageDto> message = msdao.getMessageSent(midx);
        return message;
    }




    public MessageDto getMessageReceiveView(int msidx) {
        return msdao.getMessageReceiveView(msidx);

    }

    public MessageDto getMessageSentView(int msidx) {
        return msdao.getMessageSentView(msidx); // 리턴 필요

    }

    public List<MessageDto> getMessages(int userId) {
        return msdao.getMessage(userId);
    }
}
