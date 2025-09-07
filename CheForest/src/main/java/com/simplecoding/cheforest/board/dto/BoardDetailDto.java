package com.simplecoding.cheforest.board.dto;

import lombok.*;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardDetailDto {
    private Long boardId;
    private String title;
    private String content;
    private String category;
    private Long likeCount;
    private Long viewCount;
    private Long writerId;
    private String writerNickname;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
