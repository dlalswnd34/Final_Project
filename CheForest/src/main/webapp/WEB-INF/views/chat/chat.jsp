<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CheForest 채팅</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/chat.css">
</head>
<body>
    <!-- 더미 데이터 (숨겨진 div) -->
    <div id="chatDummyData" style="display: none;">
        <!-- 더미 사용자 데이터 -->
        <div id="dummyUsers">
            <div class="dummy-user" data-id="1" data-nickname="요리왕김치찌개" data-avatar="#ff6b6b" data-grade="forest" data-online="true"></div>
            <div class="dummy-user" data-id="2" data-nickname="파스타마스터" data-avatar="#4ecdc4" data-grade="tree" data-online="true"></div>
            <div class="dummy-user" data-id="3" data-nickname="디저트요정" data-avatar="#45b7d1" data-grade="sprout" data-online="false"></div>
            <div class="dummy-user" data-id="4" data-nickname="한식러버" data-avatar="#96ceb4" data-grade="root" data-online="true"></div>
            <div class="dummy-user" data-id="5" data-nickname="베이킹초보" data-avatar="#feca57" data-grade="seed" data-online="true"></div>
            <div class="dummy-user" data-id="6" data-nickname="매운맛도전자" data-avatar="#ff9ff3" data-grade="tree" data-online="false"></div>
            <div class="dummy-user" data-id="7" data-nickname="건강요리사" data-avatar="#54a0ff" data-grade="sprout" data-online="true"></div>
        </div>
        
        <!-- 현재 사용자 데이터 -->
        <div id="currentUser" data-id="current" data-nickname="요리새싹" data-avatar="#ff7675" data-grade="sprout" data-online="true"></div>
        
        <!-- 초기 커뮤니티 메시지 -->
        <div id="initialCommunityMessages">
            <div class="initial-message" 
                 data-id="1" 
                 data-text="안녕하세요! 오늘 저녁 메뉴 추천 좀 해주실 수 있나요? 🍽️" 
                 data-user-id="1" 
                 data-timestamp="300000" 
                 data-my-message="false">
            </div>
            <div class="initial-message" 
                 data-id="2" 
                 data-text="김치찌개 어떠세요? 요즘 날씨에 딱이에요!" 
                 data-user-id="2" 
                 data-timestamp="240000" 
                 data-my-message="false">
            </div>
            <div class="initial-message" 
                 data-id="3" 
                 data-text="아니면 간단한 파스타도 좋을 것 같아요 ✨" 
                 data-user-id="4" 
                 data-timestamp="180000" 
                 data-my-message="false">
            </div>
            <div class="initial-message" 
                 data-id="4" 
                 data-text="파스타 레시피 공유해주실 수 있나요?" 
                 data-user-id="5" 
                 data-timestamp="120000" 
                 data-my-message="false">
            </div>
            <div class="initial-message" 
                 data-id="5" 
                 data-text="크림파스타가 제일 간단해요! 생크림, 베이컨, 마늘만 있으면 끝!" 
                 data-user-id="2" 
                 data-timestamp="60000" 
                 data-my-message="false">
            </div>
        </div>
        
        <!-- 초기 챗봇 메시지 -->
        <div id="initialBotMessages">
            <div class="initial-bot-message" 
                 data-id="1" 
                 data-text="안녕하세요! CheForest 챗봇입니다. 🤖&#10;궁금한 것이 있으시면 언제든 물어보세요!" 
                 data-timestamp="0" 
                 data-sender="bot">
            </div>
        </div>
        
        <!-- 랜덤 메시지 풀 -->
        <div id="randomMessages">
            <div class="random-message">방금 김치볶음밥 만들어 먹었는데 정말 맛있어요! 🍚</div>
            <div class="random-message">오늘 새로운 레시피 도전해봤어요 ✨</div>
            <div class="random-message">누구 디저트 레시피 추천해주실 분 있나요?</div>
            <div class="random-message">요즘 제철 식재료로 뭐 만드시나요?</div>
            <div class="random-message">채식 요리에 관심이 생겼는데 추천 레시피 있을까요? 🥗</div>
            <div class="random-message">간단한 도시락 반찬 아이디어 부탁드려요!</div>
            <div class="random-message">와... 방금 만든 케이크가 대박이에요! 🎂</div>
            <div class="random-message">초보도 쉽게 만들 수 있는 국물 요리 있나요?</div>
            <div class="random-message">오늘 장 봐온 재료로 뭘 만들지 고민되네요</div>
            <div class="random-message">집에서 만든 빵 냄새가 너무 좋아요 🍞</div>
        </div>
    </div>
    <!-- 라이브 채팅 컨테이너 -->
    <div id="liveChatContainer" class="live-chat-container">
        <!-- 스와이프 토글 버튼 -->
        <div class="chat-toggle-wrapper">
            <!-- 메인 토글 컨테이너 -->
            <div class="toggle-container">
                <div class="toggle-inner">
                    <!-- 슬라이딩 배경 -->
                    <div id="slidingBackground" class="sliding-background community-mode"></div>
                    
                    <!-- 커뮤니티 채팅 버튼 -->
                    <button id="communityBtn" class="toggle-btn active" title="커뮤니티 채팅">
                        <svg class="btn-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                        </svg>
                        <span class="btn-text">채팅</span>
                    </button>
                    
                    <!-- AI 챗봇 버튼 -->
                    <button id="chatbotBtn" class="toggle-btn" title="AI 챗봇">
                        <svg class="btn-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                        </svg>
                        <span class="btn-text">AI</span>
                    </button>
                </div>
                
                <!-- 상태 배지 -->
                <div id="statusBadge" class="status-badge community-mode">4</div>
                
                <!-- 펄스 애니메이션 -->
                <div id="pulseAnimation" class="pulse-animation community-mode" style="display: none;"></div>
            </div>
        </div>

        <!-- 채팅창 -->
        <div id="chatWindow" class="chat-window" style="display: none;">
            <div class="chat-container">
                <!-- 채팅 헤더 -->
                <div id="chatHeader" class="chat-header community-mode">
                    <div class="header-content">
                        <div class="header-icon">
                            <svg id="headerIcon" class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                            </svg>
                        </div>
                        <div class="header-info">
                            <h3 id="chatTitle" class="chat-title">CheForest 커뮤니티</h3>
                            <p id="chatStatus" class="chat-status">
                                <span class="status-indicator"></span>
                                <span id="statusText">4명 접속중</span>
                            </p>
                        </div>
                    </div>
                    <div class="header-actions">
                        <button id="closeChatBtn" class="close-btn">
                            <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                            </svg>
                        </button>
                    </div>
                </div>

                <!-- 메시지 영역 -->
                <div id="messagesArea" class="messages-area">
                    <!-- 커뮤니티 메시지들 -->
                    <div id="communityMessages" class="messages-container">
                        <!-- 초기 메시지들이 JavaScript로 추가됩니다 -->
                    </div>
                    
                    <!-- 챗봇 메시지들 -->
                    <div id="chatbotMessages" class="messages-container" style="display: none;">
                        <!-- 챗봇 메시지들이 JavaScript로 추가됩니다 -->
                    </div>
                    
                    <!-- 타이핑 인디케이터 -->
                    <div id="typingIndicator" class="typing-indicator" style="display: none;">
                        <div class="avatar bot-avatar">🤖</div>
                        <div class="message-content">
                            <div class="user-info">
                                <span class="timestamp">방금 전</span>
                                <span class="grade-icon">🌲</span>
                                <span class="username">CheForest Bot</span>
                            </div>
                            <div class="typing-bubble">
                                <div class="typing-dots">
                                    <div class="dot"></div>
                                    <div class="dot"></div>
                                    <div class="dot"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 입력 영역 -->
                <div class="input-area">
                    <!-- 현재 사용자 정보 -->
                    <div class="current-user-info">
                        <div class="user-avatar" style="background-color: #ff7675;">요</div>
                        <span class="username">요리새싹</span>
                        <span class="grade-icon">🌱</span>
                    </div>
                    
                    <div class="input-controls">
                        <div class="input-wrapper">
                            <input 
                                type="text" 
                                id="messageInput" 
                                class="message-input" 
                                placeholder="메시지를 입력하세요..."
                            />
                        </div>
                        <button id="sendBtn" class="send-btn community-mode" disabled>
                            <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="/js/common.js"></script>
    <script src="/js/chat.js"></script>
</body>
</html>