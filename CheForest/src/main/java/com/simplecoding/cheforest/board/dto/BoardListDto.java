package com.simplecoding.cheforest.board.dto;

import lombok.*;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardListDto {
    private Long boardId;
    private String title;
    private String category;
    private Long likeCount;
    private Long viewCount;
    private Long writerId;         // writer.memberIdx
    private String writerNickname; // writer.nickname
    private LocalDateTime createdAt;
}
