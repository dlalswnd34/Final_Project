package com.simplecoding.cheforest.file.dto;
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class FileDto {
    private Long fileId;
    private String fileName;
    private String filePath;
    private String fileType;
    private String useType;
    private Long useTargetId;
    private String usePosition;
    private LocalDateTime uploadDate;
    private Long uploaderId;
    private byte[] fileData;
}
