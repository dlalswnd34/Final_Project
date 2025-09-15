package com.simplecoding.cheforest.review.controller;

import com.simplecoding.cheforest.auth.security.CustomUserDetails;
import com.simplecoding.cheforest.review.dto.ReviewSaveReq;
import com.simplecoding.cheforest.review.dto.ReviewUpdateReq;
import com.simplecoding.cheforest.review.service.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/reviews")
public class ReviewController {

    private final ReviewService reviewService;

    // 댓글 등록
    @PostMapping
    public String addReview(@ModelAttribute ReviewSaveReq dto,
                            @AuthenticationPrincipal CustomUserDetails user) {
        reviewService.saveReview(dto, user.getMember().getMemberIdx());
        return "redirect:/boards/" + dto.getBoardId();
    }

    // 댓글 수정
    @PostMapping("/{id}")
    public String editReview(@PathVariable Long id,
                             @ModelAttribute ReviewUpdateReq dto,
                             @AuthenticationPrincipal CustomUserDetails user) {
        reviewService.updateReview(dto, user.getMember().getMemberIdx());
        return "redirect:/boards/" + dto.getBoardId();
    }

    // 댓글 삭제
    @PostMapping("/delete/{id}")
    public String deleteReview(@PathVariable Long id,
                               @RequestParam Long boardId,
                               @AuthenticationPrincipal CustomUserDetails user) {
        reviewService.deleteReview(id, user.getMember().getMemberIdx());
        return "redirect:/boards/" + boardId;
    }
}
