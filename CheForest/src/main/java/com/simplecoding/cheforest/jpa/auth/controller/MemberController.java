package com.simplecoding.cheforest.jpa.auth.controller;

import com.simplecoding.cheforest.jpa.auth.dto.MemberDetailDto;
import com.simplecoding.cheforest.jpa.auth.dto.MemberSignupDto;
import com.simplecoding.cheforest.jpa.auth.dto.MemberUpdateDto;
import com.simplecoding.cheforest.jpa.auth.service.MemberService;
import com.simplecoding.cheforest.jpa.auth.service.EmailService;
import com.simplecoding.cheforest.jpa.auth.security.CustomUserDetails;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;
    private final EmailService emailService;

    // ================= 로그인 페이지 =================
    @GetMapping("/auth/login")
    public String loginView() {
        return "auth/login";
    }

    // ================= 회원가입 페이지 =================
    @GetMapping("/auth/register")
    public String registerView(Model model) {
        model.addAttribute("memberSignupDto", new MemberSignupDto());
        return "auth/signup";
    }

    // ================= 회원가입 처리 =================
    @PostMapping("/auth/register/addition")
    @ResponseBody
    public String register(@Valid @ModelAttribute MemberSignupDto dto,
                           BindingResult bindingResult,
                           @SessionAttribute(name = "emailAuthCode", required = false) String serverAuthCode,
                           Model model) {
        if (bindingResult.hasErrors()) {
            return "❌ 입력값을 확인해주세요.";
        }
        try {
            memberService.register(dto, serverAuthCode);
            return "OK"; // ✅ 가입 성공 시 문자열만 반환
        } catch (IllegalArgumentException e) {
            return "❌ " + e.getMessage();
        }
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
            model.addAttribute("msg", "회원정보가 수정되었습니다.");
        } catch (IllegalArgumentException e) {
            model.addAttribute("msg", "❌ " + e.getMessage());
            return "mypage/edit";
        }
        return "mypage/edit";
    }

//    회원탈퇴
    @PostMapping("/member/withdraw")
    public String withdraw(@AuthenticationPrincipal CustomUserDetails user,
                           RedirectAttributes ra) {

        Long memberIdx = user.getMember().getMemberIdx();
        memberService.withdraw(memberIdx);

        // ✅ Spring Security 인증정보 삭제 (로그아웃 처리)
        SecurityContextHolder.clearContext();

        ra.addFlashAttribute("msg", "회원 탈퇴가 완료되었습니다.");
        return "redirect:/";
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
                                HttpSession session) {
        String newCode = emailService.sendAuthCode(email);
        session.setAttribute("emailAuthCode", newCode);
        return "OK";
    }

    @PostMapping("/auth/verify-email-code")
    @ResponseBody
    public boolean verifyEmailCode(@RequestParam String code,
                                   @SessionAttribute(name = "emailAuthCode", required = false) String serverCode) {
        return serverCode != null && serverCode.equals(code);
    }

//    회원탈퇴

}
