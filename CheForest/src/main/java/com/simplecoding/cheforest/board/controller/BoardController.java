package com.simplecoding.cheforest.board.controller;

import com.simplecoding.cheforest.board.dto.*;
import com.simplecoding.cheforest.board.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {
    private final BoardService boardService;

    @GetMapping("/{id}")
    public String detail(@PathVariable("id") Long boardId, Model model) {
        model.addAttribute("board", boardService.getBoard(boardId));
        return "board/detail";
    }

    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("boards", boardService.findAll());
        return "board/list";
    }

    @GetMapping("/write")
    public String writeForm() {
        return "board/write";
    }

    @PostMapping("/write")
    public String write(@ModelAttribute BoardSaveDto dto) {
        boardService.save(dto);
        return "redirect:/board/list";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute BoardUpdateDto dto) {
        boardService.update(dto);
        return "redirect:/board/" + dto.getBoardId();
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long boardId) {
        boardService.delete(boardId);
        return "redirect:/board/list";
    }
}
