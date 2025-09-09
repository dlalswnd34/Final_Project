package com.simplecoding.cheforest.member.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SocialUserInfo {

    private String socialId;     // 소셜 고유 식별자 (카카오 id, 구글 sub, 네이버 id)
    private String email;        // 이메일 (없을 수도 있음 → Optional 처리 가능)
    private String nickname;     // 닉네임
    private String profileImage; // 프로필 이미지 URL
    private String provider;     // 소셜 제공자: "KAKAO", "GOOGLE", "NAVER"
}
