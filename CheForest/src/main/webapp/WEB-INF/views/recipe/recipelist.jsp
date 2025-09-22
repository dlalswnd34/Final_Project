<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CheForest 레시피</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/recipe.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
</head>
<jsp:include page="/common/header.jsp"/>
<body>
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
                            name="searchKeyword"
                            value="${searchKeyword}"
                            placeholder="레시피, 재료, 요리법 검색..."
                            class="recipe-search-input pl-10 pr-4 py-3 w-full border-2 border-gray-200 focus:border-orange-500 rounded-lg bg-white"
                    />
                </div>
            </div>
        </div>
    </section>

    <!-- 카테고리 + 레시피 목록 -->
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

                <!-- 메인 -->
                <main class="flex-1">

                    <!-- 인기 레시피 -->
                    <div class="mb-12">
                        <h3 class="text-xl flex items-center mb-6">
                            <i data-lucide="trending-up" class="w-6 h-6 mr-3 text-red-500"></i>
                            인기 레시피 <span class="ml-2 px-3 py-1 bg-red-100 text-red-700 text-sm rounded-full">TOP 3</span>
                        </h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            <c:forEach var="recipe" items="${best3Recipes}" varStatus="loop">
                                <div class="popular-recipe-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg"
                                     onclick="location.href='/recipe/view?recipeId=${recipe.recipeId}'">
                                    <div class="relative">
                                        <div class="absolute top-3 left-3 z-10">
                                            <div class="rank-badge w-8 h-8 text-white rounded-full flex items-center justify-center text-sm">
                                                    ${loop.index + 1}
                                            </div>
                                        </div>
                                        <img src="${empty recipe.thumbnail ? '/images/default_recipe.jpg' : recipe.thumbnail}"
                                             alt="${recipe.titleKr}"
                                             class="recipe-card-image w-full h-56 object-cover"
                                             onerror="this.src='/images/default_recipe.jpg'"/>
                                        <div class="absolute top-3 right-3 flex flex-col space-y-2">
                                            <span class="category-badge ${recipe.categoryKr eq '한식' ? 'korean' :
                                                                         recipe.categoryKr eq '일식' ? 'japanese' :
                                                                         recipe.categoryKr eq '중식' ? 'chinese' :
                                                                         recipe.categoryKr eq '양식' ? 'western' :
                                                                         recipe.categoryKr eq '디저트' ? 'dessert' : ''}">
                                                    ${recipe.categoryKr}
                                            </span>
                                            <span class="category-badge hot-badge">HOT</span>
                                        </div>
                                    </div>
                                    <div class="p-4">
                                        <h3 class="recipe-card-title text-lg mb-2 line-clamp-1">${recipe.titleKr}</h3>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">${fn:substring(recipe.instructionKr,0,80)}...</p>

                                        <div class="flex items-center justify-between text-sm mb-2">
                                            <div class="flex items-center space-x-1 text-gray-500">
                                                <i data-lucide="clock" class="h-4 w-4"></i><span>${recipe.cookTime}분</span>
                                            </div>
                                            <span class="difficulty-badge
                                                ${recipe.difficulty == 'Easy' ? 'easy' :
                                                  recipe.difficulty == 'Normal' ? 'normal' :
                                                  recipe.difficulty == 'Hard' ? 'hard' : ''}">
                                                    ${recipe.difficulty}
                                            </span>
                                        </div>

                                        <hr class="my-2">

                                        <div class="flex items-center space-x-4 text-sm text-gray-500">
                                            <div class="flex items-center space-x-1">
                                                <i data-lucide="eye" class="h-4 w-4"></i><span>${recipe.viewCount}</span>
                                            </div>
                                            <div class="flex items-center space-x-1 text-red-500">
                                                <i data-lucide="heart" class="h-4 w-4"></i><span>${recipe.likeCount}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- 전체 레시피 -->
                    <div>
                        <h3 class="text-xl flex items-center mb-6">
                            <i data-lucide="list" class="w-6 h-6 mr-3 text-orange-500"></i>
                            전체 레시피 <span class="ml-2 px-3 py-1 bg-gray-100 text-gray-700 text-sm rounded-full">${totalCount}개</span>
                        </h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
                            <c:forEach var="recipe" items="${recipeList}">
                                <div class="recipe-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-lg"
                                     onclick="location.href='/recipe/view?recipeId=${recipe.recipeId}'">
                                    <div class="relative">
                                        <img src="${empty recipe.thumbnail ? '/images/default_recipe.jpg' : recipe.thumbnail}"
                                             alt="${recipe.titleKr}"
                                             class="recipe-card-image w-full h-56 object-cover"
                                             onerror="this.src='/images/default_recipe.jpg'"/>
                                        <div class="absolute top-3 right-3">
                                            <span class="category-badge ${recipe.categoryKr eq '한식' ? 'korean' :
                                                                         recipe.categoryKr eq '일식' ? 'japanese' :
                                                                         recipe.categoryKr eq '중식' ? 'chinese' :
                                                                         recipe.categoryKr eq '양식' ? 'western' :
                                                                         recipe.categoryKr eq '디저트' ? 'dessert' : ''}">
                                                    ${recipe.categoryKr}
                                            </span>
                                        </div>
                                    </div>
                                    <div class="p-4">
                                        <h3 class="recipe-card-title text-lg mb-2 line-clamp-1">${recipe.titleKr}</h3>
                                        <p class="text-sm text-gray-500 mb-3 line-clamp-2">${fn:substring(recipe.instructionKr,0,80)}...</p>

                                        <div class="flex items-center justify-between text-sm mb-2">
                                            <div class="flex items-center space-x-1 text-gray-500">
                                                <i data-lucide="clock" class="h-4 w-4"></i><span>${recipe.cookTime}분</span>
                                            </div>
                                            <span class="difficulty-badge
                                                ${recipe.difficulty == 'Easy' ? 'easy' :
                                                  recipe.difficulty == 'Normal' ? 'normal' :
                                                  recipe.difficulty == 'Hard' ? 'hard' : ''}">
                                                    ${recipe.difficulty}
                                            </span>
                                        </div>

                                        <hr class="my-2">

                                        <div class="flex items-center space-x-4 text-sm text-gray-500">
                                            <div class="flex items-center space-x-1">
                                                <i data-lucide="eye" class="h-4 w-4"></i><span>${recipe.viewCount}</span>
                                            </div>
                                            <div class="flex items-center space-x-1 text-red-500">
                                                <i data-lucide="heart" class="h-4 w-4"></i><span>${recipe.likeCount}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- ✅ 페이징 (10개 블록, fmt:formatNumber 적용) -->
                        <div class="mt-8 flex justify-center">
                            <c:if test="${totalPages > 1}">
                                <nav class="flex space-x-2">

                                    <c:set var="blockSize" value="10"/>
                                    <c:set var="currentBlock" value="${currentPage div blockSize}"/>
                                    <c:set var="startPage" value="${currentBlock * blockSize}"/>
                                    <c:set var="endPage" value="${startPage + blockSize - 1}"/>
                                    <c:if test="${endPage >= totalPages}">
                                        <c:set var="endPage" value="${totalPages - 1}"/>
                                    </c:if>

                                    <!-- 이전 목록 -->
                                    <c:if test="${startPage > 0}">
                                        <a href="/recipe/list?page=<fmt:formatNumber value='${startPage - 1}' type='number' maxFractionDigits='0'/>&categoryKr=${categoryKr}&searchKeyword=${searchKeyword}"
                                           class="px-3 py-1 border rounded bg-white text-gray-700">&laquo;</a>
                                    </c:if>

                                    <!-- 현재 블록 -->
                                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                        <a href="/recipe/list?page=<fmt:formatNumber value='${i}' type='number' maxFractionDigits='0'/>&categoryKr=${categoryKr}&searchKeyword=${searchKeyword}"
                                           class="px-3 py-1 border rounded ${currentPage == i ? 'bg-orange-500 text-white' : 'bg-white text-gray-700'}">
                                                ${i + 1}
                                        </a>
                                    </c:forEach>

                                    <!-- 다음 목록 -->
                                    <c:if test="${endPage < totalPages - 1}">
                                        <a href="/recipe/list?page=<fmt:formatNumber value='${endPage + 1}' type='number' maxFractionDigits='0'/>&categoryKr=${categoryKr}&searchKeyword=${searchKeyword}"
                                           class="px-3 py-1 border rounded bg-white text-gray-700">&raquo;</a>
                                    </c:if>

                                </nav>
                            </c:if>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </section>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        lucide.createIcons();
    });
</script>
<script src="/js/common.js"></script>
<script src="/js/recipe.js"></script>

<jsp:include page="/common/footer.jsp"/>
</body>
</html>
