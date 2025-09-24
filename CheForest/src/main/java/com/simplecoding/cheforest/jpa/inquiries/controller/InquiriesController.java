package com.simplecoding.cheforest.jpa.inquiries.controller;


import com.simplecoding.cheforest.jpa.inquiries.dto.InquiryWithNicknameDto;
import com.simplecoding.cheforest.jpa.inquiries.service.InquiriesService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Log4j2
@RequiredArgsConstructor
@RestController
public class InquiriesController {

    private final InquiriesService inquiriesService;


    @GetMapping("/api/inquiries")
    public Map<String, Object> getPagedInquiries(@PageableDefault(size = 10, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable) {
        Page<InquiryWithNicknameDto> pageResult = inquiriesService.findInquiryWithNickname(pageable);

        Map<String, Object> response = new HashMap<>();
        response.put("data", pageResult.getContent());       // 실제 문의 내역
        response.put("total", pageResult.getTotalElements()); // 전체 개수
        response.put("totalPages", pageResult.getTotalPages()); // 전체 페이지 수
        response.put("page", pageResult.getNumber() + 1);     // 현재 페이지 번호 (1-based)
        return response;
    }

    @GetMapping("/api/inquiries/countAllInquiries")
    public Long countAllInquiries() {
        return inquiriesService.countAllInquiries();
    }

    @GetMapping("/api/inquiries/countPendingInquiries")
    public Long countPendingInquiries() {
        return inquiriesService.countPendingInquiries();
    }
    @GetMapping("/api/inquiries/countAnsweredInquiries")
    public Long countAnsweredInquiries() {
        return inquiriesService.countAnsweredInquiries();
    }
    @GetMapping("/api/inquiries/countTodayInquiries")
    public Long countTodayInquiries() {
        return inquiriesService.countTodayInquiries();
    }

    @GetMapping("/api/inquiries/pending")
    public List<InquiryWithNicknameDto> findPendingInquiriesWithNickname() {
        return inquiriesService.findPendingInquiriesWithNickname();
    }








}
