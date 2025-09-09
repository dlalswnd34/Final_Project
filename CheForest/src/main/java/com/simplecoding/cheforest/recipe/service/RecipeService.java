package com.simplecoding.cheforest.recipe.service;

import com.simplecoding.cheforest.recipe.dto.RecipeDto;
import com.simplecoding.cheforest.recipe.entity.Recipe;
import com.simplecoding.cheforest.recipe.repository.RecipeRepository;
import com.simplecoding.cheforest.common.MapStruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class RecipeService {

    private final RecipeRepository recipeRepository;
    private final MapStruct mapper;

    public RecipeDto save(RecipeDto dto) {
        Recipe recipe = mapper.toEntity(dto);
        Recipe saved = recipeRepository.save(recipe);
        return mapper.toDto(saved);
    }

    public void delete(String recipeId) {
        recipeRepository.deleteById(recipeId);
    }

    public RecipeDto getRecipe(String recipeId) {
        return recipeRepository.findById(recipeId).map(mapper::toDto)
                .orElseThrow(() -> new IllegalArgumentException("레시피 없음"));
    }

    public List<RecipeDto> getAllRecipes() {
        return recipeRepository.findAll().stream().map(mapper::toDto).toList();
    }

    public boolean existsRecipe(String recipeId) {
        return recipeRepository.existsByRecipeId(recipeId);
    }

    // ✅ 카테고리별 랜덤 레시피
    public List<RecipeDto> selectRandomRecipesByCategory(String category, int limit) {
        List<RecipeDto> all = recipeRepository.findByCategoryKr(category)
                .stream().map(mapper::toDto)
                .collect(Collectors.toList());
        Collections.shuffle(all); // 무작위 섞기
        return all.stream().limit(limit).toList();
    }

    // ✅ 인기 레시피 (좋아요 순 Top5 예시)
    public List<RecipeDto> selectBestRecipes() {
        return recipeRepository.findAll().stream()
                .sorted((a, b) -> {
                    Long likeA = (a.getLikeCount() == null ? 0L : a.getLikeCount());
                    Long likeB = (b.getLikeCount() == null ? 0L : b.getLikeCount());
                    return likeB.compareTo(likeA); // 내림차순
                })
                .limit(5)
                .map(mapper::toDto)
                .toList();
    }
}
