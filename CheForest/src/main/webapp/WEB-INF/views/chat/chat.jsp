<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>chat</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/chat.css">
</head>
<body>
<!-- 커뮤니티 채팅 컨테이너 -->
<div class="community-chat-container">
    <!-- 채팅 플로팅 버튼 -->
    <button class="chat-floating-btn" id="chatFloatingBtn">
        <i data-lucide="users"></i>
        <div class="floating-btn-pulse"></div>
        <!-- 온라인 사용자 수 배지 -->
<%--        <div class="online-badge" id="onlineBadge">--%>
<%--            <span id="onlineCount">4</span> <!-- JSP에서 실제 온라인 사용자 수로 교체 -->--%>
<%--        </div>--%>
    </button>

    <!-- 커뮤니티 채팅창 -->
    <div class="chat-window hidden" id="chatWindow">
        <div class="chat-container-inner">
            <!-- 채팅 헤더 -->
            <div class="chat-header">
                <div class="header-content">
                    <div class="header-icon">
                        <i data-lucide="users"></i>
                    </div>
                    <div class="header-info">
                        <h3>와글와글 요리이야기</h3>
                        <p class="header-subtitle">
<%--                            <span class="online-indicator"></span>--%>
<%--                            <span id="headerOnlineCount">4명 접속중</span> <!-- JSP에서 동적으로 교체 -->--%>
                        </p>
                    </div>
                </div>
                <div class="header-actions">
                    <button class="close-btn" id="closeChatBtn">
                        <i data-lucide="x"></i>
                    </button>
                </div>
            </div>

            <!-- 메시지 영역 -->
            <div class="messages-container" id="messagesContainer">
                <!-- JSP에서 c:forEach로 반복 생성할 일반 사용자 메시지 1개 예시 -->
                <div class="message-item">
                    <div class="message-avatar" style="background-color: #ff6b6b">
                        사 <!-- JSP에서 사용자 이니셜로 교체 -->
                    </div>
                    <div class="message-content">
                        <div class="message-header">
                            <span class="message-time">5분 전</span> <!-- JSP에서 DB 데이터로 교체 -->
                            <span class="user-grade">🌳</span> <!-- JSP에서 등급별 아이콘으로 교체 -->
                            <span class="user-nickname">요리왕김치찌개</span> <!-- JSP에서 DB 데이터로 교체 -->
                        </div>
                        <div class="message-bubble">
                            <p>안녕하세요! 오늘 저녁 메뉴 추천 좀 해주실 수 있나요? 🍽️</p> <!-- JSP에서 DB 데이터로 교체 -->
                        </div>
                    </div>
                </div>

                <!-- JSP에서 c:forEach로 반복 생성할 다른 사용자 메시지 1개 예시 -->
                <div class="message-item">
                    <div class="message-avatar" style="background-color: #4ecdc4">
                        파 <!-- JSP에서 사용자 이니셜로 교체 -->
                    </div>
                    <div class="message-content">
                        <div class="message-header">
                            <span class="message-time">4분 전</span> <!-- JSP에서 DB 데이터로 교체 -->
                            <span class="user-grade">🌳</span> <!-- JSP에서 등급별 아이콘으로 교체 -->
                            <span class="user-nickname">파스타마스터</span> <!-- JSP에서 DB 데이터로 교체 -->
                        </div>
                        <div class="message-bubble">
                            <p>김치찌개 어떠세요? 요즘 날씨에 딱이에요!</p> <!-- JSP에서 DB 데이터로 교체 -->
                        </div>
                    </div>
                </div>

                <!-- 내 메시지 예시 (오른쪽 정렬) -->
                <div class="message-item my-message">
                    <div class="message-avatar" style="background-color: #ec4899">
                        내 <!-- JSP에서 현재 사용자 이니셜로 교체 -->
                    </div>
                    <div class="message-content">
                        <div class="message-header">
                            <span class="my-badge">나</span>
                            <span class="message-time">방금 전</span> <!-- JSP에서 DB 데이터로 교체 -->
                            <span class="user-grade">🌱</span> <!-- JSP에서 현재 사용자 등급으로 교체 -->
                            <span class="user-nickname">요리새싹</span> <!-- JSP에서 현재 사용자 닉네임으로 교체 -->
                        </div>
                        <div class="message-bubble my-bubble">
                            <p>좋은 아이디어네요! 김치찌개 레시피 공유해주실 수 있나요?</p> <!-- JSP에서 DB 데이터로 교체 -->
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
                    <div class="current-user-avatar" style="background-color: #ec4899">
                        내 <!-- JSP에서 현재 사용자 이니셜로 교체 -->
                    </div>
                    <span class="current-user-name">요리새싹</span> <!-- JSP에서 현재 사용자 닉네임으로 교체 -->
                    <span class="current-user-grade">🌱</span> <!-- JSP에서 현재 사용자 등급 아이콘으로 교체 -->
                </div>

                <!-- 메시지 입력 -->
                <div class="message-input-wrapper">
                    <div class="input-group">
                        <input
                                type="text"
                                id="messageInput"
                                placeholder="메시지를 입력하세요..."
                                class="message-input"
                                maxlength="500"
                        >
                        <button class="send-btn" id="sendBtn" disabled>
                            <i data-lucide="send"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Lucide 아이콘 라이브러리 -->
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
<script>lucide.createIcons();</script>

<!-- 커뮤니티 채팅 JavaScript -->
<script src="/js/chat.js"></script>
</body>
</html>