package com.simplecoding.cheforest.file.controller;

import com.simplecoding.cheforest.file.dto.FileDto;
import com.simplecoding.cheforest.file.service.FileService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/file")
public class FileController {

    private final FileService fileService;

    // 파일 삭제
    @DeleteMapping("/{fileId}")
    public ResponseEntity<Void> deleteFile(@PathVariable Long fileId) {
        fileService.deleteFile(fileId);
        return ResponseEntity.ok().build();
    }

    // 프로필 업로드
    @PostMapping("/profile-upload")
    public ResponseEntity<FileDto> uploadProfileImage(
            @RequestParam("memberId") Long memberId,
            @RequestParam("profileImage") MultipartFile file
    ) throws IOException {
        // 기존 프로필 삭제
        FileDto oldProfile = fileService.getProfileFileByMemberId(memberId);
        if (oldProfile != null) {
            fileService.deleteFile(oldProfile.getId());
        }

        // 새 프로필 저장
        FileDto newFile = fileService.saveFile(file, "MEMBER", memberId, "PROFILE", memberId);

        // 실제 Member 테이블 profile 컬럼 업데이트는 MemberService에서 따로 처리
        return ResponseEntity.ok(newFile);
    }
}
