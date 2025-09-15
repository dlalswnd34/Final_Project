package com.simplecoding.cheforest.auth.controller;

import com.simplecoding.cheforest.auth.dto.*;
import com.simplecoding.cheforest.auth.service.MemberService;
import com.simplecoding.cheforest.auth.service.EmailService;
import com.simplecoding.cheforest.auth.security.CustomUserDetails;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;
    private final EmailService emailService;

    // ================= 로그인 페이지 =================
    @GetMapping("/auth/login")
    public String loginView() {
        log.info("👉 [테스트] loginView 호출됨"); // 로그 메시지도 살짝 바꿔서 구별해봅시다.
        return "auth/login";
    }

    // ================= 회원가입 페이지 =================
    @GetMapping("/auth/register")
    public String registerView(Model model) {
        model.addAttribute("memberSignupDto", new MemberSignupDto());
        return "auth/register";
    }

    // ================= 회원가입 처리 =================
    @PostMapping("/auth/register/addition")
    public String register(@Valid @ModelAttribute MemberSignupDto dto,
                           BindingResult bindingResult,
                           @SessionAttribute(name = "emailAuthCode", required = false) String serverAuthCode,
                           Model model) {
        if (bindingResult.hasErrors()) {
            return "auth/register";
        }
        try {
            memberService.register(dto, serverAuthCode);
            model.addAttribute("msg", "✅ 회원가입이 완료되었습니다.");
        } catch (IllegalArgumentException e) {
            model.addAttribute("msg", "❌ " + e.getMessage());
            return "auth/register";
        }
        return "auth/register";
    }

    // ================= 회원정보 수정 페이지 =================
    @GetMapping("/auth/update")
    public String updateView(@AuthenticationPrincipal CustomUserDetails user, Model model) {
        if (user == null) {
            return "redirect:/auth/login";
        }
        model.addAttribute("memberUpdateDto", new MemberUpdateDto());
        return "mypage/edit";
    }

    // ================= 회원정보 수정 처리 =================
    @PostMapping("/auth/update")
    public String update(@Valid @ModelAttribute MemberUpdateDto dto,
                         BindingResult bindingResult,
                         @AuthenticationPrincipal CustomUserDetails user,
                         Model model) {
        if (bindingResult.hasErrors()) {
            return "mypage/edit";
        }
        try {
            memberService.update(dto);
            model.addAttribute("msg", "✅ 회원정보가 수정되었습니다.");
        } catch (IllegalArgumentException e) {
            model.addAttribute("msg", "❌ " + e.getMessage());
            return "mypage/edit";
        }
        return "mypage/edit";
    }

    // ================= 회원 상세 조회 =================
    @GetMapping("/auth/detail/{id}")
    public String detail(@PathVariable("id") Long memberIdx, Model model) {
        MemberDetailDto detail = memberService.findById(memberIdx);
        model.addAttribute("member", detail);
        return "auth/detail";
    }

    // ================= Ajax: 중복체크 & 이메일 =================
    @GetMapping("/auth/check-id")
    @ResponseBody
    public boolean checkId(@RequestParam String loginId) {
        return !memberService.existsByLoginId(loginId);
    }

    @GetMapping("/auth/check-nickname")
    @ResponseBody
    public boolean checkNickname(@RequestParam String nickname) {
        return !memberService.existsByNickname(nickname);
    }

    @PostMapping("/auth/send-email-code")
    @ResponseBody
    public String sendEmailCode(@RequestParam String email,
                                @SessionAttribute(name = "emailAuthCode", required = false) String code) {
        String newCode = emailService.sendAuthCode(email);
        return "OK";
    }

    @PostMapping("/auth/verify-email-code")
    @ResponseBody
    public boolean verifyEmailCode(@RequestParam String code,
                                   @SessionAttribute(name = "emailAuthCode", required = false) String serverCode) {
        return serverCode != null && serverCode.equals(code);
    }
}
