package com.simplecoding.cheforest.like.service;

import com.simplecoding.cheforest.like.dto.LikeDto;
import com.simplecoding.cheforest.like.entity.Like;
import com.simplecoding.cheforest.like.repository.LikeRepository;
import com.simplecoding.cheforest.common.MapStruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class LikeService {

    private final LikeRepository likeRepository;
    private final MapStruct mapper;

    public LikeDto addLike(LikeDto dto) {
        Like like = mapper.toEntity(dto);
        Like saved = likeRepository.save(like);
        return mapper.toDto(saved);
    }

    public void removeLike(Long likeId) {
        likeRepository.deleteById(likeId);
    }

    public List<LikeDto> getLikesByBoard(Long boardId) {
        return likeRepository.findByBoardId(boardId).stream().map(mapper::toDto).toList();
    }

    public List<LikeDto> getLikesByRecipe(Long recipeId) {
        return likeRepository.findByRecipeId(recipeId).stream().map(mapper::toDto).toList();
    }

    public boolean existsBoardLike(Long boardId, Long memberIdx) {
        return likeRepository.existsByBoardIdAndMemberIdx(boardId, memberIdx);
    }

    public boolean existsRecipeLike(Long recipeId, Long memberIdx) {
        return likeRepository.existsByRecipeIdAndMemberIdx(recipeId, memberIdx);
    }
}
