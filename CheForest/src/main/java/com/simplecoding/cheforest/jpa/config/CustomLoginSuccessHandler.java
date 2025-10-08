package com.simplecoding.cheforest.jpa.config;

import com.simplecoding.cheforest.jpa.auth.entity.Member;
import com.simplecoding.cheforest.jpa.auth.repository.MemberRepository;
import com.simplecoding.cheforest.jpa.auth.service.MemberService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
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
import java.nio.charset.StandardCharsets;

//@Slf4j
//@Component
//@RequiredArgsConstructor
//public class CustomLoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler { // 수정된 코드
//
//    private final MemberRepository memberRepository;
//    private final MemberService memberService;
//
//    @Override
//    public void onAuthenticationSuccess(HttpServletRequest request,
//                                        HttpServletResponse response,
//                                        Authentication authentication) throws IOException, ServletException { // ServletException 추가
//
//        Object principal = authentication.getPrincipal();
//        Member member = null;
//        String loginId = null;
//
//        // ✅ 일반 로그인
//        if (principal instanceof UserDetails userDetails) {
//            loginId = userDetails.getUsername();
//            member = memberRepository.findByLoginId(loginId).orElse(null);
//            request.getSession().setAttribute("provider", "LOCAL");
//        }
//        // ✅ 소셜 로그인
//        else if (principal instanceof OAuth2User oAuth2User) {
//            Object socialIdObj = oAuth2User.getAttributes().get("id");
//            String socialId = (socialIdObj != null) ? String.valueOf(socialIdObj) : null;
//            Object providerObj = oAuth2User.getAttributes().get("provider");
//            String provider = (providerObj instanceof String) ? (String) providerObj : null;
//
//            if (socialId != null && provider != null) {
//                member = memberRepository.findBySocialIdAndProvider(socialId, provider.toUpperCase()).orElse(null);
//                request.getSession().setAttribute("provider", provider.toUpperCase());
//            }
//        }
//
//        // ✅ 마지막 로그인 시간 업데이트
//        if (loginId != null) {
//            memberService.updateLastLoginTime(loginId);
//            log.info("마지막 로그인 시간 업데이트 완료: {}", loginId);
//        }
//
//        // ✅ 자동 생성된 닉네임이면 모달용 세션 저장
//        if (member != null && member.getNickname() != null && member.getNickname().contains("_")) {
//            String originalNickname = member.getNickname().split("_")[0];
//            request.getSession().setAttribute("originalNickname", originalNickname);
//            log.info("자동 생성된 닉네임 감지 → 모달 표시 준비 (원래 닉네임: {}, 현재 닉네임: {})",
//                    originalNickname, member.getNickname());
//        }
//
//        // 2. 리다이렉트 URL 설정 (기본값: 홈)
//        // SavedRequest가 있으면 부모 클래스가 알아서 원래 가려던 페이지로 보내줍니다.
//        setDefaultTargetUrl("/");
//
//        // 3. 부모 클래스의 onAuthenticationSuccess를 호출하여 세션 저장 및 리다이렉트 처리
//        // 직접 response.sendRedirect()를 호출하지 않습니다.
//        super.onAuthenticationSuccess(request, response, authentication);
//    }
//}
@Slf4j
@Component
@RequiredArgsConstructor
public class CustomLoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    private final MemberRepository memberRepository;
    private final MemberService memberService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        Object principal = authentication.getPrincipal();
        Member member = null;
        String loginId = null;

        // ===== 1) 사용자 식별 =====
        if (principal instanceof org.springframework.security.core.userdetails.UserDetails userDetails) {
            loginId = userDetails.getUsername();
            member = memberRepository.findByLoginId(loginId).orElse(null);
            request.getSession().setAttribute("provider", "LOCAL");
        } else if (principal instanceof org.springframework.security.oauth2.core.user.OAuth2User oAuth2User) {

            // (A) provider 추출 (kakao / google / naver)
            String provider = null;
            if (authentication instanceof org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken oAuth2Token) {
                provider = oAuth2Token.getAuthorizedClientRegistrationId();
            }
            if (provider != null) provider = provider.toUpperCase();

            // (B) socialId 추출 (프로바이더별 상이)
            String socialId = extractSocialId(provider, oAuth2User.getAttributes());

            if (socialId != null && provider != null) {
                member = memberRepository.findBySocialIdAndProvider(socialId, provider).orElse(null);
                request.getSession().setAttribute("provider", provider);
            }
        }

        if (loginId != null) {
            memberService.updateLastLoginTime(loginId);
            log.info("마지막 로그인 시간 업데이트 완료: {}", loginId);
        }

        if (member != null && member.getNickname() != null && member.getNickname().contains("_")) {
            String originalNickname = member.getNickname().split("_")[0];
            request.getSession().setAttribute("originalNickname", originalNickname);
            log.info("자동 생성 닉네임 감지 → 모달 준비 (원래: {}, 현재: {})", originalNickname, member.getNickname());
        }

        // ===== 2) redirect 우선 처리 (파라미터/쿠키) =====
        String redirect = trimToNull(request.getParameter("redirect"));
        if (redirect == null) {
            redirect = trimToNull(java.net.URLDecoder.decode(readCookie(request, "post_login_redirect"), StandardCharsets.UTF_8));
        }
        if (redirect != null && !isSafeRedirect(redirect)) {
            log.warn("차단된 redirect 요청: {}", redirect);
            redirect = null;
        }

        if (redirect != null) {
            deleteCookie("post_login_redirect", request, response);
            clearAuthenticationAttributes(request);
            getRedirectStrategy().sendRedirect(request, response, redirect);
            return;
        }

        // ===== 3) SavedRequest → Referer → "/" =====
        setUseReferer(true);
        setDefaultTargetUrl("/");
        super.onAuthenticationSuccess(request, response, authentication);
    }

    // ---------- provider별 socialId 추출 ----------
    @SuppressWarnings("unchecked")
    private String extractSocialId(String provider, java.util.Map<String, Object> attrs) {
        if (provider == null || attrs == null) return null;
        switch (provider) {
            case "KAKAO":
                // kakao: root에 "id"
                return attrs.get("id") != null ? String.valueOf(attrs.get("id")) : null;

            case "GOOGLE":
                // google: OIDC claims에서 "sub"
                Object sub = attrs.get("sub");
                return sub != null ? String.valueOf(sub) : null;

            case "NAVER":
                // naver: 기본 매핑은 "response" 맵 내부에 "id"
                Object resp = attrs.get("response");
                if (resp instanceof java.util.Map<?, ?> m) {
                    Object naverId = ((java.util.Map<String, Object>) m).get("id");
                    return naverId != null ? String.valueOf(naverId) : null;
                }
                // 만약 CustomOAuth2UserService에서 평탄화했다면 root "id"에도 있을 수 있음
                Object id = attrs.get("id");
                return id != null ? String.valueOf(id) : null;

            default:
                return null;
        }
    }

    // ---------- helpers ----------
    private static String trimToNull(String s) {
        if (s == null) return null;
        s = s.trim();
        return s.isEmpty() ? null : s;
    }

    private static boolean isSafeRedirect(String url) {
        if (url == null) return false;
        if (url.startsWith("?") || url.startsWith("#")) return true;
        if (url.startsWith("http://") || url.startsWith("https://") || url.startsWith("//")) return false;
        return url.startsWith("/");
    }

    private static String readCookie(HttpServletRequest req, String name) {
        var cookies = req.getCookies();
        if (cookies == null) return null;
        for (Cookie c : cookies) {
            if (name.equals(c.getName())) return c.getValue();
        }
        return null;
    }

    private static void deleteCookie(String name, HttpServletRequest req, HttpServletResponse res) {
        Cookie cookie = new Cookie(name, "");
        cookie.setPath("/");
        cookie.setMaxAge(0);
        cookie.setHttpOnly(true);
        res.addCookie(cookie);
    }
}