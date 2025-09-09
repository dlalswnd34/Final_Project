package com.simplecoding.cheforest.board.entity;

import com.simplecoding.cheforest.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "BOARD")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor @Builder
public class Board extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BOARD_SEQ")
    @SequenceGenerator(name = "BOARD_SEQ", sequenceName = "BOARD_SEQ", allocationSize = 1)
    @Column(name = "BOARD_ID")
    private Long boardId;

    @Column(name = "CATEGORY")
    private String category;

    @Column(name = "TITLE")
    private String title;

    @Column(name = "PREPARE")
    private String prepare;

    @Column(name = "CONTENT")
    private String content;

    @Column(name = "THUMBNAIL")
    private String thumbnail;

    @Column(name = "WRITE_DATE")
    private String writeDate;

    @Column(name = "VIEW_COUNT")
    private Integer viewCount;

    @Column(name = "WRITER_IDX")
    private Long writerIdx;
}
