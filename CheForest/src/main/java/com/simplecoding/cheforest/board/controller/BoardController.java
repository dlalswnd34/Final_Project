package com.simplecoding.cheforest.board.controller;

import com.simplecoding.cheforest.board.dto.*;
import com.simplecoding.cheforest.board.service.BoardService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/board") // 소문자 유지
public class BoardController {

    private final BoardService boardService;

    // 목록(검색: 제목/내용 + 카테고리)
    // → /WEB-INF/views/board/boardlist.jsp
    @GetMapping
    public String list(@RequestParam(defaultValue = "") String kw,
                       @RequestParam(defaultValue = "") String cat,
                       @PageableDefault(size = 10, sort = "boardId", direction = Sort.Direction.DESC) Pageable pageable,
                       Model model) {
        model.addAttribute("page", boardService.search(kw, cat, pageable));
        model.addAttribute("kw", kw);
        model.addAttribute("cat", cat);
        return "board/boardlist";
    }

    // 상세 (조회수 증가)
    // → /WEB-INF/views/board/boardview.jsp
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        BoardDetailDto dto = boardService.getDetail(id, true);
        model.addAttribute("board", dto);
        return "board/boardview";
    }

    // 작성 폼
    // → /WEB-INF/views/board/boardwrite.jsp
    @GetMapping("/new")
    public String form(@ModelAttribute("form") BoardSaveReq form) {
        return "board/boardwrite";
    }

    // 등록
    @PostMapping
    public String create(@Valid @ModelAttribute("form") BoardSaveReq form,
                         BindingResult br) {
        if (br.hasErrors()) {
            return "board/boardwrite";
        }
        Long id = boardService.create(form);
        return "redirect:/board/" + id;
    }

    // 수정 폼
    // → /WEB-INF/views/board/boardupdate.jsp
    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        BoardDetailDto dto = boardService.getDetail(id, false);
        BoardUpdateReq form = BoardUpdateReq.builder()
                .boardId(dto.getBoardId())
                .title(dto.getTitle())
                .content(dto.getContent())
                .category(dto.getCategory())
                .build();
        model.addAttribute("form", form);
        return "board/boardupdate";
    }

    // 수정 (JSP에서 POST 전송)
    @PostMapping("/{id}")
    public String update(@PathVariable Long id,
                         @Valid @ModelAttribute("form") BoardUpdateReq form,
                         BindingResult br) {
        if (br.hasErrors()) {
            return "board/boardupdate";
        }
        form.setBoardId(id); // path 변수 우선
        boardService.update(form);
        return "redirect:/board/" + id;
    }

    // 삭제 (JSP 폼에서 POST 전송)
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) {
        boardService.delete(id);
        return "redirect:/board";
    }

    // 작성자별 목록 (마이페이지)
    // 원본 zip에 list-by-writer.jsp가 없으므로, 우선 boardlist.jsp 재사용
    // → /WEB-INF/views/board/boardlist.jsp
    @GetMapping("/writer/{memberIdx}")
    public String listByWriter(@PathVariable Long memberIdx,
                               @PageableDefault(size = 10, sort = "boardId", direction = Sort.Direction.DESC) Pageable pageable,
                               Model model) {
        model.addAttribute("page", boardService.listByWriter(memberIdx, pageable));
        model.addAttribute("memberIdx", memberIdx);
        model.addAttribute("byWriter", true); // JSP에서 분기 필요하면 사용
        return "board/boardlist";
    }

    // 사이드/홈 위젯: 최신 Top5 (JSON)
    @GetMapping("/api/latest")
    @ResponseBody
    public List<BoardListDto> latestTop5() {
        return boardService.latestTop5();
    }

    // 사이드/홈 위젯: 좋아요 Top5 (JSON)
    @GetMapping("/api/top-liked")
    @ResponseBody
    public List<BoardListDto> topLikedTop5() {
        return boardService.topLikedTop5();
    }
}
