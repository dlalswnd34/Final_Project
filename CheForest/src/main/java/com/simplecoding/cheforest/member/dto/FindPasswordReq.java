package com.simplecoding.cheforest.member.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FindPasswordReq {
    private String id;         // 회원 아이디
    private String email;      // 가입 이메일
    private String emailCode;  // 인증번호
}
