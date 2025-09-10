package com.simplecoding.cheforest.review.controller;

import com.simplecoding.cheforest.member.entity.Member;
import com.simplecoding.cheforest.review.dto.ReviewSaveReq;
import com.simplecoding.cheforest.review.dto.ReviewUpdateReq;
import com.simplecoding.cheforest.review.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/review")
public class ReviewController {

    private final ReviewService reviewService;

    // 댓글 등록
    @PostMapping("/add")
    public String addReview(@ModelAttribute ReviewSaveReq dto, HttpSession session) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }
        reviewService.saveReview(dto, loginUser.getMemberIdx());
        return "redirect:/board/view.do?boardId=" + dto.getBoardId();
    }

    // 댓글 수정
    @PostMapping("/edit")
    public String editReview(@ModelAttribute ReviewUpdateReq dto, HttpSession session) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }
        reviewService.updateReview(dto, loginUser.getMemberIdx());
        return "redirect:/board/view.do?boardId=" + dto.getBoardId();
    }

    // 댓글 삭제
    @PostMapping("/delete")
    public String deleteReview(@RequestParam Long reviewId,
                               @RequestParam Long boardId,
                               HttpSession session) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }
        reviewService.deleteReview(reviewId, loginUser.getMemberIdx());
        return "redirect:/board/view.do?boardId=" + boardId;
    }
}
