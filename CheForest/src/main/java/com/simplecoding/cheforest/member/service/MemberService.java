package com.simplecoding.cheforest.member.service;

import com.simplecoding.cheforest.member.dto.*;
import com.simplecoding.cheforest.member.entity.Member;
import com.simplecoding.cheforest.member.repository.MemberRepository;
import com.simplecoding.cheforest.common.MapStruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Transactional
public class MemberService {

    private final MemberRepository memberRepository;
    private final MapStruct mapper;

    public MemberDetailDto authenticate(MemberLoginDto dto) {
        Member member = memberRepository.findById(dto.getId())
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 아이디"));

        if (!member.getPassword().equals(dto.getPassword())) {
            throw new IllegalArgumentException("비밀번호 불일치");
        }
        return mapper.toDto(member);
    }

    public void register(MemberRegisterDto dto) {
        Member member = mapper.toEntity(dto);
        member.setJoinDate(LocalDateTime.now());
        member.setRole("USER");
        memberRepository.save(member);
    }

    public MemberDetailDto getMember(Long memberIdx) {
        return memberRepository.findById(memberIdx)
                .map(mapper::toDto)
                .orElseThrow(() -> new IllegalArgumentException("회원 없음"));
    }
}
