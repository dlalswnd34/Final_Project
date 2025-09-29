package com.simplecoding.cheforest.jpa.review.service;

import com.simplecoding.cheforest.jpa.board.entity.Board;
import com.simplecoding.cheforest.jpa.common.MapStruct;
import com.simplecoding.cheforest.jpa.review.dto.ReviewDto;
import com.simplecoding.cheforest.jpa.review.entity.Review;
import com.simplecoding.cheforest.jpa.review.repository.ReviewRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final MapStruct mapStruct;

    @Transactional
    public ReviewDto save(ReviewDto dto) {
        Review review = mapStruct.toEntity(dto);

        if (dto.getBoardId() != null) {
            Board board = new Board();
            board.setBoardId(dto.getBoardId());
            review.setBoard(board);
        } else {
            throw new IllegalArgumentException("boardId가 없습니다.");
        }

        Review saved = reviewRepository.save(review);

        // ✅ MapStruct 변환
        ReviewDto result = mapStruct.toDto(saved);
        result.setBoardId(saved.getBoard().getBoardId());
        result.setWriterIdx(saved.getWriterIdx());

        // ✅ 닉네임을 DB/MemberService에서 가져올 수 있으면 세팅
        if (dto.getNickname() != null) {
            result.setNickname(dto.getNickname());
        }

        return result;
    }
    // 댓글 수정
    @Transactional
    public ReviewDto update(ReviewDto dto) {
        Review review = reviewRepository.findById(dto.getReviewId())
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 댓글입니다. ID=" + dto.getReviewId()));

        mapStruct.updateEntityFromDto(dto, review);
        review.setUpdateTime(LocalDateTime.now());

        Review updated = reviewRepository.save(review);
        return mapStruct.toDto(updated);
    }

    // 게시글별 댓글 + 대댓글 조회
    @Transactional(readOnly = true)
    public List<ReviewDto> getCommentsWithReplies(Long boardId) {
        List<Review> parents = reviewRepository.findByBoard_BoardIdAndParentIdIsNullOrderByInsertTimeAsc(boardId);

        return parents.stream().map(parent -> {
            ReviewDto parentDto = mapStruct.toDto(parent);

            List<ReviewDto> replyDtos = reviewRepository.findByParentIdOrderByInsertTimeAsc(parent.getReviewId())
                    .stream()
                    .map(mapStruct::toDto)
                    .collect(Collectors.toList());

            parentDto.setReplies(replyDtos);
            return parentDto;
        }).collect(Collectors.toList());
    }

    // 게시글 삭제 시 댓글 전체 삭제
    @Transactional
    public void deleteByBoardId(Long boardId) {
        reviewRepository.deleteByBoard_BoardId(boardId);
    }

    // 댓글 삭제 (단일)
    @Transactional
    public void delete(Long reviewId) {
        if (!reviewRepository.existsById(reviewId)) {
            throw new IllegalArgumentException("존재하지 않는 댓글입니다. ID=" + reviewId);
        }
        reviewRepository.deleteById(reviewId);
    }
}
