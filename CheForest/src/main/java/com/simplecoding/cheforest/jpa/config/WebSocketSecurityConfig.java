package com.simplecoding.cheforest.jpa.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.messaging.MessageSecurityMetadataSourceRegistry;
import org.springframework.security.config.annotation.web.socket.AbstractSecurityWebSocketMessageBrokerConfigurer;
import org.springframework.security.config.annotation.web.socket.EnableWebSocketSecurity;

@Configuration
@EnableWebSocketSecurity // 👈 WebSocket 메시지 보안 활성화
public class WebSocketSecurityConfig extends AbstractSecurityWebSocketMessageBrokerConfigurer {

    // 🛑 메시지 전송(pub)에 대한 인증/인가 규칙
    @Override
    protected void configureInbound(MessageSecurityMetadataSourceRegistry messages) {
        messages
                // "/pub/message"로 들어오는 메시지는 인증된 사용자만 허용합니다.
                .simpDestMatchers("/pub/message").authenticated()
                // 그 외 모든 메시지(CONNECT, SUBSCRIBE 등)는 인증된 사용자라면 모두 허용합니다.
                .anyMessage().authenticated();
    }

    // STOMP는 일반 웹 CSRF와 다르므로 비활성화
    @Override
    protected boolean sameOriginDisabled() {
        return true;
    }
}
