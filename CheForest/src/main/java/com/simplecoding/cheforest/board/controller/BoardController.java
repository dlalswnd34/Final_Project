package com.simplecoding.cheforest.board.controller;

import com.simplecoding.cheforest.board.dto.BoardDetailDto;
import com.simplecoding.cheforest.board.dto.BoardListDto;
import com.simplecoding.cheforest.board.entity.Board;
import com.simplecoding.cheforest.board.service.BoardService;
import com.simplecoding.cheforest.file.dto.FileDto;
import com.simplecoding.cheforest.file.service.FileService;
import com.simplecoding.cheforest.member.entity.Member;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {

    private final BoardService boardService;
    private final FileService fileService;

    // 1. 목록 조회
    @GetMapping("/list")
    public String list(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String keyword,
            @PageableDefault(size = 10) Pageable pageable,
            Model model
    ) {
        Page<BoardListDto> boards = boardService.searchBoards(keyword, category, pageable);
        model.addAttribute("boards", boards);

        List<BoardListDto> bestPosts = (category == null || category.isBlank())
                ? boardService.getBestPosts()
                : boardService.getBestPostsByCategory(category);
        model.addAttribute("bestPosts", bestPosts);

        return "board/boardlist";
    }

    // 2. 글 작성 폼
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("board", new Board());
        return "board/boardwrite";
    }

    // 3. 글 등록
    @PostMapping("/add")
    public String add(
            @ModelAttribute Board board,
            @RequestParam(value = "images", required = false) List<MultipartFile> images,
            HttpSession session
    ) throws IOException {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }

        board.setWriter(loginUser);
        Board savedBoard = boardService.save(board);

        Long firstFileId = fileService.saveBoardFiles(savedBoard.getBoardId(), loginUser.getMemberIdx(), images);

        if (firstFileId != null) {
            boardService.updateThumbnail(savedBoard.getBoardId(), "/file/download?fileId=" + firstFileId);
        }

        String encodedCategory = URLEncoder.encode(board.getCategory(), "UTF-8");
        return "redirect:/board/list?category=" + encodedCategory;
    }

    // 4. 수정 페이지
    @GetMapping("/edition/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        BoardDetailDto board = boardService.getBoardDetail(id); // 조회수 증가 제거 원하면 별도 메소드 사용
        model.addAttribute("board", board);

        List<FileDto> fileList = fileService.getFilesByBoardId(id);
        model.addAttribute("fileList", fileList);

        return "board/boardupdate";
    }

    // 5. 글 수정
    @PostMapping("/edit/{id}")
    public String update(
            @PathVariable Long id,
            @ModelAttribute Board board,
            @RequestParam(value = "images", required = false) List<MultipartFile> images,
            @RequestParam(value = "deleteImageIds", required = false) List<Long> deleteImageIds,
            HttpSession session
    ) throws IOException {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }

        if (deleteImageIds != null) {
            for (Long fileId : deleteImageIds) {
                fileService.deleteFile(fileId);
            }
        }

        Long firstFileId = fileService.saveBoardFiles(id, loginUser.getMemberIdx(), images);

        if (firstFileId != null) {
            boardService.updateThumbnail(id, "/file/download?fileId=" + firstFileId);
        } else {
            List<FileDto> remainFiles = fileService.getFilesByBoardId(id);
            if (!remainFiles.isEmpty()) {
                boardService.updateThumbnail(id, "/file/download?fileId=" + remainFiles.get(0).getId());
            } else {
                boardService.updateThumbnail(id, "/img/no-image.png");
            }
        }

        board.getBoardId();
        boardService.update(board);

        String encodedCategory = URLEncoder.encode(board.getCategory(), "UTF-8");
        return "redirect:/board/list?category=" + encodedCategory;
    }

    // 6. 글 삭제
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        boardService.delete(id);
        return "redirect:/board/list";
    }

    // 7. 관리자 삭제
    @PostMapping("/admin/delete/{id}")
    public String adminDelete(@PathVariable Long id, HttpSession session) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
            return "redirect:/board/list?error=unauthorized";
        }
        boardService.adminDelete(id);
        return "redirect:/board/list";
    }

    // 8. 상세 조회
    @GetMapping("/view/{id}")
    public String view(@PathVariable Long id, Model model, HttpSession session) {
        BoardDetailDto board = boardService.getBoardDetail(id);
        model.addAttribute("board", board);

        Member loginUser = (Member) session.getAttribute("loginUser");
        model.addAttribute("loginUser", loginUser);

        List<FileDto> fileList = fileService.getFilesByBoardId(id);
        model.addAttribute("fileList", fileList);

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
