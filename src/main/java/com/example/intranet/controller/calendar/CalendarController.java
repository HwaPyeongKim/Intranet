package com.example.intranet.controller.calendar;

import com.example.intranet.dto.FileDto;
import com.example.intranet.dto.MemberDto;
import com.example.intranet.service.FileService;
import com.example.intranet.service.calendar.CalendarService;
import com.example.intranet.dto.calendar.CalendarDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
        @RestController -> @Controller 로 바꿈
        그에 따라 각 메소드에 @ResponseBody 어노테이션 붙임
        일정조회, 일정추가 기능에 midx 추가, 이제 로그인 유저 전용 기능
    */

    @Autowired
    FileService fs;
    @Autowired
    private CalendarService calendarService;

    @GetMapping("/schedule") // 임시적 링크
    public String calendar(HttpSession session, Model model) {
        // String url = "member/login";
        if (session.getAttribute("loginUser") != null) {
            MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
            // FileDto fdto = fs.getFile(mdto.getImage());
            model.addAttribute("loginUser", mdto);
            // model.addAttribute("profileImg", fdto.getPath());
            // url = "calendar/calendar";

        }
        return "calendar/calendar";
    }

    /**
     * 캘린더 일정 조회하기
     *
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping("/calendarList")
    public List<CalendarDto> calendarList(HttpSession session) throws Exception {
        // 로그인 유저의 midx로 select
        List<CalendarDto> dto = null;
        if (session.getAttribute("loginUser") != null) {
            MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
            dto = calendarService.calendarList(mdto.getMidx());
        }
        return dto;
    }

    /**
     * 캘린더 일정 추가하기
     *
     * @param map
     * @return
     * @throws Exception
     */
    @ResponseBody
    @PostMapping("/calendarSave")
    public CalendarDto calendarSave(@RequestBody Map<String, Object> map, HttpSession session) throws Exception {

        CalendarDto dto = null;
        // 비로그인시 null이 리턴, if문에서 분기가 갈리게 됨
        if (session.getAttribute("loginUser") != null) {
            dto = new CalendarDto();
            dto.setTitle((String) map.get("title"));

            // 카테고리 1:개인, 2:부서, 3:회사
            // Dto 설정으로 카테고리를 입력할때 수정가능 여부와 색깔이 자동 입력됩니다.
            int category = Integer.parseInt((String) map.get("category"));
            dto.setCategory(category);

            // 일정 DB에 로그인 유저의 midx를 같이 insert
            MemberDto mdto = (MemberDto) session.getAttribute("loginUser");
            dto.setMidx(mdto.getMidx());

            // UTC 시간을 LocalDateTime으로 변환
            DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE_TIME;
            ZonedDateTime startUTC = ZonedDateTime.parse((String) map.get("start"), formatter).withZoneSameInstant(ZoneId.of("Asia/Seoul"));
            ZonedDateTime endUTC = map.get("end") != null ? ZonedDateTime.parse((String) map.get("end"), formatter).withZoneSameInstant(ZoneId.of("Asia/Seoul")) : null;

            // 한국 시간으로 변환하여 저장
            dto.setStart1(startUTC.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            dto.setEnd(endUTC != null ? endUTC.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) : null);
            dto.setAllDay((Boolean) map.get("allDay"));


            calendarService.calendarSave(dto);
        }

        // 저장한 일정의 key 값을 포함한 데이터를 다시 반환
        return dto;
    }

    /**
     * 캘린더 일정 삭제하기
     *
     * @param no
     * @return
     * @throws Exception
     */
    @ResponseBody
    @DeleteMapping("/calendarDelete")
    public String calendarDelete(@RequestParam String no) throws Exception {
        try {
            calendarService.calendarDelete(no);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }


    /**
     * 캘린더 일정 수정하기
     *
     * @param no
     * @param map
     * @return
     */
    @ResponseBody
    @PutMapping("/eventUpdate/{no}")
    public String eventUpdate(@PathVariable String no, @RequestBody Map<String, Object> map) {

        CalendarDto dto = new CalendarDto();
        dto.setCalendarNo(Long.valueOf(no));
        dto.setTitle((String) map.get("title"));
        dto.setStart1(map.get("start1").toString().substring(0, 19));
        if (map.get("end") != null) {
            dto.setEnd(map.get("end").toString().substring(0, 19));
        }
        dto.setAllDay((Boolean) map.get("allDay"));

        try {
            calendarService.eventUpdate(dto);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

}