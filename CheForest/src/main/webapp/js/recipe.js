/* CheForest Recipe Page JavaScript */
/* 레시피 페이지 전용 JavaScript (HTML 기반 필터링) */

// 레시피 페이지 관련 전역 변수
let selectedCategory = 'all';
let searchQuery = '';
let sortBy = 'popularity';

// 카테고리 데이터
const categories = [
    { id: 'all', name: '전체', icon: '🍽️', color: 'bg-gray-100 text-gray-800' },
    { id: 'korean', name: '한식', icon: '🥢', color: 'korean' },
    { id: 'western', name: '양식', icon: '🍝', color: 'western' },
    { id: 'chinese', name: '중식', icon: '🥟', color: 'chinese' },
    { id: 'japanese', name: '일식', icon: '🍣', color: 'japanese' },
    { id: 'dessert', name: '디저트', icon: '🧁', color: 'dessert' }
];

// === HTML 카드 기반 필터링 함수들 ===

// HTML에서 레시피 카드 요소들 가져오기
function getRecipeCards() {
    const popularCards = Array.from(document.querySelectorAll('#popularGrid .popular-recipe-card'));
    const regularCards = Array.from(document.querySelectorAll('#regularGrid .recipe-card'));
    
    return {
        popular: popularCards,
        regular: regularCards,
        all: [...popularCards, ...regularCards]
    };
}

// 카드 필터링 함수
function shouldShowRecipeCard(card) {
    const category = card.dataset.category;
    const title = card.dataset.title?.toLowerCase() || '';
    const description = card.dataset.description?.toLowerCase() || '';
    
    // 카테고리 필터
    const matchesCategory = selectedCategory === 'all' || category === selectedCategory;
    
    // 검색 필터
    const searchLower = searchQuery.toLowerCase();
    const matchesSearch = !searchQuery || 
                         title.includes(searchLower) || 
                         description.includes(searchLower);
    
    return matchesCategory && matchesSearch;
}

// 카드 정렬 함수 (일반 카드만)
function sortRecipeCards(cards) {
    return cards.sort((a, b) => {
        const aLikes = parseInt(a.dataset.likes) || 0;
        const bLikes = parseInt(b.dataset.likes) || 0;
        const aRating = parseFloat(a.dataset.rating) || 0;
        const bRating = parseFloat(b.dataset.rating) || 0;
        const aViews = parseInt(a.dataset.views) || 0;
        const bViews = parseInt(b.dataset.views) || 0;
        const aCreated = new Date(a.dataset.created).getTime();
        const bCreated = new Date(b.dataset.created).getTime();
        
        switch (sortBy) {
            case 'popularity':
                return bLikes - aLikes;
            case 'rating':
                return bRating - aRating;
            case 'newest':
                return bCreated - aCreated;
            case 'views':
                return bViews - aViews;
            default:
                return 0;
        }
    });
}

// === UI 업데이트 함수들 ===

// 카테고리 버튼 렌더링
function renderCategories() {
    const categoryList = document.getElementById('categoryList');
    if (!categoryList) return;

    // 각 카테고리별 총 카드 개수 계산
    const cards = getRecipeCards();
    const categoryCounts = {};
    
    cards.all.forEach(card => {
        const category = card.dataset.category;
        categoryCounts[category] = (categoryCounts[category] || 0) + 1;
    });

    categoryList.innerHTML = categories.map(category => `
        <button
            class="category-button w-full flex items-center space-x-3 px-3 py-2 rounded-lg transition-all duration-200 ${
                selectedCategory === category.id ? 'active' : 'text-gray-700 hover:bg-gray-50'
            }"
            onclick="switchRecipeCategory('${category.id}')"
        >
            <span class="text-lg">${category.icon}</span>
            <span>${category.name}</span>
            <span class="category-count ml-auto text-xs bg-gray-100 text-gray-700 px-2 py-1 rounded">
                ${category.id === 'all' ? cards.all.length : (categoryCounts[category.id] || 0)}
            </span>
        </button>
    `).join('');
}

// 인기 레시피 필터링 및 렌더링
function renderPopularRecipes() {
    const cards = getRecipeCards();
    const popularSection = document.getElementById('popularSection');
    const popularCount = document.getElementById('popularCount');
    
    let visibleCount = 0;
    
    cards.popular.forEach(card => {
        if (shouldShowRecipeCard(card)) {
            card.style.display = 'block';
            visibleCount++;
        } else {
            card.style.display = 'none';
        }
    });
    
    if (visibleCount > 0) {
        popularSection.style.display = 'block';
        popularCount.textContent = `TOP ${visibleCount}`;
    } else {
        popularSection.style.display = 'none';
    }
}

// 일반 레시피 필터링, 정렬 및 렌더링
function renderRegularRecipes() {
    const cards = getRecipeCards();
    const regularCount = document.getElementById('regularCount');
    
    // 필터링
    const visibleCards = cards.regular.filter(card => shouldShowRecipeCard(card));
    
    // 정렬
    const sortedCards = sortRecipeCards([...visibleCards]);
    
    // 모든 카드 숨기기
    cards.regular.forEach(card => {
        card.style.display = 'none';
    });
    
    // 정렬된 순서대로 표시
    const regularGrid = document.getElementById('regularGrid');
    if (regularGrid && sortedCards.length > 0) {
        // 정렬된 순서대로 DOM에서 재배치
        sortedCards.forEach(card => {
            card.style.display = 'block';
            regularGrid.appendChild(card); // 순서 재배치
        });
    }
    
    regularCount.textContent = `${visibleCards.length}개`;
}

// 결과 없음 섹션 표시/숨김
function toggleNoResultsSection() {
    const cards = getRecipeCards();
    const noResultsSection = document.getElementById('noResultsSection');
    const loadMoreSection = document.getElementById('loadMoreSection');
    
    const visiblePopular = cards.popular.filter(card => shouldShowRecipeCard(card)).length;
    const visibleRegular = cards.regular.filter(card => shouldShowRecipeCard(card)).length;
    
    if (visiblePopular === 0 && visibleRegular === 0) {
        noResultsSection.style.display = 'block';
        loadMoreSection.style.display = 'none';
    } else {
        noResultsSection.style.display = 'none';
        loadMoreSection.style.display = 'block';
    }
}

// 레시피 개수 업데이트
function updateRecipeCount() {
    const cards = getRecipeCards();
    const recipeCount = document.getElementById('recipeCount');
    
    const visiblePopular = cards.popular.filter(card => shouldShowRecipeCard(card)).length;
    const visibleRegular = cards.regular.filter(card => shouldShowRecipeCard(card)).length;
    const totalVisible = visiblePopular + visibleRegular;
    
    if (recipeCount) {
        recipeCount.textContent = `총 ${totalVisible}개의 레시피 • 인기 ${visiblePopular}개, 일반 ${visibleRegular}개`;
    }
}

// 카테고리 제목 업데이트
function updateCategoryTitle() {
    const categoryTitle = document.getElementById('categoryTitle');
    const selectedCategoryData = categories.find(c => c.id === selectedCategory);
    
    if (categoryTitle && selectedCategoryData) {
        categoryTitle.textContent = `${selectedCategoryData.name} 레시피`;
    }
}

// === 이벤트 핸들러들 ===

// 카테고리 전환
function switchRecipeCategory(categoryId) {
    selectedCategory = categoryId;
    updateRecipeContent();
    
    // 카테고리 버튼 활성화 상태 업데이트
    renderCategories();
}

// 검색 처리
function handleRecipeSearch() {
    const searchInput = document.getElementById('recipeSearchInput');
    if (searchInput) {
        searchQuery = searchInput.value.trim();
        updateRecipeContent();
    }
}

// 카테고리 배지 스타일 적용
function fixCategoryBadges() {
    // 모든 카테고리 배지 찾기 및 수정
    const badges = document.querySelectorAll('span');
    
    badges.forEach(badge => {
        const text = badge.textContent.trim();
        const hasGenericBg = badge.classList.contains('bg-white/90') || 
                           badge.classList.contains('bg-red-500/90') || 
                           badge.classList.contains('bg-green-500/90');
        
        if (hasGenericBg) {
            // 카테고리별 스타일 적용
            if (text === '한식') {
                badge.className = 'category-badge korean';
            } else if (text === '양식') {
                badge.className = 'category-badge western';
            } else if (text === '중식') {
                badge.className = 'category-badge chinese';
            } else if (text === '일식') {
                badge.className = 'category-badge japanese';
            } else if (text === '디저트') {
                badge.className = 'category-badge dessert';
            } else if (text === 'HOT') {
                badge.className = 'category-badge hot-badge';
            } else if (text === 'NEW') {
                badge.className = 'category-badge new-badge';
            }
        }
    });
}

// 레시피 콘텐츠 전체 업데이트
function updateRecipeContent() {
    updateCategoryTitle();
    updateRecipeCount();
    renderPopularRecipes();
    renderRegularRecipes();
    toggleNoResultsSection();
    
    // 카테고리 배지 스타일 적용
    fixCategoryBadges();
    
    // Lucide 아이콘 재초기화
    if (window.CheForest && window.CheForest.common) {
        window.CheForest.common.initializeLucideIcons();
    } else if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
}

// 검색 입력 이벤트 설정
function setupRecipeSearchEvents() {
    const searchInput = document.getElementById('recipeSearchInput');
    if (searchInput) {
        // 실시간 검색 (디바운스 적용)
        let searchTimeout;
        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(() => {
                handleRecipeSearch();
            }, 300);
        });
        
        // Enter 키 이벤트
        searchInput.addEventListener('keydown', function(event) {
            if (event.key === 'Enter') {
                clearTimeout(searchTimeout);
                handleRecipeSearch();
            }
        });
    }
}

// === 레시피 페이지 초기화 ===

function initializeRecipePage() {
    // 카테고리 렌더링
    renderCategories();
    
    // 초기 레시피 콘텐츠 렌더링
    updateRecipeContent();
    
    // 검색 이벤트 설정
    setupRecipeSearchEvents();
    
    // 카테고리 배지 스타일 적용 (초기화 시에도 실행)
    fixCategoryBadges();
    
    // 현재 네비게이션 상태 업데이트
    if (window.CheForest && window.CheForest.common) {
        window.CheForest.common.updateActiveNavigation('recipes');
    }
    
    console.log('✅ 레시피 페이지 초기화 완료! (HTML 기반 필터링 + 카테고리 배지 스타일 적용)');
}

// 페이지 로드 시 레시피 페이지 초기화
document.addEventListener('DOMContentLoaded', function() {
    // 공통 스크립트가 로드될 때까지 기다림
    if (window.CheForest && window.CheForest.common) {
        initializeRecipePage();
    } else {
        setTimeout(initializeRecipePage, 100);
    }
});

// 레시피 페이지 함수들을 전역 객체에 등록
window.CheForest = window.CheForest || {};
window.CheForest.recipe = {
    switchRecipeCategory,
    handleRecipeSearch,
    updateRecipeContent,
    initializeRecipePage,
    getRecipeCards,
    shouldShowRecipeCard,
    sortRecipeCards
};