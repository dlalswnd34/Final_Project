package com.simplecoding.cheforest.member.repository;
import com.simplecoding.cheforest.member.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {
    Optional<Member> findById(String id);
    Optional<Member> findByEmail(String email);
    boolean existsByNickname(String nickname);
}
