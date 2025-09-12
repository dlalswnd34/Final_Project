package com.simplecoding.cheforest.board.dto;

import lombok.*;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardListDto {  // 목록조회 dto
    private Long boardId;
    private String category;
    private String title;
    private String nickname;       // 작성자 닉네임
    private Long writerIdx;
    private Long viewCount;
    private Long likeCount;
    private String thumbnail;
    private LocalDateTime insertTime; // 작성일


}
