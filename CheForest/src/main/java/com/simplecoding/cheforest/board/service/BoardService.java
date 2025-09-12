package com.simplecoding.cheforest.board.service;

import com.simplecoding.cheforest.board.dto.BoardDetailDto;
import com.simplecoding.cheforest.board.dto.BoardListDto;
import com.simplecoding.cheforest.board.dto.BoardSaveReq;
import com.simplecoding.cheforest.board.dto.BoardUpdateReq;
import com.simplecoding.cheforest.board.entity.Board;
import com.simplecoding.cheforest.board.repository.BoardRepository;
import com.simplecoding.cheforest.board.repository.BoardRepositoryDsl;
import com.simplecoding.cheforest.common.MapStruct;
import com.simplecoding.cheforest.file.service.FileService;
import com.simplecoding.cheforest.like.service.LikeService;
import com.simplecoding.cheforest.member.entity.Member;
import com.simplecoding.cheforest.member.repository.MemberRepository;
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
        return boardRepositoryDsl.searchBoards(keyword, category, pageable);
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
