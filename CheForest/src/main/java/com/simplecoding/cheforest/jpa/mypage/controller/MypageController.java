package com.simplecoding.cheforest.jpa.mypage.controller;

import com.simplecoding.cheforest.jpa.auth.entity.Member;
import com.simplecoding.cheforest.jpa.auth.repository.MemberRepository;
import com.simplecoding.cheforest.jpa.auth.security.CustomOAuth2User;
import com.simplecoding.cheforest.jpa.auth.security.CustomUserDetails;
import com.simplecoding.cheforest.jpa.board.repository.BoardRepository;
import com.simplecoding.cheforest.jpa.file.repository.FileRepository;
import com.simplecoding.cheforest.jpa.mypage.dto.MypageLikedBoardDto;
import com.simplecoding.cheforest.jpa.mypage.dto.MypageLikedRecipeDto;
import com.simplecoding.cheforest.jpa.mypage.dto.MypageMyPostDto;
import com.simplecoding.cheforest.jpa.mypage.dto.MypageReviewDto;
import com.simplecoding.cheforest.jpa.mypage.service.MypageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
public class MypageController {

    private final MypageService mypageService;
    private final BoardRepository boardRepository;
    private final PasswordEncoder passwordEncoder;
    private final MemberRepository memberRepository;

    @Value("${file.upload-dir}")
    private String uploadDir;

    @GetMapping("")
    public String mypageMain(@RequestParam(defaultValue = "myboard") String tab,
                             @RequestParam(value = "myPostsPage",     defaultValue = "1") int myPostsPage,
                             @RequestParam(value = "likedPostsPage",  defaultValue = "1") int likedPostsPage,
                             @RequestParam(value = "myCommentsPage",  defaultValue = "1") int myCommentsPage,
                             @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                             @AuthenticationPrincipal Object principal,
                             Model model) {

        Member member = null;

        // ✅ 일반 로그인
        if (principal instanceof CustomUserDetails user) {
            member = user.getMember();
        }
        // ✅ 소셜 로그인 (카카오/네이버/구글)
        else if (principal instanceof CustomOAuth2User oauthUser) {
            member = oauthUser.getMember();
        }

        // ✅ 로그인 안 된 경우
        if (member == null) {
            return "redirect:/auth/login?redirect=/mypage";
        }

        Long memberIdx = member.getMemberIdx();
        model.addAttribute("activeTab", tab);
        model.addAttribute("currentMemberIdx", memberIdx);

        // ===== 상단 통계 =====
        long receivedLikesTotal    = mypageService.getReceivedBoardLikes(memberIdx);
        long myPostsTotalViewCount = mypageService.getMyPostsTotalViewCount(memberIdx);
        long myCommentsTotalCount  = mypageService.getMyCommentsTotalCount(memberIdx);

        model.addAttribute("receivedLikesTotalCount", receivedLikesTotal);
        model.addAttribute("myPostsTotalViewCount", myPostsTotalViewCount);
        model.addAttribute("myCommentsTotalCount", myCommentsTotalCount);

        // ===== 내가 작성한 글 =====
        Pageable myPostsPageable = PageRequest.of(myPostsPage - 1, 10, Sort.by("insertTime").descending());
        Page<MypageMyPostDto> myPosts = mypageService.getMyPosts(memberIdx, searchKeyword, myPostsPageable);
        model.addAttribute("myPosts", myPosts.getContent());
        model.addAttribute("myPostsTotalCount", myPosts.getTotalElements());
        model.addAttribute("myPostsPaginationInfo", myPosts);

        // ===== 내가 좋아요한 레시피 =====
        Pageable likedRecipesPageable = PageRequest.of(likedPostsPage - 1, 10, Sort.by("likeDate").descending());
        Page<MypageLikedRecipeDto> likedRecipes = mypageService.getLikedRecipes(memberIdx, searchKeyword, likedRecipesPageable);
        model.addAttribute("likedRecipes", likedRecipes.getContent());
        model.addAttribute("likedRecipesTotalCount", likedRecipes.getTotalElements());
        model.addAttribute("likedRecipesPaginationInfo", likedRecipes);

        // ===== 내가 좋아요한 게시글 =====
        Pageable likedBoardsPageable = PageRequest.of(likedPostsPage - 1, 10, Sort.by("likeDate").descending());
        Page<MypageLikedBoardDto> likedBoards = mypageService.getLikedBoards(memberIdx, searchKeyword, likedBoardsPageable);
        model.addAttribute("likedPosts", likedBoards.getContent());
        model.addAttribute("likedPostsTotalCount", likedBoards.getTotalElements());
        model.addAttribute("likedPostsPaginationInfo", likedBoards);

        // ===== 내가 쓴 댓글 =====
        Pageable myCommentsPageable = PageRequest.of(myCommentsPage - 1, 10, Sort.by("insertTime").descending());
        Page<MypageReviewDto> myReviews = mypageService.getMyReviews(memberIdx, myCommentsPageable);
        model.addAttribute("myReviews", myReviews.getContent());
        model.addAttribute("myReviewsTotalCount", myReviews.getTotalElements());
        model.addAttribute("myReviewsPaginationInfo", myReviews);

        // ===== 카테고리, 썸네일 매핑 =====
        List<Long> ids = myPosts.getContent().stream()
                .map(MypageMyPostDto::getBoardId)
                .toList();

        Map<Long, String> categoryById  = new HashMap<>();
        Map<Long, String> thumbnailById = new HashMap<>();
        if (!ids.isEmpty()) {
            for (Object[] r : boardRepository.findMetaByIds(ids)) {
                Long id = (Long) r[0];
                categoryById.put(id,  (String) r[1]); // category
                thumbnailById.put(id, (String) r[2]); // thumbnail
            }
        }
        model.addAttribute("categoryById", categoryById);
        model.addAttribute("thumbnailById", thumbnailById);

        // ===== 가입일 =====
        model.addAttribute("joinDate", mypageService.getMemberJoinDateText(memberIdx));

        // ===== 등급 및 진행률 계산 =====
        final Map<String, Integer> levelMap = new LinkedHashMap<>();
        levelMap.put("씨앗", 0);
        levelMap.put("뿌리", 1000);
        levelMap.put("새싹", 2000);
        levelMap.put("나무", 3000);
        levelMap.put("숲", 4000);
        final List<String> levels = new ArrayList<>(levelMap.keySet());

        int userPoints = member.getPoint().intValue();
        String currentLevel = "씨앗";
        int currentLevelIndex = 0;

        for (int i = levels.size() - 1; i >= 0; i--) {
            String levelName = levels.get(i);
            if (userPoints >= levelMap.get(levelName)) {
                currentLevel = levelName;
                currentLevelIndex = i;
                break;
            }
        }

        String nextLevel = (currentLevelIndex < levels.size() - 1) ? levels.get(currentLevelIndex + 1) : null;
        long pointsNeeded = 0;
        double progressPercentage = 100.0;

        if (nextLevel != null) {
            int currentLevelMinPoints = levelMap.get(currentLevel);
            int nextLevelMinPoints = levelMap.get(nextLevel);

            int pointsInCurrentLevel = userPoints - currentLevelMinPoints;
            int pointsForNextLevelup = nextLevelMinPoints - currentLevelMinPoints;

            pointsNeeded = nextLevelMinPoints - userPoints;
            progressPercentage = ((double) pointsInCurrentLevel / pointsForNextLevelup) * 100;
        }

        model.addAttribute("currentLevel", currentLevel);
        model.addAttribute("nextLevel", nextLevel);
        model.addAttribute("userPoints", userPoints);
        model.addAttribute("pointsNeeded", pointsNeeded);
        model.addAttribute("progressPercentage", String.format("%.2f", progressPercentage));

        return "mypage/mypage";
    }


//    설정탭 비밀번호 잠금
    @PostMapping("/verify-settings")
    public ResponseEntity<?> verifySettingsPassword(
            @AuthenticationPrincipal Object principal,
            @RequestBody Map<String, String> payload
    ) {
        // 1️⃣ 로그인 여부 확인
        if (principal == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        // 2️⃣ 일반 로그인 (CustomUserDetails)
        if (principal instanceof CustomUserDetails user) {
            // provider가 null이면 일반 회원, 있으면 소셜 연동 회원
            if (user.getMember().getProvider() == null) {
                String rawPassword = payload.get("password");
                String encodedPassword = user.getPassword();

                if (passwordEncoder.matches(rawPassword, encodedPassword)) {
                    return ResponseEntity.ok("비밀번호 확인 성공");
                } else {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("비밀번호가 올바르지 않습니다.");
                }
            } else {
                // ✅ 소셜 로그인은 통과
                return ResponseEntity.ok("소셜 로그인은 비밀번호 확인 없이 접근 가능합니다.");
            }
        }

        // 3️⃣ 소셜 로그인 (CustomOAuth2User)
        if (principal instanceof CustomOAuth2User) {
            return ResponseEntity.ok("소셜 로그인은 비밀번호 확인 없이 접근 가능합니다.");
        }

        // 4️⃣ 기타 예외
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
    }

    /* =========================
     * 🧩 프로필 경로(Member.profile) 업데이트
     * ========================= */
    @PostMapping("/profile/update")
    @ResponseBody
    public ResponseEntity<String> updateProfilePath(
            @AuthenticationPrincipal Object principal,
            @RequestParam("filePath") String filePath
    ) {
        Member member = null;
        if (principal instanceof CustomUserDetails user) {
            member = user.getMember();
        } else if (principal instanceof CustomOAuth2User oauthUser) {
            member = oauthUser.getMember();
        }

        if (member == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        // DB 업데이트
        member.setProfile(filePath);
        memberRepository.save(member);

        log.info("✅ 프로필 이미지 경로 업데이트 완료: memberIdx={} -> {}", member.getMemberIdx(), filePath);
        return ResponseEntity.ok("프로필 이미지가 변경되었습니다.");
    }
}