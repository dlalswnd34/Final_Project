package com.simplecoding.cheforest.jpa.config;

import com.simplecoding.cheforest.jpa.auth.entity.Member;
import com.simplecoding.cheforest.jpa.auth.repository.MemberRepository;
import com.simplecoding.cheforest.jpa.auth.service.MemberService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Slf4j
@Component
@RequiredArgsConstructor
public class CustomLoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler { // 수정된 코드

    private final MemberRepository memberRepository;
    private final MemberService memberService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException { // ServletException 추가

        Object principal = authentication.getPrincipal();
        Member member = null;
        String loginId = null;

        // ✅ 일반 로그인
        if (principal instanceof UserDetails userDetails) {
            loginId = userDetails.getUsername();
            member = memberRepository.findByLoginId(loginId).orElse(null);
            request.getSession().setAttribute("provider", "LOCAL");
        }
        // ✅ 소셜 로그인
        else if (principal instanceof OAuth2User oAuth2User) {
            Object socialIdObj = oAuth2User.getAttributes().get("id");
            String socialId = (socialIdObj != null) ? String.valueOf(socialIdObj) : null;
            Object providerObj = oAuth2User.getAttributes().get("provider");
            String provider = (providerObj instanceof String) ? (String) providerObj : null;

            if (socialId != null && provider != null) {
                member = memberRepository.findBySocialIdAndProvider(socialId, provider.toUpperCase()).orElse(null);
                request.getSession().setAttribute("provider", provider.toUpperCase());
            }
        }

        // ✅ 마지막 로그인 시간 업데이트
        if (loginId != null) {
            memberService.updateLastLoginTime(loginId);
            log.info("마지막 로그인 시간 업데이트 완료: {}", loginId);
        }

        // ✅ 자동 생성된 닉네임이면 모달용 세션 저장
        if (member != null && member.getNickname() != null && member.getNickname().contains("_")) {
            String originalNickname = member.getNickname().split("_")[0];
            request.getSession().setAttribute("originalNickname", originalNickname);
            log.info("자동 생성된 닉네임 감지 → 모달 표시 준비 (원래 닉네임: {}, 현재 닉네임: {})",
                    originalNickname, member.getNickname());
        }

        // 2. 리다이렉트 URL 설정 (기본값: 홈)
        // SavedRequest가 있으면 부모 클래스가 알아서 원래 가려던 페이지로 보내줍니다.
        setDefaultTargetUrl("/");

        // 3. 부모 클래스의 onAuthenticationSuccess를 호출하여 세션 저장 및 리다이렉트 처리
        // 직접 response.sendRedirect()를 호출하지 않습니다.
        super.onAuthenticationSuccess(request, response, authentication);
    }
}