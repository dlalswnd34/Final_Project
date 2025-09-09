package com.simplecoding.cheforest.member.dto;
import lombok.Data;

@Data
public class MemberRegisterDto {
    private String id;
    private String email;
    private String password;
    private String nickname;
}
