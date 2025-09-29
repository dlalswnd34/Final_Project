// CheForest 통합검색 페이지 JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // 페이지 초기화
    initializeSearchPage();
});

// 페이지 초기화 함수
function initializeSearchPage() {
    // DOM 요소 참조
    const searchInput = document.getElementById('search-input');
    const searchBtn = document.getElementById('search-btn');
    const searchClear = document.getElementById('search-clear');
    const searchKeywords = document.getElementById('search-keywords');
    const searchResults = document.getElementById('search-results');

    // 검색 입력 이벤트 (구조만)
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const query = this.value.trim();

            // 검색어가 있으면 클리어 버튼 표시
            if (query) {
                searchClear.style.display = 'block';
                searchKeywords.style.display = 'none';
                searchResults.style.display = 'block';
                // 실제 검색 로직 호출
                performSearch(query);
            } else {
                searchClear.style.display = 'none';
                searchKeywords.style.display = 'block';
                searchResults.style.display = 'none';
            }

            console.log('검색어 입력:', query);
        });

        // 엔터키 검색
        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                const query = this.value.trim();
                if (query) {
                    performSearch(query);
                    console.log('엔터키 검색:', query);
                }
            }
        });
    }

    // 검색 버튼 이벤트 (구조만)
    if (searchBtn) {
        searchBtn.addEventListener('click', function() {
            const query = searchInput.value.trim();
            if (query) {
                performSearch(query);
                console.log('검색 버튼 클릭:', query);
            }
        });
    }

    // 검색어 지우기 버튼 이벤트 (구조만)
    if (searchClear) {
        searchClear.addEventListener('click', function() {
            clearSearch();
            console.log('검색어 지우기');
        });
    }

    // 인기/최근 검색어 클릭 이벤트 (구조만)
    document.addEventListener('click', function(e) {
        if (e.target.closest('.keyword-item')) {
            const keyword = e.target.closest('.keyword-item').dataset.keyword;
            setSearchQuery(keyword);
            console.log('키워드 클릭:', keyword);
        }
    });

    // 필터 변경 이벤트 (구조만)
    const categoryFilter = document.getElementById('category-filter');
    const sortFilter = document.getElementById('sort-filter');

    if (categoryFilter) {
        categoryFilter.addEventListener('change', function() {
            const category = this.value;
            applyFilters();
            console.log('카테고리 필터 변경:', category);
        });
    }

    if (sortFilter) {
        sortFilter.addEventListener('change', function() {
            const sort = this.value;
            applyFilters();
            console.log('정렬 필터 변경:', sort);
        });
    }

    // 탭 버튼 이벤트 (구조만)
    const tabButtons = document.querySelectorAll('.tab-button');
    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            const tab = this.dataset.tab;
            switchTab(tab);
            console.log('탭 전환:', tab);
        });
    });

    // 검색 결과 아이템 클릭 이벤트 (구조만)
    document.addEventListener('click', function(e) {
        if (e.target.closest('.result-item')) {
            const item = e.target.closest('.result-item');
            const type = item.dataset.type;
            const id = item.dataset.id;
            viewSearchResult(type, id);
            console.log('검색 결과 클릭:', type, id);
        }
    });

    // 태그 클릭 이벤트 (구조만)
    document.addEventListener('click', function(e) {
        if (e.target.closest('.tag-item')) {
            e.stopPropagation();
            const tag = e.target.closest('.tag-item').dataset.tag;
            setSearchQuery(tag);
            console.log('태그 클릭:', tag);
        }
    });

    // 더보기 버튼 이벤트 (구조만)
    const btnLoadMore = document.getElementById('btn-load-more');
    if (btnLoadMore) {
        btnLoadMore.addEventListener('click', function() {
            loadMoreResults();
            console.log('더보기 버튼 클릭');
        });
    }

    // 검색어 지우기 버튼 (결과 없음 화면) 이벤트 (구조만)
    const btnClearSearch = document.getElementById('btn-clear-search');
    if (btnClearSearch) {
        btnClearSearch.addEventListener('click', function() {
            clearSearch();
            console.log('검색어 지우기 (결과 없음)');
        });
    }

    console.log('통합검색 페이지 초기화 완료');
}

// 검색 실행 함수 (구조만)
function performSearch(query) {
    if (!query.trim()) return;

    // 로딩 상태 표시
    showLoadingState();

    // 검색어 표시 업데이트
    updateSearchQuery(query);

    // 실제 검색 API 호출 로직이 들어갈 자리
    console.log('검색 실행:', query);

    // 시뮬레이션을 위한 지연
    setTimeout(() => {
        hideLoadingState();
        // 검색 결과 업데이트 (실제로는 API 응답으로 처리)
        updateSearchResults([]);
    }, 1000);
}

// 검색어 설정 함수
function setSearchQuery(query) {
    const searchInput = document.getElementById('search-input');
    if (searchInput) {
        searchInput.value = query;

        // 검색 실행
        performSearch(query);

        // UI 상태 업데이트
        document.getElementById('search-clear').style.display = 'block';
        document.getElementById('search-keywords').style.display = 'none';
        document.getElementById('search-results').style.display = 'block';
    }
}

// 검색어 지우기 함수
function clearSearch() {
    const searchInput = document.getElementById('search-input');
    if (searchInput) {
        searchInput.value = '';

        // UI 상태 업데이트
        document.getElementById('search-clear').style.display = 'none';
        document.getElementById('search-keywords').style.display = 'block';
        document.getElementById('search-results').style.display = 'none';
    }
}

// 검색어 표시 업데이트 함수
function updateSearchQuery(query) {
    const searchQueryText = document.getElementById('search-query-text');
    if (searchQueryText) {
        searchQueryText.textContent = query;
    }
}

// 필터 적용 함수 (구조만)
function applyFilters() {
    const categoryFilter = document.getElementById('category-filter');
    const sortFilter = document.getElementById('sort-filter');

    const category = categoryFilter ? categoryFilter.value : 'all';
    const sort = sortFilter ? sortFilter.value : 'relevance';

    // 필터 적용 로직
    console.log('필터 적용:', { category, sort });

    // 검색 결과 재필터링 (실제로는 API 재호출)
    const currentQuery = document.getElementById('search-input').value.trim();
    if (currentQuery) {
        performSearch(currentQuery);
    }
}

// 탭 전환 함수 (구조만)
function switchTab(targetTab) {
    // 모든 탭 버튼 비활성화
    const tabButtons = document.querySelectorAll('.tab-button');
    tabButtons.forEach(button => {
        button.classList.remove('active');
    });

    // 선택된 탭 활성화
    const targetButton = document.querySelector(`[data-tab="${targetTab}"]`);
    if (targetButton) {
        targetButton.classList.add('active');
    }

    // 결과 필터링 (실제로는 데이터 필터링)
    console.log('탭 전환 완료:', targetTab);
}

// 검색 결과 보기 함수 (구조만)
function viewSearchResult(type, id) {
    // 검색 결과 상세 페이지로 이동 로직
    let targetPage = '';

    switch (type) {
        case 'recipe':
            targetPage = 'recipe-detail.jsp';
            break;
        case 'board':
            targetPage = 'board-detail.jsp';
            break;
        case 'qna':
            targetPage = 'qna-detail.jsp';
            break;
        default:
            console.log('알 수 없는 컨텐츠 타입:', type);
            return;
    }

    console.log('상세 페이지 이동:', targetPage, id);
    // window.location.href = `${targetPage}?id=${id}`;
}

// 더 많은 결과 로드 함수 (구조만)
function loadMoreResults() {
    // 로딩 상태 표시
    showLoadingState();

    // 추가 결과 로드 API 호출 로직
    console.log('추가 결과 로드');

    setTimeout(() => {
        hideLoadingState();
        // 결과 목록에 추가
        console.log('추가 결과 로드 완료');
    }, 1000);
}

// 로딩 상태 표시 함수
function showLoadingState() {
    const loadingState = document.getElementById('loading-state');
    const noResults = document.getElementById('no-results');
    const resultsGrid = document.getElementById('results-grid');
    const loadMoreContainer = document.getElementById('load-more-container');

    if (loadingState) {
        loadingState.style.display = 'block';
    }

    if (noResults) {
        noResults.style.display = 'none';
    }

    if (resultsGrid) {
        resultsGrid.style.display = 'none';
    }

    if (loadMoreContainer) {
        loadMoreContainer.style.display = 'none';
    }
}

// 로딩 상태 숨김 함수
function hideLoadingState() {
    const loadingState = document.getElementById('loading-state');
    if (loadingState) {
        loadingState.style.display = 'none';
    }
}

// 검색 결과 업데이트 함수 (구조만)
function updateSearchResults(results) {
    const noResults = document.getElementById('no-results');
    const resultsGrid = document.getElementById('results-grid');
    const loadMoreContainer = document.getElementById('load-more-container');
    const resultCount = document.getElementById('result-count');

    // 결과 개수 업데이트
    if (resultCount) {
        resultCount.textContent = results.length;
    }

    // 탭별 개수 업데이트
    updateTabCounts(results);

    if (results.length === 0) {
        // 결과 없음 상태 표시
        if (noResults) {
            noResults.style.display = 'block';
        }
        if (resultsGrid) {
            resultsGrid.style.display = 'none';
        }
        if (loadMoreContainer) {
            loadMoreContainer.style.display = 'none';
        }
    } else {
        // 결과 표시
        if (noResults) {
            noResults.style.display = 'none';
        }
        if (resultsGrid) {
            resultsGrid.style.display = 'grid';
            // 실제로는 여기서 결과 아이템들을 동적 생성
        }
        if (loadMoreContainer) {
            loadMoreContainer.style.display = 'block';
        }
    }

    console.log('검색 결과 업데이트:', results.length);
}

// 탭별 개수 업데이트 함수 (구조만)
function updateTabCounts(results) {
    const tabButtons = document.querySelectorAll('.tab-button');

    // 실제로는 results 배열을 분석해서 각 타입별 개수 계산
    const counts = {
        all: results.length,
        recipe: 0,
        board: 0,
        qna: 0
    };

    // 타입별 개수 계산 (실제 데이터가 있을 때)
    results.forEach(result => {
        if (result.type && counts.hasOwnProperty(result.type)) {
            counts[result.type]++;
        }
    });

    // 탭 버튼 개수 업데이트
    tabButtons.forEach(button => {
        const tab = button.dataset.tab;
        const countElement = button.querySelector('.tab-count');
        if (countElement && counts.hasOwnProperty(tab)) {
            countElement.textContent = counts[tab];
        }
    });
}

// 검색 히스토리 관리 함수들 (구조만)

// 최근 검색어 추가
function addToRecentSearches(query) {
    // 로컬 스토리지에 최근 검색어 저장 로직
    console.log('최근 검색어 추가:', query);
}

// 최근 검색어 가져오기
function getRecentSearches() {
    // 로컬 스토리지에서 최근 검색어 가져오기 로직
    return [];
}

// 검색어 자동완성 함수 (구조만)
function setupSearchAutocomplete() {
    const searchInput = document.getElementById('search-input');

    if (searchInput) {
        // 자동완성 로직 구현 자리
        console.log('자동완성 설정 완료');
    }
}

// 검색 결과 하이라이팅 함수
function highlightSearchTerms(text, searchQuery) {
    if (!searchQuery || !text) return text;

    const regex = new RegExp(`(${searchQuery})`, 'gi');
    return text.replace(regex, '<mark class="search-highlight">$1</mark>');
}

// 검색 통계 기록 함수 (구조만)
function recordSearchStatistics(query, resultCount) {
    // 검색 통계 기록 로직
    console.log('검색 통계 기록:', { query, resultCount });
}

// 검색 결과 정렬 함수 (구조만)
function sortSearchResults(results, sortBy) {
    // 정렬 로직 구현
    switch (sortBy) {
        case 'relevance':
            // 관련도순 정렬
            break;
        case 'latest':
            // 최신순 정렬
            break;
        case 'popular':
            // 인기순 정렬
            break;
        default:
            break;
    }

    return results;
}

// 검색 필터 함수 (구조만)
function filterSearchResults(results, filters) {
    // 필터 적용 로직
    const { category, type } = filters;

    return results.filter(result => {
        if (category && category !== 'all' && result.category !== category) {
            return false;
        }

        if (type && type !== 'all' && result.type !== type) {
            return false;
        }

        return true;
    });
}

// URL 파라미터 처리 함수
function handleUrlParameters() {
    const urlParams = new URLSearchParams(window.location.search);
    const query = urlParams.get('q');
    const category = urlParams.get('category');

    if (query) {
        setSearchQuery(query);
    }

    if (category) {
        const categoryFilter = document.getElementById('category-filter');
        if (categoryFilter) {
            categoryFilter.value = category;
        }
    }
}

// 페이지 로드 시 URL 파라미터 확인
window.addEventListener('load', function() {
    handleUrlParameters();
});

// 브라우저 뒤로가기/앞으로가기 처리
window.addEventListener('popstate', function() {
    handleUrlParameters();
});

// 키보드 단축키 지원
document.addEventListener('keydown', function(e) {
    // Ctrl/Cmd + K로 검색창 포커스
    if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
        e.preventDefault();
        const searchInput = document.getElementById('search-input');
        if (searchInput) {
            searchInput.focus();
        }
    }

    // ESC로 검색 지우기
    if (e.key === 'Escape') {
        const searchInput = document.getElementById('search-input');
        if (searchInput && document.activeElement === searchInput) {
            clearSearch();
        }
    }
});

// 페이지 언로드 시 정리
window.addEventListener('beforeunload', function() {
    // 필요한 정리 작업
    console.log('통합검색 페이지 언로드');
});