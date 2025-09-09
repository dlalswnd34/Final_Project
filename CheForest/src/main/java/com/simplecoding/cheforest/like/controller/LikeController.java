package com.simplecoding.cheforest.like.controller;

import com.simplecoding.cheforest.like.dto.LikeDto;
import com.simplecoding.cheforest.like.service.LikeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/like")
public class LikeController {

    private final LikeService likeService;

    @PostMapping("/add")
    public String addLike(@ModelAttribute LikeDto dto) {
        likeService.addLike(dto);
        if ("BOARD".equals(dto.getLikeType())) {
            return "redirect:/board/" + dto.getBoardId();
        } else {
            return "redirect:/recipe/" + dto.getRecipeId();
        }
    }

    @PostMapping("/remove/{id}")
    public String removeLike(@PathVariable("id") Long likeId,
                             @RequestParam(required = false) Long boardId,
                             @RequestParam(required = false) Long recipeId,
                             @RequestParam String likeType) {
        likeService.removeLike(likeId);
        if ("BOARD".equals(likeType)) {
            return "redirect:/board/" + boardId;
        } else {
            return "redirect:/recipe/" + recipeId;
        }
    }

    @GetMapping("/board/{boardId}")
    public String listBoardLikes(@PathVariable("boardId") Long boardId, Model model) {
        model.addAttribute("likes", likeService.getLikesByBoard(boardId));
        return "like/list";
    }

    @GetMapping("/recipe/{recipeId}")
    public String listRecipeLikes(@PathVariable("recipeId") Long recipeId, Model model) {
        model.addAttribute("likes", likeService.getLikesByRecipe(recipeId));
        return "like/list";
    }
}
