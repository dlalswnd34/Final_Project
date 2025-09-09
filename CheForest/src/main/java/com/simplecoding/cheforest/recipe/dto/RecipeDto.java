package com.simplecoding.cheforest.recipe.dto;
import lombok.Data;

@Data
public class RecipeDto {
    private String recipeId;
    private String title;
    private String category;
    private String instruction;
    private String thumbnail;
    private String titleKr;
    private String categoryKr;
    private String instructionKr;
    private String ingredient;
    private String measure;
    private String area;
    private String ingredientKr;
    private String measureKr;
    private Long likeCount;
}
