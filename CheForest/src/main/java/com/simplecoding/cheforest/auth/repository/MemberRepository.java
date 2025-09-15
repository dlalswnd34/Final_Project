package com.simplecoding.cheforest.auth.repository;

import com.simplecoding.cheforest.auth.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {

    // 로그인/중복검사
    Optional<Member> findByLoginId(String id);
    boolean existsByLoginId(String id);

    // 이메일
    Optional<Member> findByEmail(String email);
    boolean existsByEmail(String email);

    // 닉네임
    Optional<Member> findByNickname(String nickname);
    boolean existsByNickname(String nickname);

    // 회원정보 수정 시, 자기 자신 제외하고 닉네임 중복 확인
    boolean existsByNicknameAndMemberIdxNot(String nickname, Long memberIdx);

    // 회원번호로 조회
    Optional<Member> findByMemberIdx(Long memberIdx);

    // 소셜 로그인
    Optional<Member> findBySocialIdAndProvider(String socialId, String provider);

    // 사용자 확인 (비밀번호 찾기용)
    Optional<Member> findByLoginIdAndEmail(String id, String email);

    // JPQL: 비밀번호만 조회
    @Query("select m.password from Member m where m.memberIdx = :memberIdx")
    String findPasswordByMemberIdx(Long memberIdx);

    // JPQL: 임시비밀번호 여부 조회
    @Query("select m.tempPasswordYn from Member m where m.memberIdx = :memberIdx")
    String findTempPasswordYnByMemberIdx(Long memberIdx);

    // JPQL: 아이디 찾기 (이메일로 아이디 반환)
    @Query("select m.loginId from Member m where m.email = :email")
    String findIdByEmail(String email);
}
