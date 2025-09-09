package com.simplecoding.cheforest.review.dto;
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class ReviewDto {
    private Long reviewId;
    private Long boardId;
    private Long writerIdx;
    private String content;
    private LocalDateTime writeDate;
    private String nickname;
}
