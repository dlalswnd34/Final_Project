package com.simplecoding.cheforest.auth.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class MemberUpdateDto {
    private Long memberIdx;

    @NotBlank
    private String nickname;

    private String profile;
}
