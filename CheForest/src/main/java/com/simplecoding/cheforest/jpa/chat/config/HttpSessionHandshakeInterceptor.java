package com.simplecoding.cheforest.jpa.chat.config;

import jakarta.servlet.http.HttpSession;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;
import java.util.Map;

// HTTP 세션에서 웹소켓 세션 속성으로 보안 컨텍스트를 복사하는 클래스입니다.
public class HttpSessionHandshakeInterceptor implements HandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                   WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
            HttpSession session = servletRequest.getServletRequest().getSession(false); // 새로운 세션을 생성하지 않음
            if (session != null) {
                // Spring Security 컨텍스트를 가져와 웹소켓 속성에 저장합니다.
                attributes.put("SPRING_SECURITY_CONTEXT", session.getAttribute("SPRING_SECURITY_CONTEXT"));
            }
        }
        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
                               WebSocketHandler wsHandler, Exception exception) {
        // 핸드셰이크 후에는 별도의 작업이 필요하지 않습니다.
    }
}