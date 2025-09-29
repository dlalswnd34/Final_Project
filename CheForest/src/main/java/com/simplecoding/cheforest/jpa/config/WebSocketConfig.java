package com.simplecoding.cheforest.jpa.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.security.config.annotation.web.messaging.MessageSecurityMetadataSourceRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    private final StompHandler stompHandler;

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // 클라이언트가 WebSocket 연결을 시작할 EndPoint를 설정합니다.
        // Handshake 과정에서 HTTP 세션 정보를 WebSocket 세션으로 안전하게 복사합니다.
        // 이 부분이 JSP의 new SockJS("/ws")와 일치해야 합니다.
        registry.addEndpoint("/ws")
                .setAllowedOriginPatterns("*") // 👈 모든 오리진 허용 (개발 시)
                .withSockJS();
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // 메시지를 구독(Subscribe)하는 클라이언트에게 메시지를 전달할 경로의 Prefix를 설정합니다.
        // JSP의 stompClient.subscribe("/sub/...") 부분과 일치합니다.
        registry.enableSimpleBroker("/sub");
        // 클라이언트가 서버로 메시지를 보낼(Publish) 경로의 Prefix를 설정합니다.
        // JSP의 stompClient.send("/pub/...") 부분과 일치합니다.
        registry.setApplicationDestinationPrefixes("/pub");
    }

    /**
     * 클라이언트로부터 들어오는 메시지를 처리하는 채널에 StompHandler를 등록합니다.
     * 이 핸들러가 Spring Security의 보안 검사보다 먼저 실행되어
     * CONNECT 메시지에 사용자 인증 정보를 올바르게 설정하는 핵심 역할을 합니다.
     */
    public void customizeClientInboundChannel(ChannelRegistration registration) {
        registration.interceptors(stompHandler);
    }
}

