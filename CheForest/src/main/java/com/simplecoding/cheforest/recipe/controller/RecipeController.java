package com.simplecoding.cheforest.recipe.controller;

import com.simplecoding.cheforest.recipe.dto.RecipeDto;
import com.simplecoding.cheforest.recipe.service.RecipeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/recipe")
@RequiredArgsConstructor
public class RecipeController {

    private final RecipeService recipeService;

    // ✅ 1. 이미지 캐싱 실행 (관리자 전용)
    @PostMapping("/cache-images")
    @ResponseBody
    public String cacheImages() {
        recipeService.downloadAndCacheAllImages();
        return "✅ 이미지 캐싱 완료!";
    }

    // ✅ 2. 레시피 목록 조회 (카테고리 + 검색 + 페이징)
    @GetMapping("/list")
    public String showRecipeList(
            @RequestParam(defaultValue = "") String categoryKr,
            @RequestParam(defaultValue = "") String searchKeyword,
            @RequestParam(defaultValue = "0") int page,   // 0-based
            @RequestParam(defaultValue = "12") int size,  // 페이지당 개수
            Model model) {

        Pageable pageable = PageRequest.of(page, size);
        Page<RecipeDto> recipePage = recipeService.getRecipeList(categoryKr, searchKeyword, pageable);

        // ✅ 인기 레시피 3개
        List<RecipeDto> best3Recipes = recipeService.getBest3Recipes();

        // ✅ 카테고리 목록 (예: 한식, 양식, 중식, 일식, 디저트)
        List<String> categoryList = recipeService.getAllCategories();
        long totalCount = recipePage.getTotalElements();
        model.addAttribute("recipeList", recipePage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", recipePage.getTotalPages());
        model.addAttribute("categoryKr", categoryKr);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("best3Recipes", best3Recipes);
        model.addAttribute("categoryList", categoryList);
        Map<String, Long> recipeCountMap = recipeService.getCategoryCounts();
        model.addAttribute("recipeCountMap", recipeCountMap);
        model.addAttribute("totalCount", totalCount);
        return "recipe/recipelist";  // ✅ /WEB-INF/jsp/recipe/recipelist.jsp
    }

    // ✅ 3. 레시피 상세 조회
    @GetMapping("/view")
    public String showRecipeDetail(@RequestParam String recipeId, Model model) {
        // ✅ 상세 들어올 때 조회수 +1
        recipeService.viewCount(recipeId);

        RecipeDto recipe = recipeService.getRecipeDetail(recipeId);
        model.addAttribute("recipe", recipe);
        return "recipe/recipeview";  // ✅ /WEB-INF/jsp/recipe/recipeview.jsp
    }

}
