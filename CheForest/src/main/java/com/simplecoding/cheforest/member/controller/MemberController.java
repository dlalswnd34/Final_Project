package com.simplecoding.cheforest.member.controller;

import com.simplecoding.cheforest.file.service.FileService;
import com.simplecoding.cheforest.member.dto.*;
import com.simplecoding.cheforest.member.entity.Member;
import com.simplecoding.cheforest.member.service.EmailService;
import com.simplecoding.cheforest.member.service.MemberService;
import com.simplecoding.cheforest.member.service.social.KakaoLoginService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;
    private final EmailService emailService;
    private final KakaoLoginService kakaoLoginService;
    private final FileService fileService;

    // ✅ 회원가입 처리
    @PostMapping("/member/register")
    public String register(@ModelAttribute MemberSaveReq req,
                           RedirectAttributes rttr,
                           Model model) {
        try {
            memberService.register(req);
            rttr.addFlashAttribute("signupSuccess", true);
            return "redirect:/member/login";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "member/login";
        }
    }

    // ✅ 아이디 중복 검사 (AJAX)
    @ResponseBody
    @GetMapping("/member/idCheck")
    public Map<String, Boolean> idCheck(@RequestParam String id) {
        return Collections.singletonMap("available", memberService.isIdAvailable(id));
    }

    // ✅ 닉네임 중복 검사 (AJAX)
    @ResponseBody
    @GetMapping("/member/nicknameCheck")
    public Map<String, Boolean> nicknameCheck(@RequestParam String nickname,
                                              HttpSession session) {
        MemberDetailDto loginUser = (MemberDetailDto) session.getAttribute("loginUser");
        Long currentIdx = loginUser != null ? loginUser.getMemberIdx() : null;
        boolean available = memberService.isNicknameAvailable(nickname, currentIdx);
        return Collections.singletonMap("available", available);
    }

    // ✅ 로그인
    @PostMapping("/member/login")
    public String login(@ModelAttribute MemberLoginReq req,
                        HttpSession session,
                        Model model,
                        @RequestParam(value = "redirect", required = false) String redirect) {
        try {
            MemberDetailDto loginUser = memberService.authenticate(req);
            session.setAttribute("loginUser", loginUser);

            // 임시비밀번호 사용자 분기
            if ("Y".equals(loginUser.getTempPasswordYn()) && loginUser.getSocialId() == null) {
                session.setAttribute("redirectAfterLogin", redirect != null ? redirect : "/");
                return "redirect:/redirect/confirm";
            }

            if (redirect != null && !redirect.trim().isEmpty()) {
                return "redirect:" + redirect;
            }
            return "redirect:/";

        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "member/login";
        }
    }

    // ✅ 임시비밀번호 경고창
    @GetMapping("/redirect/confirm")
    public String showConfirmPage() {
        return "member/redirectConfirm";
    }

    // ✅ 로그인 페이지
    @GetMapping("/member/login")
    public String loginPage(@RequestParam(value = "redirect", required = false) String redirect,
                            HttpServletRequest request) {
        if (redirect == null || redirect.trim().isEmpty()) {
            redirect = "/";
        }
        String kakaoLink = "https://kauth.kakao.com/oauth/authorize?" +
                "client_id=" + "여기에_카카오_REST_KEY" +
                "&redirect_uri=" + "http://localhost:8080/member/kakao/callback" +
                "&response_type=code" +
                "&state=" + java.net.URLEncoder.encode(redirect, java.nio.charset.StandardCharsets.UTF_8);

        request.setAttribute("kakaoLink", kakaoLink);
        return "member/login";
    }

    // ✅ 로그아웃
    @GetMapping("/member/logout")
    public String logout(HttpSession session,
                         @RequestParam(value = "redirect", required = false) String redirect) {
        session.invalidate();
        return redirect != null ? "redirect:" + redirect : "redirect:/";
    }

    // ✅ 이메일 인증번호 발송
    @ResponseBody
    @PostMapping("/member/sendEmailCode")
    public Map<String, Object> sendEmailCode(@RequestBody Map<String, String> data,
                                             HttpSession session) {
        String email = data.get("email");
        String mode = data.get("mode");

        Map<String, Object> result = new HashMap<>();
        boolean isRegistered = memberService.isEmailRegistered(email);

        if ("signup".equals(mode) && isRegistered) {
            return Map.of("success", false, "message", "이미 가입된 이메일입니다.");
        }
        if ((mode.equals("findId") || mode.equals("findPw")) && !isRegistered) {
            return Map.of("success", false, "message", "가입되지 않은 이메일입니다.");
        }

        String code = String.format("%06d", new Random().nextInt(1000000));
        session.setAttribute("emailCode", code);
        session.setAttribute("emailForCode", email);
        session.setAttribute("emailCodeExpiry", LocalDateTime.now().plusMinutes(5));

        try {
            emailService.sendCode(email, code);
            result.put("success", true);
            result.put("message", "인증번호가 이메일로 전송되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "이메일 전송 실패: " + e.getMessage());
        }
        return result;
    }

    // ✅ 이메일 인증번호 확인
    @ResponseBody
    @PostMapping("/member/verifyCode")
    public Map<String, Object> verifyCode(@RequestBody Map<String, String> data,
                                          HttpSession session) {
        String inputCode = data.get("code");
        String sessionCode = (String) session.getAttribute("emailCode");
        String email = (String) session.getAttribute("emailForCode");
        LocalDateTime expiry = (LocalDateTime) session.getAttribute("emailCodeExpiry");

        if (expiry == null || LocalDateTime.now().isAfter(expiry)) {
            return Map.of("success", false, "message", "인증 시간이 만료되었습니다.");
        }

        if (inputCode != null && inputCode.equals(sessionCode)) {
            session.setAttribute("verifiedEmail", email);
            session.removeAttribute("emailCode");
            session.removeAttribute("emailForCode");
            session.removeAttribute("emailCodeExpiry");
            return Map.of("success", true, "message", "인증이 완료되었습니다.");
        } else {
            return Map.of("success", false, "message", "인증번호가 일치하지 않습니다.");
        }
    }

    // ✅ 아이디 찾기
    @PostMapping("/member/findId")
    public String findId(@RequestParam("email") String email,
                         HttpSession session,
                         Model model) {
        String verifiedEmail = (String) session.getAttribute("verifiedEmail");
        if (verifiedEmail == null || !verifiedEmail.equals(email)) {
            model.addAttribute("msg", "이메일 인증이 완료되지 않았습니다.");
            return "member/findidform";
        }

        String id = memberService.findIdByEmail(email);
        session.removeAttribute("verifiedEmail");

        model.addAttribute("msg", id != null ? "가입된 아이디: " + id : "아이디가 없습니다.");
        return "member/findidform";
    }

    // ✅ 비밀번호 찾기
    @PostMapping("/member/findPassword")
    public String findPassword(@RequestParam("id") String id,
                               @RequestParam("email") String email,
                               HttpSession session,
                               Model model) {
        String verifiedEmail = (String) session.getAttribute("verifiedEmail");
        if (verifiedEmail == null || !verifiedEmail.equals(email)) {
            model.addAttribute("msg", "이메일 인증이 완료되지 않았습니다.");
            return "member/findpasswordform";
        }

        try {
            String tempPw = memberService.resetPassword(id, email);
            session.removeAttribute("verifiedEmail");
            model.addAttribute("msg", "임시 비밀번호: " + tempPw + " (로그인 후 변경하세요)");
        } catch (Exception e) {
            model.addAttribute("msg", "비밀번호 초기화 실패: " + e.getMessage());
        }

        return "member/findpasswordform";
    }

    // 수정페이지 열기
    @GetMapping("/member/edit")
    public String showEditForm(HttpSession session, Model model) {
        // 세션에는 MemberDetailDto가 들어갑니다 (로그인 시 authenticate()로 저장)
        MemberDetailDto loginUser = (MemberDetailDto) session.getAttribute("loginUser");
        if (loginUser == null || loginUser.getMemberIdx() == null) {
            return "redirect:/member/login";
        }

        // 최신 회원 정보 조회 (Service 시그니처 준수)
        MemberDetailDto memberInfo = memberService.selectMemberByIdx(loginUser.getMemberIdx());

        // 임시 비밀번호 경고
        if ("Y".equals(memberInfo.getTempPasswordYn())) {
            model.addAttribute("showTempPasswordWarning", true);
        }

        model.addAttribute("member", memberInfo);
        // 기존 설계에 맞춰 view 이름은 필요에 맞게 사용: "member/edit" 또는 "mypage/mycorrection"
        return "member/edit";
    }

    // 수정 처리
    @PostMapping("/member/update")
    public String updateMemberInfo(
            @ModelAttribute MemberUpdateReq updateReq,                 // ✅ DTO로 직접 바인딩
            @RequestParam(value = "profileImage", required = false) MultipartFile profileImage,
            @RequestParam(value = "originProfileImage", required = false) String originProfileImage,
            HttpSession session,
            RedirectAttributes rttr
    ) throws IOException {

        MemberDetailDto loginUser = (MemberDetailDto) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }
        Long memberIdx = loginUser.getMemberIdx();

        // (선택) 비밀번호 확인 검증
        if (updateReq.getPassword() != null && !updateReq.getPassword().isEmpty()) {
            if (updateReq.getConfirmPassword() == null ||
                    !updateReq.getPassword().equals(updateReq.getConfirmPassword())) {
                rttr.addFlashAttribute("error", "비밀번호 확인이 일치하지 않습니다.");
                return "redirect:/member/edit";
            }
        }

        // 프로필 이미지 교체 처리
        if (profileImage != null && !profileImage.isEmpty()) {
            // ✅ FileService에 새로 추가한 replaceProfileImage 사용
            var newFile = fileService.replaceProfileImage(memberIdx, profileImage);
            // 저장된 웹 경로를 MemberUpdateReq.profile에 반영
            updateReq.setProfile(newFile.getFilePath());
        } else {
            // 새 업로드가 없다면:
            // 1) originProfileImage가 전달되면 그 값으로 유지,
            // 2) 전달 안 되면 null 그대로 → Service에서 변경 안 함
            if (originProfileImage != null && !originProfileImage.isBlank()) {
                updateReq.setProfile(originProfileImage);
            }
        }

        // 회원 정보 업데이트 (닉네임/비번/프로필 등)
        memberService.updateMember(memberIdx, updateReq);

        // 세션 갱신 (DB 최신값 재조회)
        MemberDetailDto refreshed = memberService.selectMemberByIdx(memberIdx);
        session.setAttribute("loginUser", refreshed);

        rttr.addFlashAttribute("updateSuccess", true);
        // 중간 설계 기준: 마이페이지 목록 화면으로 이동 (현재 컨트롤러는 "/mypage", 메서드는 "/mypage")
        return "redirect:/mypage/mypage";
    }

    // 회원 탈퇴
    @PostMapping("/member/delete")
    public String deleteMember(@RequestParam Long memberIdx, HttpSession session) {
        MemberDetailDto loginUser = (MemberDetailDto) session.getAttribute("loginUser");
        if (!loginUser.getMemberIdx().equals(memberIdx)) {
            throw new RuntimeException("권한이 없습니다.");
        }
        memberService.deleteMember(memberIdx);
        session.invalidate();
        return "redirect:/";
    }

    // 카카오 로그인
    @GetMapping("/kakaoLogin")
    public String kakaoCallback(@RequestParam("code") String code,
                                @RequestParam(value = "state", required = false) String redirect,
                                HttpSession session) {
        try {
            String accessToken = kakaoLoginService.getAccessToken(code);
            SocialUserInfo userInfo = kakaoLoginService.getUserInfo(accessToken);

            Member member = memberService.findBySocial(userInfo.getSocialId(), userInfo.getProvider())
                    .orElseGet(() -> memberService.insertSocialMember(userInfo));

            session.setAttribute("loginUser", memberService.selectMemberByIdx(member.getMemberIdx()));

            if (redirect != null && !redirect.trim().isEmpty()) {
                return "redirect:" + redirect;
            }
            return "redirect:/";

        } catch (Exception e) {
            log.error("카카오 로그인 실패", e);
            throw new RuntimeException("카카오 로그인 실패", e);
        }
    }

    //  카카오 이용자 닉네임 자동 변경 안내 confirm창
    @GetMapping("/redirect/nicknameConfirm")
    public String showNicknameConfirmPage() {
        return "member/nicknameWarning";
    }

    // 카카오 회원탈퇴
    @GetMapping("/member/kakao-delete")
    public String kakaoDelete(HttpSession session, RedirectAttributes rttr) {
        MemberDetailDto loginUser = (MemberDetailDto) session.getAttribute("loginUser");

        if (loginUser == null || !"KAKAO".equals(loginUser.getProvider())) {
            rttr.addFlashAttribute("message", "잘못된 접근입니다.");
            return "redirect:/";
        }

        try {
            // 1. 카카오 연결 해제
            kakaoLoginService.unlink(loginUser.getSocialId());

            // 2. DB 삭제
            memberService.deleteMember(loginUser.getMemberIdx());

            // 3. 세션 종료
            session.invalidate();
            rttr.addFlashAttribute("message", "카카오 회원 탈퇴가 완료되었습니다.");
            return "redirect:/";

        } catch (Exception e) {
            log.error("❌ 카카오 회원 탈퇴 실패", e);
            rttr.addFlashAttribute("message", "탈퇴 처리 중 오류가 발생했습니다.");
            return "redirect:/member/mypage";
        }
    }
}
