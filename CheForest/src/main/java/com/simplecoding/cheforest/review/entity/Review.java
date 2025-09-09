package com.simplecoding.cheforest.review.entity;

import com.simplecoding.cheforest.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "BOARD_REVIEW")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor @Builder
public class Review extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BOARD_REVIEW_SEQ")
    @SequenceGenerator(name = "BOARD_REVIEW_SEQ", sequenceName = "BOARD_REVIEW_SEQ", allocationSize = 1)
    @Column(name = "REVIEW_ID")
    private Long reviewId;

    @Column(name = "BOARD_ID")
    private Long boardId;

    @Column(name = "WRITER_IDX")
    private Long writerIdx;

    @Column(name = "CONTENT")
    private String content;

    @Column(name = "WRITE_DATE")
    private LocalDateTime writeDate;
}
