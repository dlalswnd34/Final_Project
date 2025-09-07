package com.simplecoding.cheforest.board.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardSaveReq {
    private String title;
    private String content;
    private String category;
    private Long writerId; // memberIdx
}
