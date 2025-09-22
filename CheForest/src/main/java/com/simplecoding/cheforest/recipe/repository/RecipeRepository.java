package com.simplecoding.cheforest.recipe.repository;

import com.simplecoding.cheforest.recipe.entity.Recipe;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface RecipeRepository extends JpaRepository<Recipe, String> {

    // 1. 카테고리별 조회 (페이징 포함)
    Page<Recipe> findByCategoryKrContainingAndTitleKrContaining(
            String categoryKr,
            String titleKr,
            Pageable pageable
    );

    // 2. 랜덤 조회 (Oracle RANDOM → JPA 네이티브 쿼리 사용)
    @Query(value = "SELECT * FROM API_RECIPE WHERE CATEGORY_KR = :categoryKr ORDER BY DBMS_RANDOM.VALUE FETCH FIRST :count ROWS ONLY",
            nativeQuery = true)
    List<Recipe> findRandomByCategory(String categoryKr, int count);

    // 3. 썸네일만 전체 조회
    @Query("SELECT r.recipeId, r.thumbnail FROM Recipe r")
    List<Object[]> findAllRecipeThumb();

    // 4. 인기 레시피 (TOP 10 by LIKE_COUNT)
    List<Recipe> findTop10ByOrderByLikeCountDescRecipeIdDesc();

    // 5. 인기 레시피 (TOP 3 by LIKE_COUNT)
    List<Recipe> findTop3ByOrderByLikeCountDescRecipeIdDesc();

    // 6. 카테고리 목록 (중복 제거)
    @Query("SELECT DISTINCT r.categoryKr FROM Recipe r ORDER BY r.categoryKr")
    List<String> findDistinctCategories();
    // 7. 카테고리별 레시피 개수
    @Query("SELECT r.categoryKr, COUNT(r) FROM Recipe r GROUP BY r.categoryKr")
    List<Object[]> countRecipesByCategory();
    }
