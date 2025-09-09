package com.simplecoding.cheforest.member.service;

import com.simplecoding.cheforest.common.MapStruct;
import com.simplecoding.cheforest.member.dto.*;
import com.simplecoding.cheforest.member.entity.Member;
import com.simplecoding.cheforest.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class MemberService {

    private final MemberRepository memberRepository;
    private final MapStruct mapStruct;
    private final BCryptPasswordEncoder passwordEncoder;

    // 회원가입
    public void register(MemberSaveReq req) {
        if (memberRepository.existsById(req.getId())) {
            throw new IllegalArgumentException("이미 사용중인 아이디입니다.");
        }
        if (memberRepository.existsByEmail(req.getEmail())) {
            throw new IllegalArgumentException("이미 사용중인 이메일입니다.");
        }
        if (memberRepository.existsByNickname(req.getNickname())) {
            throw new IllegalArgumentException("이미 사용중인 닉네임입니다.");
        }

        String hashedPassword = passwordEncoder.encode(req.getPassword());

        Member member = Member.builder()
                .id(req.getId())
                .email(req.getEmail())
                .password(hashedPassword)
                .nickname(req.getNickname())
                .profile(req.getProfile())
                .role(Member.Role.USER)
                .tempPasswordYn("N")
                .build();

        memberRepository.save(member);
    }

    // 로그인
    public MemberDetailDto authenticate(MemberLoginReq req) {
        Member member = memberRepository.findById(req.getId())
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 아이디입니다."));

        if (!passwordEncoder.matches(req.getPassword(), member.getPassword())) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }

        return mapStruct.toDetailDto(member);
    }

    // 닉네임 중복검사
    public boolean isNicknameAvailable(String nickname, Long currentMemberIdx) {
        if (currentMemberIdx != null) {
            return !memberRepository.existsByNicknameAndMemberIdxNot(nickname, currentMemberIdx);
        }
        return !memberRepository.existsByNickname(nickname);
    }

    // 아이디 중복검사
    public boolean isIdAvailable(String id) {
        return !memberRepository.existsById(id);
    }

    // 이메일 중복검사
    public boolean isEmailRegistered(String email) {
        return memberRepository.existsByEmail(email);
    }

    // 회원 상세조회
    public MemberDetailDto selectMemberByIdx(Long memberIdx) {
        Member member = memberRepository.findByMemberIdx(memberIdx)
                .orElseThrow(() -> new IllegalArgumentException("회원 정보를 찾을 수 없습니다."));
        return mapStruct.toDetailDto(member);
    }

    // 회원정보 수정
    public void updateMember(Long memberIdx, MemberUpdateReq req) {
        Member member = memberRepository.findByMemberIdx(memberIdx)
                .orElseThrow(() -> new IllegalArgumentException("회원 정보를 찾을 수 없습니다."));

        if (req.getPassword() != null && !req.getPassword().isEmpty()) {
            member.setPassword(passwordEncoder.encode(req.getPassword()));
            member.setTempPasswordYn("N");
        }

        if (req.getNickname() != null) {
            member.setNickname(req.getNickname());
        }

        if (req.getProfile() != null) {
            member.setProfile(req.getProfile());
        }

        memberRepository.save(member);
    }

    // 아이디 찾기
    public String findIdByEmail(String email) {
        return memberRepository.findIdByEmail(email);
    }

    // 비밀번호 찾기 (임시 비밀번호 발급)
    public String resetPassword(String id, String email) {
        Member member = memberRepository.findByIdAndEmail(id, email)
                .orElseThrow(() -> new IllegalArgumentException("회원 정보를 찾을 수 없습니다."));

        String tempPassword = UUID.randomUUID().toString().substring(0, 8);
        member.setPassword(passwordEncoder.encode(tempPassword));
        member.setTempPasswordYn("Y");

        memberRepository.save(member);

        return tempPassword; // 이메일 발송 서비스에서 사용
    }

    // 회원 탈퇴
    public void deleteMember(Long memberIdx) {
        memberRepository.deleteById(memberIdx);
    }

    // ✅ 소셜 로그인 유저 조회 (provider + socialId)
    public Optional<Member> findBySocial(String socialId, String provider) {
        return memberRepository.findBySocialIdAndProvider(socialId, provider);
    }

    // 닉네임 자동 중복 처리 (소셜 로그인 전용)
    public String generateUniqueNickname(String baseNickname) {
        String candidate = baseNickname;
        int suffix = 1;
        while (memberRepository.existsByNickname(candidate)) {
            candidate = baseNickname + suffix++;
        }
        return candidate;
    }

    // ✅ 소셜 로그인 신규 등록
    public Member insertSocialMember(SocialUserInfo socialUserInfo) {
        // 닉네임 자동 중복 처리
        String finalNickname = generateUniqueNickname(socialUserInfo.getNickname());

        String dummyPassword = UUID.randomUUID().toString().substring(0, 8);

        Member member = Member.builder()
                .socialId(socialUserInfo.getSocialId())
                .provider(socialUserInfo.getProvider())
                .email(socialUserInfo.getEmail())
                .nickname(finalNickname)  // 중복 처리된 닉네임 저장
                .profile(socialUserInfo.getProfileImage())
                .password(passwordEncoder.encode(dummyPassword))
                .tempPasswordYn("N")
                .role(Member.Role.USER)
                .build();

        return memberRepository.save(member);
    }
}
