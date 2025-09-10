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
@SequenceGenerator(
        name = "MEMBER_SEQ_JPA",
        sequenceName = "MEMBER_SEQ",  // 실제 DB 시퀀스 이름
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
    private Long memberIdx;  // PK

    private String id;        // 로그인 ID (Unique)
    private String password;
    private String email;

    public enum Role {
        USER, ADMIN
    }

    @Enumerated(EnumType.STRING)
    private Role role;        // USER / ADMIN

    private String nickname;
    private String profile;

    @Builder.Default
    private String tempPasswordYn = "N";  // 기본값 N
    private String socialId;   // 카카오, 구글, 네이버 식별자
    private String provider;   // "KAKAO", "GOOGLE", "NAVER"
}
