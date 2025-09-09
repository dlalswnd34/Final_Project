package com.simplecoding.cheforest.common;

import org.mapstruct.Mapper;
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
    Member toEntity(MemberRegisterDto dto);
    MemberDetailDto toDto(Member entity);

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
