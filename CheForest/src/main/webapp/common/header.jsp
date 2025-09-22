<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/header.css">
</head>
<body>
<!-- CheForest Header Component -->
<!-- Header.tsx 기반으로 정확히 재현 -->
<header class="bg-white border-b border-gray-200 sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <!-- 상단: 로고, 검색창, 사용자 메뉴 -->
        <div class="flex items-center justify-between h-16">
            <!-- 로고 -->
            <div class="logo-container flex items-center space-x-4 cursor-pointer" onclick="showPage('home')">
                <div class="relative">
                    <i data-lucide="chef-hat" class="h-12 w-12 text-orange-500"></i>
                </div>
                <h1 class="text-3xl font-black tracking-tight brand-gradient">
                    CheForest
                </h1>
            </div>

            <!-- 중앙 검색바 -->
            <div class="hidden md:flex flex-1 justify-center px-8">
                <div class="relative w-full max-w-lg">
                    <div class="relative">
                        <i data-lucide="search" class="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-4 w-4"></i>
                        <input
                                type="text"
                                placeholder="레시피, 재료, 요리법 검색..."
                                class="search-input pl-10 pr-12 py-2 w-full border-2 border-gray-200 rounded-full bg-gray-50 cursor-pointer"
                        />
                        <button
                                class="search-btn absolute right-1 top-1/2 transform -translate-y-1/2 h-7 px-3 text-white rounded-full text-sm"
                        >
                            <i data-lucide="search" class="h-3 w-3"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- 우측 사용자 메뉴 -->
            <div class="flex items-center space-x-2">
                <!-- 모바일 검색 -->
                <button
                        class="md:hidden header-icon-btn p-2 rounded-lg"
                        onclick="showPage('search')"
                        title="검색"
                >
                    <i data-lucide="search" class="h-5 w-5"></i>
                </button>

                <!-- 관리자 모드 버튼 -->
                <button
                        class="hidden sm:flex header-icon-btn p-2 rounded-lg"
                        onclick="showPage('admin')"
                        title="관리자 모드"
                >
                    <i data-lucide="shield" class="h-6 w-6"></i>
                </button>

                <!-- 등급 안내 -->
                <button
                        class="header-icon-btn p-2 rounded-lg"
                        onclick="showPage('grade')"
                        title="등급 안내"
                >
                    <i data-lucide="award" class="h-6 w-6"></i>
                </button>

                <!-- 마이페이지 -->
                <button
                        class="hidden sm:flex header-icon-btn p-2 rounded-lg"
                        onclick="showPage('mypage')"
                        title="마이페이지"
                >
                    <i data-lucide="user" class="h-6 w-6"></i>
                </button>

                <button
                        onclick="showPage('login')"
                        class="hidden sm:flex login-btn text-white px-4 py-2 rounded-lg font-medium"
                >
                    로그인
                </button>

                <button
                        class="sm:hidden mobile-menu-btn p-2 rounded-lg"
                        onclick="toggleMobileMenu()"
                >
                    <i data-lucide="menu" class="h-5 w-5"></i>
                </button>
            </div>
        </div>

        <!-- 하단: 메인 네비게이션 -->
        <nav class="hidden sm:flex items-center justify-center space-x-8 py-3">
            <button
                    onclick="showPage('home')"
                    class="nav-item relative font-medium transition-colors text-gray-700 hover:text-orange-500"
                    data-page="home"
            >
                홈
                <span class="nav-underline"></span>
            </button>

            <button
                    onclick="showPage('recipes')"
                    class="nav-item relative font-medium transition-colors text-gray-700 hover:text-orange-500"
                    data-page="recipes"
            >
                <div class="text-center">
                    <div class="text-sm leading-tight">CheForest</div>
                    <div class="text-sm leading-tight">레시피</div>
                </div>
                <span class="nav-underline"></span>
            </button>

            <button
                    onclick="showPage('board')"
                    class="nav-item relative font-medium transition-colors text-gray-700 hover:text-orange-500"
                    data-page="board"
            >
                <div class="text-center">
                    <div class="text-sm leading-tight">사용자</div>
                    <div class="text-sm leading-tight">레시피</div>
                </div>
                <span class="nav-underline"></span>
            </button>

            <div class="relative group">
                <button
                        onclick="showPage('ingredients')"
                        onmouseenter="showIngredientsDropdown()"
                        onmouseleave="hideIngredientsDropdown()"
                        class="nav-item relative flex items-center space-x-1 font-medium transition-colors text-gray-700 hover:text-orange-500"
                        data-page="ingredients"
                >
                    <span>계절 식재료</span>
                    <i data-lucide="chevron-down" class="h-4 w-4"></i>
                    <span class="nav-underline"></span>
                </button>

<%--                <!-- 드롭다운 메뉴 -->--%>
<%--                <div--%>
<%--                        id="ingredientsDropdown"--%>
<%--                        class="absolute top-full left-0 mt-2 w-56 bg-white border border-gray-200 rounded-lg shadow-xl opacity-0 invisible transform -translate-y-2 transition-all duration-200 z-50"--%>
<%--                        onmouseenter="showIngredientsDropdown()"--%>
<%--                        onmouseleave="hideIngredientsDropdown()"--%>
<%--                >--%>
<%--                    <div class="py-2">--%>
<%--                        <button--%>
<%--                                onclick="showPage('ingredients')"--%>
<%--                                class="w-full text-left px-6 py-3 text-base text-gray-700 hover:bg-orange-50 hover:text-orange-500 transition-colors font-medium"--%>
<%--                        >--%>
<%--                            <span class="text-lg mr-3">🌸</span>--%>
<%--                            봄철 식재료--%>
<%--                        </button>--%>
<%--                        <button--%>
<%--                                onclick="showPage('ingredients')"--%>
<%--                                class="w-full text-left px-6 py-3 text-base text-gray-700 hover:bg-orange-50 hover:text-orange-500 transition-colors font-medium"--%>
<%--                        >--%>
<%--                            <span class="text-lg mr-3">☀️</span>--%>
<%--                            여름철 식재료--%>
<%--                        </button>--%>
<%--                        <button--%>
<%--                                onclick="showPage('ingredients')"--%>
<%--                                class="w-full text-left px-6 py-3 text-base text-gray-700 hover:bg-orange-50 hover:text-orange-500 transition-colors font-medium"--%>
<%--                        >--%>
<%--                            <span class="text-lg mr-3">🍂</span>--%>
<%--                            가을철 식재료--%>
<%--                        </button>--%>
<%--                        <button--%>
<%--                                onclick="showPage('ingredients')"--%>
<%--                                class="w-full text-left px-6 py-3 text-base text-gray-700 hover:bg-orange-50 hover:text-orange-500 transition-colors font-medium"--%>
<%--                        >--%>
<%--                            <span class="text-lg mr-3">❄️</span>--%>
<%--                            겨울철 식재료--%>
<%--                        </button>--%>
<%--                    </div>--%>
<%--                </div>--%>
            </div>

            <button
                    onclick="showPage('events')"
                    class="nav-item relative font-medium transition-colors text-gray-700 hover:text-orange-500"
                    data-page="events"
            >
                이벤트
                <span class="nav-underline"></span>
            </button>

            <button
                    onclick="showPage('qna')"
                    class="nav-item relative font-medium transition-colors text-gray-700 hover:text-orange-500"
                    data-page="qna"
            >
                Q&A
                <span class="nav-underline"></span>
            </button>
        </nav>

        <!-- 모바일 네비게이션 -->
        <nav id="mobileMenu" class="hidden sm:hidden py-3 border-t border-gray-200">
            <div class="flex flex-col space-y-2">
                <button onclick="showPage('home')" class="w-full text-left font-medium py-2 px-3 rounded hover:bg-gray-50 text-gray-700 hover:text-orange-500 transition-colors">홈</button>
                <button onclick="showPage('recipes')" class="w-full text-left font-medium py-2 px-3 rounded hover:bg-gray-50 text-gray-700 hover:text-orange-500 transition-colors">
                    <div>
                        <div>CheForest</div>
                        <div>레시피</div>
                    </div>
                </button>
                <button onclick="showPage('board')" class="w-full text-left font-medium py-2 px-3 rounded hover:bg-gray-50 text-gray-700 hover:text-orange-500 transition-colors">
                    <div>
                        <div>사용자</div>
                        <div>레시피</div>
                    </div>
                </button>
                <button onclick="showPage('ingredients')" class="w-full text-left font-medium py-2 px-3 rounded hover:bg-gray-50 text-gray-700 hover:text-orange-500 transition-colors">계절 식재료</button>
                <button onclick="showPage('grade')" class="w-full text-left font-medium py-2 px-3 rounded hover:bg-gray-50 text-gray-700 hover:text-orange-500 transition-colors">등급 안내</button>
                <button onclick="showPage('events')" class="w-full text-left font-medium py-2 px-3 rounded hover:bg-gray-50 text-gray-700 hover:text-orange-500 transition-colors">이벤트</button>
                <button onclick="showPage('qna')" class="w-full text-left font-medium py-2 px-3 rounded hover:bg-gray-50 text-gray-700 hover:text-orange-500 transition-colors">Q&A</button>
                <button onclick="showPage('admin')" class="w-full text-left font-medium py-2 px-3 rounded hover:bg-gray-50 text-gray-700 hover:text-orange-500 transition-colors">🛡️ 관리자 모드</button>
                <button onclick="showPage('mypage')" class="w-full text-left font-medium py-2 px-3 rounded hover:bg-gray-50 text-gray-700 hover:text-orange-500 transition-colors">👤 마이페이지</button>

                <div class="pt-4 border-t border-gray-200 mt-4">
                    <button onclick="showPage('login')" class="w-full login-btn text-white py-2 px-4 rounded-lg font-medium">로그인</button>
                </div>
            </div>
        </nav>
    </div>
</header>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
    <script src="/js/common.js"></script>
    <script src="/js/header.js"></script>

</body>
</html>