package com.simplecoding.cheforest.member.entity;

import com.simplecoding.cheforest.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "MEMBER")
@SequenceGenerator(
        name = "MEMBER_SEQ_JPA",
        sequenceName = "MEMBER_SEQ",
        allocationSize = 1
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "MEMBER_SEQ_JPA")
    private Long memberIdx;   // PK (DB 컬럼: MEMBERIDX 로 맞춰야 함)

    @Column(name = "ID", nullable = false, unique = true)
    private String loginId;  // 로그인 ID
    private String password;
    private String email;

    @Enumerated(EnumType.STRING)
    private Role role;        // USER / ADMIN

    private String nickname;
    private String profile;

    @Builder.Default
    private String tempPasswordYn = "N";  // 기본값 N

    private String socialId;   // 카카오, 구글, 네이버 식별자
    private String provider;   // "KAKAO", "GOOGLE", "NAVER"

    public enum Role {
        USER, ADMIN
    }
}
