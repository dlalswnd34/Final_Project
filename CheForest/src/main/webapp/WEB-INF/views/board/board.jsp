<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/board.css">
</head>
<body>
    <!-- CheForest 사용자 레시피 게시판 페이지 -->
    <div class="min-h-screen bg-white">
        <!-- 페이지 헤더 -->
        <section class="bg-gradient-to-r from-pink-500 to-orange-500 text-white py-16">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                <div class="flex items-center justify-center mb-4">
                    <i data-lucide="chef-hat" class="h-8 w-8 mr-3"></i>
                    <h1 class="text-4xl">CheForest 레시피 커뮤니티</h1>
                </div>
                <p class="text-xl opacity-90 mb-8">
                    요리 애호가들이 직접 올린 특별한 레시피들을 만나보세요
                </p>
                <div class="flex items-center justify-center space-x-8 text-sm">
                    <div class="flex items-center">
                        <i data-lucide="book-open" class="h-5 w-5 mr-2"></i>
                        <span id="totalRecipeCount">6개의 레시피</span>
                    </div>
                    <div class="flex items-center">
                        <i data-lucide="user" class="h-5 w-5 mr-2"></i>
                        <span>커뮤니티 멤버들의 창작</span>
                    </div>
                </div>
            </div>
        </section>

        <!-- 검색 및 필터 섹션 -->
        <section class="py-8 border-b border-gray-200 bg-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col md:flex-row gap-4 items-center justify-between">
                    <!-- 검색바 -->
                    <div class="relative flex-1 max-w-md">
                        <i data-lucide="search" class="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500 h-4 w-4"></i>
                        <input
                            type="text"
                            id="boardSearchInput"
                            placeholder="레시피, 재료로 검색..."
                            class="board-search-input pl-10 pr-4 py-2 w-full border border-gray-300 rounded-lg bg-white focus:border-orange-500 focus:outline-none"
                        />
                    </div>

                    <!-- 필터 컨트롤 -->
                    <div class="flex items-center space-x-4">
                        <button class="xl:hidden bg-gray-100 hover:bg-gray-200 text-gray-700 px-3 py-2 rounded-lg text-sm">
                            <i data-lucide="filter" class="h-4 w-4 mr-2 inline"></i>
                            필터
                        </button>
                        
                        <select id="boardCategorySelect" class="border border-gray-300 rounded-lg px-3 py-2 text-sm bg-white">
                            <!-- 카테고리 옵션들이 JavaScript로 동적 생성됩니다 -->
                        </select>

                        <select id="boardSortSelect" class="border border-gray-300 rounded-lg px-3 py-2 text-sm bg-white">
                            <option value="popularity">인기순</option>
                            <option value="rating">평점순</option>
                            <option value="newest">최신순</option>
                            <option value="views">조회수순</option>
                        </select>
                    </div>
                </div>
            </div>
        </section>

        <!-- 카테고리 네비게이션 -->
        <section class="py-6 border-b border-gray-200">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="flex items-center">
                        <i data-lucide="filter" class="h-5 w-5 mr-2 text-orange-500"></i>
                        카테고리
                    </h3>
                </div>
                
                <!-- 카테고리 버튼들 -->
                <div class="flex flex-wrap gap-3" id="boardCategoryButtons">
                    <!-- 카테고리 버튼들이 JavaScript로 동적 생성됩니다 -->
                </div>
            </div>
        </section>

        <!-- 레시피 목록 -->
        <section class="py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex gap-6">
                    <!-- 좌측 프로필 사이드바 -->
                    <div class="w-64 hidden xl:block">
                        <div class="sticky top-8 space-y-6">
                            <!-- 내 프로필 -->
                            <div class="border-orange-200 bg-gradient-to-br from-orange-50 to-pink-50 border rounded-lg p-6">
                                <div class="flex flex-col items-center text-center space-y-3 pb-3">
                                    <div class="w-16 h-16 bg-gradient-to-r from-pink-500 to-orange-500 rounded-full flex items-center justify-center text-white text-lg">
                                        김요
                                    </div>
                                    <div>
                                        <h3 class="text-orange-800">김요리사</h3>
                                        <div class="flex items-center justify-center space-x-1">
                                            <span class="text-sm">🌿</span>
                                            <p class="text-xs text-orange-600">뿌리 등급</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="space-y-3">
                                    <div class="grid grid-cols-2 gap-3 text-center">
                                        <div>
                                            <div class="text-orange-700">12</div>
                                            <div class="text-xs text-orange-600">레시피</div>
                                        </div>
                                        <div>
                                            <div class="text-orange-700">89</div>
                                            <div class="text-xs text-orange-600">좋아요</div>
                                        </div>
                                    </div>
                                    <div class="pt-2 border-t border-orange-200 space-y-2">
                                        <!-- 나의 Q&A 버튼 -->
                                        <button class="w-full flex items-center justify-center px-3 py-2 bg-white border border-orange-200 hover:bg-orange-50 hover:border-orange-300 transition-all rounded-lg group">
                                            <i data-lucide="help-circle" class="h-4 w-4 text-orange-500 group-hover:text-orange-600 mr-2"></i>
                                            <span class="text-sm text-orange-600 group-hover:text-orange-700">나의 Q&A</span>
                                        </button>
                                        <!-- 마이페이지 버튼 -->
                                        <button class="w-full flex items-center justify-center px-3 py-2 bg-white border border-orange-200 hover:bg-orange-50 hover:border-orange-300 transition-all rounded-lg group" onclick="showPage('mypage')">
                                            <i data-lucide="user" class="h-4 w-4 text-orange-500 group-hover:text-orange-600 mr-2"></i>
                                            <span class="text-sm text-orange-600 group-hover:text-orange-700">마이페이지</span>
                                        </button>
                                        <!-- 로그아웃 버튼 -->
                                        <button class="w-full flex items-center justify-center px-3 py-2 bg-white border border-orange-200 hover:bg-orange-50 hover:border-orange-300 transition-all rounded-lg group">
                                            <i data-lucide="log-out" class="h-4 w-4 text-orange-500 group-hover:text-orange-600 mr-2"></i>
                                            <span class="text-sm text-orange-600 group-hover:text-orange-700">로그아웃</span>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- 나의 활동 -->
                            <div class="bg-white border border-gray-200 rounded-lg">
                                <div class="p-4 border-b border-gray-200">
                                    <h3 class="flex items-center">
                                        <i data-lucide="book-open" class="h-5 w-5 mr-2 text-orange-500"></i>
                                        나의 활동
                                    </h3>
                                </div>
                                <div class="p-4 space-y-3">
                                    <div class="flex justify-between items-center">
                                        <span class="text-sm text-gray-500">작성한 레시피</span>
                                        <span class="text-orange-600">12개</span>
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-sm text-gray-500">받은 좋아요</span>
                                        <span class="text-orange-600">89개</span>
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-sm text-gray-500">작성한 댓글 수</span>
                                        <span class="text-orange-600">156개</span>
                                    </div>
                                </div>
                            </div>

                            <!-- 커뮤니티 통계 -->
                            <div class="bg-white border border-gray-200 rounded-lg">
                                <div class="p-4 border-b border-gray-200">
                                    <h3 class="flex items-center">
                                        <i data-lucide="trending-up" class="h-5 w-5 mr-2 text-orange-500"></i>
                                        커뮤니티 통계
                                    </h3>
                                </div>
                                <div class="p-4 space-y-3">
                                    <div class="flex justify-between items-center">
                                        <span class="text-sm text-gray-500">총 레시피</span>
                                        <span class="text-orange-600" id="sidebarTotalRecipes">6개</span>
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-sm text-gray-500">활성 사용자</span>
                                        <span class="text-orange-600">247명</span>
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-sm text-gray-500">오늘 등록</span>
                                        <span class="text-orange-600">12개</span>
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-sm text-gray-500">이번 주</span>
                                        <span class="text-orange-600">84개</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 메인 레시피 콘텐츠 -->
                    <div class="flex-1">
                        <!-- 게시판 공지사항 -->
                        <div class="mb-8 border-orange-200 bg-gradient-to-r from-orange-50 to-pink-50 border rounded-lg">
                            <div class="p-4 pb-3 border-b border-orange-200">
                                <div class="flex items-center justify-between">
                                    <h3 class="flex items-center text-orange-700">
                                        <i data-lucide="pin" class="h-5 w-5 mr-2"></i>
                                        게시판 공지사항
                                    </h3>
                                    <span class="bg-orange-500 text-white text-xs px-2 py-1 rounded">공지</span>
                                </div>
                            </div>
                            <div class="p-4">
                                <div class="space-y-4">
                                    <div class="border-l-4 border-orange-400 pl-4">
                                        <h4 class="text-orange-800 mb-2">🎉 CheForest 레시피 커뮤니티 오픈!</h4>
                                        <p class="text-sm text-orange-700 mb-2">
                                            요리 애호가들의 특별한 레시피를 공유하고 발견하는 공간이 새롭게 열렸습니다! 
                                            나만의 레시피를 업로드하고 다른 요리사들과 소통해보세요.
                                        </p>
                                        <span class="text-xs text-orange-600">2024.01.15 | CheForest 관리자</span>
                                    </div>
                                    
                                    <div class="border-l-4 border-blue-400 pl-4">
                                        <h4 class="text-blue-800 mb-2">📝 레시피 작성 가이드라인</h4>
                                        <p class="text-sm text-blue-700 mb-2">
                                            더 나은 커뮤니티를 위해 레시피 작성 시 재료, 조리과정, 팁을 상세히 적어주세요. 
                                            고품질 레시피는 추천 레시피로 선정됩니다!
                                        </p>
                                        <span class="text-xs text-blue-600">2024.01.12 | CheForest 관리자</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="flex items-center justify-between mb-6">
                            <div>
                                <h2 class="text-xl" id="boardCategoryTitle">전체 레시피</h2>
                                <p class="text-gray-500 mt-1" id="boardRecipeCount">
                                    <!-- 레시피 개수가 JavaScript로 동적 업데이트됩니다 -->
                                </p>
                            </div>
                            <div class="flex items-center space-x-3">
                                <button class="xl:hidden bg-blue-500 hover:bg-blue-600 text-white px-3 py-2 rounded-lg text-sm">
                                    <i data-lucide="message-circle" class="h-4 w-4 mr-2 inline"></i>
                                    채팅
                                </button>
                                <button onclick="showPage('recipe-create')" class="btn-orange text-white px-4 py-2 rounded-lg">
                                    <i data-lucide="chef-hat" class="h-4 w-4 mr-2 inline"></i>
                                    레시피 작성하기
                                </button>
                            </div>
                        </div>

                        <!-- 인기 게시글 섹션 -->
                        <div class="mb-12" id="boardPopularSection" style="display: none;">
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="text-xl flex items-center">
                                    <i data-lucide="trending-up" class="w-6 h-6 mr-3 text-red-500"></i>
                                    인기 레시피
                                    <span class="ml-2 px-3 py-1 bg-red-100 text-red-700 text-sm rounded-full" id="boardPopularCount">
                                        <!-- 인기 레시피 개수 -->
                                    </span>
                                </h3>
                                <div class="text-sm text-gray-500">
                                    ❤️ 가장 많은 좋아요를 받은 레시피
                                </div>
                            </div>
                            
                            <div class="grid grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-4" id="boardPopularGrid">
                                <!-- 인기 레시피 카드 1: 우리집 비빔밥 -->
                                <div class="board-popular-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg cursor-pointer" 
                                    data-category="korean" data-likes="456" data-rating="4.7" data-views="8234" data-created="2024-01-15"
                                    data-title="우리집 비빔밥 레시피" data-description="엄마가 해주시던 정성 가득한 비빔밥"
                                    onclick="showPage('recipe-detail')">
                                    <div class="relative">
                                        <!-- 인기 순위 배지 - 이미지 위 왼쪽 상단 -->
                                        <div class="absolute top-2 left-2 z-10">
                                            <div class="board-rank-badge w-6 h-6 text-white rounded-full flex items-center justify-center text-xs">
                                                1
                                            </div>
                                        </div>
                                        
                                        <img src="https://images.unsplash.com/photo-1718777791262-c66d11baaa3b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxrb3JlYW4lMjBmb29kJTIwYmliaW1iYXAlMjByaWNlJTIwYm93bHxlbnwxfHx8fDE3NTc1ODAwMDZ8MA&ixlib=rb-4.1.0&q=80&w=1080"
                                            alt="우리집 비빔밥 레시피"
                                            class="board-card-image w-full h-48 object-cover"
                                            onerror="this.src='https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400'" />
                                        
                                        <!-- 상태 배지들 - 이미지 위 오른쪽 상단 -->
                                        <div class="absolute top-2 right-2 flex flex-col space-y-1">
                                            <span class="bg-white/90 backdrop-blur-sm text-gray-800 text-xs px-2 py-1 rounded shadow-sm">
                                                한식
                                            </span>
                                            <span class="bg-red-500/90 backdrop-blur-sm text-white text-xs px-2 py-1 rounded shadow-sm">HOT</span>
                                        </div>
                                    </div>
                                    
                                    <div class="p-4">
                                        <h4 class="board-card-title mb-2 transition-colors line-clamp-1">
                                            우리집 비빔밥 레시피
                                        </h4>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">
                                            엄마가 해주시던 정성 가득한 비빔밥, 나물 하나하나 정성스럽게 무쳐보세요!
                                        </p>
                                        
                                        <!-- 작성자 정보 -->
                                        <div class="author-info mb-3">
                                            <div class="author-avatar">홈쿡</div>
                                            <div class="flex-1">
                                                <div class="text-sm">홈쿡마미</div>
                                                <div class="flex items-center space-x-1">
                                                    <span class="text-xs">🌳</span>
                                                    <span class="level-badge tree">나무</span>
                                                </div>
                                            </div>
                                            <div class="time-ago text-xs">
                                                9일 전
                                            </div>
                                        </div>

                                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                            <div class="flex items-center space-x-3 text-sm">
                                                <div class="board-stat-item flex items-center space-x-1 text-gray-500">
                                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                                    <span>8.2k</span>
                                                </div>
                                                <div class="board-stat-item flex items-center space-x-1 text-red-500">
                                                    <i data-lucide="heart" class="h-4 w-4 heart-like"></i>
                                                    <span>456</span>
                                                </div>
                                            </div>
                                            <div class="text-xs text-gray-500">
                                                <span class="difficulty-badge normal">보통</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- 인기 레시피 카드 2: 집에서 만드는 라멘 -->
                                <div class="board-popular-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg cursor-pointer" 
                                    data-category="japanese" data-likes="789" data-rating="4.8" data-views="12456" data-created="2024-01-10"
                                    data-title="집에서 만드는 라멘" data-description="진한 돈코츠 육수부터 토핑까지"
                                    onclick="showPage('recipe-detail')">
                                    <div class="relative">
                                        <!-- 인기 순위 배지 - 이미지 위 왼쪽 상단 -->
                                        <div class="absolute top-2 left-2 z-10">
                                            <div class="board-rank-badge w-6 h-6 text-white rounded-full flex items-center justify-center text-xs">
                                                2
                                            </div>
                                        </div>
                                        
                                        <img src="https://images.unsplash.com/photo-1637024698421-533d83c7b883?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxyYW1lbiUyMG5vb2RsZSUyMHNvdXAlMjBqYXBhbmVzZXxlbnwxfHx8fDE3NTc1ODAwMjd8MA&ixlib=rb-4.1.0&q=80&w=1080"
                                            alt="집에서 만드는 라멘"
                                            class="board-card-image w-full h-48 object-cover"
                                            onerror="this.src='https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400'" />
                                        
                                        <!-- 상태 배지들 - 이미지 위 오른쪽 상단 -->
                                        <div class="absolute top-2 right-2 flex flex-col space-y-1">
                                            <span class="bg-white/90 backdrop-blur-sm text-gray-800 text-xs px-2 py-1 rounded shadow-sm">
                                                일식
                                            </span>
                                            <span class="bg-red-500/90 backdrop-blur-sm text-white text-xs px-2 py-1 rounded shadow-sm">HOT</span>
                                        </div>
                                    </div>
                                    
                                    <div class="p-4">
                                        <h4 class="board-card-title mb-2 transition-colors line-clamp-1">
                                            집에서 만드는 라멘
                                        </h4>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">
                                            진한 돈코츠 육수부터 토핑까지, 집에서도 맛집 라멘을 만들 수 있어요!
                                        </p>
                                        
                                        <!-- 작성자 정보 -->
                                        <div class="author-info mb-3">
                                            <div class="author-avatar">라멘</div>
                                            <div class="flex-1">
                                                <div class="text-sm">라멘마니아</div>
                                                <div class="flex items-center space-x-1">
                                                    <span class="text-xs">🌳</span>
                                                    <span class="level-badge tree">나무</span>
                                                </div>
                                            </div>
                                            <div class="time-ago text-xs">
                                                2주 전
                                            </div>
                                        </div>

                                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                            <div class="flex items-center space-x-3 text-sm">
                                                <div class="board-stat-item flex items-center space-x-1 text-gray-500">
                                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                                    <span>12.5k</span>
                                                </div>
                                                <div class="board-stat-item flex items-center space-x-1 text-red-500">
                                                    <i data-lucide="heart" class="h-4 w-4 heart-like"></i>
                                                    <span>789</span>
                                                </div>
                                            </div>
                                            <div class="text-xs text-gray-500">
                                                <span class="difficulty-badge hard">어려움</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- 인기 레시피 카드 3: 홈메이드 피자 -->
                                <div class="board-popular-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg cursor-pointer" 
                                    data-category="western" data-likes="543" data-rating="4.6" data-views="9876" data-created="2024-01-08"
                                    data-title="홈메이드 피자 만들기" data-description="도우부터 직접 만드는 정통 이탈리안 피자"
                                    onclick="showPage('recipe-detail')">
                                    <div class="relative">
                                        <!-- 인기 순위 배지 - 이미지 위 왼쪽 상단 -->
                                        <div class="absolute top-2 left-2 z-10">
                                            <div class="board-rank-badge w-6 h-6 text-white rounded-full flex items-center justify-center text-xs">
                                                3
                                            </div>
                                        </div>
                                        
                                        <img src="https://images.unsplash.com/photo-1596458397260-255807e979f1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxob21lbWFkZSUyMHBpenphJTIwaXRhbGlhbiUyMGZvb2R8ZW58MXx8fHwxNzU3NTgwMDMzfDA&ixlib=rb-4.1.0&q=80&w=1080"
                                            alt="홈메이드 피자 만들기"
                                            class="board-card-image w-full h-48 object-cover"
                                            onerror="this.src='https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400'" />
                                        
                                        <!-- 상태 배지들 - 이미지 위 오른쪽 상단 -->
                                        <div class="absolute top-2 right-2 flex flex-col space-y-1">
                                            <span class="bg-white/90 backdrop-blur-sm text-gray-800 text-xs px-2 py-1 rounded shadow-sm">
                                                양식
                                            </span>
                                        </div>
                                    </div>
                                    
                                    <div class="p-4">
                                        <h4 class="board-card-title mb-2 transition-colors line-clamp-1">
                                            홈메이드 피자 만들기
                                        </h4>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">
                                            도우부터 직접 만드는 정통 이탈리안 피자! 오븐 없이도 만들 수 있어요
                                        </p>
                                        
                                        <!-- 작성자 정보 -->
                                        <div class="author-info mb-3">
                                            <div class="author-avatar">피자</div>
                                            <div class="flex-1">
                                                <div class="text-sm">피자장인</div>
                                                <div class="flex items-center space-x-1">
                                                    <span class="text-xs">🌲</span>
                                                    <span class="level-badge forest">숲</span>
                                                </div>
                                            </div>
                                            <div class="time-ago text-xs">
                                                2주 전
                                            </div>
                                        </div>

                                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                            <div class="flex items-center space-x-3 text-sm">
                                                <div class="board-stat-item flex items-center space-x-1 text-gray-500">
                                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                                    <span>9.9k</span>
                                                </div>
                                                <div class="board-stat-item flex items-center space-x-1 text-red-500">
                                                    <i data-lucide="heart" class="h-4 w-4 heart-like"></i>
                                                    <span>543</span>
                                                </div>
                                            </div>
                                            <div class="text-xs text-gray-500">
                                                <span class="difficulty-badge normal">보통</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 일반 게시글 섹션 -->
                        <div>
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="text-xl flex items-center">
                                    <i data-lucide="book-open" class="w-6 h-6 mr-3 text-purple-500"></i>
                                    CheForest 회원들의 다양한 창작 레시피
                                    <span class="ml-2 px-3 py-1 bg-purple-100 text-purple-700 text-sm rounded-full" id="boardRegularCount">
                                        <!-- 일반 레시피 개수 -->
                                    </span>
                                </h3>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6" id="boardRegularGrid">
                                <!-- 일반 레시피 카드 1: 매콤한 김치 볶음밥 -->
                                <div class="board-recipe-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg cursor-pointer" 
                                    data-category="korean" data-likes="298" data-rating="4.5" data-views="5432" data-created="2024-01-12"
                                    data-title="매콤한 김치 볶음밥" data-description="김치가 시어질 때 만드는 최고의 요리"
                                    onclick="showPage('recipe-detail')">
                                    <div class="relative">
                                        <img src="https://images.unsplash.com/photo-1708388466726-54ff913ad930?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxrb3JlYW4lMjBidWxnb2dpJTIwYmVlZiUyMGdyaWxsfGVufDF8fHx8MTc1NzU4MDA0Mnww&ixlib=rb-4.1.0&q=80&w=1080"
                                            alt="매콤한 김치 볶음밥"
                                            class="board-card-image w-full h-48 object-cover"
                                            onerror="this.src='https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400'" />
                                        
                                        <!-- 상태 배지들 - 이미지 위 오른쪽 상단 -->
                                        <div class="absolute top-2 right-2 flex flex-col space-y-1">
                                            <span class="bg-white/90 backdrop-blur-sm text-gray-800 text-xs px-2 py-1 rounded shadow-sm">
                                                한식
                                            </span>
                                            <span class="bg-red-500/90 backdrop-blur-sm text-white text-xs px-2 py-1 rounded shadow-sm">HOT</span>
                                        </div>
                                    </div>
                                    
                                    <div class="p-4">
                                        <h4 class="board-card-title mb-2 transition-colors line-clamp-1">
                                            매콤한 김치 볶음밥
                                        </h4>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">
                                            김치가 시어질 때 만드는 최고의 요리! 스팸과 함께 볶으면 더욱 맛있어요
                                        </p>
                                        
                                        <!-- 작성자 정보 -->
                                        <div class="author-info mb-3">
                                            <div class="author-avatar">김치</div>
                                            <div class="flex-1">
                                                <div class="text-sm">김치러버</div>
                                                <div class="flex items-center space-x-1">
                                                    <span class="text-xs">🌱</span>
                                                    <span class="level-badge sprout">새싹</span>
                                                </div>
                                            </div>
                                            <div class="time-ago text-xs">
                                                1주 전
                                            </div>
                                        </div>

                                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                            <div class="flex items-center space-x-3 text-sm">
                                                <div class="board-stat-item flex items-center space-x-1 text-gray-500">
                                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                                    <span>5.4k</span>
                                                </div>
                                                <div class="board-stat-item flex items-center space-x-1 text-red-500">
                                                    <i data-lucide="heart" class="h-4 w-4 heart-like"></i>
                                                    <span>298</span>
                                                </div>
                                            </div>
                                            <div class="text-xs text-gray-500">
                                                <span class="difficulty-badge easy">쉬움</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- 일반 레시피 카드 2: 중국식 볶음밥 -->
                                <div class="board-recipe-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg cursor-pointer" 
                                    data-category="chinese" data-likes="387" data-rating="4.4" data-views="6789" data-created="2024-01-05"
                                    data-title="중국식 볶음밥 레시피" data-description="중국집에서 먹던 그 맛! 웍헤이가 살아있는 볶음밥"
                                    onclick="showPage('recipe-detail')">
                                    <div class="relative">
                                        <img src="https://images.unsplash.com/photo-1723691802798-fa6efc67b2c9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjaGluZXNlJTIwZnJpZWQlMjByaWNlJTIwd29rfGVufDF8fHx8MTc1NzU4MDAzNnww&ixlib=rb-4.1.0&q=80&w=1080"
                                            alt="중국식 볶음밥 레시피"
                                            class="board-card-image w-full h-48 object-cover"
                                            onerror="this.src='https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400'" />
                                        
                                        <!-- 상태 배지들 - 이미지 위 오른쪽 상단 -->
                                        <div class="absolute top-2 right-2 flex flex-col space-y-1">
                                            <span class="bg-white/90 backdrop-blur-sm text-gray-800 text-xs px-2 py-1 rounded shadow-sm">
                                                중식
                                            </span>
                                        </div>
                                    </div>
                                    
                                    <div class="p-4">
                                        <h4 class="board-card-title mb-2 transition-colors line-clamp-1">
                                            중국식 볶음밥 레시피
                                        </h4>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">
                                            중국집에서 먹던 그 맛! 웍헤이가 살아있는 볶음밥 만드는 비법
                                        </p>
                                        
                                        <!-- 작성자 정보 -->
                                        <div class="author-info mb-3">
                                            <div class="author-avatar">중화</div>
                                            <div class="flex-1">
                                                <div class="text-sm">중화요리사</div>
                                                <div class="flex items-center space-x-1">
                                                    <span class="text-xs">🌿</span>
                                                    <span class="level-badge root">뿌리</span>
                                                </div>
                                            </div>
                                            <div class="time-ago text-xs">
                                                3주 전
                                            </div>
                                        </div>

                                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                            <div class="flex items-center space-x-3 text-sm">
                                                <div class="board-stat-item flex items-center space-x-1 text-gray-500">
                                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                                    <span>6.8k</span>
                                                </div>
                                                <div class="board-stat-item flex items-center space-x-1 text-red-500">
                                                    <i data-lucide="heart" class="h-4 w-4 heart-like"></i>
                                                    <span>387</span>
                                                </div>
                                            </div>
                                            <div class="text-xs text-gray-500">
                                                <span class="difficulty-badge easy">쉬움</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- 일반 레시피 카드 3: 촉촉한 홈베이킹 케이크 -->
                                <div class="board-recipe-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg cursor-pointer" 
                                    data-category="dessert" data-likes="234" data-rating="4.3" data-views="4321" data-created="2024-01-03"
                                    data-title="촉촉한 홈베이킹 케이크" data-description="베이킹 초보도 실패 없이! 버터크림과 딸기로 예쁘게"
                                    onclick="showPage('recipe-detail')">
                                    <div class="relative">
                                        <img src="https://images.unsplash.com/photo-1613323885553-4b069992362d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxob21lbWFkZSUyMGNha2UlMjBkZXNzZXJ0JTIwYmFraW5nfGVufDF8fHx8MTc1NzU4MDA0MHww&ixlib=rb-4.1.0&q=80&w=1080"
                                            alt="촉촉한 홈베이킹 케이크"
                                            class="board-card-image w-full h-48 object-cover"
                                            onerror="this.src='https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400'" />
                                        
                                        <!-- 상태 배지들 - 이미지 위 오른쪽 상단 -->
                                        <div class="absolute top-2 right-2 flex flex-col space-y-1">
                                            <span class="bg-white/90 backdrop-blur-sm text-gray-800 text-xs px-2 py-1 rounded shadow-sm">
                                                디저트
                                            </span>
                                        </div>
                                    </div>
                                    
                                    <div class="p-4">
                                        <h4 class="board-card-title mb-2 transition-colors line-clamp-1">
                                            촉촉한 홈베이킹 케이크
                                        </h4>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">
                                            베이킹 초보도 실패 없이! 버터크림과 딸기로 예쁘게 데코레이션해보세요
                                        </p>
                                        
                                        <!-- 작성자 정보 -->
                                        <div class="author-info mb-3">
                                            <div class="author-avatar">베이</div>
                                            <div class="flex-1">
                                                <div class="text-sm">베이킹러버</div>
                                                <div class="flex items-center space-x-1">
                                                    <span class="text-xs">🌱</span>
                                                    <span class="level-badge seed">씨앗</span>
                                                </div>
                                            </div>
                                            <div class="time-ago text-xs">
                                                1개월 전
                                            </div>
                                        </div>

                                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                            <div class="flex items-center space-x-3 text-sm">
                                                <div class="board-stat-item flex items-center space-x-1 text-gray-500">
                                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                                    <span>4.3k</span>
                                                </div>
                                                <div class="board-stat-item flex items-center space-x-1 text-red-500">
                                                    <i data-lucide="heart" class="h-4 w-4 heart-like"></i>
                                                    <span>234</span>
                                                </div>
                                            </div>
                                            <div class="text-xs text-gray-500">
                                                <span class="difficulty-badge normal">보통</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 더보기 버튼 -->
                        <div class="text-center mt-12" id="boardLoadMoreSection" style="display: none;">
                            <button class="btn-orange text-white px-8 py-3 rounded-lg">
                                더 많은 레시피 보기
                            </button>
                        </div>

                        <!-- 검색 결과 없음 -->
                        <div class="text-center py-12" id="boardNoResultsSection" style="display: none;">
                            <i data-lucide="chef-hat" class="h-16 w-16 text-gray-400 mx-auto mb-4"></i>
                            <h3 class="text-xl mb-2">검색 결과가 없습니다</h3>
                            <p class="text-gray-500">
                                다른 검색어나 카테고리를 시도해보세요.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
    <script src="/js/common.js"></script>
    <script src="/js/board.js"></script>    

    <!-- 게시판 콘텐츠 로드 -->
    <script>
        async function loadBoardContent() {
            try {
                // board.html 로드
                const response = await fetch('board.html');
                const boardHTML = await response.text();
                document.getElementById('board-content-container').innerHTML = boardHTML;
                
                // Lucide 아이콘 초기화
                lucide.createIcons();

            } catch (error) {
                console.error('❌ 게시판 페이지 로드 중 오류 발생:', error);
            }
        }

        // 페이지 로드 시 실행
        document.addEventListener('DOMContentLoaded', loadBoardContent);
    </script>
</body>
</html>