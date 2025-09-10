package com.simplecoding.cheforest.common;

import com.simplecoding.cheforest.file.entity.FileEntity;
import org.mapstruct.*;
import com.simplecoding.cheforest.member.dto.*;
import com.simplecoding.cheforest.member.entity.Member;
import com.simplecoding.cheforest.board.dto.*;
import com.simplecoding.cheforest.board.entity.Board;
import com.simplecoding.cheforest.review.dto.*;
import com.simplecoding.cheforest.review.entity.Review;
import com.simplecoding.cheforest.like.dto.LikeDto;
import com.simplecoding.cheforest.like.entity.Like;
import com.simplecoding.cheforest.file.dto.FileDto;
import com.simplecoding.cheforest.recipe.dto.RecipeDto;
import com.simplecoding.cheforest.recipe.entity.Recipe;

@Mapper(componentModel = "spring",
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface MapStruct {
    // ================= Member =================
    Member toEntity(MemberSaveReq dto);

    void updateEntity(MemberUpdateReq dto, @MappingTarget Member member);

    MemberDetailDto toDetailDto(Member member);


    // ================= Board =================
    @Mapping(target = "nickname", source = "writer.nickname")
    BoardListDto toListDto(Board board);

    @Mapping(target = "nickname", source = "writer.nickname")
    @Mapping(target = "profile", source = "writer.profile")
    BoardDetailDto toDetailDto(Board board);

    @Mapping(target = "id", ignore = true)         // PK는 DB 자동 생성
    @Mapping(target = "writer", ignore = true)    // 서비스에서 Member 주입
    @Mapping(target = "viewCount", constant = "0L")
    @Mapping(target = "likeCount", constant = "0L")
    Board toEntity(BoardSaveReq dto);

    @Mapping(target = "writer", ignore = true)
    @Mapping(target = "viewCount", ignore = true)
    @Mapping(target = "likeCount", ignore = true)
    Board toEntity(BoardUpdateReq dto);


    // ================= Review =================
    @Mapping(source = "boardId", target = "board.id")       // DTO boardId → 엔티티 board.id
    @Mapping(source = "writerIdx", target = "writer.memberIdx")
    Review toEntity(ReviewSaveReq dto);

    @Mapping(source = "board.id", target = "boardId")
    @Mapping(source = "writer.memberIdx", target = "writerIdx")
    @Mapping(source = "writer.nickname", target = "nickname")
    ReviewRes toDto(Review entity);

    @Mapping(source = "boardId", target = "board.id")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void updateEntityFromDto(ReviewUpdateReq dto, @MappingTarget Review entity);


    // ================= File =================
    @Mapping(source = "uploader.id", target = "uploaderId")
    FileDto toDto(FileEntity fileEntity);

    @Mapping(source = "uploaderId", target = "uploader.id")
    FileEntity toEntity(FileDto fileDto);

    // Like
    Like toEntity(LikeDto dto);
    LikeDto toDto(Like entity);

    // Recipe
    Recipe toEntity(RecipeDto dto);
    RecipeDto toDto(Recipe entity);
}
