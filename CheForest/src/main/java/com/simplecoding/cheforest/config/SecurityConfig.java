package com.simplecoding.cheforest.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        // [수정됨] 모든 사용자에게 허용할 경로들을 명확하게 지정합니다.
                        // 로그인 페이지가 사용하는 모든 리소스(CSS, JS, 이미지, HTML 조각 등)를 여기에 포함해야 합니다.
                        .requestMatchers(
                                "/",
                                "/home",
                                "/auth/**",     // 로그인, 회원가입 관련 모든 URL
                                "/css/**",      // CSS 파일
                                "/js/**",       // JavaScript 파일
                                "/images/**",   // 이미지 파일
                                "/WEB-INF/views/**",
                                "/fragments/**" // 공통 HTML 조각(header, footer 등)이 있다면 추가
                        ).permitAll()
                        // [원래 설정 유지] 그 외 공개할 페이지 경로들
                        .requestMatchers("/recipe/**", "/board/**", "/event/**", "/search/**").permitAll()
                        // [원래 설정 유지] 관리자 전용 경로
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        // [원래 설정 유지] 위에서 지정한 경로 외의 모든 요청은 로그인이 필요합니다.
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/auth/login") // 우리가 만든 로그인 페이지
                        .loginProcessingUrl("/auth/login") // 로그인 처리 URL
                        .usernameParameter("loginId")     // ✅ JSP input name과 일치
                        .passwordParameter("password")    // ✅ JSP input name과 일치
                        .defaultSuccessUrl("/", true)   // 로그인 성공 시 이동할 페이지
                        .failureUrl("/auth/login?error=true") // 로그인 실패 시
                        .permitAll() // formLogin과 관련된 경로는 모두 허용
                )
                .logout(logout -> logout
                        .logoutUrl("/auth/logout")
                        .logoutSuccessUrl("/")
                        .permitAll()
                );

        return http.build();
    }
}

