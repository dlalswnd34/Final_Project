package com.simplecoding.cheforest.home.service;

import com.simplecoding.cheforest.board.dto.BoardLatestRowDTO;
import com.simplecoding.cheforest.board.repository.BoardRepositoryDsl;
import com.simplecoding.cheforest.recipe.dto.RecipeCardDTO;
import com.simplecoding.cheforest.recipe.entity.Recipe;
import com.simplecoding.cheforest.recipe.repository.RecipeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class HomeService {

    private final RecipeRepository recipeRepository;
    private final BoardRepositoryDsl boardRepositoryDsl;

    // 인기 레시피 TOP4
    public List<RecipeCardDTO> getPopularRecipes() {
        return recipeRepository
                .findTop4ByLikeCountGreaterThanOrderByLikeCountDescViewCountDescRecipeIdDesc(0L)
                .stream()
                .map(this::toRecipeCardDTO)
                .toList();
    }

    // 카테고리별 레시피 TOP3
    public Map<String, List<RecipeCardDTO>> getCategoryTop3Recipes() {
        Map<String, List<RecipeCardDTO>> result = new HashMap<>();
        String[] categories = {"한식", "양식", "중식", "일식", "디저트"};

        for (String category : categories) {
            List<RecipeCardDTO> top3 = recipeRepository
                    .findTop3ByCategoryKrAndLikeCountGreaterThanOrderByLikeCountDescViewCountDescRecipeIdDesc(category, 0L)
                    .stream()
                    .map(this::toRecipeCardDTO)
                    .toList();
            result.put(category, top3);
        }
        return result;
    }

    // 카테고리별 최신 게시글 (댓글수 포함)
    public Map<String, List<BoardLatestRowDTO>> getCategoryLatestBoards() {
        Map<String, List<BoardLatestRowDTO>> result = new HashMap<>();
        String[] categories = {"한식", "양식", "중식", "일식", "디저트"};

        for (String category : categories) {
            List<BoardLatestRowDTO> latest = boardRepositoryDsl.findLatestByCategory(category, 5);
            result.put(category, latest);
        }
        return result;
    }

    // 엔티티 → DTO 변환
    private RecipeCardDTO toRecipeCardDTO(Recipe r) {
        return RecipeCardDTO.builder()
                .id(r.getRecipeId())
                .title(r.getTitleKr())
                .thumbnail(r.getThumbnail())
                .categoryName(r.getCategoryKr())
                .writerNickname("CheForest") // API 데이터엔 작성자 없음
                .cookTime(r.getCookTime())
                .difficulty(r.getDifficulty())
                .viewCount(r.getViewCount())
                .likeCount(r.getLikeCount())
                .build();
    }
}
