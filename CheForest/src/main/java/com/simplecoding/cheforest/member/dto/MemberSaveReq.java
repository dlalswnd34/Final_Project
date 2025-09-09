package com.simplecoding.cheforest.member.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberSaveReq {
    private String id;             // 아이디
    private String email;          // 이메일
    private String emailCode;      // 이메일 인증번호
    private String password;       // 비밀번호
    private String confirmPassword; // 비밀번호 확인
    private String nickname;       // 닉네임
    private Long kakaoId;          // 카카오 회원가입
    private String profile;        // 프로필 이미지
}
