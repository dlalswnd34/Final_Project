// CheForest 관리자 - 모든 탭 완전 구현 JavaScript

// 전역 변수
let currentTab = 'dashboard';
let currentUserTab = 'all';
let currentRecipeTab = 'recipes';
let currentPostTab = 'posts';
let currentSettingsTab = 'site';

// 차트 인스턴스
let memberStatusChart = null;
let monthlyActivityChart = null;

// 샘플 데이터
const sampleUsers = [
    {
        id: 1,
        name: '요리왕김셰프',
        email: 'cookingking@email.com',
        avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=40&h=40&fit=crop&crop=face',
        joinDate: '2024-01-15',
        lastLogin: '2024-12-18T10:30:00',
        grade: '숲',
        status: 'active',
        posts: 156,
        comments: 432,
        isOnline: true
    },
    {
        id: 2,
        name: '파스타러버',
        email: 'pastalover@email.com',
        avatar: 'https://images.unsplash.com/photo-1494790108755-2616b667c825?w=40&h=40&fit=crop&crop=face',
        joinDate: '2024-02-20',
        lastLogin: '2024-12-18T09:15:00',
        grade: '나무',
        status: 'active',
        posts: 89,
        comments: 234,
        isOnline: true
    },
    {
        id: 3,
        name: '매운맛조아',
        email: 'spicyfood@email.com',
        joinDate: '2024-03-10',
        lastLogin: '2024-12-17T18:45:00',
        grade: '새싹',
        status: 'suspended',
        posts: 34,
        comments: 67,
        isOnline: false
    },
    {
        id: 4,
        name: '디저트퀸',
        email: 'dessertqueen@email.com',
        avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=40&h=40&fit=crop&crop=face',
        joinDate: '2024-04-05',
        lastLogin: '2024-12-18T11:20:00',
        grade: '나무',
        status: 'active',
        posts: 127,
        comments: 345,
        isOnline: true
    },
    {
        id: 5,
        name: '라멘마스터',
        email: 'ramenmaster@email.com',
        joinDate: '2024-05-12',
        lastLogin: '2024-12-16T14:30:00',
        grade: '뿌리',
        status: 'inactive',
        posts: 23,
        comments: 45,
        isOnline: false
    },
    {
        id: 6,
        name: '홈쿠킹러버',
        email: 'homecooking@email.com',
        avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=40&h=40&fit=crop&crop=face',
        joinDate: '2024-06-18',
        lastLogin: '2024-12-18T08:45:00',
        grade: '새싹',
        status: 'active',
        posts: 45,
        comments: 89,
        isOnline: false
    },
    {
        id: 7,
        name: '건강요리사',
        email: 'healthy@email.com',
        joinDate: '2024-07-22',
        lastLogin: '2024-12-15T16:20:00',
        grade: '씨앗',
        status: 'banned',
        posts: 8,
        comments: 12,
        isOnline: false
    },
    {
        id: 8,
        name: '전통음식지킴이',
        email: 'traditional@email.com',
        avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=40&h=40&fit=crop&crop=face',
        joinDate: '2024-08-14',
        lastLogin: '2024-12-18T12:10:00',
        grade: '나무',
        status: 'active',
        posts: 67,
        comments: 156,
        isOnline: true
    },
    {
        id: 9,
        name: '베이킹초보',
        email: 'bakingbeginner@email.com',
        joinDate: '2024-09-30',
        lastLogin: '2024-12-17T20:30:00',
        grade: '뿌리',
        status: 'active',
        posts: 12,
        comments: 34,
        isOnline: false
    },
    {
        id: 10,
        name: '세계요리탐험가',
        email: 'worldfood@email.com',
        avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=40&h=40&fit=crop&crop=face',
        joinDate: '2024-10-08',
        lastLogin: '2024-12-18T13:45:00',
        grade: '새싹',
        status: 'active',
        posts: 29,
        comments: 67,
        isOnline: true
    }
];

const sampleRecipes = [
    {
        id: 1,
        title: '김치찌개',
        author: '요리왕김셰프',
        category: '한식',
        image: 'https://images.unsplash.com/photo-1498654896293-37aacf113fd9?w=300&h=200&fit=crop',
        cookingTime: 30,
        difficulty: '쉬움',
        servings: 4,
        views: 1524,
        likes: 89,
        comments: 23,
        status: 'published',
        createdAt: '2024-12-15T10:30:00',
        featured: true,
        tags: ['김치', '찌개', '한식', '간단요리']
    },
    {
        id: 2,
        title: '까르보나라',
        author: '파스타러버',
        category: '양식',
        image: 'https://images.unsplash.com/photo-1621996346565-e3dbc353d2e5?w=300&h=200&fit=crop',
        cookingTime: 25,
        difficulty: '보통',
        servings: 2,
        views: 2156,
        likes: 156,
        comments: 34,
        status: 'published',
        createdAt: '2024-12-14T15:20:00',
        featured: false,
        tags: ['파스타', '까르보나라', '양식', '크림']
    },
    {
        id: 3,
        title: '마파두부',
        author: '매운맛조아',
        category: '중식',
        image: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=300&h=200&fit=crop',
        cookingTime: 20,
        difficulty: '보통',
        servings: 3,
        views: 892,
        likes: 67,
        comments: 12,
        status: 'private',
        createdAt: '2024-12-13T09:45:00',
        tags: ['두부', '마파', '중식', '매운맛']
    },
    {
        id: 4,
        title: '치즈케이크',
        author: '디저트퀸',
        category: '디저트',
        image: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=300&h=200&fit=crop',
        cookingTime: 45,
        difficulty: '어려움',
        servings: 8,
        views: 3421,
        likes: 234,
        comments: 45,
        status: 'published',
        createdAt: '2024-12-12T14:10:00',
        featured: true,
        tags: ['치즈케이크', '디저트', '노오븐', '베이킹']
    },
    {
        id: 5,
        title: '라멘',
        author: '라멘마스터',
        category: '일식',
        image: 'https://images.unsplash.com/photo-1557872943-16a5ac26437e?w=300&h=200&fit=crop',
        cookingTime: 120,
        difficulty: '어려움',
        servings: 2,
        views: 756,
        likes: 43,
        comments: 8,
        status: 'draft',
        createdAt: '2024-12-11T11:30:00',
        tags: ['라멘', '일식', '국물', '면요리']
    }
];

const samplePosts = [
    {
        id: 1,
        title: '우리집 비빔밥 레시피',
        content: '엄마가 해주시던 정성 가득한 비빔밥, 나물 하나하나 정성스럽게 무쳐보세요!',
        author: '홈쿡마미',
        authorLevel: '나무',
        category: '한식',
        image: 'https://images.unsplash.com/photo-1718777791262-c66d11baaa3b?w=300&h=200&fit=crop',
        views: 8234,
        likes: 456,
        comments: 89,
        status: 'published',
        createdAt: '2024-12-15T14:30:00',
        isPinned: true,
        isHot: true,
        tags: ['비빔밥', '나물', '집밥', '건강식'],
        cookTime: '40분',
        difficulty: '보통',
        serves: '4인분'
    },
    {
        id: 2,
        title: '매콤한 김치 볶음밥',
        content: '김치가 시어질 때 만드는 최고의 요리! 스팸과 함께 볶으면 더욱 맛있어요',
        author: '김치러버',
        authorLevel: '새싹',
        category: '한식',
        image: 'https://images.unsplash.com/photo-1708388466726-54ff913ad930?w=300&h=200&fit=crop',
        views: 5432,
        likes: 298,
        comments: 67,
        status: 'published',
        createdAt: '2024-12-12T18:45:00',
        isHot: true,
        tags: ['김치볶음밥', '간편요리', '집밥'],
        cookTime: '15분',
        difficulty: '쉬움',
        serves: '2인분'
    },
    {
        id: 3,
        title: '집에서 만드는 라멘',
        content: '진한 돈코츠 육수부터 토핑까지, 집에서도 맛집 라멘을 만들 수 있어요!',
        author: '라멘마니아',
        authorLevel: '나무',
        category: '일식',
        image: 'https://images.unsplash.com/photo-1637024698421-533d83c7b883?w=300&h=200&fit=crop',
        views: 12456,
        likes: 789,
        comments: 156,
        status: 'published',
        createdAt: '2024-12-10T20:15:00',
        tags: ['라멘', '일식', '육수', '면요리'],
        cookTime: '2시간',
        difficulty: '어려움',
        serves: '2인분'
    },
    {
        id: 4,
        title: '이상한 요리 실험...',
        content: '아무거나 섞어서 만든 요리인데 맛있을까요? 잘 모르겠어요 ㅋㅋ',
        author: '요리초보99',
        authorLevel: '씨앗',
        category: '양식',
        image: 'https://images.unsplash.com/photo-1596458397260-255807e979f1?w=300&h=200&fit=crop',
        views: 234,
        likes: 12,
        comments: 45,
        status: 'reported',
        createdAt: '2024-12-08T16:20:00',
        reports: 8,
        tags: ['실험', '양식', '초보'],
        cookTime: '30분',
        difficulty: '보통',
        serves: '1인분'
    },
    {
        id: 5,
        title: '중국식 볶음밥 레시피',
        content: '중국집에서 먹던 그 맛! 웍헤이가 살아있는 볶음밥 만드는 비법',
        author: '중화요리사',
        authorLevel: '뿌리',
        category: '중식',
        image: 'https://images.unsplash.com/photo-1723691802798-fa6efc67b2c9?w=300&h=200&fit=crop',
        views: 6789,
        likes: 387,
        comments: 92,
        status: 'published',
        createdAt: '2024-12-05T12:10:00',
        tags: ['볶음밥', '중식', '웍헤이', '간편요리'],
        cookTime: '20분',
        difficulty: '쉬움',
        serves: '2인분'
    },
    {
        id: 6,
        title: '촉촉한 홈베이킹 케이크',
        content: '베이킹 초보도 실패 없이! 버터크림과 딸기로 예쁘게 데코레이션해보세요',
        author: '베이킹러버',
        authorLevel: '씨앗',
        category: '디저트',
        image: 'https://images.unsplash.com/photo-1613323885553-4b069992362d?w=300&h=200&fit=crop',
        views: 4321,
        likes: 234,
        comments: 45,
        status: 'private',
        createdAt: '2024-12-03T14:45:00',
        tags: ['케이크', '베이킹', '디저트', '홈베이킹'],
        cookTime: '1시간',
        difficulty: '보통',
        serves: '8인분'
    }
];

const sampleEvents = [
    {
        id: 1,
        title: "2025 CheForest 레시피 공모전",
        description: "창의적이고 건강한 레시피로 도전하세요! 우승자에게는 100만원 상금과 CheForest 명예의 전당에 이름이 등록됩니다.",
        image: "https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=300&h=200&fit=crop",
        startDate: "2025-04-22",
        endDate: "2025-10-21",
        time: "24시간 접수",
        location: "온라인",
        participants: 1247,
        maxParticipants: 5000,
        prize: "총 상금 300만원",
        status: "active",
        category: "공모전",
        tags: ["레시피", "공모전", "상금"],
        createdAt: "2024-12-01T10:00:00",
        views: 15420,
        applications: 1247,
        isPromoted: true,
        budget: 3000000
    },
    {
        id: 2,
        title: "나랑 어울리는 요리 스타일 테스트",
        description: "나와 어울리는 요리를 찾아보세요! 간단한 질문으로 당신만의 요리 스타일을 발견해보세요",
        image: "https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=300&h=200&fit=crop",
        startDate: "2024-12-01",
        endDate: "2025-12-31",
        time: "언제든지",
        location: "온라인",
        participants: 3456,
        prize: "개인 맞춤 레시피 추천",
        status: "active",
        category: "테스트",
        tags: ["성향테스트", "맞춤추천", "재미"],
        createdAt: "2024-11-15T09:00:00",
        views: 8930,
        applications: 3456,
        budget: 0
    },
    {
        id: 3,
        title: "한식 마스터 챌린지",
        description: "전통 한식부터 퓨전 한식까지! 한 달간 매주 새로운 한식 요리에 도전하고 포인트를 모아보세요.",
        image: "https://images.unsplash.com/photo-1570197788417-0e82375c9371?w=300&h=200&fit=crop",
        startDate: "2025-02-01",
        endDate: "2025-02-28",
        time: "매주 월요일 챌린지 공개",
        location: "온라인",
        participants: 456,
        maxParticipants: 1000,
        prize: "우승자 한식 마스터 인증서",
        status: "draft",
        category: "이벤트",
        tags: ["한식", "챌린지", "월간이벤트"],
        createdAt: "2024-12-08T13:45:00",
        views: 1230,
        applications: 0,
        budget: 200000
    },
    {
        id: 4,
        title: "2024 CheForest 레시피 공모전",
        description: "2024년의 마지막을 장식한 성공적인 레시피 공모전! 총 892명이 참가하여 다양하고 창의적인 레시피를 선보였습니다.",
        image: "https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=300&h=200&fit=crop",
        startDate: "2024-09-01",
        endDate: "2024-11-30",
        time: "3개월간 진행",
        location: "온라인",
        participants: 892,
        maxParticipants: 1000,
        prize: "총 상금 250만원",
        status: "ended",
        category: "공모전",
        tags: ["레시피", "공모전", "2024년", "완료"],
        createdAt: "2024-08-15T10:00:00",
        views: 12850,
        applications: 892,
        budget: 2500000
    }
];

const sampleInquiries = [
    {
        id: 1,
        name: "김요리",
        email: "kimyori@example.com",
        subject: "레시피 업로드 시 사진이 업로드되지 않아요",
        message: "안녕하세요. 레시피를 작성하다가 사진 업로드가 안 되는 문제가 발생했습니다. 크롬 브라우저를 사용하고 있고, 사진 파일 크기는 2MB 정도입니다. 다른 브라우저에서도 같은 문제가 발생해요. 도움 부탁드립니다.",
        category: "technical",
        status: "pending",
        submittedAt: "2024-12-18T14:30:00",
        lastUpdated: "2024-12-18T14:30:00",
        userId: "user123"
    },
    {
        id: 2,
        name: "박셰프",
        email: "parkchef@example.com",
        subject: "등급이 올라가지 않아요",
        message: "안녕하세요! 레시피를 20개 넘게 올렸는데도 여전히 씨앗 등급에 머물러 있어요. 등급 안내 페이지를 봐도 조건을 충족한 것 같은데 왜 승급이 안 되는지 궁금합니다. 확인 부탁드려요.",
        category: "grade",
        status: "answered",
        submittedAt: "2024-12-17T09:15:00",
        lastUpdated: "2024-12-18T10:45:00",
        answeredAt: "2024-12-18T10:45:00",
        answer: "안녕하세요 박셰프님! 문의해주신 등급 승급 건에 대해 확인해드렸습니다. 등급 승급은 레시피 수 외에도 받은 좋아요 수와 팔로워 수가 함께 고려됩니다. 현재 박셰프님의 계정을 확인해보니 레시피 수는 충족하셨지만, 좋아요 수가 조금 부족한 상황입니다. 뿌리 등급으로 승급하시려면 총 좋아요 50개가 필요한데, 현재 38개를 받으셨네요. 조금만 더 활동하시면 곧 승급하실 수 있을 것 같습니다! 감사합니다.",
        answeredBy: "관리자"
    },
    {
        id: 3,
        name: "이쿠킹",
        email: "icooking@example.com",
        subject: "비밀번호 재설정이 안 돼요",
        message: "로그인 페이지에서 비밀번호 찾기를 눌렀는데 이메일이 오지 않아요. 스팸함도 확인했는데 없습니다. 가입할 때 사용한 이메일이 맞는데 왜 안 오는지 모르겠어요.",
        category: "account",
        status: "pending",
        submittedAt: "2024-12-18T11:20:00",
        lastUpdated: "2024-12-18T13:15:00",
        userId: "user456"
    },
    {
        id: 4,
        name: "최맛집",
        email: "choimatjip@example.com",
        subject: "레시피 공모전 상금 문의",
        message: "2024 CheForest 레시피 공모전에서 3등을 수상했는데 상금 지급 일정이 언제인지 궁금합니다. 계좌번호는 이미 제출했고, 세금계산서도 필요하면 발급 가능합니다.",
        category: "payment",
        status: "answered",
        submittedAt: "2024-12-16T16:45:00",
        lastUpdated: "2024-12-17T14:20:00",
        answeredAt: "2024-12-17T14:20:00",
        answer: "축하드립니다 최맛집님! 2024 레시피 공모전 3등 수상을 진심으로 축하드려요! 상금은 결과 발표 후 영업일 기준 7일 이내에 지급됩니다. 제출해주신 계좌로 12월 20일(금)에 입금 예정이며, 세금계산서는 별도로 이메일로 발송해드리겠습니다. 앞으로도 CheForest에서 멋진 레시피 많이 공유해주세요!",
        answeredBy: "관리자"
    },
    {
        id: 5,
        name: "신규가입",
        email: "newuser@example.com",
        subject: "앱 사용법 문의",
        message: "처음 가입했는데 앱 사용법을 잘 모르겠어요. 레시피 검색은 어떻게 하고, 좋아요는 어떻게 누르나요? 초보자를 위한 가이드가 있으면 좋겠어요.",
        category: "other",
        status: "pending",
        submittedAt: "2024-12-18T15:45:00",
        lastUpdated: "2024-12-18T15:45:00",
        userId: "user789"
    },
    {
        id: 6,
        name: "개발자꿈나무",
        email: "developer@example.com",
        subject: "API 연동 문의",
        message: "개인 프로젝트에서 CheForest의 레시피 데이터를 활용하고 싶은데, 공개 API나 데이터 제공 정책이 있는지 궁금합니다. 비상업적 용도로만 사용할 예정입니다.",
        category: "suggestion",
        status: "answered",
        submittedAt: "2024-12-14T13:20:00",
        lastUpdated: "2024-12-15T11:30:00",
        answeredAt: "2024-12-15T11:30:00",
        answer: "개발자꿈나무님, 관심 가져주셔서 감사합니다! 현재 공개 API는 제공하지 않고 있지만, 개발자를 위한 파트너십 프로그램을 검토하고 있습니다. 비상업적 용도의 경우 별도 협의가 가능할 수 있으니, partnership@cheforest.com으로 자세한 프로젝트 계획서를 보내주시면 검토 후 답변드리겠습니다.",
        answeredBy: "관리자"
    },
    {
        id: 7,
        name: "요리초보",
        email: "cooking-beginner@example.com",
        subject: "레시피 즐겨찾기 기능 제안",
        message: "안녕하세요! CheForest를 정말 유용하게 사용하고 있어요. 한 가지 제안이 있는데, 마음에 드는 레시피를 즐겨찾기나 북마크할 수 있는 기능이 있으면 좋겠어요. 나중에 다시 찾기 편할 것 같아서요.",
        category: "suggestion",
        status: "pending",
        submittedAt: "2024-12-18T12:10:00",
        lastUpdated: "2024-12-18T12:10:00",
        userId: "user101"
    },
    {
        id: 8,
        name: "한국인",
        email: "hangukin@example.com",
        subject: "부적절한 레시피 신고",
        message: "사용자 'baduser123'이 올린 레시피가 음란하고 부적절한 내용을 포함하고 있습니다. 요리와 전혀 관련 없는 내용이고 다른 사용자들이 불쾌감을 느낄 수 있을 것 같아 신고합니다.",
        category: "report",
        status: "answered",
        submittedAt: "2024-12-15T20:30:00",
        lastUpdated: "2024-12-16T09:15:00",
        answeredAt: "2024-12-16T09:15:00",
        answer: "신고해주신 내용을 확인하여 해당 레시피를 즉시 삭제 조치했습니다. 해당 사용자에게는 경고 조치를 취했으며, 재발 시 계정 정지 처리될 예정입니다. 건전한 커뮤니티 환경 조성에 도움 주셔서 감사합니다.",
        answeredBy: "관리자"
    }
];

// AdminAllTabs 메인 객체
const AdminAllTabs = {
    // 초기화
    initialize() {
        this.updateCurrentTime();
        setInterval(() => this.updateCurrentTime(), 60000);
        
        this.setupNavigation();
        this.initializeCharts();
        this.setupTabEvents();
        this.renderCurrentTab();
    },

    // 현재 시간 업데이트
    updateCurrentTime() {
        const now = new Date();
        const timeElement = document.getElementById('current-time');
        
        if (timeElement) {
            const options = {
                year: 'numeric',
                month: 'long',
                day: 'numeric',
                weekday: 'long'
            };
            timeElement.textContent = now.toLocaleDateString('ko-KR', options);
        }
    },

    // 네비게이션 설정
    setupNavigation() {
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const tabName = link.getAttribute('data-tab');
                if (tabName) {
                    this.switchTab(tabName);
                }
            });
        });
    },

    // 탭 이벤트 설정
    setupTabEvents() {
        // 회원 탭 이벤트
        document.addEventListener('click', (e) => {
            if (e.target.matches('[data-user-tab]')) {
                const tabName = e.target.getAttribute('data-user-tab');
                this.switchUserTab(tabName);
            }

            if (e.target.matches('[data-recipe-tab]')) {
                const tabName = e.target.getAttribute('data-recipe-tab');
                this.switchRecipeTab(tabName);
            }

            if (e.target.matches('[data-post-tab]')) {
                const tabName = e.target.getAttribute('data-post-tab');
                this.switchPostTab(tabName);
            }

            if (e.target.matches('[data-settings-tab]')) {
                const tabName = e.target.getAttribute('data-settings-tab');
                this.switchSettingsTab(tabName);
            }
        });
    },

    // 메인 탭 전환
    switchTab(tabName) {
        currentTab = tabName;
        
        // 모든 탭 콘텐츠 숨기기
        document.querySelectorAll('.tab-content').forEach(content => {
            content.classList.remove('active');
        });
        
        // 선택된 탭 콘텐츠 보이기
        const targetTab = document.getElementById(`${tabName}-tab`);
        if (targetTab) {
            targetTab.classList.add('active');
        }
        
        // 네비게이션 활성 상태 업데이트
        document.querySelectorAll('.nav-link').forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('data-tab') === tabName) {
                link.classList.add('active');
            }
        });
        
        // 페이지 제목 업데이트
        this.updatePageTitle(tabName);
        
        // 탭별 콘텐츠 렌더링
        this.renderCurrentTab();
    },

    // 페이지 제목 업데이트
    updatePageTitle(tabName) {
        const pageTitle = document.querySelector('.page-title');
        const titleMap = {
            'dashboard': '대시보드',
            'users': '회원 관리',
            'recipes': '레시피 관리',
            'posts': '게시글 관리',
            'events': '이벤트 관리',
            'inquiries': '문의사항',
            'settings': '설정'
        };
        
        if (pageTitle && titleMap[tabName]) {
            pageTitle.textContent = titleMap[tabName];
        }
    },

    // 현재 탭 렌더링
    renderCurrentTab() {
        switch(currentTab) {
            case 'users':
                this.renderUsersManagement();
                break;
            case 'recipes':
                this.renderRecipesManagement();
                break;
            case 'posts':
                this.renderPostsManagement();
                break;
            case 'events':
                this.renderEventsManagement();
                break;
            case 'inquiries':
                this.renderInquiriesManagement();
                break;
            case 'settings':
                this.renderSettingsManagement();
                break;
        }
    },

    // 차트 초기화
    initializeCharts() {
        this.initializeMemberStatusChart();
        this.initializeMonthlyActivityChart();
    },

    // 회원 상태 분포 차트
    initializeMemberStatusChart() {
        const ctx = document.getElementById('memberStatusChart');
        if (!ctx) return;
        
        const data = {
            labels: ['활동계정', '휴면계정', '제재계정'],
            datasets: [{
                data: [856, 334, 57],
                backgroundColor: ['#f97316', '#fb923c', '#ec4899'],
                borderWidth: 0,
                cutout: '70%'
            }]
        };
        
        const config = {
            type: 'doughnut',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        borderColor: 'rgba(255, 255, 255, 0.1)',
                        borderWidth: 1,
                        cornerRadius: 8
                    }
                },
                elements: {
                    arc: {
                        borderWidth: 0
                    }
                }
            }
        };
        
        memberStatusChart = new Chart(ctx, config);
    },

    // 월별 활동 현황 차트
    initializeMonthlyActivityChart() {
        const ctx = document.getElementById('monthlyActivityChart');
        if (!ctx) return;
        
        const data = {
            labels: ['1월', '2월', '3월', '4월', '5월'],
            datasets: [
                {
                    label: '게시글',
                    data: [280, 320, 290, 350, 320],
                    backgroundColor: '#f97316',
                    borderRadius: 6,
                    maxBarThickness: 40
                },
                {
                    label: '가입자수',
                    data: [120, 135, 128, 140, 138],
                    backgroundColor: '#ec4899',
                    borderRadius: 6,
                    maxBarThickness: 40
                }
            ]
        };
        
        const config = {
            type: 'bar',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        borderColor: 'rgba(255, 255, 255, 0.1)',
                        borderWidth: 1,
                        cornerRadius: 8
                    }
                },
                scales: {
                    x: {
                        grid: {
                            display: false
                        },
                        border: {
                            display: false
                        },
                        ticks: {
                            color: '#64748b',
                            font: {
                                size: 12,
                                family: 'Gowun Dodum'
                            }
                        }
                    },
                    y: {
                        beginAtZero: true,
                        max: 400,
                        grid: {
                            color: '#f1f5f9'
                        },
                        border: {
                            display: false
                        },
                        ticks: {
                            color: '#64748b',
                            font: {
                                size: 12,
                                family: 'Gowun Dodum'
                            },
                            stepSize: 100
                        }
                    }
                }
            }
        };
        
        monthlyActivityChart = new Chart(ctx, config);
    },

    // 회원 관리 렌더링
    renderUsersManagement() {
        const container = document.getElementById('user-management-content');
        if (!container) return;

        container.innerHTML = `
            <section class="management-section">
                <div class="management-card">
                    <div class="management-header">
                        <div class="header-left">
                            <h3 class="management-title">
                                <i data-lucide="users" class="title-icon"></i>
                                회원 관리
                            </h3>
                        </div>
                        <div class="header-controls">
                            <div class="search-box">
                                <i data-lucide="search" class="search-icon"></i>
                                <input type="text" placeholder="회원 이름 또는 이메일 검색..." class="search-input" id="user-search">
                            </div>
                            <select class="filter-select" id="user-sort">
                                <option value="joinDate">가입일순</option>
                                <option value="lastLogin">최근 로그인</option>
                                <option value="name">이름순</option>
                                <option value="posts">게시글순</option>
                            </select>
                            <button class="sort-btn" id="user-sort-order">
                                <i data-lucide="sort-desc" class="btn-icon"></i>
                            </button>
                        </div>
                    </div>

                    <div class="management-tabs">
                        <div class="tab-list">
                            <button class="tab-btn active" data-user-tab="all">
                                <i data-lucide="users" class="tab-icon"></i>
                                <span>전체 회원 (${sampleUsers.length})</span>
                            </button>
                            <button class="tab-btn" data-user-tab="online">
                                <i data-lucide="activity" class="tab-icon"></i>
                                <span>현재 접속 (${sampleUsers.filter(u => u.isOnline).length})</span>
                            </button>
                            <button class="tab-btn" data-user-tab="suspended">
                                <i data-lucide="ban" class="tab-icon"></i>
                                <span>제재 회원 (${sampleUsers.filter(u => u.status === 'suspended' || u.status === 'banned').length})</span>
                            </button>
                        </div>
                    </div>

                    <div class="table-container">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th style="width: 48px;">
                                        <input type="checkbox" id="select-all-users">
                                    </th>
                                    <th>회원 정보</th>
                                    <th>등급/상태</th>
                                    <th>활동</th>
                                    <th>가입일</th>
                                    <th>최근 로그인</th>
                                    <th style="text-align: right;">관리</th>
                                </tr>
                            </thead>
                            <tbody id="users-table-body">
                                ${this.renderUsersTableRows()}
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        `;

        // 아이콘 재생성
        lucide.createIcons();
    },

    // 회원 테이블 행 렌더링
    renderUsersTableRows() {
        return sampleUsers.map(user => `
            <tr>
                <td>
                    <input type="checkbox" data-user-id="${user.id}">
                </td>
                <td>
                    <div class="user-info">
                        <div class="user-avatar">
                            <div class="avatar">
                                ${user.avatar ? `<img src="${user.avatar}" alt="${user.name}">` : user.name.charAt(0)}
                            </div>
                            ${user.isOnline ? '<div class="online-indicator"></div>' : ''}
                        </div>
                        <div class="user-details">
                            <h4>${user.name}${user.isOnline ? '<span class="online-badge">온라인</span>' : ''}</h4>
                            <div class="user-email">
                                <i data-lucide="mail" style="width: 12px; height: 12px;"></i>
                                ${user.email}
                            </div>
                        </div>
                    </div>
                </td>
                <td>
                    <div style="display: flex; flex-direction: column; gap: 4px;">
                        <div class="grade-badge grade-${user.grade}">${user.grade}</div>
                        <div class="status-badge status-${user.status}">
                            <i data-lucide="${this.getStatusIconName(user.status)}" class="status-icon"></i>
                            ${this.getStatusText(user.status)}
                        </div>
                    </div>
                </td>
                <td>
                    <div style="font-size: 12px;">
                        <div style="display: flex; align-items: center; gap: 4px; margin-bottom: 2px;">
                            <i data-lucide="file-text" style="width: 12px; height: 12px; color: #94a3b8;"></i>
                            ${user.posts} 게시글
                        </div>
                        <div style="display: flex; align-items: center; gap: 4px;">
                            <i data-lucide="message-circle" style="width: 12px; height: 12px; color: #94a3b8;"></i>
                            ${user.comments} 댓글
                        </div>
                    </div>
                </td>
                <td>
                    <div style="font-size: 12px; color: #64748b;">
                        ${this.formatDate(user.joinDate)}
                    </div>
                </td>
                <td>
                    <div style="font-size: 12px; color: #64748b;">
                        ${this.formatDate(user.lastLogin)}
                        <div style="font-size: 10px; color: #94a3b8; margin-top: 2px;">
                            ${this.formatTime(user.lastLogin)}
                        </div>
                    </div>
                </td>
                <td style="text-align: right;">
                    <button class="action-btn" onclick="AdminAllTabs.showUserActions(${user.id})">
                        <i data-lucide="more-vertical" style="width: 16px; height: 16px;"></i>
                    </button>
                </td>
            </tr>
        `).join('');
    },

    // 회원 탭 전환
    switchUserTab(tabName) {
        currentUserTab = tabName;
        
        // 탭 버튼 활성화 상태 업데이트
        document.querySelectorAll('[data-user-tab]').forEach(btn => {
            btn.classList.remove('active');
            if (btn.getAttribute('data-user-tab') === tabName) {
                btn.classList.add('active');
            }
        });
        
        // 테이블 다시 렌더링 (필터링 적용)
        this.renderUsersManagement();
    },

    // 레시피 관리 렌더링
    renderRecipesManagement() {
        const recipesGrid = document.getElementById('recipes-grid');
        if (!recipesGrid) return;

        recipesGrid.innerHTML = sampleRecipes.map(recipe => `
            <div class="recipe-card">
                <img src="${recipe.image}" alt="${recipe.title}" class="recipe-image">
                <div class="recipe-body">
                    <div class="recipe-header">
                        <h4 class="recipe-title">${recipe.title}</h4>
                        <button class="action-btn" onclick="AdminAllTabs.showRecipeActions(${recipe.id})">
                            <i data-lucide="more-vertical" style="width: 16px; height: 16px;"></i>
                        </button>
                    </div>
                    <div class="recipe-meta">
                        <span>${recipe.author}</span>
                        <span>•</span>
                        <span>${recipe.category}</span>
                        <span>•</span>
                        <span>${recipe.cookingTime}분</span>
                    </div>
                    <div class="recipe-stats">
                        <div class="stat-item">
                            <i data-lucide="eye" style="width: 12px; height: 12px;"></i>
                            ${recipe.views.toLocaleString()}
                        </div>
                        <div class="stat-item">
                            <i data-lucide="heart" style="width: 12px; height: 12px;"></i>
                            ${recipe.likes}
                        </div>
                        <div class="stat-item">
                            <i data-lucide="message-circle" style="width: 12px; height: 12px;"></i>
                            ${recipe.comments}
                        </div>
                    </div>
                    <div class="recipe-badges">
                        ${recipe.featured ? '<div class="recipe-badge featured">인기</div>' : ''}
                        <div class="recipe-badge category">${recipe.category}</div>
                        <div class="recipe-badge ${this.getStatusClass(recipe.status)}">${this.getStatusText(recipe.status)}</div>
                    </div>
                </div>
            </div>
        `).join('');

        lucide.createIcons();
    },

    // 레시피 탭 전환
    switchRecipeTab(tabName) {
        currentRecipeTab = tabName;
        
        document.querySelectorAll('[data-recipe-tab]').forEach(btn => {
            btn.classList.remove('active');
            if (btn.getAttribute('data-recipe-tab') === tabName) {
                btn.classList.add('active');
            }
        });
        
        this.renderRecipesManagement();
    },

    // 게시글 관리 렌더링
    renderPostsManagement() {
        const postsList = document.getElementById('posts-management-list');
        if (!postsList) return;

        postsList.innerHTML = samplePosts.map(post => `
            <div class="post-management-item">
                <img src="${post.image}" alt="${post.title}" class="post-image">
                <div class="post-details">
                    <h4 class="post-main-title">${post.title}</h4>
                    <p class="post-description">${post.content}</p>
                    <div class="post-badges">
                        ${post.isHot ? '<span class="recipe-badge featured">HOT</span>' : ''}
                        <span class="recipe-badge category">${post.category}</span>
                        <span class="recipe-badge ${this.getStatusClass(post.status)}">${this.getStatusText(post.status)}</span>
                    </div>
                    <div class="post-management-meta">
                        <span>👤 ${post.author}</span>
                        <span>👀 ${post.views.toLocaleString()}</span>
                        <span>❤️ ${post.likes}</span>
                        <span>💬 ${post.comments}</span>
                        <span>📅 ${this.formatDate(post.createdAt)}</span>
                    </div>
                </div>
                <div class="post-management-actions">
                    <button class="event-action-btn" onclick="AdminAllTabs.showNotification('게시글 상세보기', 'info')">
                        <i data-lucide="eye" style="width: 14px; height: 14px;"></i>
                        상세보기
                    </button>
                    <button class="event-action-btn" onclick="AdminAllTabs.showNotification('게시글 편집', 'info')">
                        <i data-lucide="edit-3" style="width: 14px; height: 14px;"></i>
                        편집
                    </button>
                </div>
            </div>
        `).join('');

        lucide.createIcons();
    },

    // 게시글 탭 전환
    switchPostTab(tabName) {
        currentPostTab = tabName;
        
        document.querySelectorAll('[data-post-tab]').forEach(btn => {
            btn.classList.remove('active');
            if (btn.getAttribute('data-post-tab') === tabName) {
                btn.classList.add('active');
            }
        });
        
        this.renderPostsManagement();
    },

    // 이벤트 관리 렌더링
    renderEventsManagement() {
        const eventsGrid = document.getElementById('events-grid');
        if (!eventsGrid) return;

        eventsGrid.innerHTML = sampleEvents.map(event => `
            <div class="event-card">
                <img src="${event.image}" alt="${event.title}" class="event-image">
                <div class="event-body">
                    <div class="event-header">
                        <h4 class="event-title">${event.title}</h4>
                        <div class="recipe-badge ${this.getStatusClass(event.status)}">${this.getStatusText(event.status)}</div>
                    </div>
                    <div class="event-meta">
                        <div class="event-meta-item">
                            <i data-lucide="calendar" class="event-meta-icon"></i>
                            ${this.formatDate(event.startDate)} ~ ${this.formatDate(event.endDate)}
                        </div>
                        <div class="event-meta-item">
                            <i data-lucide="map-pin" class="event-meta-icon"></i>
                            ${event.location}
                        </div>
                        <div class="event-meta-item">
                            <i data-lucide="trophy" class="event-meta-icon"></i>
                            ${event.category}
                        </div>
                        <div class="event-meta-item">
                            <i data-lucide="users" class="event-meta-icon"></i>
                            ${event.participants.toLocaleString()}명 참가
                        </div>
                    </div>
                    <div class="event-stats">
                        <span>👀 ${event.views.toLocaleString()}</span>
                        <span>📝 ${event.applications.toLocaleString()}</span>
                        <span>💰 ${(event.budget / 10000).toLocaleString()}만원</span>
                    </div>
                    <div class="event-actions">
                        <button class="event-action-btn" onclick="AdminAllTabs.showNotification('이벤트 상세보기', 'info')">
                            <i data-lucide="eye" style="width: 14px; height: 14px;"></i>
                            상세
                        </button>
                        <button class="event-action-btn primary" onclick="AdminAllTabs.editEvent(${event.id})">
                            <i data-lucide="edit-3" style="width: 14px; height: 14px;"></i>
                            편집
                        </button>
                    </div>
                </div>
            </div>
        `).join('');

        lucide.createIcons();
    },

    // 문의사항 관리 렌더링
    renderInquiriesManagement() {
        const inquiriesList = document.getElementById('inquiries-management-list');
        if (!inquiriesList) return;

        inquiriesList.innerHTML = sampleInquiries.map(inquiry => `
            <div class="inquiry-card">
                <div class="inquiry-header">
                    <div class="inquiry-main-content">
                        <div class="inquiry-badges">
                            <span class="recipe-badge ${this.getStatusClass(inquiry.status)}">${this.getStatusText(inquiry.status)}</span>
                            <span class="recipe-badge category">${this.getCategoryText(inquiry.category)}</span>
                            <span style="font-size: 10px; color: #64748b;">#${inquiry.id}</span>
                        </div>
                        <h4 class="inquiry-main-title">${inquiry.subject}</h4>
                        <p class="inquiry-description">${inquiry.message}</p>
                        <div class="inquiry-author-info">
                            <span>👤 ${inquiry.name}</span>
                            <span>📧 ${inquiry.email}</span>
                            <span>🕒 ${this.formatTimeAgo(inquiry.submittedAt)}</span>
                        </div>
                    </div>
                    <div style="display: flex; gap: 8px;">
                        <button class="event-action-btn primary" onclick="AdminAllTabs.openInquiryAnswer(${inquiry.id})">
                            <i data-lucide="${inquiry.answer ? 'edit-3' : 'reply'}" style="width: 14px; height: 14px;"></i>
                            ${inquiry.answer ? '수정' : '답변'}
                        </button>
                        <button class="event-action-btn" onclick="AdminAllTabs.showInquiryActions(${inquiry.id})">
                            <i data-lucide="more-vertical" style="width: 14px; height: 14px;"></i>
                        </button>
                    </div>
                </div>
                ${inquiry.answer ? `
                    <div class="inquiry-answer-section">
                        <div class="inquiry-answer-header">
                            <div class="inquiry-answer-meta">
                                <i data-lucide="check-circle-2" style="width: 14px; height: 14px;"></i>
                                <span>관리자 답변</span>
                                <span>(${this.formatTimeAgo(inquiry.answeredAt || inquiry.lastUpdated)})</span>
                            </div>
                        </div>
                        <div class="inquiry-answer-content">${inquiry.answer}</div>
                    </div>
                ` : ''}
            </div>
        `).join('');

        lucide.createIcons();
    },

    // 설정 관리 렌더링
    renderSettingsManagement() {
        // 설정 탭 이벤트만 설정 (HTML에 이미 구현됨)
        this.switchSettingsTab('site');
    },

    // 설정 탭 전환
    switchSettingsTab(tabName) {
        currentSettingsTab = tabName;
        
        document.querySelectorAll('[data-settings-tab]').forEach(btn => {
            btn.classList.remove('active');
            if (btn.getAttribute('data-settings-tab') === tabName) {
                btn.classList.add('active');
            }
        });
        
        document.querySelectorAll('.settings-tab-content').forEach(content => {
            content.classList.remove('active');
        });
        
        const targetContent = document.getElementById(`${tabName}-settings`);
        if (targetContent) {
            targetContent.classList.add('active');
        }
    },

    // DB 동기화 시작
    startDbSync() {
        const progressBar = document.getElementById('db-sync-progress');
        const progressFill = progressBar.querySelector('.progress-fill');
        const progressText = progressBar.querySelector('.progress-text');
        
        progressBar.style.display = 'block';
        let progress = 0;
        
        const interval = setInterval(() => {
            progress += 10;
            progressFill.style.width = progress + '%';
            progressText.textContent = progress + '%';
            
            if (progress >= 100) {
                clearInterval(interval);
                setTimeout(() => {
                    progressBar.style.display = 'none';
                    this.showNotification('데이터베이스 동기화가 완료되었습니다!', 'success');
                }, 1000);
            }
        }, 300);
    },

    // API 동기화 시작
    startApiSync() {
        const progressBar = document.getElementById('api-sync-progress');
        const progressFill = progressBar.querySelector('.progress-fill');
        const progressText = progressBar.querySelector('.progress-text');
        
        progressBar.style.display = 'block';
        let progress = 0;
        
        const interval = setInterval(() => {
            progress += 15;
            progressFill.style.width = progress + '%';
            progressText.textContent = progress + '%';
            
            if (progress >= 100) {
                clearInterval(interval);
                setTimeout(() => {
                    progressBar.style.display = 'none';
                    this.showNotification('API 데이터 불러오기가 완료되었습니다!', 'success');
                }, 1000);
            }
        }, 400);
    },

    // 이벤트 폼 열기
    openEventForm() {
        const modal = document.getElementById('event-modal');
        if (modal) {
            modal.style.display = 'flex';
            document.body.style.overflow = 'hidden';
        }
    },

    // 이벤트 폼 닫기
    closeEventForm() {
        const modal = document.getElementById('event-modal');
        if (modal) {
            modal.style.display = 'none';
            document.body.style.overflow = 'auto';
        }
    },

    // 이벤트 저장
    saveEvent() {
        const form = document.getElementById('event-form');
        const formData = new FormData(form);
        
        // 여기서 실제 저장 로직 구현
        this.showNotification('이벤트가 성공적으로 저장되었습니다!', 'success');
        this.closeEventForm();
    },

    // 이벤트 편집
    editEvent(eventId) {
        const event = sampleEvents.find(e => e.id === eventId);
        if (event) {
            // 폼에 데이터 채우기
            this.openEventForm();
            document.querySelector('.modal-title').innerHTML = `
                <i data-lucide="trophy" class="title-icon"></i>
                이벤트 수정
            `;
            
            // 폼 필드에 값 설정
            const form = document.getElementById('event-form');
            form.title.value = event.title;
            form.description.value = event.description;
            form.category.value = event.category;
            form.budget.value = event.budget;
            form.startDate.value = event.startDate;
            form.endDate.value = event.endDate;
            form.time.value = event.time;
            form.location.value = event.location;
            form.maxParticipants.value = event.maxParticipants || '';
            form.prize.value = event.prize;
            form.tags.value = event.tags.join(', ');
        }
    },

    // 문의사항 답변 열기
    openInquiryAnswer(inquiryId) {
        const inquiry = sampleInquiries.find(i => i.id === inquiryId);
        if (!inquiry) return;

        const modal = document.getElementById('inquiry-answer-modal');
        const originalInquiry = document.getElementById('original-inquiry');
        const answerContent = document.getElementById('answer-content');
        
        // 원본 문의 내용 표시
        originalInquiry.innerHTML = `
            <div style="display: flex; justify-content: space-between; margin-bottom: 12px;">
                <div style="display: flex; gap: 8px;">
                    <span class="recipe-badge ${this.getStatusClass(inquiry.status)}">${this.getStatusText(inquiry.status)}</span>
                    <span class="recipe-badge category">${this.getCategoryText(inquiry.category)}</span>
                    <span style="font-size: 10px; color: #64748b;">#${inquiry.id}</span>
                </div>
                <span style="font-size: 12px; color: #64748b;">${this.formatTimeAgo(inquiry.submittedAt)}</span>
            </div>
            <h4 style="font-weight: 600; margin-bottom: 8px;">${inquiry.subject}</h4>
            <p style="color: #374151; margin-bottom: 12px; line-height: 1.5;">${inquiry.message}</p>
            <div style="display: flex; gap: 16px; font-size: 12px; color: #64748b;">
                <span>👤 ${inquiry.name}</span>
                <span>📧 ${inquiry.email}</span>
            </div>
        `;
        
        // 기존 답변이 있으면 채우기
        answerContent.value = inquiry.answer || '';
        
        modal.style.display = 'flex';
        document.body.style.overflow = 'hidden';
    },

    // 문의사항 답변 닫기
    closeInquiryAnswer() {
        const modal = document.getElementById('inquiry-answer-modal');
        if (modal) {
            modal.style.display = 'none';
            document.body.style.overflow = 'auto';
        }
    },

    // 답변 제출
    submitAnswer() {
        const answerContent = document.getElementById('answer-content').value;
        if (!answerContent.trim()) {
            this.showNotification('답변 내용을 입력해주세요.', 'error');
            return;
        }
        
        this.showNotification('답변이 성공적으로 전송되었습니다!', 'success');
        this.closeInquiryAnswer();
    },

    // 사용자 액션 표시
    showUserActions(userId) {
        this.showNotification(`회원 ID ${userId}의 관리 메뉴`, 'info');
    },

    // 레시피 액션 표시
    showRecipeActions(recipeId) {
        this.showNotification(`레시피 ID ${recipeId}의 관리 메뉴`, 'info');
    },

    // 문의사항 액션 표시
    showInquiryActions(inquiryId) {
        this.showNotification(`문의사항 ID ${inquiryId}의 관리 메뉴`, 'info');
    },

    // 알림 표시
    showNotification(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.textContent = message;
        
        // 스타일 설정
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 16px 20px;
            border-radius: 12px;
            color: white;
            font-weight: 500;
            font-family: 'Gowun Dodum', sans-serif;
            z-index: 9999;
            opacity: 0;
            transform: translateX(100%);
            transition: all 0.3s ease;
            max-width: 300px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        `;
        
        // 타입별 배경색
        const colors = {
            info: 'linear-gradient(135deg, #f97316, #ec4899)',
            success: 'linear-gradient(135deg, #10b981, #059669)',
            warning: 'linear-gradient(135deg, #f59e0b, #d97706)',
            error: 'linear-gradient(135deg, #ef4444, #dc2626)'
        };
        notification.style.background = colors[type] || colors.info;
        
        document.body.appendChild(notification);
        
        // 애니메이션으로 표시
        setTimeout(() => {
            notification.style.opacity = '1';
            notification.style.transform = 'translateX(0)';
        }, 100);
        
        // 3초 후 자동 제거
        setTimeout(() => {
            notification.style.opacity = '0';
            notification.style.transform = 'translateX(100%)';
            setTimeout(() => {
                if (notification.parentNode) {
                    notification.remove();
                }
            }, 300);
        }, 3000);
    },

    // 유틸리티 함수들
    getStatusIconName(status) {
        switch (status) {
            case 'active': return 'check-circle';
            case 'inactive': return 'clock';
            case 'suspended': return 'alert-triangle';
            case 'banned': return 'ban';
            case 'published': return 'check-circle';
            case 'private': case 'hidden': return 'eye-off';
            case 'draft': return 'edit-3';
            case 'reported': return 'flag';
            case 'pending': return 'clock';
            case 'answered': return 'check-circle-2';
            case 'ended': return 'check-circle';
            case 'paused': return 'pause';
            case 'cancelled': return 'x';
            default: return 'check-circle';
        }
    },

    getStatusText(status) {
        switch (status) {
            case 'active': return '활성';
            case 'inactive': return '비활성';
            case 'suspended': return '정지';
            case 'banned': return '차단';
            case 'published': return '공개';
            case 'private': return '비공개';
            case 'draft': return '임시저장';
            case 'reported': return '신고됨';
            case 'pending': return '대기중';
            case 'answered': return '답변완료';
            case 'ended': return '종료';
            case 'paused': return '일시정지';
            case 'cancelled': return '취소';
            default: return status;
        }
    },

    getStatusClass(status) {
        switch (status) {
            case 'active':
            case 'published':
            case 'answered': return 'status-active';
            case 'pending': return 'status-pending';
            case 'private':
            case 'draft': return 'status-private';
            case 'reported': return 'status-reported';
            case 'suspended': return 'status-suspended';
            case 'banned': return 'status-banned';
            default: return 'status-active';
        }
    },

    getCategoryText(category) {
        switch (category) {
            case 'recipe': return '레시피';
            case 'account': return '계정';
            case 'grade': return '등급';
            case 'payment': return '결제';
            case 'technical': return '기술';
            case 'suggestion': return '제안';
            case 'report': return '신고';
            case 'other': return '기타';
            default: return category;
        }
    },

    formatDate(dateString) {
        return new Date(dateString).toLocaleDateString('ko-KR');
    },

    formatTime(dateString) {
        return new Date(dateString).toLocaleTimeString('ko-KR', { 
            hour: '2-digit', 
            minute: '2-digit' 
        });
    },

    formatTimeAgo(dateString) {
        const now = new Date();
        const date = new Date(dateString);
        const diffInHours = Math.floor((now.getTime() - date.getTime()) / (1000 * 60 * 60));
        
        if (diffInHours < 1) return '방금 전';
        if (diffInHours < 24) return `${diffInHours}시간 전`;
        if (diffInHours < 48) return '어제';
        return `${Math.floor(diffInHours / 24)}일 전`;
    }
};

// 전역 객체로 노출
window.AdminAllTabs = AdminAllTabs;