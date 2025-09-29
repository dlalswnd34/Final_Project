package com.simplecoding.cheforest.jpa.review.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL) // null 필드 제외
public class ReviewDto {

    private Long reviewId;     // 댓글 ID
    private Long boardId;      // 게시글 ID
    private Long writerIdx;    // 작성자 ID
    private String content;    // 내용
    private LocalDateTime insertTime;
    private LocalDateTime updateTime;
    private Long parentId;     // 부모 댓글 ID

    // 대댓글 리스트 (댓글일 경우만 채워짐)
    private List<ReviewDto> replies = new ArrayList<>();
}
