package com.simplecoding.cheforest.jpa.board.service;

import com.simplecoding.cheforest.es.integratedSearch.entity.IntegratedSearch;
import com.simplecoding.cheforest.es.integratedSearch.repository.IntegratedSearchRepository;
import com.simplecoding.cheforest.jpa.board.dto.*;
import com.simplecoding.cheforest.jpa.board.entity.Board;
import com.simplecoding.cheforest.jpa.board.repository.BoardRepository;
import com.simplecoding.cheforest.jpa.board.repository.BoardRepositoryDsl;
import com.simplecoding.cheforest.jpa.common.MapStruct;
import com.simplecoding.cheforest.jpa.common.util.JsonUtil;
import com.simplecoding.cheforest.jpa.common.util.StringUtil;
import com.simplecoding.cheforest.jpa.file.dto.FileDto;
import com.simplecoding.cheforest.jpa.file.service.FileService;
import com.simplecoding.cheforest.jpa.like.service.LikeService;
import com.simplecoding.cheforest.jpa.auth.entity.Member;
import com.simplecoding.cheforest.jpa.auth.repository.MemberRepository;
import com.simplecoding.cheforest.jpa.review.service.ReviewService;   // ✅ 추가
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Service
@RequiredArgsConstructor
@Transactional
public class BoardService {

    private final BoardRepository boardRepository;
    private final BoardRepositoryDsl boardRepositoryDsl;
    private final FileService fileService;
    private final LikeService likeService;
    private final MemberRepository memberRepository;
    private final MapStruct mapStruct;
    private final IntegratedSearchRepository integratedSearchRepository;
    private final ReviewService reviewService;   // ✅ 추가

    // 1. 목록 조회 (검색 + 페이징)
    @Transactional(readOnly = true)
    public Page<BoardListDto> searchBoards(String keyword, String category, String searchType, Pageable pageable) {
        Page<BoardListDto> result = boardRepositoryDsl.searchBoards(keyword, category, searchType, pageable);

        result.forEach(dto -> {
            if (dto.getInsertTime() != null) {
                dto.setCreatedAgo(toAgo(dto.getInsertTime()));
            }
        });
        return result;
    }

    // 2. 상세 조회 (+ 조회수 증가)
    @Transactional
    public BoardDetailDto getBoardDetail(Long boardId) {
        BoardDetailDto dto = boardRepositoryDsl.findBoardDetail(boardId);
        if (dto == null) {
            throw new IllegalArgumentException("게시글 없음: " + boardId);
        }
        dto.setInsertTimeStr(com.simplecoding.cheforest.common.util.DateTimeUtil.format(dto.getInsertTime()));

        boardRepository.increaseViewCount(boardId);
        dto.setViewCount(dto.getViewCount() + 1);

        return dto;
    }

    // 3. 게시글 등록
    @Transactional
    public Long create(BoardSaveReq dto, String writerEmail) throws IOException {
        Member writer = memberRepository.findByEmail(writerEmail)
                .orElseThrow(() -> new IllegalArgumentException("회원 없음: " + writerEmail));

        Board board = mapStruct.toEntity(dto);
        board.setWriter(writer);

//        조리시간(cookTime)에서 숫자만 추출하여 설정하는 로직 추가
        if (dto.getCookTime() != null && !dto.getCookTime().isBlank()) {
            String cookTimeStr = dto.getCookTime().replaceAll("[^0-9]", "");
            if (!cookTimeStr.isEmpty()) {
                board.setCookTime(Integer.parseInt(cookTimeStr));
            }
        }

        board.setPrepare(StringUtil.joinList(dto.getIngredientName()));
        board.setPrepareAmount(StringUtil.joinList(dto.getIngredientAmount()));

        List<StepDto> steps = new ArrayList<>();
        if (dto.getInstructionContent() != null) {
            for (int i = 0; i < dto.getInstructionContent().size(); i++) {
                String text = dto.getInstructionContent().get(i);

                steps.add(new StepDto(text, null));
            }
        }
        board.setContent(JsonUtil.toJson(steps));

        boardRepository.save(board);
        Long boardId = board.getBoardId();

        return boardId;
    }

    // 4. 게시글 수정
    @Transactional
    public void update(Long boardId,
                       BoardSaveReq dto,
                       String writerEmail,
                       List<Long> deleteImageIds) throws IOException {

        // 1) 기존 게시글 조회
        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new IllegalArgumentException("게시글 없음: " + boardId));

        // 2) 작성자 검증 (기존 로직 유지 - 좋습니다 👍)
        if (!board.getWriter().getEmail().equals(writerEmail)) {
            throw new SecurityException("작성자만 수정할 수 있습니다.");
        }

        // 3) 기본 정보 업데이트
        board.setTitle(dto.getTitle());
        board.setCategory(dto.getCategory());
        board.setDifficulty(dto.getDifficulty());

        // ✅ [수정] "30분" -> 30으로 변환. 숫자 외 문자 모두 제거
        String cookTimeStr = dto.getCookTime().replaceAll("[^0-9]", "");
        if (!cookTimeStr.isEmpty()) {
            board.setCookTime(Integer.parseInt(cookTimeStr));
        }

        // 4) 재료 → 문자열 변환 (기존 로직 유지)
        board.setPrepare(StringUtil.joinList(dto.getIngredientName()));
        board.setPrepareAmount(StringUtil.joinList(dto.getIngredientAmount()));

        // 5) ✅ [수정] 조리법 업데이트 (글 + 이미지 통합 로직)
        // 기존 조리법 정보 불러오기
        List<StepDto> originalSteps = board.getContent() != null && !board.getContent().isBlank() ?
                JsonUtil.fromJsonList(board.getContent(), StepDto.class) : new ArrayList<>();

        List<StepDto> newSteps = new ArrayList<>();
        List<String> contents = dto.getInstructionContent();
        List<MultipartFile> images = dto.getInstructionImage();

        if (contents != null) {
            for (int i = 0; i < contents.size(); i++) {
                String content = contents.get(i);
                MultipartFile imageFile = (images != null && i < images.size()) ? images.get(i) : null;
                String imageUrl = null;

                // 새 이미지가 업로드된 경우
                if (imageFile != null && !imageFile.isEmpty()) {
                    // 기존에 이미지가 있었다면 삭제
                    if (i < originalSteps.size() && originalSteps.get(i).getImage() != null) {
                        try {
                            String oldUrl = originalSteps.get(i).getImage();
                            Long oldFileId = Long.parseLong(oldUrl.substring(oldUrl.lastIndexOf('/') + 1));
                            fileService.deleteFile(oldFileId);
                        } catch (Exception e) {
                            // log.error("기존 조리법 이미지 삭제 실패", e);
                        }
                    }
                    // 새 이미지 저장
                    FileDto stepImage = fileService.saveFile(imageFile, "BOARD_STEP", boardId, String.valueOf(i + 1), board.getWriter().getMemberIdx());
                    imageUrl = "/file/board/preview/" + stepImage.getFileId();
                }
                // 새 이미지가 없고, 기존 이미지를 유지해야 하는 경우
                else if (i < originalSteps.size()) {
                    imageUrl = originalSteps.get(i).getImage();
                }
                newSteps.add(new StepDto(content, imageUrl));
            }
        }
        board.setContent(JsonUtil.toJson(newSteps));


        // 6) 삭제 요청된 기존 첨부 파일 처리 (기존 로직 유지)
        if (deleteImageIds != null && !deleteImageIds.isEmpty()) {
            deleteImageIds.forEach(fileService::deleteFile);
        }

        // 7) ✅ [수정] 대표 이미지 교체 (기존 파일 삭제 로직 추가)
        if (dto.getMainImage() != null && !dto.getMainImage().isEmpty()) {
            // 기존 썸네일 파일이 있었다면 삭제
            if (board.getThumbnail() != null && !board.getThumbnail().isEmpty()) {
                try {
                    // URL에서 fileId 추출 (예: /file/board/preview/123 -> 123)
                    String oldUrl = board.getThumbnail();
                    Long oldFileId = Long.parseLong(oldUrl.substring(oldUrl.lastIndexOf('/') + 1));
                    fileService.deleteFile(oldFileId);
                } catch (Exception e) {
                    // log.error("기존 썸네일 삭제 실패", e); // 실제 운영에서는 로그를 남기는 것이 좋습니다.
                }
            }

            // 새 썸네일 저장 및 URL 설정
            FileDto thumb = fileService.saveFile(dto.getMainImage(),
                    "BOARD", boardId, "THUMBNAIL", board.getWriter().getMemberIdx());
            if (thumb != null) {
                board.setThumbnail("/file/board/preview/" + thumb.getFileId());
            }
        }
        // JPA 더티체킹(Dirty Checking)으로 메소드 종료 시 자동으로 DB에 update 쿼리가 실행됩니다.
    }

    // 5. 게시글 삭제
    public void delete(Long boardId) {
        // ✅ 댓글 먼저 삭제
        reviewService.deleteByBoardId(boardId);

        likeService.deleteAllByBoardId(boardId);
        fileService.deleteAllByTargetIdAndType(boardId, "BOARD");
        boardRepository.deleteById(boardId);
    }

    // 6. 관리자 삭제
    public void adminDelete(Long boardId) {
        // ✅ 댓글 먼저 삭제
        reviewService.deleteByBoardId(boardId);

        likeService.deleteAllByBoardId(boardId);
        fileService.deleteAllByTargetIdAndType(boardId, "BOARD");
        boardRepository.deleteById(boardId);
    }

    // 7. 인기글 조회
    @Transactional(readOnly = true)
    public List<BoardListDto> getBestPosts() {
        List<BoardListDto> posts = boardRepositoryDsl.findBestPosts();
        posts.forEach(dto -> {
            if (dto.getInsertTime() != null) {
                dto.setCreatedAgo(toAgo(dto.getInsertTime()));
            }
        });
        return posts;
    }

    @Transactional(readOnly = true)
    public List<BoardListDto> getBestPostsByCategory(String category) {
        List<BoardListDto> posts = boardRepositoryDsl.findBestPostsByCategory(category);
        posts.forEach(dto -> {
            if (dto.getInsertTime() != null) {
                dto.setCreatedAgo(toAgo(dto.getInsertTime()));
            }
        });
        return posts;
    }

    // 8. 썸네일 업데이트
    public void updateThumbnail(Long boardId, String thumbnailPath) {
        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new IllegalArgumentException("게시글 없음: " + boardId));
        board.setThumbnail(thumbnailPath);
    }

    public Long countMyPosts(Member member) {
        return boardRepository.countByWriter(member);
    }

    //    총 게시글 수
    public long getTotalCount() {
        return boardRepository.count();
    }

    //    카테고리별 게시글 수
    public long getCountByCategory(String category) {
        return boardRepository.countByCategory(category);
    }


    //    전처리
    private String toAgo(java.time.LocalDateTime created) {
        java.time.Duration duration = java.time.Duration.between(created, java.time.LocalDateTime.now());

        long minutes = duration.toMinutes();
        if (minutes < 1) return "방금 전";
        if (minutes < 60) return minutes + "분 전";

        long hours = minutes / 60;
        if (hours < 24) return hours + "시간 전";

        long days = hours / 24;
        if (days < 7) return days + "일 전";

        long weeks = days / 7;
        if (weeks < 5) return weeks + "주 전";

        long months = days / 30;
        if (months < 12) return months + "개월 전";

        long years = days / 365;
        return years + "년 전";
    }
    //   최근 3개 조회
    public List<Board> recentPosts() {
        return boardRepository.findTop3ByOrderByInsertTimeDesc();
    }

    // 인기 게시글 (좋아요 수 기준)
    @Transactional(readOnly = true)
// 인기 게시글
    public List<BoardListDto> findPopularBoards() {
        return boardRepository.findTop5ByOrderByLikeCountDesc()
                .stream()
                .map(board -> mapStruct.toListDto(board))  // ✅ 이렇게 람다식으로
                .toList();
    }

    // 게시글 검색
    public List<BoardListDto> searchBoards(String keyword) {
        return boardRepository.searchBoards(keyword, PageRequest.of(0, 5))
                .stream()
                .map(mapStruct::toListDto)
                .toList();
    }
    // ✅ 카테고리별 랜덤 게시글 1개
    public BoardListDto getRandomBoardByCategory(String category) {
        List<Board> candidates = boardRepository.findRandomBoardsByCategory(category, 5);

        if (candidates == null || candidates.isEmpty()) return null;

        Board randomBoard = candidates.get(new Random().nextInt(candidates.size()));
        return mapStruct.toListDto(randomBoard);
    }


}





