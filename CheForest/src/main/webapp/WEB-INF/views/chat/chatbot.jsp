<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI 챗봇 - CheForest</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/chatbot.css">
</head>
<body>
<!-- AI 챗봇 컨테이너 -->
<div class="ai-chatbot-container">
    <!-- 챗봇 플로팅 버튼 -->
    <button class="chatbot-floating-btn" id="chatbotFloatingBtn">
        <i data-lucide="bot"></i>
        <div class="floating-btn-pulse"></div>
        <!-- AI 상태 표시 배지 -->
        <div class="ai-status-badge">
            <span>AI</span>
        </div>
    </button>

    <!-- AI 챗봇창 -->
    <div class="chatbot-window hidden" id="chatbotWindow">
        <div class="chatbot-container-inner">
            <!-- 챗봇 헤더 -->
            <div class="chatbot-header">
                <div class="header-content">
                    <div class="header-icon">
                        <i data-lucide="bot"></i>
                    </div>
                    <div class="header-info">
                        <h3>CheForest 챗봇</h3>
                        <p class="header-subtitle">
                            <span class="ai-indicator"></span>
                            <span>실시간 도움말</span>
                        </p>
                    </div>
                </div>
                <div class="header-actions">
                    <button class="close-btn" id="closeChatbotBtn">
                        <i data-lucide="x"></i>
                    </button>
                </div>
            </div>

            <!-- 메시지 영역 -->
            <div class="messages-container" id="messagesContainer">
                <!-- 초기 AI 인사 메시지 -->
                <div class="message-item bot-message">
                    <div class="bot-avatar">
                        🤖
                    </div>
                    <div class="message-content">
                        <div class="message-header">
                            <span class="message-time">방금 전</span>
                            <span class="bot-grade">🌲</span>
                            <span class="bot-nickname">CheForest Bot</span>
                        </div>
                        <div class="message-bubble bot-bubble">
                            <p>안녕하세요! CheForest 챗봇입니다. 🤖<br>궁금한 것이 있으시면 언제든 물어보세요!</p>
                        </div>
                    </div>
                </div>

                <!-- JSP에서 c:forEach로 반복 생성할 사용자 질문 1개 예시 -->
                <div class="message-item user-message">
                    <div class="message-content">
                        <div class="message-header">
                            <span class="user-badge">나</span>
                            <span class="message-time">질문시간 자리</span> <!-- JSP에서 DB 데이터로 교체 -->
                            <span class="user-grade">🌱</span> <!-- JSP에서 현재 사용자 등급으로 교체 -->
                            <span class="user-nickname">사용자 닉네임</span> <!-- JSP에서 현재 사용자 닉네임으로 교체 -->
                        </div>
                        <div class="message-bubble user-bubble">
                            <p>사용자 질문 내용 자리</p> <!-- JSP에서 DB 데이터로 교체 -->
                        </div>
                    </div>
                    <div class="user-avatar">
                        사 <!-- JSP에서 현재 사용자 이니셜로 교체 -->
                    </div>
                </div>

                <!-- JSP에서 c:forEach로 반복 생성할 AI 응답 1개 예시 -->
                <div class="message-item bot-message">
                    <div class="bot-avatar">
                        🤖
                    </div>
                    <div class="message-content">
                        <div class="message-header">
                            <span class="message-time">응답시간 자리</span> <!-- JSP에서 DB 데이터로 교체 -->
                            <span class="bot-grade">🌲</span>
                            <span class="bot-nickname">CheForest Bot</span>
                        </div>
                        <div class="message-bubble bot-bubble">
                            <p>AI 응답 내용 자리</p> <!-- JSP에서 AI 응답으로 교체 -->
                        </div>
                    </div>
                </div>

                <!-- 타이핑 인디케이터 (AI 응답 대기 중) -->
                <div class="message-item bot-message typing-indicator hidden" id="typingIndicator">
                    <div class="bot-avatar">
                        🤖
                    </div>
                    <div class="message-content">
                        <div class="message-header">
                            <span class="message-time">방금 전</span>
                            <span class="bot-grade">🌲</span>
                            <span class="bot-nickname">CheForest Bot</span>
                        </div>
                        <div class="message-bubble bot-bubble">
                            <div class="typing-dots">
                                <div class="dot"></div>
                                <div class="dot"></div>
                                <div class="dot"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 스크롤 앵커 -->
                <div class="messages-end" id="messagesEnd"></div>
            </div>

            <!-- 입력 영역 -->
            <div class="input-container">
                <!-- 현재 사용자 정보 -->
                <div class="current-user-info">
                    <div class="current-user-avatar">
                        내 <!-- JSP에서 현재 사용자 이니셜로 교체 -->
                    </div>
                    <span class="current-user-name">내 닉네임 자리</span> <!-- JSP에서 현재 사용자 닉네임으로 교체 -->
                    <span class="current-user-grade">🌱</span> <!-- JSP에서 현재 사용자 등급 아이콘으로 교체 -->
                </div>

                <!-- 메시지 입력 -->
                <div class="message-input-wrapper">
                    <div class="input-group">
                        <input
                                type="text"
                                id="messageInput"
                                placeholder="AI에게 질문하세요..."
                                class="message-input"
                                maxlength="500"
                        >
                        <button class="send-btn" id="sendBtn" disabled>
                            <i data-lucide="send"></i>
                        </button>
                    </div>

                    <!-- 추천 질문 (선택사항) -->
                    <div class="suggested-questions" id="suggestedQuestions">
                        <div class="suggestion-title">추천 질문:</div>
                        <div class="suggestions">
                            <button class="suggestion-btn" data-question="레시피 작성하는 방법을 알려주세요">📝 레시피 작성법</button>
                            <button class="suggestion-btn" data-question="등급 시스템에 대해 설명해주세요">⭐ 등급 시스템</button>
                            <button class="suggestion-btn" data-question="좋은 요리 팁이 있나요?">🍳 요리 팁</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Lucide 아이콘 라이브러리 -->
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
<script>lucide.createIcons();</script>

<!-- AI 챗봇 JavaScript -->
<script src="/js/chatbot.js"></script>
</body>
</html>