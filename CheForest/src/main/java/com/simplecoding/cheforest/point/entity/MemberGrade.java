package com.simplecoding.cheforest.point.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "MEMBER_GRADE")
@SequenceGenerator(
        name = "MEMBER_GRADE_JPA",
        sequenceName = "MEMBER_GRADE_SEQ",
        allocationSize = 1
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MemberGrade {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "MEMBER_GRADE_JPA")
    private Long gradeId;   // PK

    private String name;    // 등급명 (씨앗, 뿌리, 새싹, 나무, 숲)
    private Long minPoint;   // 최소 포인트
    private Long maxPoint;   // 최대 포인트 (숲 등급은 NULL 가능)
}
