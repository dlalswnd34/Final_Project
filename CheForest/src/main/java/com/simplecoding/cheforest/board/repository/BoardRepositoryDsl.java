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

        // content 조회 (DTO 매핑)
        List<BoardListDto> content = queryFactory
                .select(Projections.constructor(BoardListDto.class,
                        board.id,
                        board.category,
                        board.title,
                        member.nickname,
                        board.viewCount,
                        board.likeCount,
                        board.insertTime
                ))
                .from(board)
                .join(board.writer, member)  // Board ↔ Member 조인
                .where(builder)
                .orderBy(board.id.desc())
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .fetch();

        // total count 조회
        long total = queryFactory
                .select(board.count())
                .from(board)
                .where(builder)
                .fetchOne();

        return new PageImpl<>(content, pageable, total);
    }

    public BoardDetailDto findBoardDetail(Long boardId) {
        QBoard board = QBoard.board;
        QMember member = QMember.member;

        return queryFactory
                .select(Projections.constructor(BoardDetailDto.class,
                        board.id,
                        board.category,
                        board.title,
                        board.content,
                        board.thumbnail,
                        member.nickname,
                        board.prepare,
                        board.viewCount,
                        board.likeCount,
                        board.insertTime
                ))
                .from(board)
                .join(board.writer, member)
                .where(board.id.eq(boardId))
                .fetchOne();
    }

    // 인기 게시글 TOP 4
    public List<BoardListDto> findBestPosts() {
        QBoard board = QBoard.board;
        QMember member = QMember.member;

        return queryFactory
                .select(Projections.constructor(BoardListDto.class,
                        board.id,
                        board.category,
                        board.title,
                        member.nickname,
                        board.viewCount,
                        board.likeCount,
                        board.insertTime
                ))
                .from(board)
                .join(board.writer, member)
                .orderBy(board.likeCount.desc(), board.id.desc())
                .limit(4)
                .fetch();
    }

    // 카테고리별 인기 게시글 TOP 4
    public List<BoardListDto> findBestPostsByCategory(String category) {
        QBoard board = QBoard.board;
        QMember member = QMember.member;

        return queryFactory
                .select(Projections.constructor(BoardListDto.class,
                        board.id,
                        board.category,
                        board.title,
                        member.nickname,
                        board.viewCount,
                        board.likeCount,
                        board.insertTime
                ))
                .from(board)
                .join(board.writer, member)
                .where(board.category.eq(category))
                .orderBy(board.likeCount.desc(), board.id.desc())
                .limit(4)
                .fetch();
    }
}
