package com.simplecoding.cheforest.file.controller;

import com.simplecoding.cheforest.file.dto.FileDto;
import com.simplecoding.cheforest.file.service.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequiredArgsConstructor
@RequestMapping("/file")
public class FileController {

    private final FileService fileService;

    @PostMapping("/upload")
    public String upload(@RequestParam("file") MultipartFile multipartFile,
                         @RequestParam("useType") String useType,
                         @RequestParam("useTargetId") Long useTargetId) {
        try {
            FileDto dto = new FileDto();
            dto.setFileName(multipartFile.getOriginalFilename());
            dto.setFileType(multipartFile.getContentType());
            dto.setUseType(useType);
            dto.setUseTargetId(useTargetId);
            dto.setFileData(multipartFile.getBytes());
            fileService.save(dto);
            return "redirect:/";
        } catch (Exception e) {
            return "error";
        }
    }

    @GetMapping("/{id}")
    public String getFile(@PathVariable("id") Long fileId, Model model) {
        FileDto file = fileService.getFile(fileId);
        model.addAttribute("file", file);
        return "file/detail";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long fileId) {
        fileService.delete(fileId);
        return "redirect:/";
    }
}
