package com.simplecoding.cheforest.jpa.board.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

@Data
public class BoardUpdateReq {
    private Long boardId;
    private String category;
    private String title;
    private String cookTime;
    private String difficulty;

    // 대표 이미지
    private MultipartFile mainImage;

    // 재료 (리스트 → JSON 변환 후 DB 저장)
    private List<String> ingredientName;
    private List<String> ingredientAmount;

    // 조리법 (리스트 → JSON 변환 후 DB 저장)
    private List<String> instructionContent;
    private List<MultipartFile> instructionImage;
}
