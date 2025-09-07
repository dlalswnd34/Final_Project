package com.simplecoding.cheforest.board.service;

import com.simplecoding.cheforest.board.dto.*;
import com.simplecoding.cheforest.board.entity.Board;
import com.simplecoding.cheforest.board.entity.Member;
import com.simplecoding.cheforest.board.mapper.BoardMapper;
import com.simplecoding.cheforest.board.repository.BoardRepository;
import com.simplecoding.cheforest.common.MapStruct;
import com.simplecoding.cheforest.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class BoardService {

    private final BoardRepository boardRepository;
    private final MemberRepository memberRepository;
    private final MapStruct mapStruct;

    // 🔍 검색(제목+내용+카테고리)
    public Page<BoardListDto> search(String keyword, String category, Pageable pageable) {
        String kw  = keyword  == null ? "" : keyword.trim();
        String cat = category == null ? "" : category.trim();
        return boardRepository.search(kw, cat, pageable).map(mapStruct::toListDto);
    }

    // 👤 작성자별 목록
    public Page<BoardListDto> listByWriter(Long memberIdx, Pageable pageable) {
        return boardRepository
                .findByWriter_MemberIdxOrderByBoardIdDesc(memberIdx, pageable)
                .map(mapStruct::toListDto);
    }

    // 🕑 최신 5건
    public List<BoardListDto> latestTop5() {
        return boardRepository.findTop5ByOrderByBoardIdDesc()
                .stream().map(mapStruct::toListDto).toList();
    }

    // 👍 좋아요 많은 5건
    public List<BoardListDto> topLikedTop5() {
        return boardRepository.findTop5ByOrderByLikeCountDesc()
                .stream().map(mapStruct::toListDto).toList();
    }

    // 📊 카테고리별 개수
    public long countByCategory(String category) {
        return boardRepository.countByCategory(category);
    }

    // ✅ 존재 여부
    public boolean exists(Long boardId) {
        return boardRepository.existsById(boardId);
    }

    // 📖 상세조회 (+ 조회수 증가 옵션)
    @Transactional
    public BoardDetailDto getDetail(Long boardId, boolean increaseView) {
        if (increaseView) boardRepository.increaseViewCount(boardId);
        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new IllegalArgumentException("게시글 없음: id=" + boardId));
        return mapStruct.toDetailDto(board);
    }

    // 📝 등록
    @Transactional
    public Long create(BoardSaveReq req) {         // Integer → Long
        Board entity = mapStruct.toBoard(req);     // toEntity(...) → toBoard(...)
        Member writer = memberRepository.findById(req.getWriterId())
                .orElseThrow(() -> new IllegalArgumentException("작성자 없음: memberIdx=" + req.getWriterId()));
        entity.setWriter(writer);
        Board saved = boardRepository.save(entity);
        log.info("게시글 등록: id={}", saved.getBoardId());
        return saved.getBoardId();                 // Long 반환
    }

    // ✏ 수정
    @Transactional
    public void update(BoardUpdateReq req) {
        Board entity = boardRepository.findById(req.getBoardId())
                .orElseThrow(() -> new IllegalArgumentException("게시글 없음: id=" + req.getBoardId()));
        mapStruct.updateEntity(entity, req);
        boardRepository.save(entity);
        log.info("게시글 수정: id={}", entity.getBoardId());
    }

    // ❌ 삭제
    @Transactional
    public void delete(Long boardId) {
        if (boardRepository.existsById(boardId)) {
            boardRepository.deleteById(boardId);
            log.info("게시글 삭제: id={}", boardId);
        }
    }
}
