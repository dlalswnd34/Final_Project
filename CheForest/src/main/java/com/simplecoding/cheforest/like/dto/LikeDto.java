package com.simplecoding.cheforest.like.dto;
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class LikeDto {
    private Long likeId;
    private Long boardId;
    private Long recipeId;
    private Long memberIdx;
    private LocalDateTime likeDate;
    private String likeType; // BOARD or RECIPE
    private Integer likeCount;
}
