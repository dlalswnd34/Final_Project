package com.simplecoding.cheforest.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

    @Value("${spring.security.oauth2.client.registration.kakao.client-id}")
    private String kakaoClientId;

    @Override
    public void onLogoutSuccess(HttpServletRequest request,
                                HttpServletResponse response,
                                Authentication authentication) throws IOException {

        // ✅ 세션에 저장된 provider (LOCAL, KAKAO, GOOGLE, NAVER)
        String provider = (String) request.getSession().getAttribute("provider");

        // ✅ 기본 redirect (Referer > 홈)
        String redirectUrl = request.getHeader("Referer");
        if (redirectUrl == null || redirectUrl.contains("/auth")) {
            redirectUrl = "/";
        }

        // ✅ 소셜 로그아웃 URL
        String providerLogoutUrl = null;
        if ("KAKAO".equalsIgnoreCase(provider)) {
            providerLogoutUrl =
                    "https://kauth.kakao.com/oauth/logout"
                            + "?client_id=" + kakaoClientId
                            + "&logout_redirect_uri=" + redirectUrl;
        } else if ("GOOGLE".equalsIgnoreCase(provider)) {
            providerLogoutUrl = "https://accounts.google.com/Logout";
        } else if ("NAVER".equalsIgnoreCase(provider)) {
            providerLogoutUrl = "https://nid.naver.com/nidlogin.logout";
        }

        // ✅ 세션 무효화
        request.getSession().invalidate();

        // ✅ Provider 로그아웃 → 없으면 redirectUrl
        if (providerLogoutUrl != null) {
            response.sendRedirect(providerLogoutUrl);
        } else {
            response.sendRedirect(redirectUrl);
        }
    }
}
