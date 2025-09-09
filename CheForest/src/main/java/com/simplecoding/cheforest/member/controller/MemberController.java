package com.simplecoding.cheforest.member.controller;

import com.simplecoding.cheforest.member.dto.*;
import com.simplecoding.cheforest.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {

    private final MemberService memberService;

    @GetMapping("/login")
    public String loginForm() {
        return "member/login";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute MemberLoginDto dto, Model model) {
        try {
            MemberDetailDto member = memberService.authenticate(dto);
            model.addAttribute("member", member);
            return "redirect:/home";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            return "member/login";
        }
    }

    @GetMapping("/register")
    public String registerForm() {
        return "member/register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute MemberRegisterDto dto, Model model) {
        try {
            memberService.register(dto);
            return "redirect:/member/login";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "member/register";
        }
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable("id") Long memberIdx, Model model) {
        MemberDetailDto dto = memberService.getMember(memberIdx);
        model.addAttribute("member", dto);
        return "member/detail";
    }
}
