package com.simplecoding.cheforest;

import com.simplecoding.cheforest.recipe.service.RecipeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Log4j2
@Controller
@RequiredArgsConstructor
public class HomeController {

    private final RecipeService recipeService;

    @GetMapping("/")
    public String home(Model model) {
        log.info("HomeController 진입");
        model.addAttribute("koreanRecipe", recipeService.getRandomRecipes("한식", 5));
        model.addAttribute("westernRecipe", recipeService.getRandomRecipes("양식", 5));
        model.addAttribute("chineseRecipe", recipeService.getRandomRecipes("중식", 5));
        model.addAttribute("japaneseRecipe", recipeService.getRandomRecipes("일식", 5));
        model.addAttribute("dessertRecipe", recipeService.getRandomRecipes("디저트", 5));
        model.addAttribute("bestRecipes", recipeService.getBestRecipes());
        return "home"; // home.jsp
    }

    @GetMapping("/search/all")
    public String search(Model model) {
        return "search/searchAll";
    }
}
