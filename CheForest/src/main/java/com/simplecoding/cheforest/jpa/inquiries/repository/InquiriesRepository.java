package com.simplecoding.cheforest.jpa.inquiries.repository;


import com.simplecoding.cheforest.jpa.inquiries.dto.InquiryWithNicknameDto;
import com.simplecoding.cheforest.jpa.inquiries.entity.Inquiries;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface InquiriesRepository extends JpaRepository<Inquiries, Long> {

    @Query("SELECT new com.simplecoding.cheforest.jpa.inquiries.dto.InquiryWithNicknameDto(" +
            "i.inquiryId, i.memberIdx, i.title, i.questionContent, i.answerContent, " +
            "i.answerStatus, i.isFaq, i.createdAt, i.answerAt, m.nickname) " +
            "FROM Inquiries i " +
            "JOIN Member m ON i.memberIdx = m.memberIdx " )
    Page<InquiryWithNicknameDto> findInquiryWithNickname(Pageable pageable);

    // 전체 문의사항 데이터 수 카운트
    @Query("SELECT COUNT(i) FROM Inquiries i")
    long countAllInquiries();

    // ANSWER_STATUS = '대기중' 인 데이터 수 카운트
    @Query("SELECT COUNT(i) FROM Inquiries i WHERE i.answerStatus = '대기중'")
    long countPendingInquiries();

    // ANSWER_STATUS = '답변완료' 인 데이터 수 카운트
    @Query("SELECT COUNT(i) FROM Inquiries i WHERE i.answerStatus = '답변완료'")
    long countAnsweredInquiries();
    //  오늘 작성된 문의사항 수 카운트
    @Query(value = "SELECT COUNT(*) FROM INQUIRIES WHERE TRUNC(CREATED_AT) = TRUNC(SYSDATE)", nativeQuery = true)
    long countTodayInquiries();

    // '대기중' 상태인 문의 전체 리스트 조회
    @Query("SELECT new com.simplecoding.cheforest.jpa.inquiries.dto.InquiryWithNicknameDto(" +
            "i.inquiryId, i.memberIdx, i.title, i.questionContent, i.answerContent, " +
            "i.answerStatus, i.isFaq, i.createdAt, i.answerAt, m.nickname) " +
            "FROM Inquiries i " +
            "JOIN Member m ON i.memberIdx = m.memberIdx " +
            "WHERE i.answerStatus = '대기중'")
    List<InquiryWithNicknameDto> findPendingInquiriesWithNickname();

    //   전체문의 사항중 검색어와 상태검색이 일치하는 것들만 조회
    @Query("SELECT new com.simplecoding.cheforest.jpa.inquiries.dto.InquiryWithNicknameDto(" +
            "i.inquiryId, i.memberIdx, i.title, i.questionContent, i.answerContent, " +
            "i.answerStatus, i.isFaq, i.createdAt, i.answerAt, m.nickname) " +
            "FROM Inquiries i " +
            "JOIN Member m ON i.memberIdx = m.memberIdx " +
            "WHERE " +
            "(:keyword IS NULL OR :keyword = '' OR " +
            "LOWER(i.title) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(i.questionContent) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(i.answerContent) LIKE LOWER(CONCAT('%', :keyword, '%'))) " +
            "AND (:status IS NULL OR :status = 'all' OR i.answerStatus = :status)")
    Page<InquiryWithNicknameDto> findByKeywordAndStatus(@Param("keyword") String keyword,
                                                        @Param("status") String status,
                                                        Pageable pageable);

    /**
     * 특정 회원의 문의 내역을 최신순으로 조회 (마이페이지용)
     * Member 엔티티와 JOIN하여 닉네임을 함께 가져옵니다.
     * @param memberIdx 조회할 회원의 고유 ID
     * @param pageable 페이징 정보 (페이지 번호, 크기, 정렬)
     * @return 해당 회원의 문의 내역 DTO 리스트 (Pageable 적용)
     */
    @Query(value = "SELECT new com.simplecoding.cheforest.jpa.inquiries.dto.InquiryWithNicknameDto(" +
            "i.inquiryId, i.memberIdx, i.title, i.questionContent, i.answerContent, " +
            "i.answerStatus, i.isFaq, i.createdAt, i.answerAt, m.nickname) " +
            "FROM Inquiries i " +
            "JOIN Member m ON i.memberIdx = m.memberIdx " +
            "WHERE i.memberIdx = :memberIdx " +
            "ORDER BY i.createdAt DESC",
            countQuery = "SELECT COUNT(i) FROM Inquiries i JOIN Member m ON i.memberIdx = m.memberIdx WHERE i.memberIdx = :memberIdx")
    Page<InquiryWithNicknameDto> findMyInquiriesWithNickname(
            @Param("memberIdx") Long memberIdx,
            Pageable pageable
    );

    /**
     * 특정 회원의 전체 문의사항 데이터 수 카운트 (마이페이지 카운트용)
     * @param memberIdx 조회할 회원의 고유 ID
     * @return 해당 회원이 작성한 문의 개수
     */
    @Query("SELECT COUNT(i) FROM Inquiries i WHERE i.memberIdx = :memberIdx")
    long countMyInquiries(@Param("memberIdx") Long memberIdx);

    /**
     * 특정 문의 ID로 상세 내역을 조회합니다. (수정 페이지 로드 및 상세 보기용)
     * InquiryService에서 getInquiryById() 메서드가 호출합니다.
     * @param inquiryId 조회할 문의의 고유 ID
     * @return 문의 상세 정보 DTO (Optional)
     */
    @Query("SELECT new com.simplecoding.cheforest.jpa.inquiries.dto.InquiryWithNicknameDto(" +
            "i.inquiryId, i.memberIdx, i.title, i.questionContent, i.answerContent, " +
            "i.answerStatus, i.isFaq, i.createdAt, i.answerAt, m.nickname) " +
            "FROM Inquiries i " +
            "JOIN Member m ON i.memberIdx = m.memberIdx " +
            "WHERE i.inquiryId = :inquiryId")
    Optional<InquiryWithNicknameDto> findInquiryDetailById(@Param("inquiryId") Long inquiryId);
}
