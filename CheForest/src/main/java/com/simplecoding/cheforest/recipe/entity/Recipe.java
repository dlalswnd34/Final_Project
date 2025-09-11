package com.simplecoding.cheforest.recipe.entity;

import com.simplecoding.cheforest.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "API_RECIPE")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Recipe {

    @Id
    @Column(name = "RECIPE_ID", length = 20, nullable = false)
    private String recipeId;   // PK

    // 한글 정보
    @Column(name = "TITLE_KR", length = 300)
    private String titleKr;

    @Column(name = "CATEGORY_KR", length = 100)
    private String categoryKr;

    @Lob
    @Column(name = "INSTRUCTION_KR")
    private String instructionKr;

    @Column(name = "INGREDIENT_KR", length = 1500)
    private String ingredientKr;

    @Column(name = "MEASURE_KR", length = 1500)
    private String measureKr;

    // 영어 정보
    @Column(name = "TITLE_EN", length = 300)
    private String titleEn;

    @Column(name = "CATEGORY_EN", length = 100)
    private String categoryEn;

    @Lob
    @Column(name = "INSTRUCTION_EN")
    private String instructionEn;

    @Column(name = "INGREDIENT_EN", length = 1500)
    private String ingredientEn;

    @Column(name = "MEASURE_EN", length = 1500)
    private String measureEn;

    // 기타
    @Column(name = "THUMBNAIL", length = 300)
    private String thumbnail;

    @Column(name = "AREA", length = 50)
    private String area;

    @Column(name = "LIKE_COUNT")
    private Long likeCount;
}
