package com.simplecoding.cheforest.member.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FindIdReq {
    private String email;      // 가입 이메일
    private String emailCode;  // 인증번호
}
