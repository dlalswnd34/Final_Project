<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/recipe.css">
</head>
<body>
    <!-- CheForest 레시피 페이지 -->
    <div class="min-h-screen bg-white">
        <!-- 페이지 헤더 -->
        <section class="bg-gradient-to-r from-pink-500 to-orange-500 text-white py-12">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center">
                    <div class="flex items-center justify-center mb-4">
                        <i data-lucide="book-open" class="h-10 w-10 mr-3"></i>
                        <h1 class="text-4xl">CheForest 레시피</h1>
                    </div>
                    <p class="text-lg opacity-90 max-w-2xl mx-auto">
                        요리의 즐거움을 함께하세요! 다양한 카테고리의 검증된 레시피들을 만나보세요.
                    </p>
                </div>
            </div>
        </section>

        <!-- 검색 및 필터 섹션 -->
        <section class="py-8" style="background-color: rgba(156, 163, 175, 0.1);">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col lg:flex-row gap-6 items-center">
                    <!-- 검색바 -->
                    <div class="relative flex-1 w-full lg:max-w-md">
                        <i data-lucide="search" class="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500 h-5 w-5"></i>
                        <input
                            type="text"
                            id="recipeSearchInput"
                            placeholder="레시피, 재료, 요리법 검색..."
                            class="recipe-search-input pl-10 pr-4 py-3 w-full border-2 border-gray-200 focus:border-orange-500 rounded-lg bg-white"
                        />
                    </div>
                </div>
            </div>
        </section>

        <!-- 카테고리 및 레시피 목록 -->
        <section class="py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col lg:flex-row gap-8">
                    <!-- 사이드바 - 카테고리 -->
                    <aside class="lg:w-64">
                        <div class="bg-white border border-gray-200 rounded-lg p-6 sticky top-24">
                            <h3 class="font-semibold mb-4 flex items-center">
                                <i data-lucide="chef-hat" class="h-5 w-5 mr-2 text-orange-500"></i>
                                카테고리
                            </h3>
                            <div class="space-y-2" id="categoryList">
                                <!-- 카테고리 버튼들이 JavaScript로 동적 생성됩니다 -->
                            </div>
                        </div>
                    </aside>

                    <!-- 메인 컨텐츠 - 레시피 그리드 -->
                    <main class="flex-1">
                        <div class="mb-6 flex items-center justify-between">
                            <div>
                                <h2 class="text-2xl" id="categoryTitle">전체 레시피</h2>
                                <p class="text-gray-500 mt-1" id="recipeCount">
                                    <!-- 레시피 개수가 JavaScript로 동적 업데이트됩니다 -->
                                </p>
                            </div>
                        </div>

                        <!-- 인기 레시피 섹션 -->
                        <div class="mb-12" id="popularSection" style="display: none;">
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="text-xl flex items-center">
                                    <i data-lucide="trending-up" class="w-6 h-6 mr-3 text-red-500"></i>
                                    인기 레시피
                                    <span class="ml-2 px-3 py-1 bg-red-100 text-red-700 text-sm rounded-full" id="popularCount">
                                        <!-- 인기 레시피 개수 -->
                                    </span>
                                </h3>
                            </div>
                            
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="popularGrid">
                                <!-- 인기 레시피 카드 1: 집에서 만드는 김치찌개 -->
                                <div class="popular-recipe-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg cursor-pointer" 
                                    data-category="korean" data-likes="1203" data-rating="4.8" data-views="15234" data-created="2024-01-15"
                                    data-title="집에서 만드는 김치찌개" data-description="매콤하고 진한 김치찌개 만들기"
                                    onclick="showPage('recipe-detail')">
                                    <div class="relative">
                                        <!-- 인기 순위 배지 - 이미지 위 왼쪽 상단 -->
                                        <div class="absolute top-3 left-3 z-10">
                                            <div class="rank-badge w-8 h-8 text-white rounded-full flex items-center justify-center text-sm">
                                                1
                                            </div>
                                        </div>
                                        
                                        <img src="https://images.unsplash.com/photo-1708388064278-707e85eaddc0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxrb3JlYW4lMjBmb29kJTIwa2ltY2hpJTIwamppZ2FlfGVufDF8fHx8MTc1NzU3OTAxOHww&ixlib=rb-4.1.0&q=80&w=1080"
                                            alt="집에서 만드는 김치찌개"
                                            class="recipe-card-image w-full h-56 object-cover"
                                            onerror="this.src='https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400'" />
                                        
                                        <!-- 상태 배지들 - 이미지 위 오른쪽 상단 -->
                                        <div class="absolute top-3 right-3 flex flex-col space-y-2">
                                            <span class="category-badge korean">
                                                한식
                                            </span>
                                            <span class="category-badge hot-badge">HOT</span>
                                            <span class="category-badge new-badge">NEW</span>
                                        </div>
                                    </div>
                                    
                                    <div class="p-4">
                                        <h3 class="recipe-card-title text-lg mb-2 transition-colors line-clamp-1">
                                            집에서 만드는 김치찌개
                                        </h3>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">
                                            매콤하고 진한 김치찌개 만들기, 집에서도 맛집처럼!
                                        </p>
                                        
                                        <div class="flex items-center justify-between text-sm mb-3">
                                            <div class="flex items-center space-x-4">
                                                <div class="flex items-center space-x-1">
                                                    <i data-lucide="clock" class="h-4 w-4 text-gray-500"></i>
                                                    <span>30분</span>
                                                </div>
                                            </div>
                                            <span class="difficulty-badge normal">보통</span>
                                        </div>

                                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                            <div class="flex items-center space-x-3 text-sm">
                                                <div class="stat-item flex items-center space-x-1 text-gray-500">
                                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                                    <span>15.2k</span>
                                                </div>
                                                <div class="stat-item flex items-center space-x-1 text-red-500">
                                                    <i data-lucide="heart" class="h-4 w-4"></i>
                                                    <span>1.2k</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- 인기 레시피 카드 2: 크리미 카르보나라 파스타 -->
                                <div class="popular-recipe-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg cursor-pointer" 
                                    data-category="western" data-likes="987" data-rating="4.9" data-views="12876" data-created="2024-01-12"
                                    data-title="크리미 카르보나라 파스타" data-description="부드럽고 진한 카르보나라의 비밀 레시피"
                                    onclick="showPage('recipe-detail')">
                                    <div class="relative">
                                        <!-- 인기 순위 배지 - 이미지 위 왼쪽 상단 -->
                                        <div class="absolute top-3 left-3 z-10">
                                            <div class="rank-badge w-8 h-8 text-white rounded-full flex items-center justify-center text-sm">
                                                2
                                            </div>
                                        </div>
                                        
                                        <img src="https://images.unsplash.com/photo-1655662844229-d2c2a81f09ec?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxpdGFsaWFuJTIwcGFzdGElMjBjYXJib25hcmF8ZW58MXx8fHwxNzU3NTc5MDI2fDA&ixlib=rb-4.1.0&q=80&w=1080"
                                            alt="크리미 카르보나라 파스타"
                                            class="recipe-card-image w-full h-56 object-cover"
                                            onerror="this.src='https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400'" />
                                        
                                        <!-- 상태 배지들 - 이미지 위 오른쪽 상단 -->
                                        <div class="absolute top-3 right-3 flex flex-col space-y-2">
                                            <span class="category-badge western">
                                                양식
                                            </span>
                                            <span class="category-badge hot-badge">HOT</span>
                                        </div>
                                    </div>
                                    
                                    <div class="p-4">
                                        <h3 class="recipe-card-title text-lg mb-2 transition-colors line-clamp-1">
                                            크리미 카르보나라 파스타
                                        </h3>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">
                                            부드럽고 진한 카르보나라의 비밀 레시피
                                        </p>
                                        
                                        <div class="flex items-center justify-between text-sm mb-3">
                                            <div class="flex items-center space-x-4">
                                                <div class="flex items-center space-x-1">
                                                    <i data-lucide="clock" class="h-4 w-4 text-gray-500"></i>
                                                    <span>20분</span>
                                                </div>
                                            </div>
                                            <span class="difficulty-badge easy">쉬움</span>
                                        </div>

                                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                            <div class="flex items-center space-x-3 text-sm">
                                                <div class="stat-item flex items-center space-x-1 text-gray-500">
                                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                                    <span>12.9k</span>
                                                </div>
                                                <div class="stat-item flex items-center space-x-1 text-red-500">
                                                    <i data-lucide="heart" class="h-4 w-4"></i>
                                                    <span>987</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- 인기 레시피 카드 3: 촉촉한 초콜릿 케이크 -->
                                <div class="popular-recipe-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg cursor-pointer" 
                                    data-category="dessert" data-likes="1567" data-rating="4.8" data-views="14532" data-created="2024-01-10"
                                    data-title="촉촉한 초콜릿 케이크" data-description="베이킹 초보도 성공하는 초콜릿 케이크"
                                    onclick="showPage('recipe-detail')">
                                    <div class="relative">
                                        <!-- 인기 순위 배지 - 이미지 위 왼쪽 상단 -->
                                        <div class="absolute top-3 left-3 z-10">
                                            <div class="rank-badge w-8 h-8 text-white rounded-full flex items-center justify-center text-sm">
                                                3
                                            </div>
                                        </div>
                                        
                                        <img src="https://images.unsplash.com/photo-1644158776192-2d24ce35da1d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkZXNzZXJ0JTIwY2hvY29sYXRlJTIwY2FrZXxlbnwxfHx8fDE3NTc0NjI3Nzd8MA&ixlib=rb-4.1.0&q=80&w=1080"
                                            alt="촉촉한 초콜릿 케이크"
                                            class="recipe-card-image w-full h-56 object-cover"
                                            onerror="this.src='https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400'" />
                                        
                                        <!-- 상태 배지들 - 이미지 위 오른쪽 상단 -->
                                        <div class="absolute top-3 right-3 flex flex-col space-y-2">
                                            <span class="category-badge dessert">
                                                디저트
                                            </span>
                                            <span class="category-badge hot-badge">HOT</span>
                                            <span class="category-badge new-badge">NEW</span>
                                        </div>
                                    </div>
                                    
                                    <div class="p-4">
                                        <h3 class="recipe-card-title text-lg mb-2 transition-colors line-clamp-1">
                                            촉촉한 초콜릿 케이크
                                        </h3>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">
                                            베이킹 초보도 성공하는 초콜릿 케이크
                                        </p>
                                        
                                        <div class="flex items-center justify-between text-sm mb-3">
                                            <div class="flex items-center space-x-4">
                                                <div class="flex items-center space-x-1">
                                                    <i data-lucide="clock" class="h-4 w-4 text-gray-500"></i>
                                                    <span>60분</span>
                                                </div>
                                            </div>
                                            <span class="difficulty-badge normal">보통</span>
                                        </div>

                                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                            <div class="flex items-center space-x-3 text-sm">
                                                <div class="stat-item flex items-center space-x-1 text-gray-500">
                                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                                    <span>14.5k</span>
                                                </div>
                                                <div class="stat-item flex items-center space-x-1 text-red-500">
                                                    <i data-lucide="heart" class="h-4 w-4"></i>
                                                    <span>1.6k</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 일반 레시피 섹션 -->
                        <div class="mb-8">
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="text-xl flex items-center">
                                    <i data-lucide="list" class="w-6 h-6 mr-3 text-orange-500"></i>
                                    일반 레시피
                                    <span class="ml-2 px-3 py-1 bg-gray-100 text-gray-700 text-sm rounded-full" id="regularCount">
                                        <!-- 일반 레시피 개수 -->
                                    </span>
                                </h3>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6" id="regularGrid">
                                <!-- 일반 레시피 카드 1: 촉촉한 딤섬 만두 -->
                                <div class="recipe-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg cursor-pointer" 
                                    data-category="chinese" data-likes="743" data-rating="4.7" data-views="9432" data-created="2024-01-08"
                                    data-title="촉촉한 딤섬 만두" data-description="집에서 만드는 정통 딤섬 레시피"
                                    onclick="showPage('recipe-detail')">
                                    <div class="relative">
                                        <img src="https://images.unsplash.com/photo-1753179253638-65a35859db6f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjaGluZXNlJTIwZGltJTIwc3VtJTIwZHVtcGxpbmdzfGVufDF8fHx8MTc1NzU3OTAzN3ww&ixlib=rb-4.1.0&q=80&w=1080"
                                            alt="촉촉한 딤섬 만두"
                                            class="recipe-card-image w-full h-56 object-cover"
                                            onerror="this.src='https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400'" />
                                        
                                        <!-- 상태 배지들 - 이미지 위 오른쪽 상단 -->
                                        <div class="absolute top-3 right-3 flex flex-col space-y-2">
                                            <span class="category-badge chinese">
                                                중식
                                            </span>
                                            <span class="category-badge new-badge">NEW</span>
                                        </div>
                                    </div>
                                    
                                    <div class="p-4">
                                        <h3 class="recipe-card-title text-lg mb-2 transition-colors line-clamp-1">
                                            촉촉한 딤섬 만두
                                        </h3>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">
                                            집에서 만드는 정통 딤섬 레시피
                                        </p>
                                        
                                        <div class="flex items-center justify-between text-sm mb-3">
                                            <div class="flex items-center space-x-4">
                                                <div class="flex items-center space-x-1">
                                                    <i data-lucide="clock" class="h-4 w-4 text-gray-500"></i>
                                                    <span>45분</span>
                                                </div>
                                            </div>
                                            <span class="difficulty-badge hard">어려움</span>
                                        </div>

                                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                            <div class="flex items-center space-x-3 text-sm">
                                                <div class="stat-item flex items-center space-x-1 text-gray-500">
                                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                                    <span>9.4k</span>
                                                </div>
                                                <div class="stat-item flex items-center space-x-1 text-red-500">
                                                    <i data-lucide="heart" class="h-4 w-4"></i>
                                                    <span>743</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- 일반 레시피 카드 2: 신선한 연어 사시미 -->
                                <div class="recipe-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg cursor-pointer" 
                                    data-category="japanese" data-likes="654" data-rating="4.9" data-views="8765" data-created="2024-01-05"
                                    data-title="신선한 연어 사시미" data-description="완벽한 연어 사시미 손질법과 플레이팅"
                                    onclick="showPage('recipe-detail')">
                                    <div class="relative">
                                        <img src="https://images.unsplash.com/photo-1625248464253-1b528c1ab7e0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxqYXBhbmVzZSUyMHN1c2hpJTIwc2FsbW9ufGVufDF8fHx8MTc1NzU3OTA0Nnww&ixlib=rb-4.1.0&q=80&w=1080"
                                            alt="신선한 연어 사시미"
                                            class="recipe-card-image w-full h-56 object-cover"
                                            onerror="this.src='https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400'" />
                                        
                                        <!-- 상태 배지들 - 이미지 위 오른쪽 상단 -->
                                        <div class="absolute top-3 right-3 flex flex-col space-y-2">
                                            <span class="category-badge japanese">
                                                일식
                                            </span>
                                        </div>
                                    </div>
                                    
                                    <div class="p-4">
                                        <h3 class="recipe-card-title text-lg mb-2 transition-colors line-clamp-1">
                                            신선한 연어 사시미
                                        </h3>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">
                                            완벽한 연어 사시미 손질법과 플레이팅
                                        </p>
                                        
                                        <div class="flex items-center justify-between text-sm mb-3">
                                            <div class="flex items-center space-x-4">
                                                <div class="flex items-center space-x-1">
                                                    <i data-lucide="clock" class="h-4 w-4 text-gray-500"></i>
                                                    <span>15분</span>
                                                </div>
                                            </div>
                                            <span class="difficulty-badge normal">보통</span>
                                        </div>

                                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                            <div class="flex items-center space-x-3 text-sm">
                                                <div class="stat-item flex items-center space-x-1 text-gray-500">
                                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                                    <span>8.8k</span>
                                                </div>
                                                <div class="stat-item flex items-center space-x-1 text-red-500">
                                                    <i data-lucide="heart" class="h-4 w-4"></i>
                                                    <span>654</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- 일반 레시피 카드 3: 된장찌개 황금 레시피 -->
                                <div class="recipe-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg cursor-pointer" 
                                    data-category="korean" data-likes="432" data-rating="4.6" data-views="7890" data-created="2024-01-03"
                                    data-title="된장찌개 황금 레시피" data-description="구수하고 깊은 맛의 된장찌개 만들기"
                                    onclick="showPage('recipe-detail')">
                                    <div class="relative">
                                        <img src="https://images.unsplash.com/photo-1708388064278-707e85eaddc0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxrb3JlYW4lMjBmb29kJTIwa2ltY2hpJTIwamppZ2FlfGVufDF8fHx8MTc1NzU3OTAxOHww&ixlib=rb-4.1.0&q=80&w=1080"
                                            alt="된장찌개 황금 레시피"
                                            class="recipe-card-image w-full h-56 object-cover"
                                            onerror="this.src='https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400'" />
                                        
                                        <!-- 상태 배지들 - 이미지 위 오른쪽 상단 -->
                                        <div class="absolute top-3 right-3 flex flex-col space-y-2">
                                            <span class="category-badge korean">
                                                한식
                                            </span>
                                        </div>
                                    </div>
                                    
                                    <div class="p-4">
                                        <h3 class="recipe-card-title text-lg mb-2 transition-colors line-clamp-1">
                                            된장찌개 황금 레시피
                                        </h3>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">
                                            구수하고 깊은 맛의 된장찌개 만들기
                                        </p>
                                        
                                        <div class="flex items-center justify-between text-sm mb-3">
                                            <div class="flex items-center space-x-4">
                                                <div class="flex items-center space-x-1">
                                                    <i data-lucide="clock" class="h-4 w-4 text-gray-500"></i>
                                                    <span>25분</span>
                                                </div>
                                            </div>
                                            <span class="difficulty-badge easy">쉬움</span>
                                        </div>

                                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                            <div class="flex items-center space-x-3 text-sm">
                                                <div class="stat-item flex items-center space-x-1 text-gray-500">
                                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                                    <span>7.9k</span>
                                                </div>
                                                <div class="stat-item flex items-center space-x-1 text-red-500">
                                                    <i data-lucide="heart" class="h-4 w-4"></i>
                                                    <span>432</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 더보기 버튼 -->
                        <div class="text-center mt-12" id="loadMoreSection" style="display: none;">
                            <button class="btn-orange text-white px-8 py-3 rounded-lg">
                                더 많은 레시피 보기
                            </button>
                        </div>

                        <!-- 검색 결과 없음 -->
                        <div class="text-center py-12" id="noResultsSection" style="display: none;">
                            <i data-lucide="chef-hat" class="h-16 w-16 text-gray-400 mx-auto mb-4"></i>
                            <h3 class="text-xl mb-2">검색 결과가 없습니다</h3>
                            <p class="text-gray-500">
                                다른 검색어나 카테고리를 시도해보세요.
                            </p>
                        </div>
                    </main>
                </div>
            </div>
        </section>
    </div>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
    <script src="/js/common.js"></script>
    <script src="/js/recipe.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Lucide 아이콘 초기화
            lucide.createIcons();        
        });
    </script>
</body>
</html>