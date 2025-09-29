package com.simplecoding.cheforest.jpa.review.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "BOARD_REVIEW")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "REVIEW_ID")
    private Long reviewId; // 댓글 PK

    @Column(name = "BOARD_ID", nullable = false)
    private Long boardId;  // 게시글 ID (무조건 게시글에만 달림)

    @Column(name = "WRITER_IDX", nullable = false)
    private Long writerIdx; // 작성자 ID

    @Column(name = "CONTENT", nullable = false, length = 1000)
    private String content; // 댓글 내용

    @Column(name = "INSERT_TIME")
    private LocalDateTime insertTime;

    @Column(name = "UPDATE_TIME")
    private LocalDateTime updateTime;

    @Column(name = "PARENT_ID")
    private Long parentId; // 부모 댓글 (NULL = 댓글, 값 있으면 대댓글)

    @PrePersist
    protected void onCreate() {
        this.insertTime = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updateTime = LocalDateTime.now();
    }
}
