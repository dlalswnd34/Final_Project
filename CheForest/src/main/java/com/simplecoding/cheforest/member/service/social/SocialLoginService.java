package com.simplecoding.cheforest.member.service.social;

import com.simplecoding.cheforest.member.dto.SocialUserInfo;

public interface SocialLoginService {
    // 인가코드(code) → 액세스 토큰
    String getAccessToken(String code);

    // 액세스 토큰 → 사용자 정보
    SocialUserInfo getUserInfo(String accessToken);
}
