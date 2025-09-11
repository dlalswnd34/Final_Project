package com.simplecoding.cheforest.mypage.service;

import com.simplecoding.cheforest.mypage.dto.MypageLikedBoardDto;
import com.simplecoding.cheforest.mypage.dto.MypageLikedRecipeDto;
import com.simplecoding.cheforest.mypage.dto.MypageMyPostDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MypageService {

    private final com.simplecoding.cheforest.mypage.repository.MypageRepository mypageRepository;

    // 내가 작성한 글
    public Page<MypageMyPostDto> getMyPosts(Long memberIdx, String keyword, Pageable pageable) {
        log.info("내가 작성한 글 조회 - memberIdx={}, keyword={}", memberIdx, keyword);
        return mypageRepository.findMyPosts(memberIdx, keyword, pageable);
    }

    public int getMyPostsCount(Long memberIdx, String keyword) {
        return mypageRepository.countMyPosts(memberIdx, keyword);
    }

    // 내가 좋아요한 게시글
    public Page<MypageLikedBoardDto> getLikedBoards(Long memberIdx, String keyword, Pageable pageable) {
        log.info("좋아요한 게시글 조회 - memberIdx={}, keyword={}", memberIdx, keyword);
        return mypageRepository.findLikedBoards(memberIdx, keyword, pageable);
    }

    public int getLikedBoardsCount(Long memberIdx, String keyword) {
        return mypageRepository.countLikedBoards(memberIdx, keyword);
    }

    // 내가 좋아요한 레시피
    public Page<MypageLikedRecipeDto> getLikedRecipes(Long memberIdx, String keyword, Pageable pageable) {
        log.info("좋아요한 레시피 조회 - memberIdx={}, keyword={}", memberIdx, keyword);
        return mypageRepository.findLikedRecipes(memberIdx, keyword, pageable);
    }

    public int getLikedRecipesCount(Long memberIdx, String keyword) {
        return mypageRepository.countLikedRecipes(memberIdx, keyword);
    }
}
