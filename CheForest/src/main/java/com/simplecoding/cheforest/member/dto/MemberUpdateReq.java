package com.simplecoding.cheforest.member.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberUpdateReq {
    private String password;        // 새 비밀번호 (nullable)
    private String confirmPassword; // 새 비밀번호 확인 (nullable)
    private String nickname;        // 변경할 닉네임 (nullable)
    private String profile;         // 변경할 프로필 이미지 경로 (nullable)
}
