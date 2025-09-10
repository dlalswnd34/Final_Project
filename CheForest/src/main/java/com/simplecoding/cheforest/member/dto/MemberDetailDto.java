package com.simplecoding.cheforest.member.dto;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberDetailDto {
    private Long memberIdx;
    private String id;
    private String email;
    private String nickname;
    private String profile;
    private String role;
    private String tempPasswordYn;

    // 시간 필드 (BaseTimeEntity 매핑)
    private LocalDateTime insertTime;  // 가입일
    private LocalDateTime updateTime;  // 최근 수정일

    // 소셜 로그인 추가 필드
    private String socialId;
    private String provider;
}
