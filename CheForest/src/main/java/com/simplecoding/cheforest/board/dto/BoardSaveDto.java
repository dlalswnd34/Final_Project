package com.simplecoding.cheforest.board.dto;
import lombok.Data;

@Data
public class BoardSaveDto {
    private String category;
    private String title;
    private String prepare;
    private String content;
    private String thumbnail;
    private Long writerIdx;
}
