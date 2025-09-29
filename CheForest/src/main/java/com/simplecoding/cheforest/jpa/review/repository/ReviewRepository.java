package com.simplecoding.cheforest.jpa.review.repository;

import com.simplecoding.cheforest.jpa.review.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    // 특정 게시글의 최상위 댓글
    List<Review> findByBoardIdAndParentIdIsNullOrderByInsertTimeAsc(Long boardId);

    // 특정 댓글의 대댓글
    List<Review> findByParentIdOrderByInsertTimeAsc(Long parentId);

    // 특정 게시글의 댓글 전부 삭제
    void deleteByBoardId(Long boardId);
}
