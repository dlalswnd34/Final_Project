package com.simplecoding.cheforest.jpa.like.controller;


import com.simplecoding.cheforest.jpa.like.dto.LikeRes;
import com.simplecoding.cheforest.jpa.like.dto.LikeSaveReq;
import com.simplecoding.cheforest.jpa.like.service.LikeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/like")
@RequiredArgsConstructor
public class LikeController {

    private final LikeService likeService;

    /** 👍 좋아요 등록 */
    @PostMapping("/add")
    public LikeRes addLike(@RequestBody LikeSaveReq req) {
        log.info("📥 addLike 요청: {}", req);

        if ("BOARD".equalsIgnoreCase(req.getLikeType())) {
            if (likeService.existsBoardLike(req.getMemberIdx(), req.getBoardId())) {
                log.info("⚠️ 이미 좋아요 누름");
            } else {
                likeService.addLike(req);
            }
            // ✅ insert 후 즉시 최신 count 리턴
            long count = likeService.countBoardLikes(req.getBoardId());
            return LikeRes.builder()
                    .likeType("BOARD")
                    .boardId(req.getBoardId())
                    .likeCount(count)
                    .build();

        } else if ("RECIPE".equalsIgnoreCase(req.getLikeType())) {
            if (likeService.existsRecipeLike(req.getMemberIdx(), req.getRecipeId())) {
                log.info("⚠️ 이미 좋아요 누름");
            } else {
                likeService.addLike(req);
            }
            // ✅ insert 후 즉시 최신 count 리턴
            long count = likeService.countRecipeLikes(req.getRecipeId());
            return LikeRes.builder()
                    .likeType("RECIPE")
                    .recipeId(req.getRecipeId())
                    .likeCount(count)
                    .build();
        }

        return LikeRes.builder().likeType(req.getLikeType()).likeCount(0L).build();
    }

    /** ❌ 좋아요 취소 */
    @PostMapping("/remove")
    public LikeRes removeLike(@RequestBody LikeSaveReq req) {
        log.info("📥 removeLike 요청: {}", req);

        if ("BOARD".equalsIgnoreCase(req.getLikeType())) {
            if (likeService.existsBoardLike(req.getMemberIdx(), req.getBoardId())) {
                likeService.removeLike(req);
            } else {
                log.info("⚠️ 취소 요청했지만 좋아요 안 되어 있음");
            }
            // ✅ delete 후 최신 count 리턴
            long count = likeService.countBoardLikes(req.getBoardId());
            return LikeRes.builder()
                    .likeType("BOARD")
                    .boardId(req.getBoardId())
                    .likeCount(count)
                    .build();

        } else if ("RECIPE".equalsIgnoreCase(req.getLikeType())) {
            if (likeService.existsRecipeLike(req.getMemberIdx(), req.getRecipeId())) {
                likeService.removeLike(req);
            } else {
                log.info("⚠️ 취소 요청했지만 좋아요 안 되어 있음");
            }
            // ✅ delete 후 최신 count 리턴
            long count = likeService.countRecipeLikes(req.getRecipeId());
            return LikeRes.builder()
                    .likeType("RECIPE")
                    .recipeId(req.getRecipeId())
                    .likeCount(count)
                    .build();
        }

        return LikeRes.builder().likeType(req.getLikeType()).likeCount(0L).build();
    }

    /** 📊 좋아요 수 조회 */
    @GetMapping("/count")
    public long getLikeCount(@RequestParam(required = false) Long boardId,
                             @RequestParam(required = false) String recipeId,
                             @RequestParam String likeType) {
        if ("BOARD".equalsIgnoreCase(likeType) && boardId != null) {
            return likeService.countBoardLikes(boardId);
        } else if ("RECIPE".equalsIgnoreCase(likeType) && recipeId != null) {
            return likeService.countRecipeLikes(recipeId);
        }
        return 0L;
    }

    /** 🔍 좋아요 여부 확인 */
    @GetMapping("/check")
    public boolean checkLike(@RequestParam Long memberIdx,
                             @RequestParam String likeType,
                             @RequestParam(required = false) Long boardId,
                             @RequestParam(required = false) String recipeId) {
        if ("BOARD".equalsIgnoreCase(likeType) && boardId != null) {
            return likeService.existsBoardLike(memberIdx, boardId);
        } else if ("RECIPE".equalsIgnoreCase(likeType) && recipeId != null) {
            return likeService.existsRecipeLike(memberIdx, recipeId);
        }
        return false;
    }

    /** ✅ CheForest 레시피 좋아요 목록 (마이페이지용) */
    @GetMapping("/api/mypage/liked/recipes")
    public List<LikeRes> getLikedRecipes(
            @RequestParam Long memberIdx
    ) {
        return likeService.getLikesByMember(memberIdx, "RECIPE");
    }

    /** ✅ 사용자 작성 게시글 좋아요 목록 (마이페이지용) */
    @GetMapping("/api/mypage/liked/posts")
    public List<LikeRes> getLikedBoards(
            @RequestParam Long memberIdx
    ) {
        return likeService.getLikesByMember(memberIdx, "BOARD");
    }
}