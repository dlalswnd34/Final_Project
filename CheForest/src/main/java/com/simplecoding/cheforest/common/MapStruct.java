package com.simplecoding.cheforest.common;

import com.simplecoding.cheforest.board.dto.BoardDetailDto;
import com.simplecoding.cheforest.board.dto.BoardListDto;
import com.simplecoding.cheforest.board.dto.BoardSaveReq;
import com.simplecoding.cheforest.board.dto.BoardUpdateReq;
import com.simplecoding.cheforest.board.entity.Board;
import org.mapstruct.*;

@Mapper(componentModel = "spring",                                                 // spring 과 연결
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE // null 제외 기능(update 시 사용)
)
public interface MapStruct {
//    TODO: 여기서 할것: 각 업무별로 함수명 정하기
//         -> 라이브러리가 알아서 그 함수명으로 복사해 줍니다.
//    TODO: 1) 부서: Dept <-> DeptDto
//    DeptDto toDto(Dept dept);
//    Dept toEntity(DeptDto deptDto);
////    TODO: 더티 체킹용 수정 함수: @MappingTarget 꼭 사용할 것
//    void updateFromDto(DeptDto deptDto, @MappingTarget Dept dept);

    // Entity -> 목록 DTO
    @Mapping(target = "writerId",       source = "writer.memberIdx")
    @Mapping(target = "writerNickname", source = "writer.nickname")
    BoardListDto toListDto(Board entity);

    // Entity -> 상세 DTO
    @Mapping(target = "writerId",       source = "writer.memberIdx")
    @Mapping(target = "writerNickname", source = "writer.nickname")
    BoardDetailDto toDetailDto(Board entity);

    // SaveReq -> Entity (writer는 Service에서 주입)
    @Mapping(target = "boardId", ignore = true)
    @Mapping(target = "writer",  ignore = true) // Service에서 memberRepository로 세팅
    Board toEntity(BoardSaveReq req);

    // UpdateReq -> 존재 엔티티 갱신 (null은 무시 → 부분수정)
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void updateEntity(@MappingTarget Board target, BoardUpdateReq req);

    // 기본값 보정 (like/view null 방어)
    @AfterMapping
    default void fillDefaults(@MappingTarget Board target) {
        if (target.getLikeCount() == null) target.setLikeCount(0L);
        if (target.getViewCount() == null) target.setViewCount(0L);
    }
}