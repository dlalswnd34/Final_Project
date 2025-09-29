<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>통합검색 - CheForest</title>
  <link rel="stylesheet" href="css/common.css">
  <link rel="stylesheet" href="css/search.css">
</head>
<body>
<!-- 헤더는 제외 -->

<main class="search-main">
  <!-- 검색 헤더 -->
  <section class="search-header">
    <div class="container">
      <div class="header-content">
        <div class="header-title">
          <span class="search-icon">🔍</span>
          <h1>CheForest 통합 검색</h1>
        </div>
        <p class="header-description">
          레시피, 게시글, Q&A를 한 번에 검색하세요
        </p>
      </div>

      <!-- 인기 검색어 & 최근 검색어 -->
      <div class="search-keywords" id="search-keywords">
        <div class="keywords-grid">
          <!-- 인기 검색어 -->
          <div class="keywords-section">
            <h3 class="keywords-title">
              <span class="keywords-icon">📈</span>
              인기 검색어
            </h3>
            <div class="keywords-list">
              <!-- 반복될 인기 검색어 아이템 구조 (하나만) -->
              <button class="keyword-item popular-keyword" data-keyword="인기검색어">
                <span class="keyword-rank">1</span>
                <span class="keyword-text">인기검색어</span>
              </button>
            </div>
          </div>

          <!-- 최근 검색어 -->
          <div class="keywords-section">
            <h3 class="keywords-title">
              <span class="keywords-icon">🕐</span>
              최근 검색어
            </h3>
            <div class="keywords-list">
              <!-- 반복될 최근 검색어 아이템 구조 (하나만) -->
              <button class="keyword-item recent-keyword" data-keyword="최근검색어">
                <span class="keyword-icon">#</span>
                <span class="keyword-text">최근검색어</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- 검색 결과 영역 -->
  <section class="search-results" id="search-results" style="display: none;">
    <div class="container">
      <!-- 필터 및 정렬 -->
      <div class="search-filters">
        <div class="filter-controls">
          <!-- 카테고리 선택 -->
          <div class="filter-group">
            <select id="category-filter" class="filter-select">
              <option value="">전체 카테고리</option>
              <option value="한식">한식</option>
              <option value="양식">양식</option>
              <option value="중식">중식</option>
              <option value="일식">일식</option>
              <option value="디저트">디저트</option>
            </select>
          </div>
        </div>

        <!-- 검색 결과 개수 -->
        <div class="search-count">
          '<span class="search-query-highlight" id="search-query-text">검색어</span>' 검색 결과
          <span class="result-count" id="result-count">0</span>개
        </div>
      </div>

      <!-- 결과 탭 -->
      <div class="result-tabs">
        <div class="tab-buttons">
          <button class="tab-button active" data-tab="all" id="tab-all">
            전체 (<span class="tab-count">0</span>)
          </button>
          <button class="tab-button" data-tab="recipe" id="tab-recipe">
            레시피 (<span class="tab-count">0</span>)
          </button>
          <button class="tab-button" data-tab="board" id="tab-board">
            게시글 (<span class="tab-count">0</span>)
          </button>
        </div>
      </div>

      <!-- 결과 컨텐츠 -->
      <div class="result-content">
        <!-- 로딩 상태 -->
        <div class="loading-state" id="loading-state" style="display: none;">
          <div class="loading-spinner"></div>
          <p class="loading-text">검색 중...</p>
        </div>

        <!-- 결과 없음 상태 -->
        <div class="no-results" id="no-results" style="display: none;">
          <div class="no-results-icon">🔍</div>
          <h3 class="no-results-title">검색 결과가 없습니다</h3>
          <p class="no-results-description">
            다른 검색어를 시도하거나 필터를 조정해보세요.
          </p>
          <button class="btn-clear-search" id="btn-clear-search">
            검색어 지우기
          </button>
        </div>

        <!-- 검색 결과 리스트 -->
        <div class="results-grid" id="results-grid">
          <!-- 반복될 검색 결과 아이템 구조 (하나만) -->
          <div class="result-item" data-type="recipe" data-id="1">
            <!-- 이미지 영역 (레시피/게시글용) -->
            <div class="result-image-container">
              <img src="결과이미지URL" alt="결과 제목" class="result-image">

              <!-- 콘텐츠 타입 배지 -->
              <div class="result-badges">
                <span class="content-type-badge recipe-badge">레시피</span>
                <span class="category-badge">카테고리명</span>
              </div>
            </div>

            <!-- 콘텐츠 영역 -->
            <div class="result-content-area">
              <!-- Q&A 타입 헤더 (Q&A용) -->
              <div class="qna-header" style="display: none;">
                <span class="content-type-badge qna-badge">Q&A</span>
                <span class="category-badge">카테고리명</span>
              </div>

              <h3 class="result-title">결과 제목 자리입니다</h3>
              <p class="result-description">
                결과 설명 내용이 들어갈 자리입니다. 검색 결과에 대한 간단한 설명을 보여줍니다.
              </p>

              <!-- 작성자 정보 -->
              <div class="result-author">
                <span class="author-icon">👤</span>
                <span class="author-text">by 작성자닉네임</span>
                <span class="author-level">등급</span>
              </div>

              <!-- 메타데이터 (레시피용) -->
              <div class="result-meta">
                                    <span class="meta-item">
                                        <span class="meta-icon">⏱️</span>
                                        <span class="meta-text">조리시간: 30분</span>
                                    </span>
                <span class="meta-divider">•</span>
                <span class="meta-item">
                                        <span class="meta-text">난이도: 보통</span>
                                    </span>
              </div>

            </div>
          </div>
        </div>

        <!-- 페이징 -->
      </div>
    </div>
  </section>
</main>

<!-- 푸터는 제외 -->

<script src="js/common.js"></script>
<script src="js/search.js"></script>
</body>
</html>