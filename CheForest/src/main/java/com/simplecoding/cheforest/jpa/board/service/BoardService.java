package com.simplecoding.cheforest.jpa.board.service;

import com.simplecoding.cheforest.jpa.board.dto.BoardDetailDto;
import com.simplecoding.cheforest.jpa.board.dto.BoardListDto;
import com.simplecoding.cheforest.jpa.board.dto.BoardSaveReq;
import com.simplecoding.cheforest.jpa.board.dto.BoardUpdateReq;
import com.simplecoding.cheforest.jpa.board.entity.Board;
import com.simplecoding.cheforest.jpa.board.repository.BoardRepository;
import com.simplecoding.cheforest.jpa.board.repository.BoardRepositoryDsl;
import com.simplecoding.cheforest.jpa.common.MapStruct;
import com.simplecoding.cheforest.jpa.file.service.FileService;
import com.simplecoding.cheforest.jpa.like.service.LikeService;
import com.simplecoding.cheforest.jpa.auth.entity.Member;
import com.simplecoding.cheforest.jpa.auth.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class BoardService {

    private final BoardRepository boardRepository;
    private final BoardRepositoryDsl boardRepositoryDsl;
    private final FileService fileService;
    private final LikeService likeService;
    private final MemberRepository memberRepository;
    private final MapStruct mapStruct;

    // 1. 목록 조회 (검색 + 페이징)
    @Transactional(readOnly = true)
    public Page<BoardListDto> searchBoards(String keyword, String category, Pageable pageable) {

        Page<BoardListDto> result = boardRepositoryDsl.searchBoards(keyword, category, pageable);

        result.forEach(dto -> {
            if (dto.getInsertTime() != null) {
                dto.setCreatedAgo(toAgo(dto.getInsertTime()));
            }
        });

        return result;
    }

    // 2. 상세 조회 (+ 조회수 증가)
    @Transactional
    public BoardDetailDto getBoardDetail(Long boardId) {
        // ✅ DSL 사용
        BoardDetailDto dto = boardRepositoryDsl.findBoardDetail(boardId);
        if (dto == null) {
            throw new IllegalArgumentException("게시글 없음: " + boardId);
        }

        // 조회수 증가 (DB 반영)
//        boardRepository.increaseViewCount(boardId);
//        dto.setViewCount(dto.getViewCount() + 1);

        return dto;
    }

    // 3. 게시글 등록
    public Long create(BoardSaveReq dto, String writerEmail) {
        Member writer = memberRepository.findByEmail(writerEmail)
                .orElseThrow(() -> new IllegalArgumentException("회원 없음: " + writerEmail));

        Board board = mapStruct.toEntity(dto);
        board.setWriter(writer);

        boardRepository.save(board);
        return board.getBoardId();
    }

    // 4. 게시글 수정
    public void update(BoardUpdateReq dto, String writerEmail) {
        Board existing = boardRepository.findById(dto.getBoardId())
                .orElseThrow(() -> new IllegalArgumentException("게시글 없음: " + dto.getBoardId()));

        Member writer = memberRepository.findByEmail(writerEmail)
                .orElseThrow(() -> new IllegalArgumentException("회원 없음: " + writerEmail));
        existing.setWriter(writer);

        mapStruct.updateEntity(dto, existing); // ✅ @MappingTarget 활용
    }

    // 5. 게시글 삭제
    public void delete(Long boardId) {
        likeService.deleteAllByBoardId(boardId);
        fileService.deleteAllByTargetIdAndType(boardId, "board");
        boardRepository.deleteById(boardId);
    }

    // 6. 관리자 삭제
    public void adminDelete(Long boardId) {
        likeService.deleteAllByBoardId(boardId);
        fileService.deleteAllByTargetIdAndType(boardId, "board");
        boardRepository.deleteById(boardId);
    }

    // 7. 인기글 조회
    @Transactional(readOnly = true)
    public List<BoardListDto> getBestPosts() {
        List<BoardListDto> posts = boardRepositoryDsl.findBestPosts();
        posts.forEach(dto -> {
            if (dto.getInsertTime() != null) {
                dto.setCreatedAgo(toAgo(dto.getInsertTime()));
            }
        });
        return posts;
    }

    @Transactional(readOnly = true)
    public List<BoardListDto> getBestPostsByCategory(String category) {
        List<BoardListDto> posts = boardRepositoryDsl.findBestPostsByCategory(category);
        posts.forEach(dto -> {
            if (dto.getInsertTime() != null) {
                dto.setCreatedAgo(toAgo(dto.getInsertTime()));
            }
        });
        return posts;
    }

    // 8. 썸네일 업데이트
    public void updateThumbnail(Long boardId, String thumbnailPath) {
        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new IllegalArgumentException("게시글 없음: " + boardId));
        board.setThumbnail(thumbnailPath);
    }

    public Long countMyPosts(Member member) {
        return boardRepository.countByWriter(member);
    }

//    총 게시글 수
    public long getTotalCount() {
        return boardRepository.count();
    }
//    카테고리별 게시글 수
    public long getCountByCategory(String category) {
        return boardRepository.countByCategory(category);
    }

//    전처리
    private String toAgo(java.time.LocalDateTime created) {
        java.time.Duration duration = java.time.Duration.between(created, java.time.LocalDateTime.now());

        long minutes = duration.toMinutes();
        if (minutes < 1) return "방금 전";
        if (minutes < 60) return minutes + "분 전";

        long hours = minutes / 60;
        if (hours < 24) return hours + "시간 전";

        long days = hours / 24;
        if (days < 7) return days + "일 전";

        long weeks = days / 7;
        if (weeks < 5) return weeks + "주 전";

        long months = days / 30;
        if (months < 12) return months + "개월 전";

        long years = days / 365;
        return years + "년 전";
    }
}
