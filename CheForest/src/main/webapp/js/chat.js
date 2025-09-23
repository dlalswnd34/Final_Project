/* CheForest 커뮤니티 채팅 전용 JavaScript */

class CommunityChat {
    constructor() {
        this.isOpen = false;
        this.onlineCount = 4; // JSP에서 실제 값으로 교체
        this.currentUser = {
            nickname: '요리새싹', // JSP에서 실제 사용자 닉네임으로 교체
            grade: 'sprout', // JSP에서 실제 사용자 등급으로 교체
            avatar: '#ec4899', // JSP에서 실제 사용자 아바타 색상으로 교체
            id: 'current' // JSP에서 실제 사용자 ID로 교체
        };

        this.init();
    }

    init() {
        this.bindEvents();
        this.updateOnlineCount();
        this.updateSendButton();

        // 실시간 메시지 시뮬레이션 (개발용)
        this.startMessageSimulation();
    }

    bindEvents() {
        // 플로팅 버튼 클릭
        const floatingBtn = document.getElementById('chatFloatingBtn');
        if (floatingBtn) {
            floatingBtn.addEventListener('click', () => this.openChat());
        }

        // 채팅창 닫기
        const closeChatBtn = document.getElementById('closeChatBtn');
        if (closeChatBtn) {
            closeChatBtn.addEventListener('click', () => this.closeChat());
        }

        // 메시지 전송
        const sendBtn = document.getElementById('sendBtn');
        const messageInput = document.getElementById('messageInput');

        if (sendBtn) {
            sendBtn.addEventListener('click', () => this.sendMessage());
        }

        if (messageInput) {
            messageInput.addEventListener('keypress', (e) => {
                if (e.key === 'Enter' && !e.shiftKey) {
                    e.preventDefault();
                    this.sendMessage();
                }
            });

            messageInput.addEventListener('input', () => {
                this.updateSendButton();
            });
        }
    }

    openChat() {
        const floatingBtn = document.getElementById('chatFloatingBtn');
        const chatWindow = document.getElementById('chatWindow');

        if (chatWindow) {
            chatWindow.classList.remove('hidden');
        }

        this.isOpen = true;

        // 입력창 포커스
        setTimeout(() => {
            const messageInput = document.getElementById('messageInput');
            if (messageInput) {
                messageInput.focus();
            }
        }, 300);

        this.scrollToBottom();
    }

    closeChat() {
        const chatWindow = document.getElementById('chatWindow');
        if (chatWindow) {
            chatWindow.classList.add('hidden');
        }

        this.isOpen = false;
    }

    sendMessage() {
        const messageInput = document.getElementById('messageInput');
        if (!messageInput || !messageInput.value.trim()) return;

        const messageText = messageInput.value.trim();

        // 내 메시지 추가
        this.addMessage({
            text: messageText,
            isMyMessage: true,
            timestamp: new Date(),
            user: this.currentUser
        });

        // 입력창 초기화
        messageInput.value = '';
        this.updateSendButton();

        // 가끔 다른 사용자가 반응하는 시뮬레이션 (30% 확률)
        if (Math.random() < 0.3) {
            setTimeout(() => {
                this.simulateUserResponse(messageText);
            }, 2000 + Math.random() * 3000);
        }

        // 실제 구현에서는 여기서 서버로 메시지 전송
        // this.sendMessageToServer(messageText);
    }

    addMessage(messageData) {
        const messagesContainer = document.getElementById('messagesContainer');
        if (!messagesContainer) return;

        const messageElement = this.createMessageElement(messageData);

        // messagesEnd 앞에 삽입
        const messagesEnd = document.getElementById('messagesEnd');
        if (messagesEnd) {
            messagesContainer.insertBefore(messageElement, messagesEnd);
        } else {
            messagesContainer.appendChild(messageElement);
        }

        this.scrollToBottom();
    }

    createMessageElement(messageData) {
        const messageDiv = document.createElement('div');
        messageDiv.className = `message-item ${messageData.isMyMessage ? 'my-message' : ''}`;

        const gradeIcon = this.getGradeIcon(messageData.user.grade);
        const timeAgo = this.formatTimeAgo(messageData.timestamp);

        messageDiv.innerHTML = `
            <div class="message-avatar" ${!messageData.isMyMessage ? `style="background-color: ${messageData.user.avatar}"` : ''}>
                ${messageData.user.nickname.charAt(0)}
            </div>
            <div class="message-content">
                <div class="message-header">
                    ${messageData.isMyMessage ? '<span class="my-badge">나</span>' : ''}
                    <span class="message-time">${timeAgo}</span>
                    <span class="user-grade">${gradeIcon}</span>
                    <span class="user-nickname">${messageData.user.nickname}</span>
                </div>
                <div class="message-bubble ${messageData.isMyMessage ? 'my-bubble' : ''}">
                    <p>${messageData.text}</p>
                </div>
            </div>
        `;

        return messageDiv;
    }

    simulateUserResponse(originalMessage) {
        const dummyUsers = [
            { id: '1', nickname: '요리왕김치찌개', avatar: '#ff6b6b', grade: 'forest' },
            { id: '2', nickname: '파스타마스터', avatar: '#4ecdc4', grade: 'tree' },
            { id: '3', nickname: '디저트요정', avatar: '#45b7d1', grade: 'sprout' },
            { id: '4', nickname: '한식러버', avatar: '#96ceb4', grade: 'root' },
            { id: '5', nickname: '베이킹초보', avatar: '#feca57', grade: 'seed' }
        ];

        const randomUser = dummyUsers[Math.floor(Math.random() * dummyUsers.length)];
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

        this.addMessage({
            text: response,
            isMyMessage: false,
            timestamp: new Date(),
            user: randomUser
        });
    }

    startMessageSimulation() {
        // 채팅이 열려있고 20% 확률로 새 메시지 생성 (15초마다)
        setInterval(() => {
            if (this.isOpen && Math.random() < 0.2) {
                this.simulateNewMessage();
            }
        }, 15000);
    }

    simulateNewMessage() {
        const dummyUsers = [
            { id: '1', nickname: '요리왕김치찌개', avatar: '#ff6b6b', grade: 'forest' },
            { id: '2', nickname: '파스타마스터', avatar: '#4ecdc4', grade: 'tree' },
            { id: '3', nickname: '디저트요정', avatar: '#45b7d1', grade: 'sprout' },
            { id: '4', nickname: '한식러버', avatar: '#96ceb4', grade: 'root' },
            { id: '5', nickname: '베이킹초보', avatar: '#feca57', grade: 'seed' }
        ];

        const randomUser = dummyUsers[Math.floor(Math.random() * dummyUsers.length)];
        const randomMessages = [
            '방금 김치볶음밥 만들어 먹었는데 정말 맛있어요! 🍚',
            '오늘 새로운 레시피 도전해봤어요 ✨',
            '누구 디저트 레시피 추천해주실 분 있나요?',
            '요즘 제철 식재료로 뭐 만드시나요?',
            '채식 요리에 관심이 생겼는데 추천 레시피 있을까요? 🥗',
            '간단한 도시락 반찬 아이디어 부탁드려요!',
            '와... 방금 만든 케이크가 대박이에요! 🎂',
            '초보도 쉽게 만들 수 있는 국물 요리 있나요?',
            '오늘 장 봐온 재료로 뭘 만들지 고민되네요',
            '집에서 만든 빵 냄새가 너무 좋아요 🍞'
        ];

        const randomMessage = randomMessages[Math.floor(Math.random() * randomMessages.length)];

        this.addMessage({
            text: randomMessage,
            isMyMessage: false,
            timestamp: new Date(),
            user: randomUser
        });
    }

    updateSendButton() {
        const messageInput = document.getElementById('messageInput');
        const sendBtn = document.getElementById('sendBtn');

        if (messageInput && sendBtn) {
            const hasText = messageInput.value.trim().length > 0;
            sendBtn.disabled = !hasText;
        }
    }

    updateOnlineCount() {
        const onlineCountElement = document.getElementById('onlineCount');
        const headerOnlineCount = document.getElementById('headerOnlineCount');

        if (onlineCountElement) {
            onlineCountElement.textContent = this.onlineCount;
        }

        if (headerOnlineCount) {
            headerOnlineCount.textContent = `${this.onlineCount}명 접속중`;
        }
    }

    scrollToBottom() {
        setTimeout(() => {
            const messagesEnd = document.getElementById('messagesEnd');
            if (messagesEnd) {
                messagesEnd.scrollIntoView({ behavior: 'smooth' });
            }
        }, 100);
    }

    getGradeIcon(grade) {
        const gradeIcons = {
            seed: '🌱',
            root: '🌿',
            sprout: '🌱',
            tree: '🌳',
            forest: '🌲'
        };
        return gradeIcons[grade] || '🌱';
    }

    formatTimeAgo(date) {
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

    // 서버 통신 메서드 (JSP에서 구현)
    sendMessageToServer(messageText) {
        fetch('/api/community-chat/send', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                message: messageText,
                timestamp: new Date().toISOString(),
                userId: this.currentUser.id
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log('메시지 전송 완료');
                }
            })
            .catch(error => {
                console.error('메시지 전송 실패:', error);
            });
    }

    // 실시간 메시지 수신 (WebSocket)
    initWebSocket() {
        if (typeof WebSocket === 'undefined') return;

        this.websocket = new WebSocket('ws://localhost:8080/community-chat');

        this.websocket.onopen = () => {
            console.log('커뮤니티 채팅 WebSocket 연결됨');
        };

        this.websocket.onmessage = (event) => {
            const messageData = JSON.parse(event.data);
            if (messageData.userId !== this.currentUser.id) {
                this.addMessage(messageData);
            }
        };

        this.websocket.onclose = () => {
            console.log('커뮤니티 채팅 WebSocket 연결 종료');
        };
    }
}

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    // 커뮤니티 채팅 컨테이너가 있는 경우에만 초기화
    if (document.querySelector('.community-chat-container')) {
        window.communityChat = new CommunityChat();

        // Lucide 아이콘 초기화 (있는 경우)
        if (window.lucide) {
            window.lucide.createIcons();
        }
    }
});