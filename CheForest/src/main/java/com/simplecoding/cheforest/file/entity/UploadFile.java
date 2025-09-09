package com.simplecoding.cheforest.file.entity;

import com.simplecoding.cheforest.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

import java.sql.Blob;
import java.time.LocalDateTime;

@Entity
@Table(name = "UPLOAD_FILE")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor @Builder
public class UploadFile extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "FILE_SEQ")
    @SequenceGenerator(name = "FILE_SEQ", sequenceName = "FILE_SEQ", allocationSize = 1)
    @Column(name = "FILE_ID")
    private Long fileId;

    @Column(name = "FILE_NAME")
    private String fileName;

    @Column(name = "FILE_PATH")
    private String filePath;

    @Column(name = "FILE_TYPE")
    private String fileType;

    @Column(name = "USE_TYPE")
    private String useType;

    @Column(name = "USE_TARGET_ID")
    private Long useTargetId;

    @Column(name = "USE_POSITION")
    private String usePosition;

    @Column(name = "UPLOAD_DATE")
    private LocalDateTime uploadDate;

    @Column(name = "UPLOADER_ID")
    private Long uploaderId;

    @Lob
    @Column(name = "FILE_DATA")
    private byte[] fileData;
}
