package com.simplecoding.cheforest.jpa.like.repository;

import com.simplecoding.cheforest.jpa.like.entity.Like;
import com.simplecoding.cheforest.jpa.auth.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface LikeRepository extends JpaRepository<Like, Long> {

    // ================== 조회 ==================

    // 좋아요 여부 확인 (게시판)
    boolean existsByMemberAndBoardId(Member member, Long boardId);

    // 좋아요 여부 확인 (레시피)
    boolean existsByMemberAndRecipeId(Member member, String recipeId);

    // ================== 삭제 ==================

    // 좋아요 취소 (게시판)
    void deleteByMemberAndBoardId(Member member, Long boardId);

    // 좋아요 취소 (레시피)
    void deleteByMemberAndRecipeId(Member member, String recipeId);

    // 게시글 삭제 시 전체 삭제
    void deleteAllByBoardId(Long boardId);

    // 레시피 삭제 시 전체 삭제
    void deleteAllByRecipeId(String recipeId);

    // 회원 탈퇴 시 전체 삭제
    void deleteAllByMember(Member member);

    // ================== LikeCount 업데이트 ==================

    // 게시판 좋아요 수 증가
    @Modifying
    @Query("UPDATE Board b SET b.likeCount = b.likeCount + 1 WHERE b.boardId = :boardId")
    void increaseBoardLikeCount(Long boardId);

    // 게시판 좋아요 수 감소
    @Modifying
    @Query("UPDATE Board b SET b.likeCount = b.likeCount - 1 WHERE b.boardId = :boardId")
    void decreaseBoardLikeCount(Long boardId);

    // 레시피 좋아요 수 증가
    @Modifying
    @Query("UPDATE Recipe r SET r.likeCount = r.likeCount + 1 WHERE r.recipeId = :recipeId")
    void increaseRecipeLikeCount(String recipeId);

    // 레시피 좋아요 수 감소
    @Modifying
    @Query("UPDATE Recipe r SET r.likeCount = r.likeCount - 1 WHERE r.recipeId = :recipeId")
    void decreaseRecipeLikeCount(String recipeId);

    /** ✅ 전체 좋아요 목록 (회원 기준) */
    @Query("SELECT l FROM Likes l WHERE l.member = :member ORDER BY l.likeDate DESC")
    List<Like> findAllByMember(Member member);

    /** ✅ 사용자 작성 레시피 좋아요 (게시판 기반) */
    @Query("SELECT l FROM Likes l WHERE l.member = :member AND l.boardId IS NOT NULL ORDER BY l.likeDate DESC")
    List<Like> findAllBoardLikesByMember(Member member);

    /** ✅ CheForest 제공 레시피 좋아요 (레시피 기반) */
    @Query("SELECT l FROM Likes l WHERE l.member = :member AND l.recipeId IS NOT NULL ORDER BY l.likeDate DESC")
    List<Like> findAllRecipeLikesByMember(Member member);
}
