package com.simplecoding.cheforest.member.controller;

import com.simplecoding.cheforest.member.dto.*;
import com.simplecoding.cheforest.member.entity.Member;
import com.simplecoding.cheforest.member.service.MemberService;
import com.simplecoding.cheforest.member.service.EmailService;
import com.simplecoding.cheforest.member.service.social.KakaoLoginService;
import com.simplecoding.cheforest.member.dto.SocialUserInfo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.*;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;
    private final EmailService emailService;
    private final KakaoLoginService kakaoLoginService;

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
