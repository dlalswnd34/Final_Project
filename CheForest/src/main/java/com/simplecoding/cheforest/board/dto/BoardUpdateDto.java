package com.simplecoding.cheforest.board.dto;
import lombok.Data;

@Data
public class BoardUpdateDto {
    private Long boardId;
    private String category;
    private String title;
    private String prepare;
    private String content;
    private String thumbnail;
}
