package com.simplecoding.cheforest.file.repository;
import com.simplecoding.cheforest.file.entity.UploadFile;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface UploadFileRepository extends JpaRepository<UploadFile, Long> {
    List<UploadFile> findByUseTargetIdAndUseType(Long targetId, String useType);
}
