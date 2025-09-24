<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>계절 식재료 - CheForest</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/season.css">
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum:wght@400&display=swap" rel="stylesheet">
</head>
<body>
<div class="ingredients-container">
    <div class="ingredients-content">
        <!-- 헤더 섹션 -->
        <div class="page-header">
            <div class="header-main">
                <span class="season-icon">🌸</span>
                <h1 class="page-title">봄철 식재료</h1>
            </div>
            <p class="page-description">
                제철 식재료로 더 맛있고 건강한 요리를 만들어보세요
            </p>
            <div class="ingredients-count">
                총 4가지 식재료
            </div>
        </div>

        <!-- 계절 선택 탭 -->
        <div class="season-tabs">
            <div class="tabs-wrapper">
                <div class="tab-list">
                    <button class="tab-button active" id="springTab" data-season="spring">
                        <span class="tab-icon">🌸</span>
                        <span class="tab-text">봄</span>
                    </button>
                    <button class="tab-button" id="summerTab" data-season="summer">
                        <span class="tab-icon">☀️</span>
                        <span class="tab-text">여름</span>
                    </button>
                    <button class="tab-button" id="autumnTab" data-season="autumn">
                        <span class="tab-icon">🍂</span>
                        <span class="tab-text">가을</span>
                    </button>
                    <button class="tab-button" id="winterTab" data-season="winter">
                        <span class="tab-icon">❄️</span>
                        <span class="tab-text">겨울</span>
                    </button>
                </div>
            </div>
        </div>

        <!-- 식재료 그리드 -->
        <div class="ingredients-grid">
            <!-- JSP forEach로 반복할 식재료 아이템 (예시로 하나만) -->
            <div class="ingredient-card">
                <div class="card-image">
                    <img src="https://images.unsplash.com/photo-1560100927-c32f29063ade?w=400&h=300&fit=crop"
                         alt="식재료 이름 자리" class="ingredient-img">
                    <div class="image-overlay"></div>
                    <div class="season-badge">
                        <span class="badge-icon">🌸</span>
                        <span class="badge-text">봄</span>
                    </div>
                </div>

                <div class="card-header">
                    <div class="ingredient-title-line">
                        <h3 class="ingredient-name">식재료 이름 자리</h3>
                        <div class="status-dot"></div>
                    </div>
                    <p class="ingredient-description">식재료 설명 자리입니다. 실제 식재료에 대한 설명이 여기에 표시됩니다.</p>
                </div>

                <div class="card-content">
                    <!-- 제철 기간 -->
                    <div class="peak-season">
                        <svg class="clock-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                            <circle cx="12" cy="12" r="10"/>
                            <polyline points="12,6 12,12 16,14"/>
                        </svg>
                        <span class="peak-text">제철: 3월 ~ 4월</span>
                    </div>

                    <!-- 주요 효능 -->
                    <div class="benefits-section">
                        <h4 class="section-title">✨ 주요 효능</h4>
                        <div class="benefits-tags">
                            <span class="benefit-tag">간 기능 개선</span>
                            <span class="benefit-tag">해독 효과</span>
                            <span class="benefit-tag">비타민 C</span>
                        </div>
                    </div>

                    <!-- 추천 요리 -->
                    <div class="recipes-section">
                        <h4 class="section-title">
                            <svg class="chef-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                <path d="M6 9H4.5a2.5 2.5 0 0 1 0-5H6"/>
                                <path d="M18 9h1.5a2.5 2.5 0 0 0 0-5H18"/>
                                <path d="M4 22h16"/>
                                <path d="M10 14.66V17c0 .55-.47.98-.97 1.21C7.85 18.75 7 20.24 7 22"/>
                                <path d="M14 14.66V17c0 .55.47.98.97 1.21C16.15 18.75 17 20.24 17 22"/>
                                <path d="M18 2H6v7a6 6 0 0 0 12 0V2Z"/>
                            </svg>
                            추천 요리
                        </h4>
                        <p class="recipes-text">요리명1 · 요리명2 · 요리명3</p>
                    </div>

                    <!-- 영양성분 -->
                    <div class="nutrition-section">
                        <div class="nutrition-header">
                            <div class="nutrition-dot"></div>
                            <span class="nutrition-label">주요 영양성분</span>
                        </div>
                        <p class="nutrition-text">비타민 A, C, 칼슘, 철분, 엽산</p>
                    </div>

                    <!-- 액션 버튼 -->
                    <button class="recipe-btn" id="recipeBtn">
                        🍽️ 레시피 보기
                    </button>
                </div>
            </div>
            <!-- 더미 데이터로 몇 개 더 추가 -->
            <div class="ingredient-card">
                <div class="card-image">
                    <img src="https://images.unsplash.com/photo-1619466218714-7b3ab1182a46?w=400&h=300&fit=crop"
                         alt="딸기" class="ingredient-img">
                    <div class="image-overlay"></div>
                    <div class="season-badge">
                        <span class="badge-icon">🌸</span>
                        <span class="badge-text">봄</span>
                    </div>
                </div>

                <div class="card-header">
                    <div class="ingredient-title-line">
                        <h3 class="ingredient-name">딸기</h3>
                        <div class="status-dot"></div>
                    </div>
                    <p class="ingredient-description">봄의 대표 과일로 달콤하고 상큼한 맛이 일품입니다. 비타민 C가 매우 풍부해 피부 건강에 좋습니다.</p>
                </div>

                <div class="card-content">
                    <div class="peak-season">
                        <svg class="clock-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                            <circle cx="12" cy="12" r="10"/>
                            <polyline points="12,6 12,12 16,14"/>
                        </svg>
                        <span class="peak-text">제철: 4월 ~ 6월</span>
                    </div>

                    <div class="benefits-section">
                        <h4 class="section-title">✨ 주요 효능</h4>
                        <div class="benefits-tags">
                            <span class="benefit-tag">비타민 C</span>
                            <span class="benefit-tag">항산화</span>
                            <span class="benefit-tag">피부 건강</span>
                        </div>
                    </div>

                    <div class="recipes-section">
                        <h4 class="section-title">
                            <svg class="chef-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                <path d="M6 9H4.5a2.5 2.5 0 0 1 0-5H6"/>
                                <path d="M18 9h1.5a2.5 2.5 0 0 0 0-5H18"/>
                                <path d="M4 22h16"/>
                                <path d="M10 14.66V17c0 .55-.47.98-.97 1.21C7.85 18.75 7 20.24 7 22"/>
                                <path d="M14 14.66V17c0 .55.47.98.97 1.21C16.15 18.75 17 20.24 17 22"/>
                                <path d="M18 2H6v7a6 6 0 0 0 12 0V2Z"/>
                            </svg>
                            추천 요리
                        </h4>
                        <p class="recipes-text">딸기잼 · 딸기타르트 · 딸기우유</p>
                    </div>

                    <div class="nutrition-section">
                        <div class="nutrition-header">
                            <div class="nutrition-dot"></div>
                            <span class="nutrition-label">주요 영양성분</span>
                        </div>
                        <p class="nutrition-text">비타민 C, 엽산, 칼륨, 안토시아닌</p>
                    </div>

                    <button class="recipe-btn" id="recipeBtn2">
                        🍽️ 레시피 보기
                    </button>
                </div>
            </div>
        </div>

        <!-- 계절별 가이드 섹션 -->
        <div class="seasonal-guide">
            <div class="guide-card">
                <div class="guide-header">
                    <div class="guide-icon-wrapper">
                        <span class="guide-main-icon">🌸</span>
                    </div>
                    <div class="guide-title-section">
                        <h3 class="guide-title">봄철 식재료 가이드</h3>
                        <p class="guide-subtitle">전문가가 추천하는 활용법</p>
                    </div>
                </div>

                <div class="guide-content">
                    <div class="guide-grid">
                        <div class="guide-item">
                            <h4 class="guide-item-title">🏠 보관법</h4>
                            <p class="guide-item-text">
                                봄나물은 찬물에 담가 이물질을 제거한 후 키친타월로 물기를 제거하고 밀폐용기에 넣어 냉장보관하세요. 2-3일 내 섭취가 좋습니다.
                            </p>
                        </div>

                        <div class="guide-item">
                            <h4 class="guide-item-title">👨‍🍳 조리법</h4>
                            <p class="guide-item-text">
                                봄나물은 끓는 물에 소금을 넣고 살짝 데친 후 찬물에 헹구어 쓴맛을 제거합니다. 참기름과 마늘로 간단히 무쳐드세요.
                            </p>
                        </div>

                        <div class="guide-item">
                            <h4 class="guide-item-title">💡 팁</h4>
                            <p class="guide-item-text">
                                봄나물의 쓴맛이 싫다면 데친 후 찬물에 30분간 담가두세요. 어린잎일수록 부드럽고 맛이 좋습니다.
                            </p>
                        </div>
                    </div>

                    <!-- 특별 정보 -->
                    <div class="special-info">
                        <h4 class="special-title">⭐ 봄철 특별 정보</h4>
                        <p class="special-text">
                            봄철에는 해독과 간 기능 개선에 도움되는 쌉쌀한 나물류가 많습니다. 겨울 동안 쌓인 독소를 배출하는 데 효과적입니다.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/js/common.js"></script>
<script src="/js/season.js"></script>
</body>
</html>