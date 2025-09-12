package com.simplecoding.cheforest.board.repository;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.simplecoding.cheforest.board.dto.BoardDetailDto;
import com.simplecoding.cheforest.board.dto.BoardListDto;
import com.simplecoding.cheforest.board.entity.QBoard;
import com.simplecoding.cheforest.member.entity.QMember;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class BoardRepositoryDsl {

    private final JPAQueryFactory queryFactory;

    // 목록 조회
    public Page<BoardListDto> searchBoards(String keyword, String category, Pageable pageable) {
        QBoard board = QBoard.board;
        QMember member = QMember.member;

        BooleanBuilder builder = new BooleanBuilder();
        if (keyword != null && !keyword.isBlank()) {
            builder.and(board.title.containsIgnoreCase(keyword));
        }
        if (category != null && !category.isBlank()) {
            builder.and(board.category.eq(category));
        }

        List<BoardListDto> content = queryFactory
                .select(Projections.bean(BoardListDto.class,
                        board.boardId.as("boardId"),
                        board.category.as("category"),
                        board.title.as("title"),
                        member.nickname.as("nickname"),
                        member.memberIdx.as("writerIdx"),
                        board.viewCount.as("viewCount"),
                        board.likeCount.as("likeCount"),
                        board.thumbnail.as("thumbnail"),
                        board.insertTime.as("insertTime")
                ))
                .from(board)
                .join(board.writer, member)
                .where(builder)
                .orderBy(board.boardId.desc())
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .fetch();

        long total = queryFactory
                .select(board.count())
                .from(board)
                .where(builder)
                .fetchOne();

        return new PageImpl<>(content, pageable, total);
    }

    // 상세 조회
    public BoardDetailDto findBoardDetail(Long boardId) {
        QBoard board = QBoard.board;
        QMember member = QMember.member;

        return queryFactory
                .select(Projections.bean(BoardDetailDto.class,
                        board.boardId.as("boardId"),
                        board.category.as("category"),
                        board.title.as("title"),
                        board.prepare.as("prepare"),
                        board.content.as("content"),
                        board.thumbnail.as("thumbnail"),
                        member.nickname.as("nickname"),
                        member.profile.as("profile"),
                        member.memberIdx.as("writerIdx"),
                        board.viewCount.as("viewCount"),
                        board.likeCount.as("likeCount"),
                        board.insertTime.as("insertTime"),
                        board.updateTime.as("updateTime")
                ))
                .from(board)
                .join(board.writer, member)
                .where(board.boardId.eq(boardId))
                .fetchOne();
    }

    // 인기글 TOP4
    public List<BoardListDto> findBestPosts() {
        QBoard board = QBoard.board;
        QMember member = QMember.member;

        return queryFactory
                .select(Projections.bean(BoardListDto.class,
                        board.boardId.as("boardId"),
                        board.category.as("category"),
                        board.title.as("title"),
                        member.nickname.as("nickname"),
                        member.memberIdx.as("writerIdx"),
                        board.viewCount.as("viewCount"),
                        board.likeCount.as("likeCount"),
                        board.thumbnail.as("thumbnail"),
                        board.insertTime.as("insertTime")
                ))
                .from(board)
                .join(board.writer, member)
                .orderBy(board.likeCount.desc(), board.boardId.desc())
                .limit(4)
                .fetch();
    }

    // 카테고리별 인기글 TOP4
    public List<BoardListDto> findBestPostsByCategory(String category) {
        QBoard board = QBoard.board;
        QMember member = QMember.member;

        return queryFactory
                .select(Projections.bean(BoardListDto.class,
                        board.boardId.as("boardId"),
                        board.category.as("category"),
                        board.title.as("title"),
                        member.nickname.as("nickname"),
                        member.memberIdx.as("writerIdx"),
                        board.viewCount.as("viewCount"),
                        board.likeCount.as("likeCount"),
                        board.thumbnail.as("thumbnail"),
                        board.insertTime.as("insertTime")
                ))
                .from(board)
                .join(board.writer, member)
                .where(board.category.eq(category))
                .orderBy(board.likeCount.desc(), board.boardId.desc())
                .limit(4)
                .fetch();
    }
}
