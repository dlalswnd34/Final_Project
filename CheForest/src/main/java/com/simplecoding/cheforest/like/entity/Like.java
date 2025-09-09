package com.simplecoding.cheforest.like.entity;

import com.simplecoding.cheforest.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "BOARD_LIKE")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor @Builder
public class Like extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_BOARD_LIKE")
    @SequenceGenerator(name = "SEQ_BOARD_LIKE", sequenceName = "SEQ_BOARD_LIKE", allocationSize = 1)
    @Column(name = "LIKE_ID")
    private Long likeId;

    @Column(name = "BOARD_ID")
    private Long boardId;

    @Column(name = "RECIPE_ID")
    private Long recipeId;

    @Column(name = "MEMBER_IDX")
    private Long memberIdx;

    @Column(name = "LIKE_DATE")
    private LocalDateTime likeDate;

    @Column(name = "LIKE_TYPE")
    private String likeType;

    @Column(name = "LIKE_COUNT")
    private Integer likeCount;
}
