package com.simplecoding.cheforest.point.repository;

import com.simplecoding.cheforest.point.entity.MemberGrade;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MemberGradeRepository extends JpaRepository<MemberGrade, Long> {

    // 현재 포인트가 속하는 등급
    @Query("SELECT g FROM MemberGrade g " +
            "WHERE g.minPoint <= :point " +
            "AND (g.maxPoint IS NULL OR g.maxPoint >= :point)")
    MemberGrade findGradeByPoint(@Param("point") Long point);

    // 다음 등급 (없으면 최고 등급)
    @Query("SELECT g FROM MemberGrade g " +
            "WHERE g.minPoint > :point " +
            "ORDER BY g.minPoint ASC")
    List<MemberGrade> findNextGrades(@Param("point") Long point);

    // 모든 등급을 순서대로 조회
    List<MemberGrade> findAllByOrderByMinPointAsc();
}
