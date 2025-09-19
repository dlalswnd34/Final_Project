// 라이브 채팅 JavaScript

class LiveChat {
    constructor() {
        this.isOpen = false;
        this.chatMode = 'community'; // 'community' | 'chatbot'
        this.onlineCount = 4;
        this.isTyping = false;
        this.messageCount = 0;
        
        // 등급별 아이콘
        this.gradeIcons = {
            seed: '🌱',
            root: '🌿',
            sprout: '🌱',
            tree: '🌳',
            forest: '🌲'
        };
        
        // HTML에서 데이터 로드
        this.loadDataFromHTML();
        
        this.init();
    }
    
    loadDataFromHTML() {
        // 현재 사용자 데이터 로드
        const currentUserEl = document.getElementById('currentUser');
        if (currentUserEl) {
            this.currentUser = {
                id: currentUserEl.dataset.id,
                nickname: currentUserEl.dataset.nickname,
                avatar: currentUserEl.dataset.avatar,
                grade: currentUserEl.dataset.grade,
                isOnline: currentUserEl.dataset.online === 'true'
            };
        } else {
            // 기본값
            this.currentUser = {
                id: 'current',
                nickname: '요리새싹',
                avatar: '#ff7675',
                grade: 'sprout',
                isOnline: true
            };
        }
        
        // 더미 사용자 데이터 로드
        this.dummyUsers = [];
        const dummyUserEls = document.querySelectorAll('#dummyUsers .dummy-user');
        dummyUserEls.forEach(el => {
            this.dummyUsers.push({
                id: el.dataset.id,
                nickname: el.dataset.nickname,
                avatar: el.dataset.avatar,
                grade: el.dataset.grade,
                isOnline: el.dataset.online === 'true'
            });
        });
        
        // 초기 커뮤니티 메시지 로드
        this.communityMessages = [];
        const communityMsgEls = document.querySelectorAll('#initialCommunityMessages .initial-message');
        communityMsgEls.forEach(el => {
            const userId = el.dataset.userId;
            const user = this.dummyUsers.find(u => u.id === userId);
            if (user) {
                this.communityMessages.push({
                    id: el.dataset.id,
                    text: el.dataset.text,
                    user: user,
                    timestamp: new Date(Date.now() - parseInt(el.dataset.timestamp)),
                    isMyMessage: el.dataset.myMessage === 'true'
                });
            }
        });
        
        // 초기 챗봇 메시지 로드
        this.botMessages = [];
        const botMsgEls = document.querySelectorAll('#initialBotMessages .initial-bot-message');
        botMsgEls.forEach(el => {
            this.botMessages.push({
                id: el.dataset.id,
                text: el.dataset.text.replace(/&#10;/g, '\n'), // HTML 엔터 처리
                user: { id: 'bot', nickname: 'CheForest Bot', avatar: '#6366f1', grade: 'forest', isOnline: true },
                timestamp: new Date(Date.now() - parseInt(el.dataset.timestamp)),
                sender: el.dataset.sender
            });
        });
        
        // 랜덤 메시지 풀 로드
        this.randomMessages = [];
        const randomMsgEls = document.querySelectorAll('#randomMessages .random-message');
        randomMsgEls.forEach(el => {
            this.randomMessages.push(el.textContent);
        });
        
        // 온라인 사용자 수 계산
        this.onlineCount = this.dummyUsers.filter(user => user.isOnline).length;
    }
    
    init() {
        this.bindEvents();
        this.renderMessages();
        this.startMessageSimulation();
    }
    
    bindEvents() {
        const communityBtn = document.getElementById('communityBtn');
        const chatbotBtn = document.getElementById('chatbotBtn');
        const closeChatBtn = document.getElementById('closeChatBtn');
        const sendBtn = document.getElementById('sendBtn');
        const messageInput = document.getElementById('messageInput');
        
        communityBtn.addEventListener('click', () => this.handleToggleClick('community'));
        chatbotBtn.addEventListener('click', () => this.handleToggleClick('chatbot'));
        closeChatBtn.addEventListener('click', () => this.toggleChat());
        sendBtn.addEventListener('click', () => this.handleSendMessage());
        
        messageInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                this.handleSendMessage();
            }
        });
        
        messageInput.addEventListener('input', () => {
            const isEmpty = !messageInput.value.trim();
            sendBtn.disabled = isEmpty;
        });
    }
    
    handleToggleClick(mode) {
        if (this.chatMode === mode && this.isOpen) {
            this.toggleChat();
        } else {
            this.setChatMode(mode);
            if (!this.isOpen) {
                this.toggleChat();
            }
        }
    }
    
    setChatMode(mode) {
        this.chatMode = mode;
        this.updateUI();
        this.renderMessages();
        
        // 입력창 포커스
        setTimeout(() => {
            const messageInput = document.getElementById('messageInput');
            if (messageInput && this.isOpen) {
                messageInput.focus();
            }
        }, 300);
    }
    
    toggleChat() {
        this.isOpen = !this.isOpen;
        const chatWindow = document.getElementById('chatWindow');
        const pulseAnimation = document.getElementById('pulseAnimation');
        
        if (this.isOpen) {
            chatWindow.style.display = 'block';
            pulseAnimation.style.display = 'block';
            
            // 스크롤을 맨 아래로
            setTimeout(() => {
                this.scrollToBottom();
                const messageInput = document.getElementById('messageInput');
                if (messageInput) {
                    messageInput.focus();
                }
            }, 100);
        } else {
            chatWindow.style.display = 'none';
            pulseAnimation.style.display = 'none';
        }
    }
    
    updateUI() {
        // 토글 버튼 상태 업데이트
        const communityBtn = document.getElementById('communityBtn');
        const chatbotBtn = document.getElementById('chatbotBtn');
        const slidingBackground = document.getElementById('slidingBackground');
        const statusBadge = document.getElementById('statusBadge');
        const pulseAnimation = document.getElementById('pulseAnimation');
        
        // 버튼 활성화 상태
        communityBtn.classList.toggle('active', this.chatMode === 'community');
        chatbotBtn.classList.toggle('active', this.chatMode === 'chatbot');
        
        // 슬라이딩 배경
        slidingBackground.className = `sliding-background ${this.chatMode}-mode`;
        
        // 상태 배지
        statusBadge.className = `status-badge ${this.chatMode}-mode`;
        statusBadge.textContent = this.chatMode === 'community' ? this.onlineCount : '•';
        
        // 펄스 애니메이션
        pulseAnimation.className = `pulse-animation ${this.chatMode}-mode`;
        
        // 헤더 업데이트
        const chatHeader = document.getElementById('chatHeader');
        const headerIcon = document.getElementById('headerIcon');
        const chatTitle = document.getElementById('chatTitle');
        const statusText = document.getElementById('statusText');
        const sendBtn = document.getElementById('sendBtn');
        const messageInput = document.getElementById('messageInput');
        
        chatHeader.className = `chat-header ${this.chatMode}-mode`;
        sendBtn.className = `send-btn ${this.chatMode}-mode`;
        
        if (this.chatMode === 'community') {
            headerIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>';
            chatTitle.textContent = 'CheForest 커뮤니티';
            statusText.textContent = `${this.onlineCount}명 접속중`;
            messageInput.placeholder = '메시지를 입력하세요...';
        } else {
            headerIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>';
            chatTitle.textContent = 'CheForest 챗봇';
            statusText.textContent = '실시간 도움말';
            messageInput.placeholder = 'AI에게 질문하세요...';
        }
    }
    
    getCurrentMessages() {
        return this.chatMode === 'community' ? this.communityMessages : this.botMessages;
    }
    
    renderMessages() {
        const communityContainer = document.getElementById('communityMessages');
        const chatbotContainer = document.getElementById('chatbotMessages');
        
        if (this.chatMode === 'community') {
            communityContainer.style.display = 'block';
            chatbotContainer.style.display = 'none';
            this.renderMessageContainer(communityContainer, this.communityMessages);
        } else {
            communityContainer.style.display = 'none';
            chatbotContainer.style.display = 'block';
            this.renderMessageContainer(chatbotContainer, this.botMessages);
        }
        
        setTimeout(() => this.scrollToBottom(), 100);
    }
    
    renderMessageContainer(container, messages) {
        container.innerHTML = '';
        messages.forEach(message => {
            const messageElement = this.createMessageElement(message);
            container.appendChild(messageElement);
        });
    }
    
    createMessageElement(message) {
        const messageDiv = document.createElement('div');
        messageDiv.className = `message-item ${message.isMyMessage ? 'my-message' : ''}`;
        
        const avatar = document.createElement('div');
        avatar.className = `avatar ${message.user.grade}`;
        avatar.style.backgroundColor = message.user.avatar;
        avatar.textContent = message.user.nickname.charAt(0);
        
        const messageContent = document.createElement('div');
        messageContent.className = 'message-content';
        
        const userInfo = document.createElement('div');
        userInfo.className = 'user-info';
        
        if (message.isMyMessage) {
            const userTag = document.createElement('span');
            userTag.className = 'user-tag';
            userTag.textContent = '나';
            userInfo.appendChild(userTag);
        }
        
        const timestamp = document.createElement('span');
        timestamp.className = 'timestamp';
        timestamp.textContent = this.formatTime(message.timestamp);
        userInfo.appendChild(timestamp);
        
        const gradeIcon = document.createElement('span');
        gradeIcon.className = 'grade-icon';
        gradeIcon.textContent = this.gradeIcons[message.user.grade];
        gradeIcon.title = `${message.user.grade} 등급`;
        userInfo.appendChild(gradeIcon);
        
        const username = document.createElement('span');
        username.className = 'username';
        username.textContent = message.user.nickname;
        userInfo.appendChild(username);
        
        const messageBubble = document.createElement('div');
        messageBubble.className = 'message-bubble';
        
        if (message.isMyMessage || message.sender === 'user') {
            messageBubble.classList.add('user-message', `${this.chatMode}-mode`);
        } else if (message.sender === 'bot') {
            messageBubble.classList.add('bot-message');
        } else {
            messageBubble.classList.add('other-message');
        }
        
        messageBubble.textContent = message.text;
        
        messageContent.appendChild(userInfo);
        messageContent.appendChild(messageBubble);
        
        messageDiv.appendChild(avatar);
        messageDiv.appendChild(messageContent);
        
        return messageDiv;
    }
    
    handleSendMessage() {
        const messageInput = document.getElementById('messageInput');
        const messageText = messageInput.value.trim();
        
        if (!messageText) return;
        
        const userMessage = {
            id: `msg_${++this.messageCount}`,
            text: messageText,
            user: this.currentUser,
            timestamp: new Date(),
            isMyMessage: true,
            sender: 'user'
        };
        
        if (this.chatMode === 'community') {
            this.communityMessages.push(userMessage);
            
            // 가끔 다른 사용자가 반응하는 시뮬레이션
            if (Math.random() < 0.3) {
                setTimeout(() => {
                    this.simulateResponse(messageText);
                }, 2000 + Math.random() * 3000);
            }
        } else {
            this.botMessages.push(userMessage);
            
            // 챗봇 응답 시뮬레이션
            setTimeout(() => {
                this.simulateBotResponse(messageText);
            }, 1000 + Math.random() * 2000);
        }
        
        messageInput.value = '';
        document.getElementById('sendBtn').disabled = true;
        this.renderMessages();
    }
    
    simulateResponse(originalMessage) {
        const onlineUsers = this.dummyUsers.filter(user => user.isOnline);
        if (onlineUsers.length === 0) return;
        
        const randomUser = onlineUsers[Math.floor(Math.random() * onlineUsers.length)];
        let response = '';
        
        if (originalMessage.includes('레시피') || originalMessage.includes('요리')) {
            const responses = [
                '좋은 레시피네요! 저도 한번 만들어봐야겠어요 👍',
                '와 정말 맛있어 보여요! 레시피 공유해주실 수 있나요?',
                '저도 비슷한 요리 해봤는데 정말 맛있더라구요!',
                '다음에 꼭 만들어보겠습니다! 감사해요 ✨'
            ];
            response = responses[Math.floor(Math.random() * responses.length)];
        } else if (originalMessage.includes('추천') || originalMessage.includes('도움')) {
            const responses = [
                '저도 궁금했던 건데 좋은 정보네요!',
                '도움이 많이 될 것 같아요 😊',
                '좋은 아이디어입니다!',
                '저도 한번 시도해볼게요!'
            ];
            response = responses[Math.floor(Math.random() * responses.length)];
        } else {
            const responses = [
                '좋은 의견이네요! 👏',
                '동감해요!',
                '저도 그렇게 생각해요 ✨',
                '흥미로운 얘기네요!',
                '공감합니다! 😊'
            ];
            response = responses[Math.floor(Math.random() * responses.length)];
        }
        
        const responseMessage = {
            id: `msg_${++this.messageCount}`,
            text: response,
            user: randomUser,
            timestamp: new Date(),
            isMyMessage: false
        };
        
        this.communityMessages.push(responseMessage);
        if (this.chatMode === 'community') {
            this.renderMessages();
        }
    }
    
    simulateBotResponse(userMessage) {
        this.isTyping = true;
        const typingIndicator = document.getElementById('typingIndicator');
        if (this.chatMode === 'chatbot') {
            typingIndicator.style.display = 'flex';
            this.scrollToBottom();
        }
        
        setTimeout(() => {
            let botResponse = '';
            
            if (userMessage.includes('레시피') || userMessage.includes('요리')) {
                botResponse = '레시피에 관한 질문이시네요! 🍳\n\n• 레시피 작성: 헤더의 "레시피" → "레시피 작성하기"\n• 레시피 검색: 상단 검색창 이용\n• 카테고리별 레시피: 홈페이지 카테고리 메뉴\n\n더 자세한 도움이 필요하시면 Q&A 페이지를 이용해주세요!';
            } else if (userMessage.includes('등급') || userMessage.includes('승급')) {
                botResponse = '등급 시스템에 대해 궁금하시군요! ⭐\n\n등급은 씨앗 → 뿌리 → 새싹 → 나무 → 숲 순서로 승급됩니다.\n\n승급 조건:\n• 작성한 레시피 수\n• 받은 좋아요 수\n• 팔로워 수\n\n등급 안내 페이지에서 자세한 정보를 확인하세요!';
            } else if (userMessage.includes('문제') || userMessage.includes('오류') || userMessage.includes('버그')) {
                botResponse = '문제가 발생하셨나요? 😅\n\n다음 정보를 포함해서 Q&A 게시판에 문의해주세요:\n• 발생한 문제 상황\n• 사용 중인 기기/브라우저\n• 오류 메시지 (있다면)\n\n업무시간 내에 신속히 답변드리겠습니다!';
            } else if (userMessage.includes('안녕') || userMessage.includes('hi') || userMessage.includes('hello')) {
                botResponse = '안녕하세요! 😊\n\nCheForest에 오신 것을 환영합니다!\n언제든 궁금한 점이 있으시면 말씀해주세요. 최선을 다해 도와드리겠습니다! 🌿';
            } else if (userMessage.includes('감사') || userMessage.includes('고마워')) {
                botResponse = '도움이 되었다니 정말 기뻐요! 😊\n\nCheForest에서 맛있는 요리 여정을 즐기시길 바랍니다!\n또 궁금한 점이 있으시면 언제든 말씀해주세요! 🍽️✨';
            } else {
                botResponse = '질문해주셔서 감사합니다! 🤔\n\n더 정확한 답변을 위해 Q&A 게시판을 이용하시거나,\n다음 키워드로 다시 질문해주세요:\n\n• 레시피 관련 질문\n• 등급/승급 문의\n• 기술적 문제\n• 계정 관련 문의\n\n항상 도와드릴 준비가 되어있어요! 💚';
            }
            
            const botMessage = {
                id: `msg_${++this.messageCount}`,
                text: botResponse,
                user: { id: 'bot', nickname: 'CheForest Bot', avatar: '#6366f1', grade: 'forest', isOnline: true },
                timestamp: new Date(),
                sender: 'bot'
            };
            
            this.botMessages.push(botMessage);
            this.isTyping = false;
            typingIndicator.style.display = 'none';
            
            if (this.chatMode === 'chatbot') {
                this.renderMessages();
            }
        }, 1000 + Math.random() * 2000);
    }
    
    simulateNewMessage() {
        if (!this.isOpen || this.chatMode !== 'community') return;
        
        const onlineUsers = this.dummyUsers.filter(user => user.isOnline);
        if (onlineUsers.length === 0 || this.randomMessages.length === 0) return;
        
        const randomUser = onlineUsers[Math.floor(Math.random() * onlineUsers.length)];
        const randomMessage = this.randomMessages[Math.floor(Math.random() * this.randomMessages.length)];
        
        const newMessage = {
            id: `msg_${++this.messageCount}`,
            text: randomMessage,
            user: randomUser,
            timestamp: new Date(),
            isMyMessage: false
        };
        
        this.communityMessages.push(newMessage);
        if (this.chatMode === 'community') {
            this.renderMessages();
        }
    }
    
    startMessageSimulation() {
        setInterval(() => {
            if (this.isOpen && this.chatMode === 'community' && Math.random() < 0.2) {
                this.simulateNewMessage();
            }
        }, 15000);
    }
    
    scrollToBottom() {
        const messagesArea = document.getElementById('messagesArea');
        if (messagesArea) {
            messagesArea.scrollTop = messagesArea.scrollHeight;
        }
    }
    
    formatTime(date) {
        const now = new Date();
        const diffInMinutes = Math.floor((now.getTime() - date.getTime()) / (1000 * 60));
        
        if (diffInMinutes < 1) {
            return '방금 전';
        } else if (diffInMinutes < 60) {
            return `${diffInMinutes}분 전`;
        } else if (diffInMinutes < 1440) {
            return `${Math.floor(diffInMinutes / 60)}시간 전`;
        } else {
            return date.toLocaleDateString('ko-KR', { 
                month: 'short', 
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });
        }
    }
}

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    window.liveChatInstance = new LiveChat();
});