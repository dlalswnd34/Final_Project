package com.simplecoding.cheforest.board.dto;
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class BoardDetailDto {
    private Long boardId;
    private String category;
    private String title;
    private String prepare;
    private String content;
    private String thumbnail;
    private LocalDateTime writeDate;
    private Integer viewCount;
    private String nickname;
    private Integer likeCount;
}
