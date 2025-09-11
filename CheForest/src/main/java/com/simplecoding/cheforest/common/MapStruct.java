package com.simplecoding.cheforest.common;

import com.simplecoding.cheforest.file.entity.File;
import com.simplecoding.cheforest.like.dto.LikeRes;
import com.simplecoding.cheforest.like.dto.LikeSaveReq;
import com.simplecoding.cheforest.like.entity.Like;
import org.mapstruct.*;
import com.simplecoding.cheforest.member.dto.*;
import com.simplecoding.cheforest.member.entity.Member;
import com.simplecoding.cheforest.board.dto.*;
import com.simplecoding.cheforest.board.entity.Board;
import com.simplecoding.cheforest.review.dto.*;
import com.simplecoding.cheforest.review.entity.Review;
import com.simplecoding.cheforest.like.dto.LikeDto;
import com.simplecoding.cheforest.file.dto.FileDto;
import com.simplecoding.cheforest.recipe.dto.RecipeDto;
import com.simplecoding.cheforest.recipe.entity.Recipe;

import java.util.List;

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

    @Mapping(target = "boardId", ignore = true)   // PK는 DB 자동 생성
    @Mapping(target = "writer", ignore = true)    // 서비스에서 Member 주입
    @Mapping(target = "viewCount", constant = "0L")
    @Mapping(target = "likeCount", constant = "0L")
    Board toEntity(BoardSaveReq dto);

    @Mapping(target = "writer", ignore = true)
    @Mapping(target = "viewCount", ignore = true)
    @Mapping(target = "likeCount", ignore = true)
    Board toEntity(BoardUpdateReq dto);


    // ================= Review =================
    // ReviewSaveReq → Review 엔티티
    @Mapping(source = "boardId", target = "board.boardId")  // DTO의 boardId → Entity의 Board 객체 내부 PK
    @Mapping(source = "writerIdx", target = "writer.memberIdx")
    Review toEntity(ReviewSaveReq dto);

    // Review 엔티티 → ReviewRes DTO
    @Mapping(source = "board.boardId", target = "boardId")
    @Mapping(source = "writer.memberIdx", target = "writerIdx")
    @Mapping(source = "writer.nickname", target = "nickname")
    ReviewRes toDto(Review entity);

    @Mapping(source = "boardId", target = "board.boardId")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void updateEntityFromDto(ReviewUpdateReq dto, @MappingTarget Review entity);


    // ================= File =================
    @Mapping(source = "uploader.id", target = "uploaderId")
    FileDto toDto(File file);

    @Mapping(source = "uploaderId", target = "uploader.id")
    File toEntity(FileDto fileDto);

    // Like
    // Entity → DTO
    LikeDto toDto(Like like);

    // DTO → Entity
    Like toEntity(LikeDto likeDto);

    // SaveReq → Entity
    Like toEntity(LikeSaveReq likeSaveReq);

    // DTO → Res
    LikeRes toRes(LikeDto likeDto);

    // Recipe
    Recipe toEntity(RecipeDto dto);
    RecipeDto toDto(Recipe entity);
    List<RecipeDto> toDtoList(List<Recipe> entities);
    List<Recipe> toEntityList(List<RecipeDto> dtos);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void updateFromDto(RecipeDto dto, @MappingTarget Recipe entity);
}
