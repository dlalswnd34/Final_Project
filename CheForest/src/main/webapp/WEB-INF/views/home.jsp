<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/home.css">
</head>
<jsp:include page="/common/header.jsp"/>
<body>
    <!-- CheForest 홈 화면 -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div id="bannerSlider" class="relative w-full h-96 md:h-[500px] lg:h-[600px] overflow-hidden rounded-xl group">
            <!-- 슬라이드 컨테이너 -->
            <div class="relative w-full h-full">
                <!-- 슬라이드 1 - 한식 -->
                <div class="slide absolute inset-0 slide-transition opacity-100" data-slide="0">
                    <img src="https://images.unsplash.com/photo-1693429308125-3be7b105ad56?w=1200&h=600&fit=crop&auto=format" 
                        alt="한식 요리" 
                        class="w-full h-full object-cover">
                    <!-- 텍스트 가독성을 위한 미세한 어두운 오버레이 -->
                    <div class="absolute inset-0 bg-black/20"></div>
                    <div class="absolute inset-0 flex items-center justify-center text-center text-white">
                        <div class="max-w-4xl px-6">
                            <span class="inline-block px-4 py-2 bg-white/90 text-gray-800 rounded-full text-sm mb-6 backdrop-blur-sm">한식</span>
                            <h2 class="text-3xl md:text-5xl lg:text-6xl mb-6 drop-shadow-lg">전통 한식의 깊은 맛</h2>
                            <p class="text-lg md:text-xl lg:text-2xl drop-shadow-md">집에서 만드는 정통 한국 요리</p>
                        </div>
                    </div>
                </div>

                <!-- 슬라이드 2 - 양식 -->
                <div class="slide absolute inset-0 slide-transition opacity-0" data-slide="1">
                    <img src="https://images.unsplash.com/photo-1662197480393-2a82030b7b83?w=1200&h=600&fit=crop&auto=format" 
                        alt="양식 요리" 
                        class="w-full h-full object-cover">
                    <div class="absolute inset-0 bg-black/20"></div>
                    <div class="absolute inset-0 flex items-center justify-center text-center text-white">
                        <div class="max-w-4xl px-6">
                            <span class="inline-block px-4 py-2 bg-white/90 text-gray-800 rounded-full text-sm mb-6 backdrop-blur-sm">양식</span>
                            <h2 class="text-3xl md:text-5xl lg:text-6xl mb-6 drop-shadow-lg">세계의 맛, 서양 요리</h2>
                            <p class="text-lg md:text-xl lg:text-2xl drop-shadow-md">집에서 즐기는 이탈리안 & 프렌치</p>
                        </div>
                    </div>
                </div>

                <!-- 슬라이드 3 - 중식 -->
                <div class="slide absolute inset-0 slide-transition opacity-0" data-slide="2">
                    <img src="https://images.unsplash.com/photo-1667474667223-bf26ff0db2a4?w=1200&h=600&fit=crop&auto=format" 
                        alt="중식 요리" 
                        class="w-full h-full object-cover">
                    <div class="absolute inset-0 bg-black/20"></div>
                    <div class="absolute inset-0 flex items-center justify-center text-center text-white">
                        <div class="max-w-4xl px-6">
                            <span class="inline-block px-4 py-2 bg-white/90 text-gray-800 rounded-full text-sm mb-6 backdrop-blur-sm">중식</span>
                            <h2 class="text-3xl md:text-5xl lg:text-6xl mb-6 drop-shadow-lg">진짜 중식의 깊은 맛</h2>
                            <p class="text-lg md:text-xl lg:text-2xl drop-shadow-md">집에서 만드는 authentic 중국 요리</p>
                        </div>
                    </div>
                </div>

                <!-- 슬라이드 4 - 일식 -->
                <div class="slide absolute inset-0 slide-transition opacity-0" data-slide="3">
                    <img src="https://images.unsplash.com/photo-1712725213572-443fe866a69a?w=1200&h=600&fit=crop&auto=format" 
                        alt="일식 요리" 
                        class="w-full h-full object-cover">
                    <div class="absolute inset-0 bg-black/20"></div>
                    <div class="absolute inset-0 flex items-center justify-center text-center text-white">
                        <div class="max-w-4xl px-6">
                            <span class="inline-block px-4 py-2 bg-white/90 text-gray-800 rounded-full text-sm mb-6 backdrop-blur-sm">일식</span>
                            <h2 class="text-3xl md:text-5xl lg:text-6xl mb-6 drop-shadow-lg">정교한 일본 요리의 예술</h2>
                            <p class="text-lg md:text-xl lg:text-2xl drop-shadow-md">섬세함이 담긴 일식 레시피</p>
                        </div>
                    </div>
                </div>

                <!-- 슬라이드 5 - 디저트 -->
                <div class="slide absolute inset-0 slide-transition opacity-0" data-slide="4">
                    <img src="https://images.unsplash.com/photo-1644158776192-2d24ce35da1d?w=1200&h=600&fit=crop&auto=format" 
                        alt="디저트" 
                        class="w-full h-full object-cover">
                    <div class="absolute inset-0 bg-black/20"></div>
                    <div class="absolute inset-0 flex items-center justify-center text-center text-white">
                        <div class="max-w-4xl px-6">
                            <span class="inline-block px-4 py-2 bg-white/90 text-gray-800 rounded-full text-sm mb-6 backdrop-blur-sm">디저트</span>
                            <h2 class="text-3xl md:text-5xl lg:text-6xl mb-6 drop-shadow-lg">달콤한 마무리</h2>
                            <p class="text-lg md:text-xl lg:text-2xl drop-shadow-md">특별한 날을 위한 홈메이드 디저트</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 네비게이션 화살표 -->
            <button
                onclick="previousSlide()"
                class="absolute left-4 top-1/2 transform -translate-y-1/2 bg-white/20 hover:bg-white/30 text-white p-3 rounded-full transition-all duration-200 opacity-0 group-hover:opacity-100 backdrop-blur-sm"
                aria-label="이전 슬라이드"
            >
                <i data-lucide="chevron-left" class="w-6 h-6"></i>
            </button>

            <button
                onclick="nextSlide()"
                class="absolute right-4 top-1/2 transform -translate-y-1/2 bg-white/20 hover:bg-white/30 text-white p-3 rounded-full transition-all duration-200 opacity-0 group-hover:opacity-100 backdrop-blur-sm"
                aria-label="다음 슬라이드"
            >
                <i data-lucide="chevron-right" class="w-6 h-6"></i>
            </button>

            <!-- 도트 인디케이터 -->
            <div class="absolute bottom-6 left-1/2 transform -translate-x-1/2 flex space-x-3">
                <button onclick="goToSlide(0)" class="slide-dot w-3 h-3 rounded-full bg-white scale-125 transition-all duration-200" aria-label="1번째 슬라이드로 이동"></button>
                <button onclick="goToSlide(1)" class="slide-dot w-3 h-3 rounded-full bg-white/50 hover:bg-white/75 transition-all duration-200" aria-label="2번째 슬라이드로 이동"></button>
                <button onclick="goToSlide(2)" class="slide-dot w-3 h-3 rounded-full bg-white/50 hover:bg-white/75 transition-all duration-200" aria-label="3번째 슬라이드로 이동"></button>
                <button onclick="goToSlide(3)" class="slide-dot w-3 h-3 rounded-full bg-white/50 hover:bg-white/75 transition-all duration-200" aria-label="4번째 슬라이드로 이동"></button>
                <button onclick="goToSlide(4)" class="slide-dot w-3 h-3 rounded-full bg-white/50 hover:bg-white/75 transition-all duration-200" aria-label="5번째 슬라이드로 이동"></button>
            </div>
        </div>
    </section>

    <!-- 인기 레시피 섹션 - PopularRecipes.tsx 기반 -->
    <section id="popular" class="py-16 bg-gray-50/30">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-12">
                <div class="flex items-center justify-center mb-4">
                    <i data-lucide="trending-up" class="h-8 w-8 text-orange-500 mr-3"></i>
                    <h2 class="text-4xl font-black brand-gradient">인기 레시피</h2>
                </div>
                <p class="text-gray-600 max-w-2xl mx-auto">
                    CheForest 사용자들이 가장 사랑하는 레시피를 만나보세요. 좋아요가 높은 검증된 맛있는 요리들입니다.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <!-- 레시피 카드 1 - 집에서 만드는 불고기 -->
                <div class="recipe-card bg-white rounded-xl shadow-lg overflow-hidden cursor-pointer" onclick="showPage('recipe-detail')">
                    <div class="relative">
                        <img src="https://images.unsplash.com/photo-1584278858536-52532423b9ea?w=400&h=300&fit=crop&auto=format" 
                            alt="집에서 만드는 불고기" 
                            class="recipe-image w-full h-48 object-cover">
                        <div class="absolute top-3 left-3">
                            <span class="bg-red-100 text-red-800 px-3 py-1 rounded-full text-sm font-medium">한식</span>
                        </div>
                    </div>
                    <div class="p-4">
                        <h3 class="text-lg mb-2 hover:text-orange-500 transition-colors">집에서 만드는 불고기</h3>
                        <p class="text-sm text-gray-600 mb-3">by 요리사 김민수</p>
                        
                        <div class="flex items-center justify-between text-sm text-gray-500 mb-3">
                            <div class="flex items-center space-x-1">
                                <i data-lucide="clock" class="w-4 h-4"></i>
                                <span>30분</span>
                            </div>
                            <span class="text-xs bg-gray-100 px-2 py-1 rounded">보통</span>
                        </div>

                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                            <div class="flex items-center space-x-3 text-sm">
                                <div class="flex items-center space-x-1 text-gray-500">
                                    <i data-lucide="eye" class="w-4 h-4"></i>
                                    <span>12.5k</span>
                                </div>
                                <div class="flex items-center space-x-1 text-red-500">
                                    <i data-lucide="heart" class="w-4 h-4"></i>
                                    <span>892</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 레시피 카드 2 - 크리미 카르보나라 파스타 -->
                <div class="recipe-card bg-white rounded-xl shadow-lg overflow-hidden cursor-pointer" onclick="showPage('recipe-detail')">
                    <div class="relative">
                        <img src="https://images.unsplash.com/photo-1651585594107-859f80b4ca3a?w=400&h=300&fit=crop&auto=format" 
                            alt="크리미 카르보나라 파스타" 
                            class="recipe-image w-full h-48 object-cover">
                        <div class="absolute top-3 left-3">
                            <span class="bg-green-100 text-green-800 px-3 py-1 rounded-full text-sm font-medium">양식</span>
                        </div>
                    </div>
                    <div class="p-4">
                        <h3 class="text-lg mb-2 hover:text-orange-500 transition-colors">크리미 카르보나라 파스타</h3>
                        <p class="text-sm text-gray-600 mb-3">by 셰프 이영희</p>
                        
                        <div class="flex items-center justify-between text-sm text-gray-500 mb-3">
                            <div class="flex items-center space-x-1">
                                <i data-lucide="clock" class="w-4 h-4"></i>
                                <span>20분</span>
                            </div>
                            <span class="text-xs bg-gray-100 px-2 py-1 rounded">쉬움</span>
                        </div>

                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                            <div class="flex items-center space-x-3 text-sm">
                                <div class="flex items-center space-x-1 text-gray-500">
                                    <i data-lucide="eye" class="w-4 h-4"></i>
                                    <span>9.9k</span>
                                </div>
                                <div class="flex items-center space-x-1 text-red-500">
                                    <i data-lucide="heart" class="w-4 h-4"></i>
                                    <span>756</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 레시피 카드 3 - 매콤한 궁보계정 -->
                <div class="recipe-card bg-white rounded-xl shadow-lg overflow-hidden cursor-pointer" onclick="showPage('recipe-detail')">
                    <div class="relative">
                        <img src="https://images.unsplash.com/photo-1597890698474-8de5af43b1aa?w=400&h=300&fit=crop&auto=format" 
                            alt="매콤한 궁보계정" 
                            class="recipe-image w-full h-48 object-cover">
                        <div class="absolute top-3 left-3">
                            <span class="bg-yellow-100 text-yellow-800 px-3 py-1 rounded-full text-sm font-medium">중식</span>
                        </div>
                    </div>
                    <div class="p-4">
                        <h3 class="text-lg mb-2 hover:text-orange-500 transition-colors">매콤한 궁보계정</h3>
                        <p class="text-sm text-gray-600 mb-3">by 요리연구가 박진우</p>
                        
                        <div class="flex items-center justify-between text-sm text-gray-500 mb-3">
                            <div class="flex items-center space-x-1">
                                <i data-lucide="clock" class="w-4 h-4"></i>
                                <span>25분</span>
                            </div>
                            <span class="text-xs bg-gray-100 px-2 py-1 rounded">보통</span>
                        </div>

                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                            <div class="flex items-center space-x-3 text-sm">
                                <div class="flex items-center space-x-1 text-gray-500">
                                    <i data-lucide="eye" class="w-4 h-4"></i>
                                    <span>8.2k</span>
                                </div>
                                <div class="flex items-center space-x-1 text-red-500">
                                    <i data-lucide="heart" class="w-4 h-4"></i>
                                    <span>634</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 레시피 카드 4 - 연어 데리야키 -->
                <div class="recipe-card bg-white rounded-xl shadow-lg overflow-hidden cursor-pointer" onclick="showPage('recipe-detail')">
                    <div class="relative">
                        <img src="https://images.unsplash.com/photo-1700706259342-3b4f681f9bfe?w=400&h=300&fit=crop&auto=format" 
                            alt="연어 데리야키" 
                            class="recipe-image w-full h-48 object-cover">
                        <div class="absolute top-3 left-3">
                            <span class="bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm font-medium">일식</span>
                        </div>
                    </div>
                    <div class="p-4">
                        <h3 class="text-lg mb-2 hover:text-orange-500 transition-colors">연어 데리야키</h3>
                        <p class="text-sm text-gray-600 mb-3">by 일식전문가 최수진</p>
                        
                        <div class="flex items-center justify-between text-sm text-gray-500 mb-3">
                            <div class="flex items-center space-x-1">
                                <i data-lucide="clock" class="w-4 h-4"></i>
                                <span>15분</span>
                            </div>
                            <span class="text-xs bg-gray-100 px-2 py-1 rounded">쉬움</span>
                        </div>

                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                            <div class="flex items-center space-x-3 text-sm">
                                <div class="flex items-center space-x-1 text-gray-500">
                                    <i data-lucide="eye" class="w-4 h-4"></i>
                                    <span>7.6k</span>
                                </div>
                                <div class="flex items-center space-x-1 text-red-500">
                                    <i data-lucide="heart" class="w-4 h-4"></i>
                                    <span>543</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="text-center mt-10">
                <button class="btn-orange text-white px-8 py-3 rounded-lg transition-all duration-200">
                    더 많은 레시피 보기
                </button>
            </div>
        </div>
    </section>

    <!-- 카테고리별 탐색 섹션 - CategoryNavigation.tsx 기반 -->
    <section class="py-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-12">
                <div class="flex items-center justify-center mb-4">
                    <i data-lucide="compass" class="h-8 w-8 text-orange-500 mr-3"></i>
                    <h2 class="text-4xl font-black brand-gradient">카테고리별 탐색</h2>
                </div>
                <p class="text-gray-600 max-w-4xl mx-auto">
                    한식부터 디저트까지, 원하는 요리 스타일을 선택하고 탐색해보세요.
                </p>
            </div>

            <!-- 카테고리 선택 -->
            <div class="flex flex-wrap justify-center gap-4 mb-8">
                <button class="category-btn active flex items-center space-x-3 px-6 py-3 rounded-xl transition-all duration-300 font-semibold border bg-gradient-to-r from-pink-500 to-orange-500 text-white shadow-2xl shadow-pink-500/30 border-transparent transform scale-105 hover:shadow-2xl hover:shadow-pink-500/40" onclick="switchCategory('korean')">
                    <span class="text-2xl">🥢</span>
                    <span class="whitespace-nowrap">한식</span>
                </button>
                <button class="category-btn flex items-center space-x-3 px-6 py-3 rounded-xl transition-all duration-300 font-semibold border bg-white text-gray-700 shadow-lg shadow-gray-200/50 border-gray-100 hover:shadow-2xl hover:shadow-orange-500/30 hover:bg-gradient-to-r hover:from-pink-500 hover:to-orange-500 hover:text-white hover:transform hover:scale-105 hover:border-transparent" onclick="switchCategory('western')">
                    <span class="text-2xl">🍝</span>
                    <span class="whitespace-nowrap">양식</span>
                </button>
                <button class="category-btn flex items-center space-x-3 px-6 py-3 rounded-xl transition-all duration-300 font-semibold border bg-white text-gray-700 shadow-lg shadow-gray-200/50 border-gray-100 hover:shadow-2xl hover:shadow-orange-500/30 hover:bg-gradient-to-r hover:from-pink-500 hover:to-orange-500 hover:text-white hover:transform hover:scale-105 hover:border-transparent" onclick="switchCategory('chinese')">
                    <span class="text-2xl">🥟</span>
                    <span class="whitespace-nowrap">중식</span>
                </button>
                <button class="category-btn flex items-center space-x-3 px-6 py-3 rounded-xl transition-all duration-300 font-semibold border bg-white text-gray-700 shadow-lg shadow-gray-200/50 border-gray-100 hover:shadow-2xl hover:shadow-orange-500/30 hover:bg-gradient-to-r hover:from-pink-500 hover:to-orange-500 hover:text-white hover:transform hover:scale-105 hover:border-transparent" onclick="switchCategory('japanese')">
                    <span class="text-2xl">🍣</span>
                    <span class="whitespace-nowrap">일식</span>
                </button>
                <button class="category-btn flex items-center space-x-3 px-6 py-3 rounded-xl transition-all duration-300 font-semibold border bg-white text-gray-700 shadow-lg shadow-gray-200/50 border-gray-100 hover:shadow-2xl hover:shadow-orange-500/30 hover:bg-gradient-to-r hover:from-pink-500 hover:to-orange-500 hover:text-white hover:transform hover:scale-105 hover:border-transparent" onclick="switchCategory('dessert')">
                    <span class="text-2xl">🧁</span>
                    <span class="whitespace-nowrap">디저트</span>
                </button>
            </div>

            <!-- 선택된 카테고리의 탭 콘텐츠 -->
            <div class="max-w-4xl mx-auto">
                <div class="w-full">
                    <div class="grid w-full grid-cols-2 mb-8 bg-gray-100 rounded-lg p-1">
                        <button class="tab-btn active flex items-center justify-center space-x-2 py-2 px-4 rounded-md bg-white shadow-sm font-medium text-gray-900" onclick="switchTab('recipes')">
                            <i data-lucide="chef-hat" class="w-4 h-4"></i>
                            <span>CheForest 레시피</span>
                        </button>
                        <button class="tab-btn flex items-center justify-center space-x-2 py-2 px-4 rounded-md font-medium text-gray-600 hover:text-gray-900" onclick="switchTab('community')">
                            <i data-lucide="users" class="w-4 h-4"></i>
                            <span>사용자 레시피</span>
                        </button>
                    </div>

                    <div id="recipesTab" class="tab-content">
                        <div class="bg-white border border-gray-200 rounded-lg">
                            <div class="p-6">
                                <div class="flex items-center justify-between mb-6">
                                    <h3 class="text-xl" id="categoryTitle">
                                        한식 CheForest 레시피
                                    </h3>
                                    <button class="text-orange-500 hover:text-transparent hover:bg-gradient-to-r hover:from-pink-500 hover:to-orange-500 hover:bg-clip-text flex items-center space-x-1 transition-all duration-200">
                                        <span>전체보기</span>
                                        <i data-lucide="arrow-right" class="w-4 h-4"></i>
                                    </button>
                                </div>
                                
                                <div class="space-y-4" id="recipesList">
                                    <div class="flex items-center justify-between p-4 bg-gray-50/30 rounded-lg hover:bg-gray-50/50 transition-colors cursor-pointer" onclick="showPage('recipe-detail')">
                                        <div class="flex-1">
                                            <h4 class="font-medium mb-1">간단한 김치찌개</h4>
                                            <p class="text-sm text-gray-600">by 김요리사</p>
                                        </div>
                                        <div class="flex items-center space-x-4 text-sm">
                                            <div class="flex items-center space-x-1">
                                                <i data-lucide="star" class="w-4 h-4 fill-yellow-400 text-yellow-400"></i>
                                                <span>4.8</span>
                                                <span class="text-gray-500">(234)</span>
                                            </div>
                                            <span class="bg-gray-100 text-gray-600 px-2 py-1 rounded text-xs">1위</span>
                                        </div>
                                    </div>
                                    <div class="flex items-center justify-between p-4 bg-gray-50/30 rounded-lg hover:bg-gray-50/50 transition-colors cursor-pointer" onclick="showPage('recipe-detail')">
                                        <div class="flex-1">
                                            <h4 class="font-medium mb-1">부드러운 갈비찜</h4>
                                            <p class="text-sm text-gray-600">by 박셰프</p>
                                        </div>
                                        <div class="flex items-center space-x-4 text-sm">
                                            <div class="flex items-center space-x-1">
                                                <i data-lucide="star" class="w-4 h-4 fill-yellow-400 text-yellow-400"></i>
                                                <span>4.9</span>
                                                <span class="text-gray-500">(189)</span>
                                            </div>
                                            <span class="bg-gray-100 text-gray-600 px-2 py-1 rounded text-xs">2위</span>
                                        </div>
                                    </div>
                                    <div class="flex items-center justify-between p-4 bg-gray-50/30 rounded-lg hover:bg-gray-50/50 transition-colors cursor-pointer" onclick="showPage('recipe-detail')">
                                        <div class="flex-1">
                                            <h4 class="font-medium mb-1">매콤한 떡볶이</h4>
                                            <p class="text-sm text-gray-600">by 이요리연구가</p>
                                        </div>
                                        <div class="flex items-center space-x-4 text-sm">
                                            <div class="flex items-center space-x-1">
                                                <i data-lucide="star" class="w-4 h-4 fill-yellow-400 text-yellow-400"></i>
                                                <span>4.7</span>
                                                <span class="text-gray-500">(312)</span>
                                            </div>
                                            <span class="bg-gray-100 text-gray-600 px-2 py-1 rounded text-xs">3위</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="communityTab" class="tab-content hidden">
                        <div class="bg-white border border-gray-200 rounded-lg">
                            <div class="p-6">
                                <div class="flex items-center justify-between mb-6">
                                    <h3 class="text-xl" id="communityTitle">
                                        한식 사용자 레시피
                                    </h3>
                                    <button class="text-orange-500 hover:text-transparent hover:bg-gradient-to-r hover:from-pink-500 hover:to-orange-500 hover:bg-clip-text flex items-center space-x-1 transition-all duration-200">
                                        <span>전체보기</span>
                                        <i data-lucide="arrow-right" class="w-4 h-4"></i>
                                    </button>
                                </div>
                                
                                <div class="space-y-4">
                                    <div class="flex items-center justify-between p-4 bg-gray-50/30 rounded-lg hover:bg-gray-50/50 transition-colors cursor-pointer">
                                        <div class="flex-1">
                                            <h4 class="font-medium mb-1">요리 초보 질문있어요!</h4>
                                            <p class="text-sm text-gray-600">by 요리새싹</p>
                                        </div>
                                        <div class="flex items-center space-x-4 text-sm text-gray-500">
                                            <span>답글 23개</span>
                                            <span>2시간 전</span>
                                        </div>
                                    </div>
                                    <div class="flex items-center justify-between p-4 bg-gray-50/30 rounded-lg hover:bg-gray-50/50 transition-colors cursor-pointer">
                                        <div class="flex-1">
                                            <h4 class="font-medium mb-1">김치찌개 맛있게 끓이는 팁</h4>
                                            <p class="text-sm text-gray-600">by 김치마스터</p>
                                        </div>
                                        <div class="flex items-center space-x-4 text-sm text-gray-500">
                                            <span>답글 45개</span>
                                            <span>5시간 전</span>
                                        </div>
                                    </div>
                                    <div class="flex items-center justify-between p-4 bg-gray-50/30 rounded-lg hover:bg-gray-50/50 transition-colors cursor-pointer">
                                        <div class="flex-1">
                                            <h4 class="font-medium mb-1">이번 주말 요리 모임 어떠세요?</h4>
                                            <p class="text-sm text-gray-600">by 요리모임장</p>
                                        </div>
                                        <div class="flex items-center space-x-4 text-sm text-gray-500">
                                            <span>답글 12개</span>
                                            <span>1일 전</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 이벤트 & 클래스 섹션 - Events.tsx 기반 -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <!-- 섹션 헤더 -->
        <div class="text-center mb-12">
            <div class="flex items-center justify-center mb-4">
                <i data-lucide="trophy" class="h-8 w-8 text-orange-500 mr-3"></i>
                <h2 class="text-4xl font-black brand-gradient">이벤트 & 클래스</h2>
            </div>
            <p class="text-gray-600 max-w-2xl mx-auto">
                CheForest에서 진행하는 특별한 이벤트와 요리 클래스에 참여해보세요! 
                전문 셰프와 함께하는 클래스부터 푸짐한 상금의 공모전까지 다양한 기회가 기다립니다.
            </p>
        </div>

        <!-- 이벤트 카드 그리드 -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <!-- 이벤트 카드 1 - 레시피 공모전 -->
            <div class="event-card bg-white border-2 border-gray-200 hover:border-orange-500 transition-all duration-300 hover:shadow-xl rounded-lg overflow-hidden group">
                <div class="relative">
                    <img src="https://images.unsplash.com/photo-1741980983785-d879e5c4f50c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxyZWNpcGUlMjBjb250ZXN0JTIwYXdhcmQlMjBwcml6ZXxlbnwxfHx8fDE3NTc1NzgyNzl8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral" 
                        alt="2024 CheForest 레시피 공모전" 
                        class="event-image w-full h-48 object-cover group-hover:scale-105 transition-transform duration-300">
                    <div class="absolute top-4 left-4">
                        <span class="bg-green-500 text-white px-3 py-1 rounded font-medium">모집중</span>
                    </div>
                    <div class="absolute top-4 right-4">
                        <span class="bg-white/90 text-gray-700 px-3 py-1 rounded font-medium">공모전</span>
                    </div>
                </div>

                <div class="p-6">
                    <h3 class="text-xl font-semibold mb-2 group-hover:text-orange-500 transition-colors">
                        2024 CheForest 레시피 공모전
                    </h3>
                    <p class="text-gray-600 line-clamp-2 mb-4">
                        창의적이고 건강한 레시피로 도전하세요! 우승자에게는 100만원 상금과 CheForest 명예의 전당에 이름이 등록됩니다.
                    </p>

                    <!-- 이벤트 정보 -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 text-sm mb-4">
                        <div class="flex items-center text-gray-600">
                            <i data-lucide="calendar" class="h-4 w-4 mr-2 text-orange-500"></i>
                            <span>2024-01-15 ~ 2024-02-29</span>
                        </div>
                        <div class="flex items-center text-gray-600">
                            <i data-lucide="clock" class="h-4 w-4 mr-2 text-orange-500"></i>
                            <span>24시간 접수</span>
                        </div>
                        <div class="flex items-center text-gray-600">
                            <i data-lucide="users" class="h-4 w-4 mr-2 text-orange-500"></i>
                            <span>1,247명 참여</span>
                        </div>
                        <div class="flex items-center text-gray-600">
                            <i data-lucide="chef-hat" class="h-4 w-4 mr-2 text-orange-500"></i>
                            <span>총 상금 300만원</span>
                        </div>
                    </div>

                    <!-- 액션 버튼 -->
                    <div class="flex gap-3 pt-2">
                        <button class="flex-1 btn-orange text-white py-2 px-4 rounded-lg font-medium">
                            지금 참여하기
                        </button>
                        <button class="border border-orange-500 text-orange-500 hover:bg-orange-50 py-2 px-4 rounded-lg font-medium">
                            자세히 보기
                        </button>
                    </div>
                </div>
            </div>

            <!-- 이벤트 카드 2 - 요리 클래스 -->
            <div class="event-card bg-white border-2 border-gray-200 hover:border-orange-500 transition-all duration-300 hover:shadow-xl rounded-lg overflow-hidden group">
                <div class="relative">
                    <img src="https://images.unsplash.com/photo-1681889870636-3f58e5288e03?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjb29raW5nJTIwd29ya3Nob3AlMjBtYXN0ZXJjbGFzc3xlbnwxfHx8fDE3NTc1NzgyODJ8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral" 
                        alt="프리미엄 셰프와 함께하는 요리 클래스" 
                        class="event-image w-full h-48 object-cover group-hover:scale-105 transition-transform duration-300">
                    <div class="absolute top-4 left-4">
                        <span class="bg-red-500 text-white px-3 py-1 rounded font-medium">마감임박</span>
                    </div>
                    <div class="absolute top-4 right-4">
                        <span class="bg-white/90 text-gray-700 px-3 py-1 rounded font-medium">클래스</span>
                    </div>
                </div>

                <div class="p-6">
                    <h3 class="text-xl font-semibold mb-2 group-hover:text-orange-500 transition-colors">
                        프리미엄 셰프와 함께하는 요리 클래스
                    </h3>
                    <p class="text-gray-600 line-clamp-2 mb-4">
                        미슐랭 스타 셰프와 함께하는 특별한 요리 클래스! 프랑스 정통 요리법을 배우고 고급 요리 스킬을 익혀보세요.
                    </p>

                    <!-- 이벤트 정보 -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 text-sm mb-4">
                        <div class="flex items-center text-gray-600">
                            <i data-lucide="calendar" class="h-4 w-4 mr-2 text-orange-500"></i>
                            <span>2024-01-20</span>
                        </div>
                        <div class="flex items-center text-gray-600">
                            <i data-lucide="clock" class="h-4 w-4 mr-2 text-orange-500"></i>
                            <span>오후 2:00 - 5:00</span>
                        </div>
                        <div class="flex items-center text-gray-600">
                            <i data-lucide="users" class="h-4 w-4 mr-2 text-orange-500"></i>
                            <span>20명 한정</span>
                        </div>
                        <div class="flex items-center text-gray-600">
                            <i data-lucide="chef-hat" class="h-4 w-4 mr-2 text-orange-500"></i>
                            <span>수료증 발급</span>
                        </div>
                    </div>

                    <!-- 액션 버튼 -->
                    <div class="flex gap-3 pt-2">
                        <button class="flex-1 btn-orange text-white py-2 px-4 rounded-lg font-medium">
                            신청하기
                        </button>
                        <button class="border border-orange-500 text-orange-500 hover:bg-orange-50 py-2 px-4 rounded-lg font-medium">
                            자세히 보기
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 더 많은 이벤트 버튼 -->
        <div class="text-center mt-12">
            <button class="bg-gradient-to-r from-pink-500 to-orange-500 hover:from-pink-600 hover:to-orange-600 text-white px-8 py-3 rounded-lg font-medium text-lg">
                더 많은 이벤트 보기
            </button>
        </div>
    </section>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
    <script src="/js/common.js"></script>
    <script src="/js/home.js"></script>

    <!-- 홈 콘텐츠 로드 -->
    <script>
        async function loadHomeContent() {
            try {
                // home.html 로드
                const response = await fetch('home.html');
                const homeHTML = await response.text();
                document.getElementById('home-content-container').innerHTML = homeHTML;
                
                // Lucide 아이콘 초기화
                lucide.createIcons();
                
                console.log('✅ 홈 콘텐츠만 성공적으로 로드되었습니다!');
                console.log('📁 사용된 파일: common.css, home.css, common.js, home.js, home.html');
                
            } catch (error) {
                console.error('❌ 홈 콘텐츠 로드 중 오류 발생:', error);
            }
        }

        // 페이지 로드 시 실행
        document.addEventListener('DOMContentLoaded', loadHomeContent);
    </script>
    <jsp:include page="/common/footer.jsp"/>
</body>
</html>