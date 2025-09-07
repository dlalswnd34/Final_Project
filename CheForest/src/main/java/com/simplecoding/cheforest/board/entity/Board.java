package com.simplecoding.cheforest.board.entity;

import com.simplecoding.cheforest.common.BaseTimeEntity;
import com.simplecoding.cheforest.member.entity.Member;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "BOARD")
@SequenceGenerator(
        name = "BOARD_SEQ_JPA",       // JPA에서 사용할 시퀀스 이름
        sequenceName = "BOARD_SEQ",   // DB 시퀀스 이름
        allocationSize = 1
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = "writer")
@EqualsAndHashCode(of = "boardId", callSuper = false)
public class Board extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BOARD_SEQ_JPA")
    @Column(name = "BOARD_ID")
    private Long boardId;   // 기본키

    @Column(name = "CATEGORY", nullable = false, length = 50)
    private String category;   // 카테고리

    @Column(name = "TITLE", nullable = false, length = 200)
    private String title;      // 제목

    @Column(name = "PREPARE", length = 1000)
    private String prepare;    // 준비물

    @Lob
    @Column(name = "CONTENT")
    private String content;    // 본문

    @Column(name = "THUMBNAIL", length = 400)
    private String thumbnail;  // 썸네일

    @Column(name = "WRITE_DATE")
    private LocalDateTime writeDate; // 작성일 (DB 컬럼 그대로)

    @Column(name = "VIEW_COUNT")
    private Integer viewCount; // 조회수

    @Column(name = "LIKE_COUNT")
    private Integer likeCount; // 좋아요 수

    // 작성자 (MEMBER 테이블 FK)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "WRITER_IDX", referencedColumnName = "MEMBER_IDX")
    private Member writer;
}
