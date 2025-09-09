package com.simplecoding.cheforest.member.entity;

import com.simplecoding.cheforest.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "MEMBER",
        uniqueConstraints = {
                @UniqueConstraint(name = "UK_MEMBER_ID", columnNames = "ID"),
                @UniqueConstraint(name = "UK_MEMBER_NICKNAME", columnNames = "NICKNAME"),
                @UniqueConstraint(name = "UK_MEMBER_KAKAO_ID", columnNames = "KAKAO_ID")
        })
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MEMBER_IDX")
    private Long memberIdx;  // PK

    @Column(name = "ID", length = 50, nullable = false)
    private String id;  // 로그인 ID (Unique)

    @Column(name = "PASSWORD", nullable = false, length = 100)
    private String password;

    @Column(name = "EMAIL", length = 100)
    private String email;

    // 내부 enum (필요 시 별도 파일로 분리 가능)
    public enum Role {
        USER, ADMIN
    }

    @Enumerated(EnumType.STRING)
    @Column(name = "ROLE", length = 10, nullable = false)
    private Role role;  // USER / ADMIN

    @Column(name = "NICKNAME", length = 50, nullable = false)
    private String nickname;

    @Column(name = "PROFILE", length = 300)
    private String profile;

    @Column(name = "TEMP_PASSWORD_YN", length = 1, nullable = false)
    private String tempPasswordYn = "N";  // 기본값 N

    @Column(name = "SOCIAL_ID", length = 100)
    private String socialId;   // 카카오, 구글, 네이버 식별자

    @Column(name = "PROVIDER", length = 20)
    private String provider;   // "KAKAO", "GOOGLE", "NAVER"
}
