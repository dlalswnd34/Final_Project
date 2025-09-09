package com.simplecoding.cheforest.review.service;

import com.simplecoding.cheforest.review.dto.*;
import com.simplecoding.cheforest.review.entity.Review;
import com.simplecoding.cheforest.review.repository.ReviewRepository;
import com.simplecoding.cheforest.common.MapStruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class ReviewService {
    private final ReviewRepository reviewRepository;
    private final MapStruct mapStruct;

    public ReviewDto save(ReviewSaveDto dto) {
        Review review = mapStruct.toEntity(dto);
        Review saved = reviewRepository.save(review);
        return mapStruct.toDto(saved);
    }

    public void delete(Long reviewId) {
        reviewRepository.deleteById(reviewId);
    }

    public List<ReviewDto> getReviews(Long boardId) {
        return reviewRepository.findByBoardId(boardId).stream().map(mapStruct::toDto)
                .collect(Collectors.toList());
    }
}
