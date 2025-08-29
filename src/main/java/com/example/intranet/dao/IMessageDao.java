package com.example.intranet.dao;

import com.example.intranet.dto.MemberDto;
import com.example.intranet.dto.MessageDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface IMessageDao {
    // 메시지 작성

    void sendMessage(MessageDto message);

    // 특정 회원이 받은/보낸 메시지 목록
//    ArrayList<MessageDto> getMessageByUser(int userId);

    // 메시지 상세 조회
//    ArrayList<MessageDto> getMessageById(int msidx);

    // 읽음 처리
//    void updateReadStatus(int msidx);

    // 삭제 처리
    void todeleteMessage(int msidx);

    void fromdeleteMessage(int msidx);

//    List<MemberDto> getAllMembers();

//    ArrayList<MessageDto> getMessageReceive(int midx);

//    ArrayList<MessageDto> getMessageSent(int midx);

    MessageDto getMessageReceiveView(int msidx);

    MessageDto getMessageSentView(int msidx);

//    List<MessageDto> getMessage(int userId);

    void todeleteMessages(List<Integer> msidxList);

    void fromdeleteMessages(List<Integer> msidxList);

    ArrayList<MessageDto> selectSent(int midx, String type, String key, String sort);
    ArrayList<MessageDto> selectReceive(int midx, String type, String key, String sort);

    void updateReadyn(int msidx);
}




