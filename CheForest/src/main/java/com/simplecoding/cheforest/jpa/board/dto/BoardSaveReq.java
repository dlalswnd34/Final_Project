package com.simplecoding.cheforest.jpa.board.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardSaveReq {
    private String category;
    private String title;
    private String prepare;
    private String content;
    private String thumbnail;
    private Integer cookTime;
    private String difficulty;
}
