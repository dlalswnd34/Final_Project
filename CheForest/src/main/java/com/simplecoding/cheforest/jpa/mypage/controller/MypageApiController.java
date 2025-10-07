package com.simplecoding.cheforest.jpa.mypage.controller;

import com.simplecoding.cheforest.jpa.auth.entity.Member;
import com.simplecoding.cheforest.jpa.auth.security.CustomOAuth2User;
import com.simplecoding.cheforest.jpa.auth.security.CustomUserDetails;
import com.simplecoding.cheforest.jpa.inquiries.dto.InquiryWithNicknameDto;
import com.simplecoding.cheforest.jpa.inquiries.service.InquiriesService;
import com.simplecoding.cheforest.jpa.mypage.dto.MypageLikedBoardDto;
import com.simplecoding.cheforest.jpa.mypage.dto.MypageLikedRecipeDto;
import com.simplecoding.cheforest.jpa.mypage.dto.MypageMyPostDto;
import com.simplecoding.cheforest.jpa.mypage.dto.MypageReviewDto;
import com.simplecoding.cheforest.jpa.mypage.service.MypageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.*;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.*;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Slf4j
@RestController
@RequiredArgsConstructor
public class MypageApiController {

    private final MypageService mypageService;
    private final InquiriesService inquiriesService;

    /** ✅ 공통 멤버 추출 유틸 */
    private Member getMember(Object principal) {
        if (principal instanceof CustomUserDetails user) return user.getMember();
        if (principal instanceof CustomOAuth2User oauthUser) return oauthUser.getMember();
        return null;
    }

    /* =========================================================
     * 🧩 [1] 내가 작성한 레시피 목록 (게시글)
     * ========================================================= */
    @GetMapping("/api/mypage/my-posts")
    public ResponseEntity<?> getMyPosts(
            @AuthenticationPrincipal Object principal,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword
    ) {
        Member member = getMember(principal);
        if (member == null)
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "로그인이 필요합니다."));

        Pageable pageable = PageRequest.of(page, size, Sort.by("insertTime").descending());
        Page<MypageMyPostDto> result = mypageService.getMyPosts(member.getMemberIdx(), keyword, pageable);

        return ResponseEntity.ok(Map.of(
                "data", result.getContent(),
                "page", result.getNumber() + 1,
                "totalPages", result.getTotalPages(),
                "total", result.getTotalElements()
        ));
    }

    /* =========================================================
     * 🧩 [2] 내가 작성한 댓글
     * ========================================================= */
    @GetMapping("/api/mypage/my-comments")
    public ResponseEntity<?> getMyComments(
            @AuthenticationPrincipal Object principal,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        Member member = getMember(principal);
        if (member == null)
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "로그인이 필요합니다."));

        Pageable pageable = PageRequest.of(page, size, Sort.by("insertTime").descending());
        Page<MypageReviewDto> result = mypageService.getMyReviews(member.getMemberIdx(), pageable);

        return ResponseEntity.ok(Map.of(
                "data", result.getContent(),
                "page", result.getNumber() + 1,
                "totalPages", result.getTotalPages(),
                "total", result.getTotalElements()
        ));
    }

    /* =========================================================
     * 🧩 [3] 내가 좋아요한 CheForest 레시피
     * ========================================================= */
    @GetMapping("/api/mypage/liked/recipes")
    public ResponseEntity<?> getLikedRecipes(
            @AuthenticationPrincipal Object principal,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        Member member = getMember(principal);
        if (member == null)
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "로그인이 필요합니다."));

        Pageable pageable = PageRequest.of(page, size, Sort.by("likeDate").descending());
        Page<MypageLikedRecipeDto> result = mypageService.getLikedRecipes(member.getMemberIdx(), null, pageable);

        return ResponseEntity.ok(Map.of(
                "data", result.getContent(),
                "page", result.getNumber() + 1,
                "totalPages", result.getTotalPages(),
                "total", result.getTotalElements()
        ));
    }

    /* =========================================================
     * 🧩 [4] 내가 좋아요한 사용자 레시피 (게시글)
     * ========================================================= */
    @GetMapping("/api/mypage/liked/posts")
    public ResponseEntity<?> getLikedBoards(
            @AuthenticationPrincipal Object principal,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        Member member = getMember(principal);
        if (member == null)
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "로그인이 필요합니다."));

        Pageable pageable = PageRequest.of(page, size, Sort.by("likeDate").descending());
        Page<MypageLikedBoardDto> result = mypageService.getLikedBoards(member.getMemberIdx(), null, pageable);

        return ResponseEntity.ok(Map.of(
                "data", result.getContent(),
                "page", result.getNumber() + 1,
                "totalPages", result.getTotalPages(),
                "total", result.getTotalElements()
        ));
    }

    /**
     * 마이페이지: 로그인된 사용자의 문의 내역을 페이징하여 조회하는 API
     */
    @GetMapping("/api/mypage/inquiries")
    public ResponseEntity<Map<String, Object>> getMyInquiries(
            @AuthenticationPrincipal(expression = "member.memberIdx") Long memberIdx,
            @RequestParam(defaultValue = "all") String status,   // ✅ 추가됨
            @PageableDefault(size = 5, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable
    ) {
        if (memberIdx == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        Page<InquiryWithNicknameDto> pageResult = inquiriesService.getMyInquiries(memberIdx, status, pageable);

        Map<String, Object> body = new HashMap<>();
        body.put("data", pageResult.getContent());
        body.put("total", pageResult.getTotalElements());
        body.put("totalPages", pageResult.getTotalPages());
        body.put("page", pageResult.getNumber() + 1); // 1-based
        body.put("size", pageable.getPageSize());
        body.put("status", status);

        return ResponseEntity.ok(body);
    }

    /**
     * 마이페이지: 사용자가 자신의 문의를 삭제하는 API
     */
    @PostMapping("/inquiries/my/delete")
    public ResponseEntity<String> deleteMyInquiry(
            @AuthenticationPrincipal(expression = "member.memberIdx") Long memberIdx,
            @RequestBody Map<String, Object> payload
    ) {
        if (memberIdx == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        Long inquiryId = Long.valueOf(String.valueOf(payload.get("inquiryId")));
        try {
            inquiriesService.deleteInquiry(inquiryId, memberIdx);
            return ResponseEntity.ok("성공적으로 문의사항이 삭제되었습니다.");
        } catch (SecurityException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(e.getMessage());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류 발생: " + e.getMessage());
        }
    }

    //    마이페이지에서 회원이 작성한 문의내용 수정
    @PostMapping("/inquiries/my/update")
    public ResponseEntity<String> updateMyInquiry(
            @AuthenticationPrincipal(expression = "member.memberIdx") Long memberIdx,
            @RequestBody Map<String, Object> payload
    ) {
        if (memberIdx == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        Long inquiryId = Long.valueOf(String.valueOf(payload.get("inquiryId")));
        String newTitle   = String.valueOf(payload.get("title"));
        String newContent = String.valueOf(payload.get("content"));

        try {
            inquiriesService.updateInquiry(inquiryId, memberIdx, newTitle, newContent);
            return ResponseEntity.ok("문의가 수정되었습니다.");
        } catch (SecurityException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("❌ 권한이 없습니다.");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("❌ 문의를 찾을 수 없습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("❌ 서버 오류: " + e.getMessage());
        }
    }
}
