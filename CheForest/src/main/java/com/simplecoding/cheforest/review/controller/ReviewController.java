package com.simplecoding.cheforest.review.controller;

import com.simplecoding.cheforest.review.dto.*;
import com.simplecoding.cheforest.review.service.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/review")
public class ReviewController {
    private final ReviewService reviewService;

    @PostMapping("/write")
    public String write(@ModelAttribute ReviewSaveDto dto) {
        reviewService.save(dto);
        return "redirect:/board/" + dto.getBoardId();
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long reviewId, @RequestParam("boardId") Long boardId) {
        reviewService.delete(reviewId);
        return "redirect:/board/" + boardId;
    }

    @GetMapping("/list/{boardId}")
    public String list(@PathVariable("boardId") Long boardId, Model model) {
        model.addAttribute("reviews", reviewService.getReviews(boardId));
        return "review/list";
    }
}
