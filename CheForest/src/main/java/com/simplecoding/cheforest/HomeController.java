package com.simplecoding.cheforest;

import com.simplecoding.cheforest.auth.entity.Member;
import com.simplecoding.cheforest.auth.repository.MemberRepository;
import com.simplecoding.cheforest.auth.security.CustomUserDetails;
import com.simplecoding.cheforest.point.service.RankingService;
import com.simplecoding.cheforest.recipe.service.RecipeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Log4j2
@Controller
@RequiredArgsConstructor
public class HomeController {

    private final RecipeService recipeService;
    private final RankingService rankingService;
    private final MemberRepository memberRepository;

    @GetMapping("/")
    public String home(@AuthenticationPrincipal CustomUserDetails user, Model model) {
        model.addAttribute("koreanRecipe", recipeService.getRandomRecipes("한식", 5));
        model.addAttribute("westernRecipe", recipeService.getRandomRecipes("양식", 5));
        model.addAttribute("chineseRecipe", recipeService.getRandomRecipes("중식", 5));
        model.addAttribute("japaneseRecipe", recipeService.getRandomRecipes("일식", 5));
        model.addAttribute("dessertRecipe", recipeService.getRandomRecipes("디저트", 5));
        model.addAttribute("bestRecipes", recipeService.getBestRecipes());
        model.addAttribute("best3Recipes", recipeService.getBest3Recipes());

        // 랭킹
        List<Member> topMembers = rankingService.getTopRanking(10);
        model.addAttribute("topMembers", topMembers);

        if (user != null) {
            Member me = memberRepository.findById(user.getMemberIdx())
                    .orElseThrow(() -> new IllegalArgumentException("회원이 존재하지 않습니다."));
            Long myRank = rankingService.getMyRank(me);
            model.addAttribute("myRank", myRank);
        }
        return "home"; // home.jsp
    }

    @GetMapping("/search/all")
    public String search(Model model) {
        return "search/searchAll";
    }
}
