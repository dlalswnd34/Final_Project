package com.simplecoding.cheforest.file.repository;

import com.simplecoding.cheforest.file.entity.FileEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface FileRepository extends JpaRepository<FileEntity, Long> {

    // 파일 단건 조회 (PK는 기본적으로 findById 제공)
    Optional<FileEntity> findById(Long id);

    // 특정 게시글에 속한 파일들 (useType = BOARD, useTargetId = 게시글ID)
    List<FileEntity> findByUseTypeAndUseTargetId(String useType, Long useTargetId);

    // 업로더 ID 기준 조회
    List<FileEntity> findByUploader_Id(Long uploaderId);

    // 회원 프로필 파일 조회 (USE_TYPE = MEMBER + 최신 1개)
    Optional<FileEntity> findTop1ByUseTypeAndUseTargetIdOrderByInsertTimeDesc(String useType, Long memberId);

    // 게시글 삭제 시 관련 파일 삭제 (USE_TYPE + TARGET_ID)
    void deleteByUseTargetIdAndUseType(Long useTargetId, String useType);
}
