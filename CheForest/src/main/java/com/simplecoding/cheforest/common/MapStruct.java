package com.simplecoding.cheforest.common;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;
import com.simplecoding.cheforest.member.dto.*;
import com.simplecoding.cheforest.member.entity.Member;
import com.simplecoding.cheforest.board.dto.*;
import com.simplecoding.cheforest.board.entity.Board;
import com.simplecoding.cheforest.review.dto.*;
import com.simplecoding.cheforest.review.entity.Review;
import com.simplecoding.cheforest.like.dto.LikeDto;
import com.simplecoding.cheforest.like.entity.Like;
import com.simplecoding.cheforest.file.dto.FileDto;
import com.simplecoding.cheforest.file.entity.UploadFile;
import com.simplecoding.cheforest.recipe.dto.RecipeDto;
import com.simplecoding.cheforest.recipe.entity.Recipe;

@Mapper(componentModel = "spring",
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface MapStruct {
    // Member
    // 회원가입: DTO -> 엔티티
    Member toEntity(MemberSaveReq dto);

    // 회원수정: DTO -> 엔티티 (기존 엔티티 덮어쓰기)
    void updateEntity(MemberUpdateReq dto, @MappingTarget Member member);

    // 엔티티 -> 상세조회 DTO
    @Mapping(source = "createdAt", target = "joinDate")
    @Mapping(source = "role", target = "role") // Enum → String 자동 변환
    MemberDetailDto toDetailDto(Member member);

    // Board
    Board toEntity(BoardSaveDto dto);
    BoardDetailDto toDto(Board entity);

    // Review
    Review toEntity(ReviewSaveDto dto);
    ReviewDto toDto(Review entity);

    // Like
    Like toEntity(LikeDto dto);
    LikeDto toDto(Like entity);

    // File
    UploadFile toEntity(FileDto dto);
    FileDto toDto(UploadFile entity);

    // Recipe
    Recipe toEntity(RecipeDto dto);
    RecipeDto toDto(Recipe entity);
}
