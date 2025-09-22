<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
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
                    요리사들이 가장 사랑하는 레시피를 만나보세요. 좋아요와 조회수가 높은 검증된 맛있는 요리들입니다.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <%-- 인기 레시피 카드 반복 --%>
                <c:forEach var="recipe" items="${popularRecipes}" varStatus="status">
                    <div class="recipe-card bg-white rounded-xl shadow-lg overflow-hidden cursor-pointer" onclick="location.href='${pageContext.request.contextPath}/recipe/detail?id=${recipe.recipeId}'">
                        <div class="relative">
                            <img src="${recipe.imageUrl}"
                                 alt="<c:out value='${recipe.title}'/>"
                                 class="recipe-image w-full h-48 object-cover">
                            <div class="absolute top-3 left-3">
                            <span class="bg-${recipe.categoryColor}-100 text-${recipe.categoryColor}-800 px-3 py-1 rounded-full text-sm font-medium">
                                <c:out value="${recipe.categoryName}"/>
                            </span>
                            </div>
                        </div>
                        <div class="p-4">
                            <h3 class="text-lg mb-2 hover:text-orange-500 transition-colors">
                                <c:out value="${recipe.title}"/>
                            </h3>
                            <p class="text-sm text-gray-600 mb-3">
                                by <c:out value="${recipe.authorName}"/>
                            </p>

                            <div class="flex items-center justify-between text-sm text-gray-500 mb-3">
                                <div class="flex items-center space-x-1">
                                    <i data-lucide="clock" class="w-4 h-4"></i>
                                    <span>${recipe.cookingTime}분</span>
                                </div>
                                <span class="text-xs bg-gray-100 px-2 py-1 rounded">
                                <c:out value="${recipe.difficulty}"/>
                            </span>
                            </div>

                            <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                <div class="flex items-center space-x-3 text-sm">
                                    <div class="flex items-center space-x-1 text-gray-500">
                                        <i data-lucide="eye" class="w-4 h-4"></i>
                                        <span>
                                        <c:choose>
                                            <c:when test="${recipe.viewCount >= 1000}">
                                                <fmt:formatNumber value="${recipe.viewCount / 1000}" maxFractionDigits="1"/>k
                                            </c:when>
                                            <c:otherwise>
                                                ${recipe.viewCount}
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    </div>
                                    <div class="flex items-center space-x-1 text-red-500">
                                        <i data-lucide="heart" class="w-4 h-4"></i>
                                        <span>${recipe.likeCount}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <%-- 인기 레시피가 없는 경우 기본 카드 --%>
                <c:if test="${empty popularRecipes}">
                    <%-- 기본 인기 레시피 카드들 (하드코딩) --%>
                    <div class="recipe-card bg-white rounded-xl shadow-lg overflow-hidden cursor-pointer">
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
                </c:if>
            </div>

            <div class="text-center mt-10">
                <button class="btn-orange text-white px-8 py-3 rounded-lg transition-all duration-200"
                        onclick="location.href='${pageContext.request.contextPath}/recipes'">
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
                <%-- 카테고리 버튼 반복 --%>
                <c:forEach var="category" items="${categories}" varStatus="status">
                    <button class="category-btn ${status.index == 0 ? 'active' : ''} flex items-center space-x-3 px-6 py-3 rounded-xl transition-all duration-300 font-semibold border ${status.index == 0 ? 'bg-gradient-to-r from-pink-500 to-orange-500 text-white shadow-2xl shadow-pink-500/30 border-transparent transform scale-105 hover:shadow-2xl hover:shadow-pink-500/40' : 'bg-white text-gray-700 shadow-lg shadow-gray-200/50 border-gray-100 hover:shadow-2xl hover:shadow-orange-500/30 hover:bg-gradient-to-r hover:from-pink-500 hover:to-orange-500 hover:text-white hover:transform hover:scale-105 hover:border-transparent'}"
                            onclick="switchCategory('${category.code}')">
                        <span class="text-2xl"><c:out value="${category.emoji}"/></span>
                        <span class="whitespace-nowrap"><c:out value="${category.name}"/></span>
                    </button>
                </c:forEach>

                <%-- 기본 카테고리 (데이터가 없는 경우) --%>
                <c:if test="${empty categories}">
                    <button class="category-btn active flex items-center space-x-3 px-6 py-3 rounded-xl transition-all duration-300 font-semibold border bg-gradient-to-r from-pink-500 to-orange-500 text-white shadow-2xl shadow-pink-500/30 border-transparent transform scale-105 hover:shadow-2xl hover:shadow-pink-500/40" onclick="switchCategory('korean')">
                        <span class="text-2xl">🥢</span>
                        <span class="whitespace-nowrap">한식</span>
                    </button>
                    <button class="category-btn flex items-center space-x-3 px-6 py-3 rounded-xl transition-all duration-300 font-semibold border bg-white text-gray-700 shadow-lg shadow-gray-200/50 border-gray-100 hover:shadow-2xl hover:shadow-orange-500/30 hover:bg-gradient-to-r hover:from-pink-500 hover:to-orange-500 hover:text-white hover:transform hover:scale-105 hover:border-transparent" onclick="switchCategory('western')">
                        <span class="text-2xl">🍝</span>
                        <span class="whitespace-nowrap">양식</span>
                    </button>
                </c:if>
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
                                        ${currentCategory != null ? currentCategory.name : '한식'} CheForest 레시피
                                    </h3>
                                    <button class="text-orange-500 hover:text-transparent hover:bg-gradient-to-r hover:from-pink-500 hover:to-orange-500 hover:bg-clip-text flex items-center space-x-1 transition-all duration-200"
                                            onclick="location.href='${pageContext.request.contextPath}/recipes?category=${currentCategory != null ? currentCategory.code : 'korean'}'">
                                        <span>전체보기</span>
                                        <i data-lucide="arrow-right" class="w-4 h-4"></i>
                                    </button>
                                </div>

                                <div class="space-y-4" id="recipesList">
                                    <%-- 카테고리별 레시피 목록 --%>
                                    <c:forEach var="recipe" items="${categoryRecipes}" varStatus="status">
                                        <div class="flex items-center justify-between p-4 bg-gray-50/30 rounded-lg hover:bg-gray-50/50 transition-colors cursor-pointer"
                                             onclick="location.href='${pageContext.request.contextPath}/recipe/detail?id=${recipe.recipeId}'">
                                            <div class="flex-1">
                                                <h4 class="font-medium mb-1"><c:out value="${recipe.title}"/></h4>
                                                <p class="text-sm text-gray-600">by <c:out value="${recipe.authorName}"/></p>
                                            </div>
                                            <div class="flex items-center space-x-4 text-sm">
                                                <div class="flex items-center space-x-1">
                                                    <i data-lucide="star" class="w-4 h-4 fill-yellow-400 text-yellow-400"></i>
                                                    <span><fmt:formatNumber value="${recipe.rating}" maxFractionDigits="1"/></span>
                                                    <span class="text-gray-500">(${recipe.reviewCount})</span>
                                                </div>
                                                <span class="bg-gray-100 text-gray-600 px-2 py-1 rounded text-xs">${status.index + 1}위</span>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <%-- 기본 레시피 목록 (데이터가 없는 경우) --%>
                                    <c:if test="${empty categoryRecipes}">
                                        <div class="flex items-center justify-between p-4 bg-gray-50/30 rounded-lg hover:bg-gray-50/50 transition-colors cursor-pointer">
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
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="communityTab" class="tab-content hidden">
                        <div class="bg-white border border-gray-200 rounded-lg">
                            <div class="p-6">
                                <div class="flex items-center justify-between mb-6">
                                    <h3 class="text-xl" id="communityTitle">
                                        ${currentCategory != null ? currentCategory.name : '한식'} 사용자 레시피
                                    </h3>
                                    <button class="text-orange-500 hover:text-transparent hover:bg-gradient-to-r hover:from-pink-500 hover:to-orange-500 hover:bg-clip-text flex items-center space-x-1 transition-all duration-200"
                                            onclick="location.href='${pageContext.request.contextPath}/board?category=${currentCategory != null ? currentCategory.code : 'korean'}'">
                                        <span>전체보기</span>
                                        <i data-lucide="arrow-right" class="w-4 h-4"></i>
                                    </button>
                                </div>

                                <div class="space-y-4">
                                    <%-- 커뮤니티 게시글 목록 --%>
                                    <c:forEach var="post" items="${communityPosts}">
                                        <div class="flex items-center justify-between p-4 bg-gray-50/30 rounded-lg hover:bg-gray-50/50 transition-colors cursor-pointer"
                                             onclick="location.href='${pageContext.request.contextPath}/board/detail?id=${post.postId}'">
                                            <div class="flex-1">
                                                <h4 class="font-medium mb-1"><c:out value="${post.title}"/></h4>
                                                <p class="text-sm text-gray-600">by <c:out value="${post.authorName}"/></p>
                                            </div>
                                            <div class="flex items-center space-x-4 text-sm text-gray-500">
                                                <span>답글 ${post.commentCount}개</span>
                                                <span>
                                                <c:choose>
                                                    <c:when test="${post.timeAgo < 60}">방금 전</c:when>
                                                    <c:when test="${post.timeAgo < 3600}">${post.timeAgo / 60}분 전</c:when>
                                                    <c:when test="${post.timeAgo < 86400}">${post.timeAgo / 3600}시간 전</c:when>
                                                    <c:otherwise>${post.timeAgo / 86400}일 전</c:otherwise>
                                                </c:choose>
                                            </span>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <%-- 기본 커뮤니티 게시글 (데이터가 없는 경우) --%>
                                    <c:if test="${empty communityPosts}">
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
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 이벤트 & 클래스 섹션 - Events.tsx 기반 -->
    <section class="py-16 bg-gradient-to-br from-pink-50 via-white to-orange-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-12">
                <div class="flex items-center justify-center mb-4">
                    <i data-lucide="calendar" class="h-8 w-8 text-orange-500 mr-3"></i>
                    <h2 class="text-4xl font-black brand-gradient">이벤트 & 클래스</h2>
                </div>
                <p class="text-gray-600 max-w-2xl mx-auto">
                    CheForest에서 진행하는 특별한 이벤트와 요리 클래스에 참여해보세요.
                </p>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                <%-- 이벤트 카드 반복 --%>
                <c:forEach var="event" items="${activeEvents}">
                    <div class="group relative bg-white rounded-2xl shadow-xl overflow-hidden hover:shadow-2xl transition-all duration-300 cursor-pointer"
                         onclick="location.href='${pageContext.request.contextPath}/events/detail?id=${event.eventId}'">
                        <div class="relative h-64 overflow-hidden">
                            <img src="${event.imageUrl}"
                                 alt="<c:out value='${event.title}'/>"
                                 class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">

                            <div class="absolute top-4 left-4">
                            <span class="bg-gradient-to-r from-pink-500 to-orange-500 text-white px-4 py-2 rounded-full text-sm font-medium">
                                <c:out value="${event.type}"/>
                            </span>
                            </div>

                            <c:if test="${event.isPopular}">
                                <div class="absolute top-4 right-4">
                                    <span class="bg-red-500 text-white px-3 py-1 rounded-full text-xs font-medium">인기</span>
                                </div>
                            </c:if>

                            <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                        </div>

                        <div class="p-6">
                            <h3 class="text-xl mb-3 group-hover:text-orange-500 transition-colors">
                                <c:out value="${event.title}"/>
                            </h3>
                            <p class="text-gray-600 mb-4 line-clamp-2">
                                <c:out value="${event.description}"/>
                            </p>

                            <div class="flex items-center justify-between text-sm">
                                <div class="flex items-center space-x-4 text-gray-500">
                                    <div class="flex items-center space-x-1">
                                        <i data-lucide="calendar" class="w-4 h-4"></i>
                                        <span><fmt:formatDate value="${event.startDate}" pattern="MM.dd"/></span>
                                    </div>
                                    <div class="flex items-center space-x-1">
                                        <i data-lucide="users" class="w-4 h-4"></i>
                                        <span>${event.participantCount}/${event.maxParticipants}</span>
                                    </div>
                                </div>
                                <div class="flex items-center space-x-2">
                                    <c:choose>
                                        <c:when test="${event.isFree}">
                                            <span class="text-green-600 font-medium">무료</span>
                                        </c:when>
                                        <c:otherwise>
                                        <span class="text-orange-500 font-medium">
                                            <fmt:formatNumber value="${event.price}" type="currency" currencySymbol="₩"/>
                                        </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <%-- 기본 이벤트 카드 (데이터가 없는 경우) --%>
                <c:if test="${empty activeEvents}">
                    <div class="group relative bg-white rounded-2xl shadow-xl overflow-hidden hover:shadow-2xl transition-all duration-300 cursor-pointer">
                        <div class="relative h-64 overflow-hidden">
                            <img src="https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=600&h=400&fit=crop&auto=format"
                                 alt="요리 클래스"
                                 class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">

                            <div class="absolute top-4 left-4">
                            <span class="bg-gradient-to-r from-pink-500 to-orange-500 text-white px-4 py-2 rounded-full text-sm font-medium">
                                쿠킹 클래스
                            </span>
                            </div>
                        </div>

                        <div class="p-6">
                            <h3 class="text-xl mb-3 group-hover:text-orange-500 transition-colors">
                                홈메이드 파스타 만들기
                            </h3>
                            <p class="text-gray-600 mb-4 line-clamp-2">
                                이탈리아 전통 방식으로 직접 면을 뽑아 만드는 정통 파스타 클래스입니다.
                            </p>

                            <div class="flex items-center justify-between text-sm">
                                <div class="flex items-center space-x-4 text-gray-500">
                                    <div class="flex items-center space-x-1">
                                        <i data-lucide="calendar" class="w-4 h-4"></i>
                                        <span>12.25</span>
                                    </div>
                                    <div class="flex items-center space-x-1">
                                        <i data-lucide="users" class="w-4 h-4"></i>
                                        <span>8/12</span>
                                    </div>
                                </div>
                                <div class="flex items-center space-x-2">
                                    <span class="text-orange-500 font-medium">₩35,000</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>

            <div class="text-center mt-10">
                <button class="btn-orange text-white px-8 py-3 rounded-lg transition-all duration-200"
                        onclick="location.href='${pageContext.request.contextPath}/events'">
                    모든 이벤트 보기
                </button>
            </div>
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