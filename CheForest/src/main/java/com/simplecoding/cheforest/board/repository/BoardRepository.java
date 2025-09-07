package com.simplecoding.cheforest.board.repository;

import com.simplecoding.cheforest.board.entity.Board;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

// com.simplecoding.cheforest.board.repository.BoardRepository
@Repository
public interface BoardRepository extends JpaRepository<Board, Long> { // <Board, Long>

    @EntityGraph(attributePaths = "writer")
    Page<Board> findByTitleContainingAndCategoryContainingOrderByBoardIdDesc(
            String title, String category, Pageable pageable);

    @EntityGraph(attributePaths = "writer")
    Page<Board> findByWriter_MemberIdxOrderByBoardIdDesc(Long memberIdx, Pageable pageable);

    @EntityGraph(attributePaths = "writer")
    List<Board> findTop5ByOrderByBoardIdDesc();

    @EntityGraph(attributePaths = "writer")
    List<Board> findTop5ByOrderByLikeCountDesc();

    long countByCategory(String category);

    boolean existsByBoardId(Long boardId); // Integer → Long

    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query("update Board b set b.viewCount = coalesce(b.viewCount,0) + 1 where b.boardId = :id")
    int increaseViewCount(@Param("id") Long boardId); // Integer → Long

    @EntityGraph(attributePaths = "writer")
    @Query("""
           select b from Board b
           where (:kw = '' or lower(b.title) like lower(concat('%', :kw, '%'))
                        or lower(b.content) like lower(concat('%', :kw, '%')))
             and (:cat = '' or b.category = :cat)
           order by b.boardId desc
           """)
    Page<Board> search(@Param("kw") String keyword,
                       @Param("cat") String category,
                       Pageable pageable);
}
