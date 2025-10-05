package com.simplecoding.cheforest.jpa.config;

import com.simplecoding.cheforest.jpa.auth.security.CustomOAuth2UserService;
import jakarta.servlet.DispatcherType;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.messaging.MessageSecurityMetadataSourceRegistry;
import org.springframework.security.config.annotation.web.socket.EnableWebSocketSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final CustomOAuth2UserService customOAuth2UserService;   // ✅ 소셜 로그인 서비스
    private final CustomLoginSuccessHandler customLoginSuccessHandler; // ✅ 공용 성공 핸들러
    private final CustomLogoutSuccessHandler customLogoutSuccessHandler;  // ✅ 공용 로그아웃 핸들러



    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        // DispatcherType.FORWARD = jsp redirection 허용 , DispatcherType.INCLUDE = jsp:include 허용
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()
                        // 🌟🌟🌟 핵심 수정: /ws/** 경로에 대한 접근을 무조건 허용 🌟🌟🌟
                        .requestMatchers("/ws/**").permitAll() // 👈 이 줄을 추가해야 합니다.
                        // 현재 로그인 사용자 정보 확인용 (소셜+일반 공통)
                        .requestMatchers("/auth/me").authenticated()
                        //  [1] 관리자 전용 페이지
                        .requestMatchers("/admin/**").hasAuthority("ADMIN")
                        //  [2] 로그인 필요한 페이지 (inquiries/my/** 도 인증 필요 경로에 포함되어야 안전합니다)
                        .requestMatchers(
                                "/mypage/**",
                                "/board/add","/board/edition", "/board/edit",
                                "/auth/nickname/update", "/api/mypage/**",
                                "/inquiries/my/**" // 문의 관련 경로는 인증 필요
                        ).authenticated()
                        // [3] 나머지 페이지는 모두 허용
                        .anyRequest().permitAll()
                )
                // 일반 로그인 설정
                .formLogin(form -> form
                        .loginPage("/auth/login")
                        .loginProcessingUrl("/auth/login")
                        .usernameParameter("loginId")
                        .passwordParameter("password")
                        .successHandler(customLoginSuccessHandler)
                        .failureUrl("/auth/login?error=true")
                        .permitAll()
                )
                // 소셜 로그인 설정
                .oauth2Login(oauth -> oauth
                                .loginPage("/auth/login")
                                .userInfoEndpoint(userInfo -> userInfo.userService(customOAuth2UserService))
                        .successHandler(customLoginSuccessHandler)
                )
                // 로그아웃 설정
                .logout(logout -> logout
                        .logoutUrl("/auth/logout")
                        .logoutSuccessHandler(customLogoutSuccessHandler)
                        .permitAll()

                )
                // 보안토큰설정: `/inquiries/my/delete` 경로를 CSRF 검사 예외 목록에 추가
                .csrf(csrf -> csrf
                        // ✅ 문의 삭제 POST 요청에 대한 CSRF 검사를 무시합니다. (403 Forbidden 해결)
                        .ignoringRequestMatchers("/inquiries/my/delete", "/ping")
                );

        return http.build();
    }

    // 중복으로 인해 애플리케이션 시작 오류를 발생시킨 @Bean public PasswordEncoder passwordEncoder() 메서드를 제거했습니다.
}
