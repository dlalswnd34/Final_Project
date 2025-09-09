package com.simplecoding.cheforest.review.dto;
import lombok.Data;

@Data
public class ReviewSaveDto {
    private Long boardId;
    private Long writerIdx;
    private String content;
}
