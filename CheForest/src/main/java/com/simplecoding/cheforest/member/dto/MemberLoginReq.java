package com.simplecoding.cheforest.member.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberLoginReq {
    private String loginId;        // 아이디
    private String password;  // 비밀번호
}
