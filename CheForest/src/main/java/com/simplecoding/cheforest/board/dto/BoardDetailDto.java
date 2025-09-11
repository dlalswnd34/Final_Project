package com.simplecoding.cheforest.board.dto;

import com.simplecoding.cheforest.board.entity.Board;
import lombok.*;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardDetailDto {  // 상세조회 dto
    private Long id;
    private String category;
    private String title;
    private String prepare;
    private String content;
    private String thumbnail;
    private String nickname;       // 작성자 닉네임
    private String profile;        // 작성자 프로필
    private Long viewCount;
    private Long likeCount;
    private LocalDateTime insertTime;
    private LocalDateTime updateTime;

    public static BoardDetailDto fromEntity(Board board) {
        return BoardDetailDto.builder()
                .id(board.getBoardId())
                .category(board.getCategory())
                .title(board.getTitle())
                .content(board.getContent())
                .thumbnail(board.getThumbnail())
                .nickname(board.getWriter().getNickname())
                .prepare(board.getPrepare())
                .viewCount(board.getViewCount())
                .likeCount(board.getLikeCount())
                .insertTime(board.getInsertTime())
                .build();
    }
}
