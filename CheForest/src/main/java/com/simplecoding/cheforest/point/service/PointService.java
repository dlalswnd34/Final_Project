package com.simplecoding.cheforest.point.service;

import com.simplecoding.cheforest.auth.entity.Member;
import com.simplecoding.cheforest.auth.repository.MemberRepository;
import com.simplecoding.cheforest.point.entity.MemberGrade;
import com.simplecoding.cheforest.point.entity.PointHistory;
import com.simplecoding.cheforest.point.repository.MemberGradeRepository;
import com.simplecoding.cheforest.point.repository.PointHistoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class PointService {

    private final PointHistoryRepository pointHistoryRepository;
    private final MemberRepository memberRepository;
    private final MemberGradeRepository memberGradeRepository;

    // ✅ 포인트 적립 + 등급 자동 갱신
    public void addPoint(Member member, String actionType, Long point) {
        // 1. 포인트 이력 저장
        PointHistory history = new PointHistory();
        history.setMember(member);
        history.setActionType(actionType);
        history.setPoint(point);
        pointHistoryRepository.save(history);

        // 2. 누적 포인트 갱신
        Long newPoint = member.getPoint() + point;
        member.setPoint(newPoint);

        // 3. 등급 갱신
        MemberGrade grade = memberGradeRepository.findGradeByPoint(newPoint);
        if (grade != null) {
            member.setGrade(grade.getName());
        }

        memberRepository.save(member);
    }

    // ✅ 오늘 포인트 합산
    @Transactional(readOnly = true)
    public Long getTodayPoints(Long memberId) {
        return pointHistoryRepository.sumTodayPoints(memberId);
    }

    // ✅ 이번 주 포인트 합산
    @Transactional(readOnly = true)
    public Long getWeekPoints(Long memberId) {
        LocalDate today = LocalDate.now();
        LocalDateTime weekStart = today.with(java.time.DayOfWeek.MONDAY).atStartOfDay();
        LocalDateTime weekEnd = today.with(java.time.DayOfWeek.SUNDAY).atTime(LocalTime.MAX);
        return pointHistoryRepository.sumPointsInPeriod(memberId, weekStart, weekEnd);
    }

    // ✅ 다음 등급까지 남은 점수
    @Transactional(readOnly = true)
    public Long getNextGradePoint(Long currentPoint) {
        MemberGrade nextGrade = memberGradeRepository.findNextGrades(currentPoint)
                .stream().findFirst().orElse(null);
        return (nextGrade != null) ? (nextGrade.getMinPoint() - currentPoint) : 0L;
    }

    // ✅ 최근 적립 내역 5개
    @Transactional(readOnly = true)
    public List<PointHistory> getRecentHistories(Long memberId) {
        return pointHistoryRepository.findTop5ByMember_MemberIdxOrderByInsertTimeDesc(memberId);
    }
}
