<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/season.css">
</head>
<body>
    <!-- 계절별 식재료 페이지 콘텐츠 (헤더/푸터 제외) -->
    <div id="ingredients-page" class="min-h-screen bg-gradient-to-br from-green-50 to-pink-50 transition-all duration-700">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <!-- 헤더 -->
            <div class="text-center mb-12">
                <div class="flex items-center justify-center mb-4">
                    <span id="season-icon" class="text-6xl mr-4">🌸</span>
                    <h1 id="season-title" class="text-4xl bg-gradient-to-r from-green-400 to-pink-400 bg-clip-text text-transparent font-black">
                        봄철 식재료
                    </h1>
                </div>
                <p class="text-lg text-muted-foreground mb-4">
                    제철 식재료로 더 맛있고 건강한 요리를 만들어보세요
                </p>
                <div id="ingredient-count" class="inline-block bg-gradient-to-r from-green-400 to-pink-400 text-white px-4 py-2 rounded-full text-sm font-medium">
                    총 4가지 식재료
                </div>
            </div>

            <!-- 계절 선택 탭 -->
            <div class="flex justify-center mb-12">
                <div class="bg-white/80 backdrop-blur-sm rounded-full p-2 shadow-lg border border-white/30">
                    <div class="flex flex-wrap justify-center space-x-1" id="season-tabs">
                        <button data-season="spring" class="season-tab flex items-center space-x-2 px-6 py-3 rounded-full transition-all duration-300 bg-gradient-to-r from-green-400 to-pink-400 text-white shadow-md transform scale-105">
                            <span class="text-lg">🌸</span>
                            <span class="font-medium">봄</span>
                        </button>
                        <button data-season="summer" class="season-tab flex items-center space-x-2 px-6 py-3 rounded-full transition-all duration-300 text-gray-600 hover:bg-white/50 hover:scale-102">
                            <span class="text-lg">☀️</span>
                            <span class="font-medium">여름</span>
                        </button>
                        <button data-season="autumn" class="season-tab flex items-center space-x-2 px-6 py-3 rounded-full transition-all duration-300 text-gray-600 hover:bg-white/50 hover:scale-102">
                            <span class="text-lg">🍂</span>
                            <span class="font-medium">가을</span>
                        </button>
                        <button data-season="winter" class="season-tab flex items-center space-x-2 px-6 py-3 rounded-full transition-all duration-300 text-gray-600 hover:bg-white/50 hover:scale-102">
                            <span class="text-lg">❄️</span>
                            <span class="font-medium">겨울</span>
                        </button>
                    </div>
                </div>
            </div>

            <!-- 식재료 그리드 -->
            <div id="ingredients-grid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                
                <!-- 봄 식재료들 -->
                <!-- 냉이 -->
                <div class="ingredient-card season-spring group hover:shadow-2xl transition-all duration-500 border-white/50 overflow-hidden bg-white/80 backdrop-blur-sm hover:bg-white/90 rounded-lg border relative">
                    <div class="relative">
                        <div class="aspect-[4/3] overflow-hidden">
                            <img src="https://images.unsplash.com/photo-1560100927-c32f29063ade?w=400&h=300&fit=crop" alt="냉이" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
                            <div class="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                        </div>
                        <div class="absolute top-3 right-3">
                            <div class="season-badge bg-gradient-to-r from-green-400 to-pink-400 text-white border-none shadow-lg px-2 py-1 rounded text-xs font-medium">
                                🌸 봄
                            </div>
                        </div>
                    </div>
                    
                    <div class="p-4 pb-3">
                        <div class="flex items-center justify-between">
                            <h3 class="ingredient-title text-xl font-black bg-gradient-to-r from-green-400 to-pink-400 bg-clip-text text-transparent">
                                냉이
                            </h3>
                            <div class="pulse-dot w-2 h-2 rounded-full bg-gradient-to-r from-green-400 to-pink-400 animate-pulse"></div>
                        </div>
                        <p class="text-sm text-muted-foreground line-clamp-2 mt-2">봄철 대표 나물로 특유의 향긋한 향과 씁쓸한 맛이 특징입니다. 간 기능 개선과 해독에 효과적입니다.</p>
                    </div>

                    <div class="px-4 pb-4 space-y-4">
                        <!-- 제철 기간 -->
                        <div class="season-period flex items-center space-x-2 p-2 rounded-lg bg-gradient-to-r from-green-50 to-pink-50">
                            <svg class="h-4 w-4 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polyline points="12,6 12,12 16,14"></polyline>
                            </svg>
                            <span class="text-sm font-medium">제철: 3월 ~ 4월</span>
                        </div>

                        <!-- 주요 효능 -->
                        <div>
                            <h4 class="benefit-title text-sm font-bold text-green-700 mb-2">
                                ✨ 주요 효능
                            </h4>
                            <div class="flex flex-wrap gap-1">
                                <span class="benefit-badge text-xs bg-gradient-to-r from-green-50 to-pink-50 text-green-700 px-2 py-1 rounded border-none">간 기능 개선</span>
                                <span class="benefit-badge text-xs bg-gradient-to-r from-green-50 to-pink-50 text-green-700 px-2 py-1 rounded border-none">해독 효과</span>
                                <span class="benefit-badge text-xs bg-gradient-to-r from-green-50 to-pink-50 text-green-700 px-2 py-1 rounded border-none">비타민 C 풍부</span>
                            </div>
                        </div>

                        <!-- 추천 요리 -->
                        <div>
                            <h4 class="recipe-title text-sm font-bold text-green-700 mb-2 flex items-center">
                                <svg class="h-4 w-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path d="M6 2l3 6 5-6"/>
                                    <path d="m18 2 3 6-5-6"/>
                                    <path d="M11 7H6l-1 9a2 2 0 0 0 2 2h2"/>
                                    <path d="M13 7h5l1 9a2 2 0 0 1-2 2h-2"/>
                                    <path d="m7 7 4 6 4-6"/>
                                </svg>
                                추천 요리
                            </h4>
                            <p class="text-sm text-muted-foreground">냉이된장국 · 냉이무침 · 냉이비빔밥</p>
                        </div>

                        <!-- 영양성분 -->
                        <div class="nutrition-section pt-3 border-t border-green-200">
                            <div class="flex items-center space-x-2 mb-2">
                                <div class="w-2 h-2 rounded-full bg-gradient-to-r from-green-400 to-pink-400"></div>
                                <span class="text-xs font-medium text-muted-foreground">주요 영양성분</span>
                            </div>
                            <p class="nutrition-text text-xs text-green-600 font-medium">비타민 A, C, 칼슘, 철분, 엽산</p>
                        </div>

                        <!-- 액션 버튼 -->
                        <button class="recipe-button w-full mt-4 px-4 py-2 bg-gradient-to-r from-green-400 to-pink-400 text-white rounded-lg transition-all duration-300 text-sm font-medium hover:shadow-lg hover:scale-105 active:scale-95">
                            🍽️ 레시피 보기
                        </button>
                    </div>
                </div>

                <!-- 딸기 -->
                <div class="ingredient-card season-spring group hover:shadow-2xl transition-all duration-500 border-white/50 overflow-hidden bg-white/80 backdrop-blur-sm hover:bg-white/90 rounded-lg border relative">
                    <div class="relative">
                        <div class="aspect-[4/3] overflow-hidden">
                            <img src="https://images.unsplash.com/photo-1619466218714-7b3ab1182a46?w=400&h=300&fit=crop" alt="딸기" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
                            <div class="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                        </div>
                        <div class="absolute top-3 right-3">
                            <div class="season-badge bg-gradient-to-r from-green-400 to-pink-400 text-white border-none shadow-lg px-2 py-1 rounded text-xs font-medium">
                                🌸 봄
                            </div>
                        </div>
                    </div>
                    
                    <div class="p-4 pb-3">
                        <div class="flex items-center justify-between">
                            <h3 class="ingredient-title text-xl font-black bg-gradient-to-r from-green-400 to-pink-400 bg-clip-text text-transparent">
                                딸기
                            </h3>
                            <div class="pulse-dot w-2 h-2 rounded-full bg-gradient-to-r from-green-400 to-pink-400 animate-pulse"></div>
                        </div>
                        <p class="text-sm text-muted-foreground line-clamp-2 mt-2">봄의 대표 과일로 달콤하고 상큼한 맛이 일품입니다. 비타민 C가 매우 풍부해 피부 건강에 좋습니다.</p>
                    </div>

                    <div class="px-4 pb-4 space-y-4">
                        <!-- 제철 기간 -->
                        <div class="season-period flex items-center space-x-2 p-2 rounded-lg bg-gradient-to-r from-green-50 to-pink-50">
                            <svg class="h-4 w-4 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polyline points="12,6 12,12 16,14"></polyline>
                            </svg>
                            <span class="text-sm font-medium">제철: 4월 ~ 6월</span>
                        </div>

                        <!-- 주요 효능 -->
                        <div>
                            <h4 class="benefit-title text-sm font-bold text-green-700 mb-2">
                                ✨ 주요 효능
                            </h4>
                            <div class="flex flex-wrap gap-1">
                                <span class="benefit-badge text-xs bg-gradient-to-r from-green-50 to-pink-50 text-green-700 px-2 py-1 rounded border-none">비타민 C 풍부</span>
                                <span class="benefit-badge text-xs bg-gradient-to-r from-green-50 to-pink-50 text-green-700 px-2 py-1 rounded border-none">항산화 효과</span>
                                <span class="benefit-badge text-xs bg-gradient-to-r from-green-50 to-pink-50 text-green-700 px-2 py-1 rounded border-none">피부 건강</span>
                            </div>
                        </div>

                        <!-- 추천 요리 -->
                        <div>
                            <h4 class="recipe-title text-sm font-bold text-green-700 mb-2 flex items-center">
                                <svg class="h-4 w-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path d="M6 2l3 6 5-6"/>
                                    <path d="m18 2 3 6-5-6"/>
                                    <path d="M11 7H6l-1 9a2 2 0 0 0 2 2h2"/>
                                    <path d="M13 7h5l1 9a2 2 0 0 1-2 2h-2"/>
                                    <path d="m7 7 4 6 4-6"/>
                                </svg>
                                추천 요리
                            </h4>
                            <p class="text-sm text-muted-foreground">딸기잼 · 딸기타르트 · 딸기우유</p>
                        </div>

                        <!-- 영양성분 -->
                        <div class="nutrition-section pt-3 border-t border-green-200">
                            <div class="flex items-center space-x-2 mb-2">
                                <div class="w-2 h-2 rounded-full bg-gradient-to-r from-green-400 to-pink-400"></div>
                                <span class="text-xs font-medium text-muted-foreground">주요 영양성분</span>
                            </div>
                            <p class="nutrition-text text-xs text-green-600 font-medium">비타민 C, 엽산, 칼륨, 안토시아닌</p>
                        </div>

                        <!-- 액션 버튼 -->
                        <button class="recipe-button w-full mt-4 px-4 py-2 bg-gradient-to-r from-green-400 to-pink-400 text-white rounded-lg transition-all duration-300 text-sm font-medium hover:shadow-lg hover:scale-105 active:scale-95">
                            🍽️ 레시피 보기
                        </button>
                    </div>
                </div>

                <!-- 취나물 -->
                <div class="ingredient-card season-spring group hover:shadow-2xl transition-all duration-500 border-white/50 overflow-hidden bg-white/80 backdrop-blur-sm hover:bg-white/90 rounded-lg border relative">
                    <div class="relative">
                        <div class="aspect-[4/3] overflow-hidden">
                            <img src="https://images.unsplash.com/photo-1551316679-9c6ae9dec224?w=400&h=300&fit=crop" alt="취나물" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
                            <div class="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                        </div>
                        <div class="absolute top-3 right-3">
                            <div class="season-badge bg-gradient-to-r from-green-400 to-pink-400 text-white border-none shadow-lg px-2 py-1 rounded text-xs font-medium">
                                🌸 봄
                            </div>
                        </div>
                    </div>
                    
                    <div class="p-4 pb-3">
                        <div class="flex items-center justify-between">
                            <h3 class="ingredient-title text-xl font-black bg-gradient-to-r from-green-400 to-pink-400 bg-clip-text text-transparent">
                                취나물
                            </h3>
                            <div class="pulse-dot w-2 h-2 rounded-full bg-gradient-to-r from-green-400 to-pink-400 animate-pulse"></div>
                        </div>
                        <p class="text-sm text-muted-foreground line-clamp-2 mt-2">봄철 산나물의 대표로 특유의 향과 쌉싸름한 맛이 매력적입니다. 소화를 돕고 식욕을 증진시킵니다.</p>
                    </div>

                    <div class="px-4 pb-4 space-y-4">
                        <!-- 제철 기간 -->
                        <div class="season-period flex items-center space-x-2 p-2 rounded-lg bg-gradient-to-r from-green-50 to-pink-50">
                            <svg class="h-4 w-4 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polyline points="12,6 12,12 16,14"></polyline>
                            </svg>
                            <span class="text-sm font-medium">제철: 4월 ~ 5월</span>
                        </div>

                        <!-- 주요 효능 -->
                        <div>
                            <h4 class="benefit-title text-sm font-bold text-green-700 mb-2">
                                ✨ 주요 효능
                            </h4>
                            <div class="flex flex-wrap gap-1">
                                <span class="benefit-badge text-xs bg-gradient-to-r from-green-50 to-pink-50 text-green-700 px-2 py-1 rounded border-none">소화 촉진</span>
                                <span class="benefit-badge text-xs bg-gradient-to-r from-green-50 to-pink-50 text-green-700 px-2 py-1 rounded border-none">식욕 증진</span>
                                <span class="benefit-badge text-xs bg-gradient-to-r from-green-50 to-pink-50 text-green-700 px-2 py-1 rounded border-none">비타민 보충</span>
                            </div>
                        </div>

                        <!-- 추천 요리 -->
                        <div>
                            <h4 class="recipe-title text-sm font-bold text-green-700 mb-2 flex items-center">
                                <svg class="h-4 w-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path d="M6 2l3 6 5-6"/>
                                    <path d="m18 2 3 6-5-6"/>
                                    <path d="M11 7H6l-1 9a2 2 0 0 0 2 2h2"/>
                                    <path d="M13 7h5l1 9a2 2 0 0 1-2 2h-2"/>
                                    <path d="m7 7 4 6 4-6"/>
                                </svg>
                                추천 요리
                            </h4>
                            <p class="text-sm text-muted-foreground">취나물무침 · 취나물전 · 취나물밥</p>
                        </div>

                        <!-- 영양성분 -->
                        <div class="nutrition-section pt-3 border-t border-green-200">
                            <div class="flex items-center space-x-2 mb-2">
                                <div class="w-2 h-2 rounded-full bg-gradient-to-r from-green-400 to-pink-400"></div>
                                <span class="text-xs font-medium text-muted-foreground">주요 영양성분</span>
                            </div>
                            <p class="nutrition-text text-xs text-green-600 font-medium">비타민 A, 베타카로틴, 칼슘, 철분</p>
                        </div>

                        <!-- 액션 버튼 -->
                        <button class="recipe-button w-full mt-4 px-4 py-2 bg-gradient-to-r from-green-400 to-pink-400 text-white rounded-lg transition-all duration-300 text-sm font-medium hover:shadow-lg hover:scale-105 active:scale-95">
                            🍽️ 레시피 보기
                        </button>
                    </div>
                </div>

                <!-- 아스파라거스 -->
                <div class="ingredient-card season-spring group hover:shadow-2xl transition-all duration-500 border-white/50 overflow-hidden bg-white/80 backdrop-blur-sm hover:bg-white/90 rounded-lg border relative">
                    <div class="relative">
                        <div class="aspect-[4/3] overflow-hidden">
                            <img src="https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400&h=300&fit=crop" alt="아스파라거스" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
                            <div class="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                        </div>
                        <div class="absolute top-3 right-3">
                            <div class="season-badge bg-gradient-to-r from-green-400 to-pink-400 text-white border-none shadow-lg px-2 py-1 rounded text-xs font-medium">
                                🌸 봄
                            </div>
                        </div>
                    </div>
                    
                    <div class="p-4 pb-3">
                        <div class="flex items-center justify-between">
                            <h3 class="ingredient-title text-xl font-black bg-gradient-to-r from-green-400 to-pink-400 bg-clip-text text-transparent">
                                아스파라거스
                            </h3>
                            <div class="pulse-dot w-2 h-2 rounded-full bg-gradient-to-r from-green-400 to-pink-400 animate-pulse"></div>
                        </div>
                        <p class="text-sm text-muted-foreground line-clamp-2 mt-2">봄철 고급 채소로 아삭한 식감과 고유한 풍미가 특징입니다. 아스파라긴산이 풍부해 피로 회복에 좋습니다.</p>
                    </div>

                    <div class="px-4 pb-4 space-y-4">
                        <!-- 제철 기간 -->
                        <div class="season-period flex items-center space-x-2 p-2 rounded-lg bg-gradient-to-r from-green-50 to-pink-50">
                            <svg class="h-4 w-4 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polyline points="12,6 12,12 16,14"></polyline>
                            </svg>
                            <span class="text-sm font-medium">제철: 4월 ~ 6월</span>
                        </div>

                        <!-- 주요 효능 -->
                        <div>
                            <h4 class="benefit-title text-sm font-bold text-green-700 mb-2">
                                ✨ 주요 효능
                            </h4>
                            <div class="flex flex-wrap gap-1">
                                <span class="benefit-badge text-xs bg-gradient-to-r from-green-50 to-pink-50 text-green-700 px-2 py-1 rounded border-none">피로 회복</span>
                                <span class="benefit-badge text-xs bg-gradient-to-r from-green-50 to-pink-50 text-green-700 px-2 py-1 rounded border-none">이뇨 작용</span>
                                <span class="benefit-badge text-xs bg-gradient-to-r from-green-50 to-pink-50 text-green-700 px-2 py-1 rounded border-none">해독 효과</span>
                            </div>
                        </div>

                        <!-- 추천 요리 -->
                        <div>
                            <h4 class="recipe-title text-sm font-bold text-green-700 mb-2 flex items-center">
                                <svg class="h-4 w-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path d="M6 2l3 6 5-6"/>
                                    <path d="m18 2 3 6-5-6"/>
                                    <path d="M11 7H6l-1 9a2 2 0 0 0 2 2h2"/>
                                    <path d="M13 7h5l1 9a2 2 0 0 1-2 2h-2"/>
                                    <path d="m7 7 4 6 4-6"/>
                                </svg>
                                추천 요리
                            </h4>
                            <p class="text-sm text-muted-foreground">아스파라거스볶음 · 아스파라거스샐러드 · 아스파라거스수프</p>
                        </div>

                        <!-- 영양성분 -->
                        <div class="nutrition-section pt-3 border-t border-green-200">
                            <div class="flex items-center space-x-2 mb-2">
                                <div class="w-2 h-2 rounded-full bg-gradient-to-r from-green-400 to-pink-400"></div>
                                <span class="text-xs font-medium text-muted-foreground">주요 영양성분</span>
                            </div>
                            <p class="nutrition-text text-xs text-green-600 font-medium">아스파라긴산, 비타민 K, 엽산, 루틴</p>
                        </div>

                        <!-- 액션 버튼 -->
                        <button class="recipe-button w-full mt-4 px-4 py-2 bg-gradient-to-r from-green-400 to-pink-400 text-white rounded-lg transition-all duration-300 text-sm font-medium hover:shadow-lg hover:scale-105 active:scale-95">
                            🍽️ 레시피 보기
                        </button>
                    </div>
                </div>

                <!-- 여름 식재료들 -->
                <!-- 토마토 -->
                <div class="ingredient-card season-summer group hover:shadow-2xl transition-all duration-500 border-white/50 overflow-hidden bg-white/80 backdrop-blur-sm hover:bg-white/90 rounded-lg border relative" style="display: none;">
                    <div class="relative">
                        <div class="aspect-[4/3] overflow-hidden">
                            <img src="https://images.unsplash.com/photo-1659292482339-4fe111483d1b?w=400&h=300&fit=crop" alt="토마토" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
                            <div class="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                        </div>
                        <div class="absolute top-3 right-3">
                            <div class="season-badge bg-gradient-to-r text-white border-none shadow-lg px-2 py-1 rounded text-xs font-medium">
                                ☀️ 여름
                            </div>
                        </div>
                    </div>
                    
                    <div class="p-4 pb-3">
                        <div class="flex items-center justify-between">
                            <h3 class="ingredient-title text-xl font-black bg-gradient-to-r bg-clip-text text-transparent">
                                토마토
                            </h3>
                            <div class="pulse-dot w-2 h-2 rounded-full bg-gradient-to-r animate-pulse"></div>
                        </div>
                        <p class="text-sm text-muted-foreground line-clamp-2 mt-2">여름철 대표 채소로 라이코펜이 풍부한 건강식품입니다. 항산화 효과가 뛰어나 피부와 혈관 건강에 좋습니다.</p>
                    </div>

                    <div class="px-4 pb-4 space-y-4">
                        <!-- 제철 기간 -->
                        <div class="season-period flex items-center space-x-2 p-2 rounded-lg bg-gradient-to-r">
                            <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polyline points="12,6 12,12 16,14"></polyline>
                            </svg>
                            <span class="text-sm font-medium">제철: 6월 ~ 8월</span>
                        </div>

                        <!-- 주요 효능 -->
                        <div>
                            <h4 class="benefit-title text-sm font-bold mb-2">
                                ✨ 주요 효능
                            </h4>
                            <div class="flex flex-wrap gap-1">
                                <span class="benefit-badge text-xs bg-gradient-to-r px-2 py-1 rounded border-none">라이코펜 풍부</span>
                                <span class="benefit-badge text-xs bg-gradient-to-r px-2 py-1 rounded border-none">항산화 효과</span>
                                <span class="benefit-badge text-xs bg-gradient-to-r px-2 py-1 rounded border-none">피부 보호</span>
                            </div>
                        </div>

                        <!-- 추천 요리 -->
                        <div>
                            <h4 class="recipe-title text-sm font-bold mb-2 flex items-center">
                                <svg class="h-4 w-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path d="M6 2l3 6 5-6"/>
                                    <path d="m18 2 3 6-5-6"/>
                                    <path d="M11 7H6l-1 9a2 2 0 0 0 2 2h2"/>
                                    <path d="M13 7h5l1 9a2 2 0 0 1-2 2h-2"/>
                                    <path d="m7 7 4 6 4-6"/>
                                </svg>
                                추천 요리
                            </h4>
                            <p class="text-sm text-muted-foreground">토마토볶음 · 토마토스프 · 카프레제</p>
                        </div>

                        <!-- 영양성분 -->
                        <div class="nutrition-section pt-3 border-t">
                            <div class="flex items-center space-x-2 mb-2">
                                <div class="w-2 h-2 rounded-full bg-gradient-to-r"></div>
                                <span class="text-xs font-medium text-muted-foreground">주요 영양성분</span>
                            </div>
                            <p class="nutrition-text text-xs font-medium">라이코펜, 비타민 C, 칼륨, 베타카로틴</p>
                        </div>

                        <!-- 액션 버튼 -->
                        <button class="recipe-button w-full mt-4 px-4 py-2 bg-gradient-to-r text-white rounded-lg transition-all duration-300 text-sm font-medium hover:shadow-lg hover:scale-105 active:scale-95">
                            🍽️ 레시피 보기
                        </button>
                    </div>
                </div>

                <!-- 나머지 여름, 가을, 겨울 식재료들... (간소화를 위해 생략) -->
                
            </div>

            <!-- 빈 상태 -->
            <div id="empty-state" class="text-center py-16 hidden">
                <div class="text-4xl mb-4" id="empty-icon">🌸</div>
                <h3 class="text-xl mb-2">준비중인 <span id="empty-season">봄</span>철 식재료</h3>
                <p class="text-muted-foreground">곧 더 많은 <span id="empty-season-2">봄</span>철 식재료를 만나보실 수 있습니다!</p>
            </div>

            <!-- 계절별 팁 섹션 -->
            <div class="mt-16">
                <div id="tips-card" class="bg-gradient-to-r from-green-50 to-pink-50 border-white/30 backdrop-blur-sm rounded-lg border shadow-sm">
                    <div class="p-6 pb-0">
                        <div class="flex items-center space-x-3">
                            <div id="tips-icon" class="p-3 rounded-full bg-gradient-to-r from-green-400 to-pink-400 shadow-lg">
                                <span class="text-2xl">🌸</span>
                            </div>
                            <div>
                                <h3 id="tips-title" class="text-2xl font-black bg-gradient-to-r from-green-400 to-pink-400 bg-clip-text text-transparent">
                                    봄철 식재료 가이드
                                </h3>
                                <p class="text-muted-foreground">전문가가 추천하는 활용법</p>
                            </div>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div id="storage-tip" class="p-4 rounded-xl bg-white/50 border border-green-200">
                                <h4 class="font-bold text-green-700 mb-3 flex items-center">
                                    🏠 보관법
                                </h4>
                                <p class="text-sm text-muted-foreground leading-relaxed">
                                    봄나물은 찬물에 담가 이물질을 제거한 후 키친타월로 물기를 제거하고 밀폐용기에 넣어 냉장보관하세요. 2-3일 내 섭취가 좋습니다.
                                </p>
                            </div>
                            
                            <div id="cooking-tip" class="p-4 rounded-xl bg-white/50 border border-green-200">
                                <h4 class="font-bold text-green-700 mb-3 flex items-center">
                                    👨‍🍳 조리법
                                </h4>
                                <p class="text-sm text-muted-foreground leading-relaxed">
                                    봄나물은 끓는 물에 소금을 넣고 살짝 데친 후 찬물에 헹구어 쓴맛을 제거합니다. 참기름과 마늘로 간단히 무쳐드세요.
                                </p>
                            </div>

                            <div id="general-tip" class="p-4 rounded-xl bg-white/50 border border-green-200">
                                <h4 class="font-bold text-green-700 mb-3 flex items-center">
                                    💡 팁
                                </h4>
                                <p class="text-sm text-muted-foreground leading-relaxed">
                                    봄나물의 쓴맛이 싫다면 데친 후 찬물에 30분간 담가두세요. 어린잎일수록 부드럽고 맛이 좋습니다.
                                </p>
                            </div>
                        </div>

                        <!-- 계절별 특별 정보 -->
                        <div class="mt-6 p-4 rounded-xl bg-white/30 border border-white/50">
                            <h4 class="font-bold text-green-700 mb-2 flex items-center">
                                ⭐ <span id="special-season">봄</span>철 특별 정보
                            </h4>
                            <p id="special-info" class="text-sm text-muted-foreground">
                                봄철에는 해독과 간 기능 개선에 도움되는 쌉쌀한 나물류가 많습니다. 겨울 동안 쌓인 독소를 배출하는 데 효과적입니다.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
    <script src="/js/common.js"></script>
    <script src="/js/season.js"></script>
</body>
</html>