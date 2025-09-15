package com.simplecoding.cheforest.config;

import com.simplecoding.cheforest.auth.security.CustomOAuth2UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
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
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(
                                "/",
                                "/home",
                                "/auth/**",
                                "/css/**",
                                "/js/**",
                                "/images/**",
                                "/WEB-INF/views/**",
                                "/fragments/**"
                        ).permitAll()
                        .requestMatchers("/recipe/**", "/board/**", "/event/**", "/search/**").permitAll()
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().authenticated()
                )
                // ✅ 일반 로그인 설정
                .formLogin(form -> form
                        .loginPage("/auth/login")
                        .loginProcessingUrl("/auth/login")
                        .usernameParameter("loginId")
                        .passwordParameter("password")
                        .successHandler(customLoginSuccessHandler) // 공용 SuccessHandler 적용
                        .failureUrl("/auth/login?error=true")
                        .permitAll()
                )
                // ✅ 소셜 로그인 설정
                .oauth2Login(oauth -> oauth
                        .loginPage("/auth/login")
                        .userInfoEndpoint(userInfo -> userInfo.userService(customOAuth2UserService))
                        .successHandler(customLoginSuccessHandler) // 공용 SuccessHandler 적용
                )
                .logout(logout -> logout
                        .logoutUrl("/auth/logout")
                        .logoutSuccessHandler(customLogoutSuccessHandler) // ✅ prevPage 지원 로그아웃
                        .permitAll()
                )
                // ✅ prevPage 저장 (중요!)
                .exceptionHandling(ex -> ex.authenticationEntryPoint((req, res, e) -> {
                    // 원래 가려던 URL 저장
                    req.getSession().setAttribute("prevPage", req.getRequestURI());
                    res.sendRedirect("/auth/login");
                }));

        return http.build();
    }
}
