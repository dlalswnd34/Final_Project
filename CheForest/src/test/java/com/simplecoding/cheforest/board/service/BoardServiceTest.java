package com.simplecoding.cheforest.board.service;

import com.simplecoding.cheforest.board.dto.BoardSaveReq;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import static org.assertj.core.api.Assertions.assertThat;

@Log4j2
@SpringBootTest
@Transactional   // 테스트 후 롤백
class BoardServiceTest {

    @Autowired
    BoardService boardService;

    @Test
    void create() {
        // given
        BoardSaveReq boardSaveReq = new BoardSaveReq();
        boardSaveReq.setCategory("한식");
        boardSaveReq.setTitle("테스트 제목");
        boardSaveReq.setPrepare("테스트 준비물");
        boardSaveReq.setContent("테스트 본문");
        boardSaveReq.setThumbnail("");

        String writerEmail = "123@test.com";

        // when
        Long boardId = boardService.create(boardSaveReq, writerEmail);

        // then
        log.info("생성된 게시글 ID = {}", boardId);
        assertThat(boardId).isNotNull();
    }
}
