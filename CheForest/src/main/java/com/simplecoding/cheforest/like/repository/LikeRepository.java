package com.simplecoding.cheforest.like.repository;
import com.simplecoding.cheforest.like.entity.Like;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface LikeRepository extends JpaRepository<Like, Long> {
    List<Like> findByBoardId(Long boardId);
    List<Like> findByRecipeId(Long recipeId);
    boolean existsByBoardIdAndMemberIdx(Long boardId, Long memberIdx);
    boolean existsByRecipeIdAndMemberIdx(Long recipeId, Long memberIdx);
}
