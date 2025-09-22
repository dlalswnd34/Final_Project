package com.simplecoding.cheforest.board.repository;

import com.simplecoding.cheforest.board.entity.Board;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BoardRepository extends JpaRepository<Board, Long>, JpaSpecificationExecutor<Board> {

    // 카테고리별 검색 + 제목 검색은 JpaSpecificationExecutor/QueryDSL로 처리

    // 좋아요 순 Top 4
    List<Board> findTop4ByOrderByLikeCountDesc();

    // 카테고리별 좋아요 순 Top 4
    List<Board> findTop4ByCategoryOrderByLikeCountDesc(String category);

    // 특정 회원이 작성한 게시글
    List<Board> findByWriter_MemberIdx(Long memberIdx);

    // 조회수 증가
    @Modifying
    @Query("update Board b set b.viewCount = b.viewCount + 1 where b.boardId = :boardId")
    void increaseViewCount(@Param("boardId") Long boardId);

    // 썸네일 업데이트
    @Modifying
    @Query("update Board b set b.thumbnail = :thumbnail where b.boardId = :boardId")
    void updateThumbnail(@Param("boardId") Long boardId, @Param("thumbnail") String thumbnail);
}
