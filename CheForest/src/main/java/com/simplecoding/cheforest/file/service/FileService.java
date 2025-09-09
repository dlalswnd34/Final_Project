package com.simplecoding.cheforest.file.service;

import com.simplecoding.cheforest.file.dto.FileDto;
import com.simplecoding.cheforest.file.entity.UploadFile;
import com.simplecoding.cheforest.file.repository.UploadFileRepository;
import com.simplecoding.cheforest.common.MapStruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class FileService {

    private final UploadFileRepository uploadFileRepository;
    private final MapStruct mapper;

    public FileDto save(FileDto dto) {
        UploadFile file = mapper.toEntity(dto);
        UploadFile saved = uploadFileRepository.save(file);
        return mapper.toDto(saved);
    }

    public void delete(Long fileId) {
        uploadFileRepository.deleteById(fileId);
    }

    public FileDto getFile(Long fileId) {
        return uploadFileRepository.findById(fileId).map(mapper::toDto)
                .orElseThrow(() -> new IllegalArgumentException("파일 없음"));
    }

    public List<FileDto> getFilesByTarget(Long targetId, String useType) {
        return uploadFileRepository.findByUseTargetIdAndUseType(targetId, useType)
                .stream().map(mapper::toDto).toList();
    }
}
