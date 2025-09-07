package com.simplecoding.cheforest.common;

import lombok.extern.log4j.Log4j2;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

// 목적: 컨트롤러에서 에러가 발생하면 무조건 여기로 오게하는 클래스
// AOP(공통 관심사==공통기능) 활용한 어노테이션 : @ControllerAdvice
// 예) @ControllerAdvice(에러처리 공통기능), @Transactional(commit 공통기능)
//    @Scheduled(주기적으로 실행하게하는 공통기능)
@ControllerAdvice
@Log4j2
public class CommonException {

    @ExceptionHandler(Exception.class)
    public String internalServerErrorException(Exception e
    		, Model model
    		) {
        String errors = e.getMessage();       // 에러 내용
        log.info("에러: " + errors);
        model.addAttribute("errors", errors); // 에러를 모델에 담기
        
        return "errors";                      // errors.jsp 로 결과 전송
    }
}