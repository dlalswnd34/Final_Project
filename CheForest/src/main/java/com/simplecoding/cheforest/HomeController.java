package com.simplecoding.cheforest;

import com.simplecoding.cheforest.recipe.service.RecipeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	private final RecipeService recipeService;

	public HomeController(RecipeService recipeService) {
		this.recipeService = recipeService;
	}

	@GetMapping("/")
	public String home(Model model) {
		model.addAttribute("koreanRecipe", recipeService.selectRandomRecipesByCategory("한식", 5));
		model.addAttribute("westernRecipe", recipeService.selectRandomRecipesByCategory("양식", 5));
		model.addAttribute("chineseRecipe", recipeService.selectRandomRecipesByCategory("중식", 5));
		model.addAttribute("japaneseRecipe", recipeService.selectRandomRecipesByCategory("일식", 5));
		model.addAttribute("dessertRecipe", recipeService.selectRandomRecipesByCategory("디저트", 5));
		model.addAttribute("bestRecipes", recipeService.selectBestRecipes());
		return "home"; // home.jsp
	}
}
