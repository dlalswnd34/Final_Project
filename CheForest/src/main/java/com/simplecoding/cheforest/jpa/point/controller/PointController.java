package com.simplecoding.cheforest.jpa.point.controller;

import com.simplecoding.cheforest.jpa.auth.entity.Member;
import com.simplecoding.cheforest.jpa.auth.security.AuthUser;
import com.simplecoding.cheforest.jpa.point.service.PointService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.format.DateTimeFormatter;

@Controller
@RequiredArgsConstructor
public class PointController {

    private final PointService pointService;

    @GetMapping("/grade")
    public String gradePage(@AuthenticationPrincipal Object principal, Model model) {

        if (principal instanceof AuthUser authUser) { // ✅ 통합 처리 (일반+소셜)
            Member member = authUser.getMember();

            if (member != null) {
                // ✅ 오늘 포인트/남은 포인트 계산
                Long todayPoints = pointService.getTodayPoints(member.getMemberIdx());
                Long nextGradePoint = pointService.getNextGradePoint(member.getPoint());

                // ✅ JSP 전달용
                model.addAttribute("m", member);
                model.addAttribute("todayPoints", todayPoints);
                model.addAttribute("nextGradePoint", nextGradePoint);

                // ✅ 가입일 표시
                if (member.getInsertTime() != null) {
                    String joinDate = member.getInsertTime()
                            .format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));
                    model.addAttribute("joinDate", joinDate);
                } else {
                    model.addAttribute("joinDate", "-");
                }
            }
        }

        return "grade";
    }
}
