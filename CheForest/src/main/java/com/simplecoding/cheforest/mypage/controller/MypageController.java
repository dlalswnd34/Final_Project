package com.simplecoding.cheforest.mypage.controller;

import com.simplecoding.cheforest.mypage.dto.*;
import com.simplecoding.cheforest.mypage.service.MypageService;
import com.simplecoding.cheforest.member.dto.MemberDetailDto;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
public class MypageController {

    private final MypageService mypageService;

    // 마이페이지 메인 (내 글 + 좋아요)
    @GetMapping("/mypage")
    public String myPage(
            @RequestParam(value = "tab", defaultValue = "myboard") String tab,
            @RequestParam(value = "myPostsPage", defaultValue = "1") int myPostsPage,
            @RequestParam(value = "likedPostsPage", defaultValue = "1") int likedPostsPage,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            HttpSession session,
            Model model) {

        // ✅ 세션에서 MemberDetailDto 사용
        MemberDetailDto loginUser = (MemberDetailDto) session.getAttribute("loginUser");
        if (loginUser == null || loginUser.getMemberIdx() == null) {
            return "redirect:/member/login";
        }
        Long memberIdx = loginUser.getMemberIdx();

        // 내가 작성한 글 (페이징)
        Pageable myPostsPageable = PageRequest.of(myPostsPage - 1, 10, Sort.by("insertTime").descending());
        Page<MypageMyPostDto> myPosts = mypageService.getMyPosts(memberIdx, searchKeyword, myPostsPageable);

        model.addAttribute("myPosts", myPosts.getContent());
        model.addAttribute("myPostsTotalCount", myPosts.getTotalElements());
        model.addAttribute("myPostsPaginationInfo", myPosts); // Page 객체 자체 전달

        // 내가 좋아요한 레시피 (페이징)
        Pageable likedRecipesPageable = PageRequest.of(likedPostsPage - 1, 10, Sort.by("insertTime").descending());
        Page<MypageLikedRecipeDto> likedRecipes = mypageService.getLikedRecipes(memberIdx, searchKeyword, likedRecipesPageable);

        model.addAttribute("likedRecipes", likedRecipes.getContent());
        model.addAttribute("likedRecipesTotalCount", likedRecipes.getTotalElements());
        model.addAttribute("likedRecipesPaginationInfo", likedRecipes);

        // 내가 좋아요한 게시글 (페이징)
        Pageable likedBoardsPageable = PageRequest.of(likedPostsPage - 1, 10, Sort.by("insertTime").descending());
        Page<MypageLikedBoardDto> likedBoards = mypageService.getLikedBoards(memberIdx, searchKeyword, likedBoardsPageable);

        model.addAttribute("likedPosts", likedBoards.getContent());
        model.addAttribute("likedPostsTotalCount", likedBoards.getTotalElements());
        model.addAttribute("likedPostsPaginationInfo", likedBoards);

        // 현재 탭 상태
        model.addAttribute("tab", tab);

        return "mypage/mypage";
    }
}
