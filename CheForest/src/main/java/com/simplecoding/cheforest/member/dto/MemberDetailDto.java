package com.simplecoding.cheforest.member.dto;
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class MemberDetailDto {
    private Long memberIdx;
    private String id;
    private String email;
    private String nickname;
    private String profile;
    private LocalDateTime joinDate;
}
