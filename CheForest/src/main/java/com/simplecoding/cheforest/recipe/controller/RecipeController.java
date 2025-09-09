package com.simplecoding.cheforest.recipe.controller;

import com.simplecoding.cheforest.recipe.dto.RecipeDto;
import com.simplecoding.cheforest.recipe.service.RecipeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/recipe")
public class RecipeController {

    private final RecipeService recipeService;

    @GetMapping("/{id}")
    public String detail(@PathVariable("id") String recipeId, Model model) {
        model.addAttribute("recipe", recipeService.getRecipe(recipeId));
        return "recipe/detail";
    }

    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("recipes", recipeService.getAllRecipes());
        return "recipe/list";
    }

    @GetMapping("/add")
    public String addForm() {
        return "recipe/add";
    }

    @PostMapping("/add")
    public String add(@ModelAttribute RecipeDto dto) {
        recipeService.save(dto);
        return "redirect:/recipe/list";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") String recipeId) {
        recipeService.delete(recipeId);
        return "redirect:/recipe/list";
    }
}
