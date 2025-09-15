package com.simplecoding.cheforest.config;

import com.simplecoding.cheforest.auth.entity.Member;
import com.simplecoding.cheforest.auth.repository.MemberRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Slf4j
@Component
@RequiredArgsConstructor
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    private final MemberRepository memberRepository;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException {
        Object principal = authentication.getPrincipal();
        Member member = null;

        // ✅ 일반 로그인
        if (principal instanceof UserDetails userDetails) {
            String loginId = userDetails.getUsername();
            member = memberRepository.findByLoginId(loginId).orElse(null);

            // 일반 로그인은 provider = LOCAL
            request.getSession().setAttribute("provider", "LOCAL");
        }

        // ✅ 소셜 로그인
        else if (principal instanceof OAuth2User oAuth2User) {
            String email = (String) oAuth2User.getAttributes().get("email");
            member = memberRepository.findByEmail(email).orElse(null);

            // ✅ 소셜 provider 세션 저장
            String provider = (String) oAuth2User.getAttributes().get("provider");
            if (provider != null) {
                request.getSession().setAttribute("provider", provider.toUpperCase());
            }
        }

        // ✅ 닉네임 중복 체크
        if (member != null && memberRepository.existsByNicknameAndMemberIdxNot(member.getNickname(), member.getMemberIdx())) {
            log.info("닉네임 중복 발생 → 닉네임 변경 페이지로 이동");
            response.sendRedirect("/auth/nickname/change");
            return;
        }

        // ✅ 원래 가려던 URL (세션에 저장된 경우)
        String redirectUrl = (String) request.getSession().getAttribute("prevPage");
        if (redirectUrl != null) {
            request.getSession().removeAttribute("prevPage");
            response.sendRedirect(redirectUrl);
        } else {
            response.sendRedirect("/");
        }
    }
}
