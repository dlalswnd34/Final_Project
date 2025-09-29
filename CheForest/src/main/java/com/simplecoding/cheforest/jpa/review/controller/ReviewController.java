package com.simplecoding.cheforest.jpa.review.controller;

import com.simplecoding.cheforest.jpa.review.dto.ReviewDto;
import com.simplecoding.cheforest.jpa.review.service.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/reviews")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    // 댓글/대댓글 등록
    @PostMapping("/add")
    public ResponseEntity<ReviewDto> addReview(@RequestBody ReviewDto dto) {
        return ResponseEntity.ok(reviewService.save(dto));
    }

    // 댓글 수정
    @PutMapping("/update")
    public ResponseEntity<?> updateReview(@RequestBody ReviewDto dto) {
        try {
            return ResponseEntity.ok(reviewService.update(dto));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    // 게시글별 댓글 + 대댓글 조회
    @GetMapping("/{boardId}")
    public ResponseEntity<List<ReviewDto>> getReviews(@PathVariable Long boardId) {
        return ResponseEntity.ok(reviewService.getCommentsWithReplies(boardId));
    }

    // 댓글 삭제
    @DeleteMapping("/{reviewId}")
    public ResponseEntity<?> deleteReview(@PathVariable Long reviewId) {
        try {
            reviewService.delete(reviewId);
            return ResponseEntity.ok("댓글 삭제 완료");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}
