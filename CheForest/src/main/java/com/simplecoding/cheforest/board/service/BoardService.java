package com.simplecoding.cheforest.board.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import lombok.RequiredArgsConstructor;
import java.util.List;
import com.simplecoding.cheforest.board.dto.BoardListDto;
import com.simplecoding.cheforest.board.dto.BoardDetailDto;
import com.simplecoding.cheforest.board.entity.Board;
import com.simplecoding.cheforest.board.repository.BoardRepository;
import com.simplecoding.cheforest.board.repository.BoardRepositoryDsl;
import com.simplecoding.cheforest.file.service.FileService;
import com.simplecoding.cheforest.like.service.LikeService;

@Service
@RequiredArgsConstructor
@Transactional
public class BoardService {

    private final BoardRepository boardRepository;
    private final BoardRepositoryDsl boardRepositoryDsl;
    private final FileService fileService;
    private final LikeService likeService;

    // 1. 목록 조회 (검색 + 페이징)
    @Transactional(readOnly = true)
    public Page<BoardListDto> searchBoards(String keyword, String category, Pageable pageable) {
        return boardRepositoryDsl.searchBoards(keyword, category, pageable);
    }

    // 2. 상세 조회 (+ 조회수 증가)
    public BoardDetailDto getBoardDetail(Long boardId) {
        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new IllegalArgumentException("게시글 없음: " + boardId));

        board.increaseViewCount(); // ✅ 조회수 증가
        return BoardDetailDto.fromEntity(board);
    }

    // 3. 게시글 등록
    public Board save(Board board) {
        return boardRepository.save(board);
    }

    // 4. 게시글 수정
    public void update(Board board) {
        Board existing = boardRepository.findById(board.getBoardId())
                .orElseThrow(() -> new IllegalArgumentException("게시글 없음: " + board.getBoardId()));
        existing.setCategory(board.getCategory());
        existing.setTitle(board.getTitle());
        existing.setContent(board.getContent());
        existing.setThumbnail(board.getThumbnail());
        existing.setPrepare(board.getPrepare());
    }

    // 5. 게시글 삭제
    public void delete(Long boardId) {
        // 1. 댓글 삭제는 ReviewService에서 담당할 예정
        // 2. 좋아요 삭제
        likeService.deleteAllByBoardId(boardId);
        // 3. 첨부파일 삭제
        fileService.deleteAllByTargetIdAndType(boardId, "board");
        // 4. 게시글 삭제
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
        return boardRepositoryDsl.findBestPosts();
    }

    @Transactional(readOnly = true)
    public List<BoardListDto> getBestPostsByCategory(String category) {
        return boardRepositoryDsl.findBestPostsByCategory(category);
    }

    // 8. 썸네일 업데이트
    public void updateThumbnail(Long boardId, String thumbnailPath) {
        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new IllegalArgumentException("게시글 없음: " + boardId));
        board.setThumbnail(thumbnailPath);
    }
}
