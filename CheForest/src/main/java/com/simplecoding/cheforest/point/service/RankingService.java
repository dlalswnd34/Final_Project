package com.simplecoding.cheforest.point.service;

import com.simplecoding.cheforest.auth.entity.Member;
import com.simplecoding.cheforest.auth.repository.MemberRepository;
import com.simplecoding.cheforest.point.entity.MemberGrade;
import com.simplecoding.cheforest.point.repository.MemberGradeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class RankingService {

    private final MemberRepository memberRepository;
    private final MemberGradeRepository memberGradeRepository;

    // 상위 10명 랭킹
    public List<Member> getTopRanking(int limit) {
        return memberRepository.findTop10ByOrderByPointDesc();
    }

    // 내 순위
    public Long getMyRank(Member member) {
        return memberRepository.findMyRank(member.getPoint());
    }

    // 회원 등급 조회
    public String getMemberGrade(Long point) {
        MemberGrade grade = memberGradeRepository.findGradeByPoint(point);
        return (grade != null) ? grade.getName() : "등급없음";
    }
}
