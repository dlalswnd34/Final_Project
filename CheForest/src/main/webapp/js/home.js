/* CheForest Home Page JavaScript */
/* 홈페이지 컴포넌트 전용 JavaScript */

// 홈페이지 관련 전역 변수
let currentSlide = 0;
const totalSlides = 5;
let slideInterval;
let activeCategory = 'korean';
let activeTab = 'recipes';

// 카테고리 데이터
const categoryData = {
    korean: {
        name: '한식',
        recipes: [
            { title: '간단한 김치찌개', author: '김요리사', rating: 4.8, reviews: 234 },
            { title: '부드러운 갈비찜', author: '박셰프', rating: 4.9, reviews: 189 },
            { title: '매콤한 떡볶이', author: '이요리연구가', rating: 4.7, reviews: 312 }
        ]
    },
    western: {
        name: '양식',
        recipes: [
            { title: '크리미 카르보나라', author: '이탈리안셰프', rating: 4.9, reviews: 456 },
            { title: '촉촉한 스테이크', author: '미트마스터', rating: 4.8, reviews: 298 },
            { title: '치즈 리조또', author: '유럽요리사', rating: 4.7, reviews: 201 }
        ]
    },
    chinese: {
        name: '중식',
        recipes: [
            { title: '매콤한 마파두부', author: '중화요리사', rating: 4.8, reviews: 234 },
            { title: '바삭한 탕수육', author: '딤섬마스터', rating: 4.9, reviews: 389 },
            { title: '사천식 짜장면', author: '면요리전문가', rating: 4.6, reviews: 156 }
        ]
    },
    japanese: {
        name: '일식',
        recipes: [
            { title: '신선한 연어 사시미', author: '스시장인', rating: 4.9, reviews: 412 },
            { title: '진한 라멘', author: '라멘마스터', rating: 4.8, reviews: 278 },
            { title: '부드러운 규동', author: '일식요리사', rating: 4.7, reviews: 193 }
        ]
    },
    dessert: {
        name: '디저트',
        recipes: [
            { title: '촉촉한 초콜릿케이크', author: '디저트마스터', rating: 4.9, reviews: 567 },
            { title: '바삭한 마카롱', author: '프랑스파티시에', rating: 4.8, reviews: 334 },
            { title: '부드러운 티라미수', author: '이탈리안디저트', rating: 4.7, reviews: 245 }
        ]
    }
};

// === 배너 슬라이더 기능 ===

// 슬라이드 이동
function goToSlide(slideIndex) {
    const slides = document.querySelectorAll('.slide');
    const dots = document.querySelectorAll('.slide-dot');
    
    if (slides.length === 0) return;
    
    // 현재 슬라이드 숨김
    slides[currentSlide].style.opacity = '0';
    dots[currentSlide].classList.remove('scale-125', 'bg-white');
    dots[currentSlide].classList.add('bg-white/50');
    
    // 새 슬라이드 표시
    currentSlide = slideIndex;
    slides[currentSlide].style.opacity = '1';
    dots[currentSlide].classList.remove('bg-white/50');
    dots[currentSlide].classList.add('scale-125', 'bg-white');
    
    // 자동 슬라이드 타이머 재시작
    resetSlideTimer();
}

// 다음 슬라이드
function nextSlide() {
    const nextIndex = (currentSlide + 1) % totalSlides;
    goToSlide(nextIndex);
}

// 이전 슬라이드
function previousSlide() {
    const prevIndex = currentSlide === 0 ? totalSlides - 1 : currentSlide - 1;
    goToSlide(prevIndex);
}

// 슬라이드 타이머 재시작
function resetSlideTimer() {
    clearInterval(slideInterval);
    slideInterval = setInterval(nextSlide, 5000);
}

// 배너 슬라이더 초기화
function initializeBannerSlider() {
    // 자동 슬라이드 시작
    slideInterval = setInterval(nextSlide, 5000);
    
    // 마우스 오버 시 자동 슬라이드 정지
    const bannerSlider = document.getElementById('bannerSlider');
    if (bannerSlider) {
        bannerSlider.addEventListener('mouseenter', () => {
            clearInterval(slideInterval);
        });
        
        bannerSlider.addEventListener('mouseleave', () => {
            slideInterval = setInterval(nextSlide, 5000);
        });
    }
}

// === 카테고리 네비게이션 기능 ===

// 카테고리 전환
function switchCategory(category) {
    activeCategory = category;
    
    // 버튼 상태 업데이트
    document.querySelectorAll('.category-btn').forEach(btn => {
        btn.classList.remove('active');
        btn.classList.remove('bg-gradient-to-r', 'from-pink-500', 'to-orange-500', 'text-white', 'shadow-2xl', 'shadow-pink-500/30', 'border-transparent', 'transform', 'scale-105');
        btn.classList.add('bg-white', 'text-gray-700', 'shadow-lg', 'shadow-gray-200/50', 'border-gray-100');
    });
    
    // 클릭된 버튼 활성화
    const clickedBtn = event.target.closest('.category-btn');
    if (clickedBtn) {
        clickedBtn.classList.add('active');
        clickedBtn.classList.remove('bg-white', 'text-gray-700', 'shadow-lg', 'shadow-gray-200/50', 'border-gray-100');
        clickedBtn.classList.add('bg-gradient-to-r', 'from-pink-500', 'to-orange-500', 'text-white', 'shadow-2xl', 'shadow-pink-500/30', 'border-transparent', 'transform', 'scale-105');
    }
    
    updateCategoryContent();
}

// 탭 전환
function switchTab(tab) {
    activeTab = tab;
    
    // 탭 버튼 업데이트
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.remove('active');
        btn.classList.remove('bg-white', 'shadow-sm', 'text-gray-900');
        btn.classList.add('text-gray-600');
    });
    
    event.target.classList.add('active');
    event.target.classList.add('bg-white', 'shadow-sm', 'text-gray-900');
    event.target.classList.remove('text-gray-600');
    
    // 탭 콘텐츠 업데이트
    document.querySelectorAll('.tab-content').forEach(content => {
        content.classList.add('hidden');
    });
    document.getElementById(tab + 'Tab').classList.remove('hidden');
    
    updateCategoryContent();
}

// 카테고리 콘텐츠 업데이트
function updateCategoryContent() {
    const data = categoryData[activeCategory];
    
    // 제목 업데이트
    const categoryTitle = document.getElementById('categoryTitle');
    const communityTitle = document.getElementById('communityTitle');
    
    if (categoryTitle) {
        categoryTitle.textContent = `${data.name} CheForest 레시피`;
    }
    if (communityTitle) {
        communityTitle.textContent = `${data.name} 사용자 레시피`;
    }
    
    // 레시피 목록 업데이트
    const recipesList = document.getElementById('recipesList');
    if (recipesList && activeTab === 'recipes') {
        recipesList.innerHTML = data.recipes.map((recipe, index) => `
            <div class="recipe-list-item flex items-center justify-between p-4 bg-gray-50/30 rounded-lg hover:bg-gray-50/50 transition-colors cursor-pointer" onclick="showPage('recipe-detail')">
                <div class="flex-1">
                    <h4 class="font-medium mb-1">${recipe.title}</h4>
                    <p class="text-sm text-gray-600">by ${recipe.author}</p>
                </div>
                <div class="flex items-center space-x-4 text-sm">
                    <div class="flex items-center space-x-1">
                        <i data-lucide="star" class="w-4 h-4 fill-yellow-400 text-yellow-400"></i>
                        <span>${recipe.rating}</span>
                        <span class="text-gray-500">(${recipe.reviews})</span>
                    </div>
                    <span class="bg-gray-100 text-gray-600 px-2 py-1 rounded text-xs">${index + 1}위</span>
                </div>
            </div>
        `).join('');
        
        // 아이콘 재초기화
        if (window.CheForest && window.CheForest.common) {
            window.CheForest.common.initializeLucideIcons();
        }
    }
}

// === 카드 애니메이션 ===

// 스크롤 시 카드 애니메이션
function setupScrollAnimations() {
    const cards = document.querySelectorAll('.recipe-card, .event-card');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.animation = 'slideInUp 0.6s ease-out';
            }
        });
    });
    
    cards.forEach(card => {
        observer.observe(card);
    });
}

// === 홈페이지 초기화 ===

function initializeHome() {
    // 배너 슬라이더 초기화
    initializeBannerSlider();
    
    // 카테고리 네비게이션 초기화
    updateCategoryContent();
    
    // 스크롤 애니메이션 설정
    setupScrollAnimations();
    
    // 현재 네비게이션 상태 업데이트
    if (window.CheForest && window.CheForest.common) {
        window.CheForest.common.updateActiveNavigation('home');
    }
}

// 페이지 로드 시 홈페이지 초기화
document.addEventListener('DOMContentLoaded', function() {
    // 공통 스크립트가 로드될 때까지 기다림
    if (window.CheForest && window.CheForest.common) {
        initializeHome();
    } else {
        setTimeout(initializeHome, 100);
    }
});

// 페이지 언로드 시 타이머 정리
window.addEventListener('beforeunload', function() {
    if (slideInterval) {
        clearInterval(slideInterval);
    }
});

// 홈페이지 함수들을 전역 객체에 등록
window.CheForest = window.CheForest || {};
window.CheForest.home = {
    goToSlide,
    nextSlide,
    previousSlide,
    switchCategory,
    switchTab,
    updateCategoryContent,
    initializeHome
};