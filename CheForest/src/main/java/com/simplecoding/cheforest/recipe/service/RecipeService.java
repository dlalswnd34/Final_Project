package com.simplecoding.cheforest.recipe.service;

import com.simplecoding.cheforest.common.MapStruct;
import com.simplecoding.cheforest.recipe.dto.RecipeDto;
import com.simplecoding.cheforest.recipe.entity.Recipe;
import com.simplecoding.cheforest.recipe.repository.RecipeRepository;
import com.simplecoding.cheforest.recipe.util.ImageDownloader;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class RecipeService {

    private final RecipeRepository recipeRepository;
    private final MapStruct mapStruct;
    private final ImageDownloader imageDownloader;

    // 1. 페이징 + 검색
    public Page<RecipeDto> getRecipeList(String categoryKr, String titleKr, Pageable pageable) {
        return recipeRepository
                .findByCategoryKrContainingAndTitleKrContaining(categoryKr, titleKr, pageable)
                .map(mapStruct::toDto);
    }

    // 2. 상세 조회
    public RecipeDto getRecipeDetail(String recipeId) {
        Recipe recipe = recipeRepository.findById(recipeId)
                .orElseThrow(() -> new IllegalArgumentException("레시피 없음: " + recipeId));
        return mapStruct.toDto(recipe);
    }

    // 3. 랜덤 레시피 조회
    public List<RecipeDto> getRandomRecipes(String categoryKr, int count) {
        return mapStruct.toDtoList(recipeRepository.findRandomByCategory(categoryKr, count));
    }

    // 4. 인기 레시피 TOP10
    public List<RecipeDto> getBestRecipes() {
        return mapStruct.toDtoList(recipeRepository.findTop10ByOrderByLikeCountDescRecipeIdDesc());
    }

    // 5. 썸네일 다운로드 & 로컬 캐싱
    public void downloadAndCacheAllImages() {
        List<Recipe> recipes = recipeRepository.findAll();

        log.info("🔁 총 {}개의 레시피 썸네일 처리 시작", recipes.size());

        for (Recipe recipe : recipes) {
            String recipeId = recipe.getRecipeId();
            String imageUrl = recipe.getThumbnail();

            if (imageUrl == null || imageUrl.isBlank()) {
                log.warn("❌ [{}] 무시됨 - URL 없음", recipeId);
                continue;
            }

            try {
                String localPath = "images/recipes/" + recipeId;
                imageDownloader.downloadImage(imageUrl, localPath);

                // DB 업데이트
                recipe.setThumbnail("/" + localPath + ".jpg");
                recipeRepository.save(recipe);

                log.info("✅ [{}] 처리 완료 - DB에 썸네일 경로 업데이트", recipeId);
            } catch (Exception e) {
                log.error("❌ [{}] 다운로드 실패 - URL: {}", recipeId, imageUrl, e);
            }
        }

        log.info("✅ 전체 썸네일 처리 완료");
    }
}
