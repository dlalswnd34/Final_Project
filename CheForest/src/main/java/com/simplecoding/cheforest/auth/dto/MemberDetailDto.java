package com.simplecoding.cheforest.auth.dto;

import lombok.Data;

@Data
public class MemberDetailDto {
    private Long memberIdx;
    private String loginId;
    private String email;
    private String nickname;
    private String profile;
    private String role;
}
