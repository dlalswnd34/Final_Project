package com.simplecoding.cheforest.file.entity;

import com.simplecoding.cheforest.common.BaseTimeEntity;
import com.simplecoding.cheforest.member.entity.Member;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "UPLOAD_FILE")
@SequenceGenerator(
        name = "FILE_SEQ_JPA",
        sequenceName = "FILE_SEQ",
        allocationSize = 1
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FileEntity extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "FILE_SEQ_JPA")
    private Long id;  // 파일 ID (PK)

    @Column(nullable = false, length = 200)
    private String fileName;  // 원본 파일명

    @Column(nullable = false, length = 300)
    private String filePath;  // 저장 경로

    @Column(nullable = false, length = 20)
    private String fileType;  // 파일 확장자

    @Column(nullable = false, length = 20)
    private String useType;   // 사용 목적 (예: BOARD, PROFILE)

    @Column(nullable = false)
    private Long useTargetId; // 대상 ID (게시글 번호 등)

    @Column(length = 50)
    private String usePosition; // 위치 구분 (썸네일, 본문 등)


    // 업로더 회원 (FK)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "UPLOADER_ID")
    private Member uploader;
}
