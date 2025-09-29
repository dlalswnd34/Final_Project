package com.simplecoding.cheforest.jpa.review.service;

import com.simplecoding.cheforest.jpa.review.dto.ReviewDto;
import com.simplecoding.cheforest.jpa.review.entity.Review;
import com.simplecoding.cheforest.jpa.review.repository.ReviewRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewRepository reviewRepository;

    // 댓글/대댓글 등록
    @Transactional
    public ReviewDto save(ReviewDto dto) {
        Review review = Review.builder()
                .boardId(dto.getBoardId())
                .writerIdx(dto.getWriterIdx())
                .content(dto.getContent())
                .parentId(dto.getParentId())
                .build();

        Review saved = reviewRepository.save(review);
        return toDto(saved);
    }

    // 댓글 수정
    @Transactional
    public ReviewDto update(ReviewDto dto) {
        Review review = reviewRepository.findById(dto.getReviewId())
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 댓글입니다. ID=" + dto.getReviewId()));

        review.setContent(dto.getContent());
        review.setUpdateTime(LocalDateTime.now());

        Review updated = reviewRepository.save(review);
        return toDto(updated);
    }

    // 게시글별 댓글 + 대댓글 조회 (대댓글까지만)
    @Transactional(readOnly = true)
    public List<ReviewDto> getCommentsWithReplies(Long boardId) {
        List<Review> parents = reviewRepository.findByBoardIdAndParentIdIsNullOrderByInsertTimeAsc(boardId);

        return parents.stream().map(parent -> {
            ReviewDto parentDto = toDto(parent);

            List<Review> replies = reviewRepository.findByParentIdOrderByInsertTimeAsc(parent.getReviewId());
            List<ReviewDto> replyDtos = replies.stream().map(this::toDto).collect(Collectors.toList());

            parentDto.setReplies(replyDtos);
            return parentDto;
        }).collect(Collectors.toList());
    }

    // 게시글 삭제 시 댓글 전체 삭제
    @Transactional
    public void deleteByBoardId(Long boardId) {
        reviewRepository.deleteByBoardId(boardId);
    }

    // 댓글 삭제 (단일)
    @Transactional
    public void delete(Long reviewId) {
        if (!reviewRepository.existsById(reviewId)) {
            throw new IllegalArgumentException("존재하지 않는 댓글입니다. ID=" + reviewId);
        }
        reviewRepository.deleteById(reviewId);
    }

    // Entity -> DTO 변환
    private ReviewDto toDto(Review review) {
        return ReviewDto.builder()
                .reviewId(review.getReviewId())
                .boardId(review.getBoardId())
                .writerIdx(review.getWriterIdx())
                .content(review.getContent())
                .insertTime(review.getInsertTime())
                .updateTime(review.getUpdateTime())
                .parentId(review.getParentId())
                .replies(new ArrayList<>())
                .build();
    }
}
