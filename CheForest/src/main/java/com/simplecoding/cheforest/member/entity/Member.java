package com.simplecoding.cheforest.member.entity;

import com.simplecoding.cheforest.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "MEMBER")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor @Builder
public class Member extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "MEMBER_SEQ")
    @SequenceGenerator(name = "MEMBER_SEQ", sequenceName = "MEMBER_SEQ", allocationSize = 1)
    @Column(name = "MEMBER_IDX")
    private Long memberIdx;

    @Column(name = "ID", nullable = false, unique = true)
    private String id;

    @Column(name = "EMAIL", nullable = false)
    private String email;

    @Column(name = "PASSWORD", nullable = false)
    private String password;

    @Column(name = "ROLE")
    private String role;

    @Column(name = "NICKNAME")
    private String nickname;

    @Column(name = "JOIN_DATE")
    private LocalDateTime joinDate;

    @Column(name = "PROFILE")
    private String profile;
}
