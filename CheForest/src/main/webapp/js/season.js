// CheForest 계절 식재료 JavaScript
// 주의: 이 파일은 기본 구조만 제공합니다. 실제 동작은 JSP 개발 시 구현해주세요.

document.addEventListener('DOMContentLoaded', function() {

    // 계절 탭 버튼들
    const tabButtons = document.querySelectorAll('.tab-button');

    // 계절 탭 전환 기능
    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            const season = this.getAttribute('data-season');

            // 모든 탭 버튼 비활성화
            tabButtons.forEach(btn => btn.classList.remove('active'));

            // 클릭된 탭 버튼 활성화
            this.classList.add('active');

            // TODO: JSP에서 계절별 데이터 필터링 구현
            console.log('선택된 계절:', season);

            // 배경색 변경
            changeSeasonTheme(season);
        });
    });

    // 레시피 보기 버튼들
    const recipeBtns = document.querySelectorAll('.recipe-btn');
    recipeBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            // TODO: JSP에서 해당 식재료의 레시피 페이지로 이동 구현
            console.log('레시피 페이지로 이동');
        });
    });

    // 계절별 테마 변경 함수
    function changeSeasonTheme(season) {
        const container = document.querySelector('.ingredients-container');
        const body = document.body;

        // 기존 계절 클래스 제거
        container.classList.remove('season-spring', 'season-summer', 'season-autumn', 'season-winter');
        body.classList.remove('season-spring', 'season-summer', 'season-autumn', 'season-winter');

        // 새로운 계절 클래스 추가
        container.classList.add(`season-${season}`);
        body.classList.add(`season-${season}`);

        // 페이지 제목과 아이콘 업데이트
        updateSeasonHeader(season);
    }

    // 계절별 헤더 업데이트 함수
    function updateSeasonHeader(season) {
        const seasonIcon = document.querySelector('.season-icon');
        const pageTitle = document.querySelector('.page-title');
        const guideMainIcon = document.querySelector('.guide-main-icon');

        const seasonData = {
            'spring': { icon: '🌸', name: '봄철', color: 'linear-gradient(to right, #22c55e, #ec4899)' },
            'summer': { icon: '☀️', name: '여름철', color: 'linear-gradient(to right, #f59e0b, #f97316)' },
            'autumn': { icon: '🍂', name: '가을철', color: 'linear-gradient(to right, #f97316, #dc2626)' },
            'winter': { icon: '❄️', name: '겨울철', color: 'linear-gradient(to right, #3b82f6, #6366f1)' }
        };

        if (seasonData[season]) {
            seasonIcon.textContent = seasonData[season].icon;
            pageTitle.textContent = seasonData[season].name + ' 식재료';

            if (guideMainIcon) {
                guideMainIcon.textContent = seasonData[season].icon;
            }
        }
    }

    // 카드 호버 효과 개선
    const ingredientCards = document.querySelectorAll('.ingredient-card');
    ingredientCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-10px) scale(1.02)';
        });

        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });

    // 스크롤 애니메이션
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // 모든 카드에 스크롤 애니메이션 적용
    ingredientCards.forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(card);
    });

    // 검색 기능 (향후 구현용)
    function filterIngredients(searchTerm) {
        // TODO: JSP에서 검색 기능 구현
        console.log('검색어:', searchTerm);
    }

    // 정렬 기능 (향후 구현용)
    function sortIngredients(sortBy) {
        // TODO: JSP에서 정렬 기능 구현
        // sortBy: 'name', 'season', 'popularity' 등
        console.log('정렬 기준:', sortBy);
    }

    // 즐겨찾기 기능 (향후 구현용)
    function toggleFavorite(ingredientId) {
        // TODO: JSP에서 즐겨찾기 토글 구현
        console.log('즐겨찾기 토글:', ingredientId);
    }

    // 공유 기능 (향후 구현용)
    function shareIngredient(ingredientId) {
        // TODO: JSP에서 공유 기능 구현
        console.log('식재료 공유:', ingredientId);
    }

    // 페이지 로딩 완료 로그
    console.log('계절 식재료 페이지 초기화 완료');
});

// 공통 유틸리티 함수들

// 이미지 로드 에러 처리
function handleImageError(img) {
    img.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3Qgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiBmaWxsPSIjRjNGNEY2Ii8+CjxwYXRoIGQ9Ik0xMiAxNkMxNC4yMDkxIDEgMTYgMTQuMjA5MSAxNiAxMkMxNiA5Ljc5MDg2IDE0LjIwOTEgOCAxMiA4QzkuNzkwODYgOCA4IDkuNzkwODYgOCAxMkM4IDE0LjIwOTEgOS43OTA4NiAxNiAxMiAxNloiIGZpbGw9IiM5Q0EzQUYiLz4KPC9zdmc+';
    img.alt = '이미지를 불러올 수 없습니다';
}

// 모든 이미지에 에러 처리 적용
document.addEventListener('DOMContentLoaded', function() {
    const images = document.querySelectorAll('img');
    images.forEach(img => {
        img.addEventListener('error', function() {
            handleImageError(this);
        });
    });
});

// 계절별 색상 매핑
const seasonColors = {
    spring: {
        primary: '#22c55e',
        secondary: '#ec4899',
        background: 'linear-gradient(135deg, #f0fdf4 0%, #fce7f3 100%)'
    },
    summer: {
        primary: '#f59e0b',
        secondary: '#f97316',
        background: 'linear-gradient(135deg, #fffbeb 0%, #fed7aa 100%)'
    },
    autumn: {
        primary: '#f97316',
        secondary: '#dc2626',
        background: 'linear-gradient(135deg, #fff7ed 0%, #fecaca 100%)'
    },
    winter: {
        primary: '#3b82f6',
        secondary: '#6366f1',
        background: 'linear-gradient(135deg, #eff6ff 0%, #e0e7ff 100%)'
    }
};

// 계절별 이모지 매핑
const seasonEmojis = {
    spring: '🌸',
    summer: '☀️',
    autumn: '🍂',
    winter: '❄️'
};

// 디바운스 함수 (검색 기능용)
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}