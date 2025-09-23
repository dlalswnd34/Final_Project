package com.simplecoding.cheforest.config;

import com.simplecoding.cheforest.auth.security.CustomOAuth2UserService;
import jakarta.servlet.DispatcherType;
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
                        .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()   // jsp redirection 허용
                        .dispatcherTypeMatchers(DispatcherType.INCLUDE).permitAll()   // jsp:include 허용
                        .requestMatchers(
                                "/", "/home",
                                "/auth/**",
                                "/css/**", "/js/**", "/images/**",
                                "/favicon.ico", "/fragments/**"
                        ).permitAll()
                        .requestMatchers("/recipe/**", "/board/**", "/event/**", "/search/**").permitAll()
                        .requestMatchers("/admin/**").hasAuthority("ADMIN")
                        .anyRequest().authenticated()
                )
                // ✅ 일반 로그인 설정
                .formLogin(form -> form
                        .loginPage("/auth/login")
                        .loginProcessingUrl("/auth/login")
                        .usernameParameter("loginId")
                        .passwordParameter("password")
                        .successHandler(customLoginSuccessHandler) // 성공 핸들러
                        .failureUrl("/auth/login?error=true")
                        .permitAll()
                )
                // ✅ 소셜 로그인 설정
                .oauth2Login(oauth -> oauth
                        .loginPage("/auth/login")
                        .userInfoEndpoint(userInfo -> userInfo.userService(customOAuth2UserService))
                        .successHandler(customLoginSuccessHandler) // 성공 핸들러
                )
                // ✅ 로그아웃 설정
                .logout(logout -> logout
                        .logoutUrl("/auth/logout")
                        .logoutSuccessHandler(customLogoutSuccessHandler)
                        .permitAll()
                );
        return http.build();
    }
}
