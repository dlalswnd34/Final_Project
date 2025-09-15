package com.simplecoding.cheforest.board.controller;

import com.simplecoding.cheforest.board.dto.BoardDetailDto;
import com.simplecoding.cheforest.board.dto.BoardListDto;
import com.simplecoding.cheforest.board.dto.BoardSaveReq;
import com.simplecoding.cheforest.board.dto.BoardUpdateReq;
import com.simplecoding.cheforest.board.service.BoardService;
import com.simplecoding.cheforest.file.dto.FileDto;
import com.simplecoding.cheforest.file.service.FileService;
import com.simplecoding.cheforest.auth.dto.MemberDetailDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;
    private final FileService fileService;

    // 1. 목록 조회
    @GetMapping("/board/list")
    public String list(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String keyword,
            @PageableDefault(size = 10) Pageable pageable,
            Model model
    ) {
        Page<BoardListDto> boards = boardService.searchBoards(keyword, category, pageable);
        model.addAttribute("boards", boards.getContent());
        model.addAttribute("pageInfo", boards);

        List<BoardListDto> bestPosts = (category == null || category.isBlank())
                ? boardService.getBestPosts()
                : boardService.getBestPostsByCategory(category);
        model.addAttribute("bestPosts", bestPosts);

        return "board/boardlist";
    }

    // 2. 글 작성 폼
    @GetMapping("/board/add")
    public String showAddForm(Model model) {
        model.addAttribute("board", new BoardSaveReq());
        return "board/boardwrite";
    }

    // 3. 글 등록
    @PostMapping("/board/add")
    public String add(
            @ModelAttribute BoardSaveReq dto,
            @RequestParam(value = "images", required = false) List<MultipartFile> images,
            @AuthenticationPrincipal MemberDetailDto loginUser
    ) throws IOException {
        Long boardId = boardService.create(dto, loginUser.getEmail());

        Long firstFileId = fileService.saveBoardFiles(boardId, loginUser.getMemberIdx(), images);
        if (firstFileId != null) {
            boardService.updateThumbnail(boardId, "/file/download?fileId=" + firstFileId);
        }

        String encodedCategory = URLEncoder.encode(dto.getCategory(), "UTF-8");
        return "redirect:/board/list?category=" + encodedCategory;
    }

    // 4. 수정 페이지
    @GetMapping("/board/edition")
    public String editForm(@RequestParam("boardId") Long boardId, Model model) {
        BoardDetailDto board = boardService.getBoardDetail(boardId);
        model.addAttribute("board", board);

        List<FileDto> fileList = fileService.getFilesByBoardId(boardId);
        model.addAttribute("fileList", fileList);

        return "board/boardupdate";
    }

    // 5. 글 수정
    @PostMapping("/board/edit")
    public String update(
            @ModelAttribute BoardUpdateReq dto,
            @RequestParam(value = "images", required = false) List<MultipartFile> images,
            @RequestParam(value = "deleteImageIds", required = false) List<Long> deleteImageIds,
            @AuthenticationPrincipal MemberDetailDto loginUser
    ) throws IOException {
        // 삭제할 파일 처리
        if (deleteImageIds != null) {
            deleteImageIds.forEach(fileService::deleteFile);
        }

        // 새 파일 업로드
        Long firstFileId = fileService.saveBoardFiles(dto.getBoardId(), loginUser.getMemberIdx(), images);
        if (firstFileId != null) {
            boardService.updateThumbnail(dto.getBoardId(), "/file/download?fileId=" + firstFileId);
        }

        // DB 업데이트
        boardService.update(dto, loginUser.getEmail());

        String encodedCategory = URLEncoder.encode(dto.getCategory(), "UTF-8");
        return "redirect:/board/list?category=" + encodedCategory;
    }

    // 6. 글 삭제
    @PostMapping("/board/delete")
    public String delete(@RequestParam("boardId") Long boardId) {
        boardService.delete(boardId);
        return "redirect:/board/list";
    }

    // 7. 관리자 삭제
    @PostMapping("/board/adminDelete")
    public String adminDelete(@RequestParam("boardId") Long boardId,
                              @AuthenticationPrincipal MemberDetailDto loginUser) {
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
            return "redirect:/board/list?error=unauthorized";
        }
        boardService.adminDelete(boardId);
        return "redirect:/board/list";
    }

    // 8. 상세 조회
    @GetMapping("/board/view")
    public String view(@RequestParam("boardId") Long boardId, Model model,
                       @AuthenticationPrincipal MemberDetailDto loginUser) {
        BoardDetailDto board = boardService.getBoardDetail(boardId);
        model.addAttribute("board", board);
        model.addAttribute("loginUser", loginUser);

        return "board/boardview";
    }

    // ===== 추가 페이지 이동 =====
    @GetMapping("/guide")
    public String guide() {
        return "support/guide";
    }

    @GetMapping("/qna")
    public String qna() {
        return "support/qna";
    }
}