package com.simplecoding.cheforest.board.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardUpdateReq {
    private Long boardId;
    private String title;
    private String content;
    private String category;
}
