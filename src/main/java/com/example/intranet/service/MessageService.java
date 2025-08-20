package com.example.intranet.service;

import com.example.intranet.dao.IMessageDao;
import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.MessageDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class MessageService {

    @Autowired
    IMessageDao msdao;

    public void sendMessage(MessageDto message) {

        msdao.insertMessage(message);
    }

    public List<MessageDto> getMessages(int userId) {

        return msdao.getMessagesByUser(userId);
    }

    public MessageDto getMessage(int msidx) {
        MessageDto message = msdao.getMessageById(msidx);
        if ("N".equals(message.getReadyn())) {
            msdao.updateReadStatus(msidx);
            message.setReadyn("Y");
        }
        return message;
    }

    public void deleteMessage(int msidx) {

        msdao.deleteMessage(msidx);
    }


    public List<MemberDto> getAllMembers() {
        return msdao.getAllMembers();
    }
}
