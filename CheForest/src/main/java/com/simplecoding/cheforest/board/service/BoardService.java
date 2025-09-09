package com.simplecoding.cheforest.board.service;

import com.simplecoding.cheforest.board.dto.*;
import com.simplecoding.cheforest.board.entity.Board;
import com.simplecoding.cheforest.board.repository.BoardRepository;
import com.simplecoding.cheforest.common.MapStruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class BoardService {
    private final BoardRepository boardRepository;
    private final MapStruct mapper;

    public BoardDetailDto save(BoardSaveDto dto) {
        Board board = mapper.toEntity(dto);
        board.setViewCount(0);
        Board saved = boardRepository.save(board);
        return mapper.toDto(saved);
    }

    public BoardDetailDto update(BoardUpdateDto dto) {
        Board board = boardRepository.findById(dto.getBoardId())
                .orElseThrow(() -> new IllegalArgumentException("게시글 없음"));
        board.setCategory(dto.getCategory());
        board.setTitle(dto.getTitle());
        board.setPrepare(dto.getPrepare());
        board.setContent(dto.getContent());
        board.setThumbnail(dto.getThumbnail());
        return mapper.toDto(boardRepository.save(board));
    }

    public void delete(Long boardId) {
        boardRepository.deleteById(boardId);
    }

    public BoardDetailDto getBoard(Long boardId) {
        return boardRepository.findById(boardId)
                .map(mapper::toDto)
                .orElseThrow(() -> new IllegalArgumentException("게시글 없음"));
    }

    public List<BoardDetailDto> findAll() {
        return boardRepository.findAll().stream().map(mapper::toDto).toList();
    }
}
