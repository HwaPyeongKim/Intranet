package com.example.intranet.controller.calendar;

import com.example.intranet.service.calendar.CalendarService;
import com.example.intranet.dto.calendar.CalendarDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Controller
public class CalendarController {
    // 원본 https://greed-yb.tistory.com/274
    // /calendar 에 접속하면 달력 테스트 가능
    /*
        수정사항
        패키지명 변경
        RestController -> Controller 로 바꿈
        그에 따라 각 메소드에 ResponseBody 어노테이션 붙임
    */

    @GetMapping("/calendar")
    public String calendar(){
        return "calendar/calendar";
    }


    @Autowired
    private CalendarService calendarService;

    /**
     * 캘린더 일정 조회하기
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping("/calendarList")
    public List<CalendarDto> calendarList() throws Exception{
        List<CalendarDto> vo = calendarService.calendarList();

        return vo;
    }

    /**
     * 캘린더 일정 추가하기
     * @param map
     * @return
     * @throws Exception
     */
    @ResponseBody
    @PostMapping("/calendarSave")
    public CalendarDto calendarSave(@RequestBody Map<String, Object> map) throws Exception {

        CalendarDto vo = new CalendarDto();
        vo.setTitle((String) map.get("title"));

        // UTC 시간을 LocalDateTime으로 변환
        DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE_TIME;
        ZonedDateTime startUTC = ZonedDateTime.parse((String) map.get("start"), formatter).withZoneSameInstant(ZoneId.of("Asia/Seoul"));
        ZonedDateTime endUTC = map.get("end") != null ? ZonedDateTime.parse((String) map.get("end"), formatter).withZoneSameInstant(ZoneId.of("Asia/Seoul")) : null;

        // 한국 시간으로 변환하여 저장
        vo.setStart1(startUTC.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        vo.setEnd(endUTC != null ? endUTC.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) : null);
        vo.setAllDay((Boolean) map.get("allDay"));

        // 저장한 일정의 key 값을 포함한 데이터를 다시 반환
        calendarService.calendarSave(vo);

        return vo;
    }

    /**
     * 캘린더 일정 삭제하기
     * @param no
     * @return
     * @throws Exception
     */
    @ResponseBody
    @DeleteMapping("/calendarDelete")
    public String calendarDelete(@RequestParam String no) throws Exception{
        try{
            calendarService.calendarDelete(no);
            return "success";
        }catch (Exception e){
            e.printStackTrace();
            return "fail";
        }
    }


    /**
     * 캘린더 일정 수정하기
     * @param no
     * @param map
     * @return
     */
    @ResponseBody
    @PutMapping("/eventUpdate/{no}")
    public String eventUpdate(@PathVariable String no, @RequestBody Map<String, Object> map){

        CalendarDto vo = new CalendarDto();
        vo.setCalendarNo(Long.valueOf(no));
        vo.setTitle((String) map.get("title"));
        vo.setStart1(map.get("start1").toString().substring(0, 19));
        if(map.get("end") != null){
            vo.setEnd(map.get("end").toString().substring(0, 19));
        }
        vo.setAllDay((Boolean) map.get("allDay"));

        try {
            calendarService.eventUpdate(vo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

}