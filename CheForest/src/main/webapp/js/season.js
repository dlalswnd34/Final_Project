/* CheForest 계절별 식재료 페이지 JavaScript */

// 계절별 설정
const seasonConfig = {
    spring: {
        name: '봄',
        icon: '🌸',
        titleGradient: 'from-green-400 to-pink-400',
        bgGradient: 'from-green-50 to-pink-50',
        textColor: 'text-green-700',
        borderColor: 'border-green-200',
        iconColor: 'text-green-600'
    },
    summer: {
        name: '여름',
        icon: '☀️',
        titleGradient: 'from-yellow-400 to-orange-400',
        bgGradient: 'from-yellow-50 to-orange-50',
        textColor: 'text-yellow-700',
        borderColor: 'border-yellow-200',
        iconColor: 'text-yellow-600'
    },
    autumn: {
        name: '가을',
        icon: '🍂',
        titleGradient: 'from-orange-400 to-red-400',
        bgGradient: 'from-orange-50 to-red-50',
        textColor: 'text-orange-700',
        borderColor: 'border-orange-200',
        iconColor: 'text-orange-600'
    },
    winter: {
        name: '겨울',
        icon: '❄️',
        titleGradient: 'from-blue-400 to-indigo-400',
        bgGradient: 'from-blue-50 to-indigo-50',
        textColor: 'text-blue-700',
        borderColor: 'border-blue-200',
        iconColor: 'text-blue-600'
    }
};

// 계절별 팁 데이터
const seasonTips = {
    spring: {
        storage: '봄나물은 찬물에 담가 이물질을 제거한 후 키친타월로 물기를 제거하고 밀폐용기에 넣어 냉장보관하세요. 2-3일 내 섭취가 좋습니다.',
        cooking: '봄나물은 끓는 물에 소금을 넣고 살짝 데친 후 찬물에 헹구어 쓴맛을 제거합니다. 참기름과 마늘로 간단히 무쳐드세요.',
        tip: '봄나물의 쓴맛이 싫다면 데친 후 찬물에 30분간 담가두세요. 어린잎일수록 부드럽고 맛이 좋습니다.',
        special: '봄철에는 해독과 간 기능 개선에 도움되는 쌉쌀한 나물류가 많습니다. 겨울 동안 쌓인 독소를 배출하는 데 효과적입니다.'
    },
    summer: {
        storage: '여름 채소는 직사광선을 피하고 서늘한 곳에 보관하세요. 토마토는 상온에, 오이는 냉장고에 보관하는 것이 좋습니다.',
        cooking: '수분이 많은 여름 채소는 생으로 먹거나 짧은 시간 볶아서 아삭한 식감을 살려 조리하세요. 차가운 요리가 특히 좋습니다.',
        tip: '더운 여름에는 차가운 요리를 만들어 체온을 낮춰보세요. 얼음을 활용한 냉국이나 샐러드가 좋습니다.',
        special: '여름철 식재료는 수분과 전해질이 풍부해 더위로 인한 탈수를 예방합니다. 비타민과 미네랄도 풍부합니다.'
    },
    autumn: {
        storage: '과일류는 통풍이 잘 되는 서늘한 곳에 보관하고, 뿌리채소는 흙이 묻은 채로 신문지에 싸서 보관하면 오래 신선합니다.',
        cooking: '당도가 높은 가을 식재료는 구이나 로스팅으로 조리하면 자연스러운 단맛이 더욱 깊어집니다. 오븐 활용을 추천합니다.',
        tip: '가을 과일은 완전히 익기 전에 따서 후숙시키면 더 달고 맛있습니다. 에틸렌 가스를 내는 사과와 함께 보관하세요.',
        special: '가을철에는 겨울을 대비해 영양을 비축하는 시기입니다. 당질과 지방이 풍부한 견과류와 뿌리채소를 많이 드세요.'
    },
    winter: {
        storage: '겨울 채소는 냉장고 야채실에 보관하되, 무나 배추는 습도를 유지해야 하므로 비닐봉지에 넣어 보관하세요.',
        cooking: '겨울 채소는 국물 요리나 찜 요리로 만들어 몸을 따뜻하게 해주세요. 긴 조리시간으로 영양분을 충분히 우려내세요.',
        tip: '겨울 채소는 비타민 C가 풍부해 감기 예방에 좋습니다. 생으로도 충분히 드시고, 국물요리로도 즐겨보세요.',
        special: '겨울철에는 면역력 강화와 체온 유지가 중요합니다. 비타민 C가 풍부한 채소와 따뜻한 성질의 식재료를 섭취하세요.'
    }
};

// 현재 선택된 계절
let currentSeason = 'spring';

// DOM 로드 후 초기화
document.addEventListener('DOMContentLoaded', function() {
    initializeIngredientsPage();
    setupEventListeners();
    updateSeasonalContent();
    filterIngredientsBySeason(currentSeason);
});

// 페이지 초기화
function initializeIngredientsPage() {
    console.log('계절별 식재료 페이지 초기화');
    
    // 초기 애니메이션 딜레이 설정
    const cards = document.querySelectorAll('.ingredient-card');
    cards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
    });
}

// 이벤트 리스너 설정
function setupEventListeners() {
    // 계절 탭 클릭 이벤트
    document.querySelectorAll('.season-tab').forEach(tab => {
        tab.addEventListener('click', function() {
            const season = this.dataset.season;
            selectSeason(season);
        });
    });

    // 레시피 버튼 클릭 이벤트
    document.addEventListener('click', function(e) {
        if (e.target.classList.contains('recipe-button')) {
            const card = e.target.closest('.ingredient-card');
            const ingredientName = card.querySelector('.ingredient-title').textContent;
            viewRecipe(ingredientName);
        }
    });
}

// 계절 선택
function selectSeason(season) {
    if (currentSeason === season) return;
    
    currentSeason = season;
    
    // 탭 활성화 상태 업데이트
    updateSeasonTabs();
    
    // 배경 그라데이션 변경
    updatePageBackground();
    
    // 계절별 콘텐츠 업데이트
    updateSeasonalContent();
    
    // 식재료 카드 필터링
    filterIngredientsBySeason(season);
    
    // 카드 스타일 업데이트
    updateCardStyles(season);
}

// 계절 탭 업데이트
function updateSeasonTabs() {
    document.querySelectorAll('.season-tab').forEach(tab => {
        const season = tab.dataset.season;
        const isActive = season === currentSeason;
        
        if (isActive) {
            tab.className = `season-tab flex items-center space-x-2 px-6 py-3 rounded-full transition-all duration-300 bg-gradient-to-r ${seasonConfig[currentSeason].titleGradient} text-white shadow-md transform scale-105 active`;
        } else {
            tab.className = 'season-tab flex items-center space-x-2 px-6 py-3 rounded-full transition-all duration-300 text-gray-600 hover:bg-white/50 hover:scale-102';
        }
    });
}

// 페이지 배경 업데이트
function updatePageBackground() {
    const page = document.getElementById('ingredients-page');
    page.className = `min-h-screen bg-gradient-to-br ${seasonConfig[currentSeason].bgGradient} transition-all duration-700`;
}

// 계절별 콘텐츠 업데이트
function updateSeasonalContent() {
    const config = seasonConfig[currentSeason];
    const tips = seasonTips[currentSeason];
    
    // 헤더 업데이트
    const seasonIcon = document.getElementById('season-icon');
    const seasonTitle = document.getElementById('season-title');
    
    if (seasonIcon) seasonIcon.textContent = config.icon;
    if (seasonTitle) {
        seasonTitle.textContent = `${config.name}철 식재료`;
        seasonTitle.className = `text-4xl bg-gradient-to-r ${config.titleGradient} bg-clip-text text-transparent font-black`;
    }
    
    // 팁 섹션 업데이트
    updateTipsSection(config, tips);
    
    // 빈 상태 업데이트
    const emptyIcon = document.getElementById('empty-icon');
    const emptySeasons = document.querySelectorAll('#empty-season, #empty-season-2');
    
    if (emptyIcon) emptyIcon.textContent = config.icon;
    emptySeasons.forEach(el => {
        if (el) el.textContent = config.name;
    });
}

// 팁 섹션 업데이트
function updateTipsSection(config, tips) {
    // 팁 카드 배경
    const tipsCard = document.getElementById('tips-card');
    if (tipsCard) {
        tipsCard.className = `bg-gradient-to-r ${config.bgGradient} border-white/30 backdrop-blur-sm rounded-lg border shadow-sm`;
    }
    
    // 팁 아이콘
    const tipsIcon = document.getElementById('tips-icon');
    if (tipsIcon) {
        tipsIcon.className = `p-3 rounded-full bg-gradient-to-r ${config.titleGradient} shadow-lg`;
        const iconSpan = tipsIcon.querySelector('span');
        if (iconSpan) iconSpan.textContent = config.icon;
    }
    
    // 팁 제목
    const tipsTitle = document.getElementById('tips-title');
    if (tipsTitle) {
        tipsTitle.textContent = `${config.name}철 식재료 가이드`;
        tipsTitle.className = `text-2xl font-black bg-gradient-to-r ${config.titleGradient} bg-clip-text text-transparent`;
    }
    
    // 개별 팁 업데이트
    updateTipCard('storage-tip', config, tips.storage);
    updateTipCard('cooking-tip', config, tips.cooking);
    updateTipCard('general-tip', config, tips.tip);
    
    // 특별 정보
    const specialSeason = document.getElementById('special-season');
    const specialInfo = document.getElementById('special-info');
    
    if (specialSeason) specialSeason.textContent = config.name;
    if (specialInfo) specialInfo.textContent = tips.special;
    
    // 특별 정보 제목 색상
    const specialTitle = specialSeason?.parentElement;
    if (specialTitle) {
        specialTitle.className = `font-bold ${config.textColor} mb-2 flex items-center`;
    }
}

// 개별 팁 카드 업데이트
function updateTipCard(cardId, config, content) {
    const card = document.getElementById(cardId);
    if (!card) return;
    
    card.className = `p-4 rounded-xl bg-white/50 border ${config.borderColor}`;
    
    const h4 = card.querySelector('h4');
    if (h4) {
        h4.className = `font-bold ${config.textColor} mb-3 flex items-center`;
    }
    
    const p = card.querySelector('p');
    if (p) {
        p.textContent = content;
    }
}

// 계절별 식재료 카드 필터링
function filterIngredientsBySeason(season) {
    const allCards = document.querySelectorAll('.ingredient-card');
    const emptyState = document.getElementById('empty-state');
    let visibleCount = 0;
    
    allCards.forEach((card, index) => {
        const cardSeason = getCardSeason(card);
        
        if (cardSeason === season) {
            card.style.display = 'block';
            // 등장 애니메이션을 위한 딜레이 설정
            card.style.animationDelay = `${index * 0.1}s`;
            visibleCount++;
        } else {
            card.style.display = 'none';
        }
    });
    
    // 카운트 배지 업데이트
    const countBadge = document.getElementById('ingredient-count');
    if (countBadge) {
        countBadge.textContent = `총 ${visibleCount}가지 식재료`;
        countBadge.className = `inline-block bg-gradient-to-r ${seasonConfig[season].titleGradient} text-white px-4 py-2 rounded-full text-sm font-medium`;
    }
    
    // 빈 상태 처리
    if (emptyState) {
        if (visibleCount === 0) {
            emptyState.classList.remove('hidden');
        } else {
            emptyState.classList.add('hidden');
        }
    }
}

// 카드에서 계절 정보 추출
function getCardSeason(card) {
    if (card.classList.contains('season-spring')) return 'spring';
    if (card.classList.contains('season-summer')) return 'summer';
    if (card.classList.contains('season-autumn')) return 'autumn';
    if (card.classList.contains('season-winter')) return 'winter';
    return 'spring'; // 기본값
}

// 카드 스타일 업데이트 (선택된 계절에 맞게)
function updateCardStyles(season) {
    const config = seasonConfig[season];
    const visibleCards = document.querySelectorAll(`.ingredient-card.season-${season}[style*="block"], .ingredient-card.season-${season}:not([style*="none"])`);
    
    visibleCards.forEach(card => {
        // 계절 배지 업데이트
        const seasonBadge = card.querySelector('.season-badge');
        if (seasonBadge) {
            seasonBadge.className = `season-badge bg-gradient-to-r ${config.titleGradient} text-white border-none shadow-lg px-2 py-1 rounded text-xs font-medium`;
        }
        
        // 제목 그라데이션 업데이트
        const title = card.querySelector('.ingredient-title');
        if (title) {
            title.className = `ingredient-title text-xl font-black bg-gradient-to-r ${config.titleGradient} bg-clip-text text-transparent`;
        }
        
        // 펄스 점 업데이트
        const pulseDot = card.querySelector('.pulse-dot');
        if (pulseDot) {
            pulseDot.className = `pulse-dot w-2 h-2 rounded-full bg-gradient-to-r ${config.titleGradient} animate-pulse`;
        }
        
        // 제철 기간 배경 및 아이콘 업데이트
        const seasonPeriod = card.querySelector('.season-period');
        if (seasonPeriod) {
            seasonPeriod.className = `season-period flex items-center space-x-2 p-2 rounded-lg bg-gradient-to-r ${config.bgGradient}`;
            const icon = seasonPeriod.querySelector('svg');
            if (icon) {
                icon.className = `h-4 w-4 ${config.iconColor}`;
            }
        }
        
        // 효능 제목 업데이트
        const benefitTitle = card.querySelector('.benefit-title');
        if (benefitTitle) {
            benefitTitle.className = `benefit-title text-sm font-bold ${config.textColor} mb-2`;
        }
        
        // 효능 배지들 업데이트
        const benefitBadges = card.querySelectorAll('.benefit-badge');
        benefitBadges.forEach(badge => {
            badge.className = `benefit-badge text-xs bg-gradient-to-r ${config.bgGradient} ${config.textColor} px-2 py-1 rounded border-none`;
        });
        
        // 추천 요리 제목 업데이트
        const recipeTitle = card.querySelector('.recipe-title');
        if (recipeTitle) {
            recipeTitle.className = `recipe-title text-sm font-bold ${config.textColor} mb-2 flex items-center`;
        }
        
        // 영양성분 섹션 업데이트
        const nutritionSection = card.querySelector('.nutrition-section');
        if (nutritionSection) {
            nutritionSection.className = `nutrition-section pt-3 border-t ${config.borderColor}`;
            const nutritionDot = nutritionSection.querySelector('div div');
            if (nutritionDot) {
                nutritionDot.className = `w-2 h-2 rounded-full bg-gradient-to-r ${config.titleGradient}`;
            }
            const nutritionText = nutritionSection.querySelector('.nutrition-text');
            if (nutritionText) {
                nutritionText.className = `nutrition-text text-xs ${config.iconColor} font-medium`;
            }
        }
        
        // 버튼 업데이트
        const button = card.querySelector('.recipe-button');
        if (button) {
            button.className = `recipe-button w-full mt-4 px-4 py-2 bg-gradient-to-r ${config.titleGradient} text-white rounded-lg transition-all duration-300 text-sm font-medium hover:shadow-lg hover:scale-105 active:scale-95`;
        }
    });
}

// 레시피 보기 버튼 클릭 (임시)
function viewRecipe(ingredientName) {
    alert(`${ingredientName} 레시피 보기\n준비중인 기능입니다!`);
}

// 스크롤 이벤트 리스너 (선택사항)
function setupScrollEffects() {
    let ticking = false;
    
    function updateScrollProgress() {
        const scrollTop = window.pageYOffset;
        const docHeight = document.documentElement.scrollHeight - window.innerHeight;
        const scrollPercent = scrollTop / docHeight;
        
        const indicator = document.querySelector('.scroll-indicator');
        if (indicator) {
            indicator.style.transform = `scaleX(${scrollPercent})`;
        }
        
        ticking = false;
    }
    
    function requestTick() {
        if (!ticking) {
            requestAnimationFrame(updateScrollProgress);
            ticking = true;
        }
    }
    
    window.addEventListener('scroll', requestTick);
}

// 페이지 언로드 시 정리
window.addEventListener('beforeunload', function() {
    // 필요한 정리 작업
});

// 접근성 개선
function setupAccessibility() {
    // 키보드 네비게이션
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Tab') {
            document.body.classList.add('user-is-tabbing');
        }
    });
    
    // 마우스 클릭 시 포커스 아웃라인 제거
    document.addEventListener('mousedown', function() {
        document.body.classList.remove('user-is-tabbing');
    });
}

// 초기화 완료 후 추가 설정
document.addEventListener('DOMContentLoaded', function() {
    setupScrollEffects();
    setupAccessibility();
});