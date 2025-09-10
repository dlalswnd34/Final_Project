package com.simplecoding.cheforest.board.dto;

import lombok.*;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardListDto {  // 목록조회 dto
    private Long id;
    private String category;
    private String title;
    private String nickname;       // 작성자 닉네임
    private Long viewCount;
    private Long likeCount;
    private LocalDateTime insertTime; // 작성일
}
