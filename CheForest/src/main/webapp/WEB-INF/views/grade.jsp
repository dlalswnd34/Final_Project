<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>등급 시스템 - CheForest</title>
  <link rel="stylesheet" href="/css/common/common.css">
  <link rel="stylesheet" href="/css/grade.css">.
  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- Lucide Icons -->
  <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
</head>
<body>
<!-- 헤더 부분은 제외 -->
<jsp:include page="/common/header.jsp"/>

<main class="grade-main">
  <!-- 페이지 헤더 -->
  <section class="grade-hero">
    <div class="hero-container">
      <div class="hero-content">
        <div class="hero-title-wrapper">
          <span class="hero-icon">🏆</span>
          <h1 class="hero-title">CheForest 등급 시스템</h1>
        </div>
        <p class="hero-description">
          포인트를 쌓아 성장하는 5단계 등급 시스템
        </p>
        <div class="hero-features">
          <div class="feature-item">
            <span class="feature-icon">✨</span>
            <span>씨앗(0점) ~ 숲(4000점+)</span>
          </div>
          <div class="feature-item">
            <span class="feature-icon">🏆</span>
            <span>포인트로 자동 승급</span>
          </div>
          <div class="feature-item">
            <span class="feature-icon">⏰</span>
            <span>하루 최대 500점</span>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- 메인 콘텐츠 -->
  <div class="grade-container">
    <div class="grade-layout">

      <!-- 사이드바 - 내 등급 현황 -->
      <aside class="grade-sidebar">

        <!-- 현재 등급 카드 -->
        <div class="current-grade-card">
          <div class="grade-icon-wrapper">
            <div class="grade-icon root-grade">
              ⚓
            </div>
          </div>
          <h2 class="grade-name">뿌리 (Root)</h2>
          <p class="grade-description">요리 기초를 다지는 단계</p>

          <div class="points-display">
            <div class="total-points">1,250</div>
            <div class="points-label">총 포인트</div>

            <div class="points-grid">
              <div class="point-item">
                <div class="point-value">230</div>
                <div class="point-label">오늘 획득</div>
              </div>
              <div class="point-item">
                <div class="point-value">270</div>
                <div class="point-label">오늘 남은</div>
              </div>
            </div>
          </div>

          <div class="grade-range">
            뿌리 등급: 1,000 ~ 1,999점
          </div>

          <div class="join-date">
            가입일: 2024.01.15
          </div>
        </div>

        <!-- 다음 등급 진행상황 -->
        <div class="next-grade-card">
          <div class="card-header">
            <span class="card-icon">🏆</span>
            <h3>다음 등급: 새싹</h3>
          </div>
          <div class="card-content">
            <div class="progress-info">
              <div class="progress-label">
                <span>포인트 진행도</span>
                <span>1,250/2,000</span>
              </div>
              <div class="progress-bar">
                <div class="progress-fill" style="width: 25%"></div>
              </div>
            </div>

            <div class="upgrade-info">
              <div class="upgrade-text">
                승급까지 750포인트 필요
              </div>
              <div class="upgrade-methods">
                • 게시글 8개 또는<br/>
                • 댓글 75개 작성 시 승급
              </div>
            </div>
          </div>
        </div>

        <!-- 오늘의 포인트 현황 -->
        <div class="today-points-card">
          <div class="card-header">
            <span class="card-icon">📈</span>
            <h3>오늘의 포인트 현황</h3>
          </div>
          <div class="card-content">
            <div class="today-stats">
              <div class="stat-item">
                <div class="stat-value">230/500</div>
                <div class="stat-label">오늘 획득/제한</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">2/3</div>
                <div class="stat-label">게시글 작성</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">13/20</div>
                <div class="stat-label">댓글 작성</div>
              </div>
            </div>

            <div class="progress-details">
              <div class="progress-item">
                <div class="progress-header">
                  <span>게시글 포인트</span>
                  <span>2 / 3개 (200점)</span>
                </div>
                <div class="progress-bar small">
                  <div class="progress-fill" style="width: 67%"></div>
                </div>
              </div>

              <div class="progress-item">
                <div class="progress-header">
                  <span>댓글 포인트</span>
                  <span>13 / 20개 (130점)</span>
                </div>
                <div class="progress-bar small">
                  <div class="progress-fill" style="width: 65%"></div>
                </div>
              </div>
            </div>

            <div class="remaining-points">
              <span class="remaining-icon">⏰</span>
              오늘 270포인트 더 획득 가능
            </div>
          </div>
        </div>

        <!-- 이모티콘 현황 -->
        <div class="emoji-status-card">
          <div class="card-header">
            <span class="card-icon">🎭</span>
            <h3>이모티콘 현황</h3>
          </div>
          <div class="card-content">
            <div class="emoji-count">
              <div class="emoji-total">8개</div>
              <div class="emoji-label">사용 가능한 이모티콘</div>
            </div>

            <div class="emoji-progress">
              <div class="emoji-grade-item unlocked">
                <div class="emoji-grade-info">
                  <span class="emoji-grade-icon">⚡</span>
                  <span>씨앗</span>
                </div>
                <div class="emoji-count-info">+4개 ✓</div>
              </div>
              <div class="emoji-grade-item unlocked">
                <div class="emoji-grade-info">
                  <span class="emoji-grade-icon">⚓</span>
                  <span>뿌리</span>
                </div>
                <div class="emoji-count-info">+4개 ✓</div>
              </div>
              <div class="emoji-grade-item locked">
                <div class="emoji-grade-info">
                  <span class="emoji-grade-icon">🌱</span>
                  <span>새싹</span>
                </div>
                <div class="emoji-count-info">+4개 🔒</div>
              </div>
              <div class="emoji-grade-item locked">
                <div class="emoji-grade-info">
                  <span class="emoji-grade-icon">🌲</span>
                  <span>나무</span>
                </div>
                <div class="emoji-count-info">+4개 🔒</div>
              </div>
              <div class="emoji-grade-item locked">
                <div class="emoji-grade-info">
                  <span class="emoji-grade-icon">🌳</span>
                  <span>숲</span>
                </div>
                <div class="emoji-count-info">+4개 🔒</div>
              </div>
            </div>
          </div>
        </div>

        <!-- 현재 등급 혜택 -->
        <div class="current-benefits-card">
          <div class="card-header">
            <span class="card-icon">🎁</span>
            <h3>현재 등급 혜택</h3>
          </div>
          <div class="card-content">
            <div class="benefit-item">
              <span class="benefit-icon">⭐</span>
              <span>🎭 이모티콘 +4개 해금 (총 8개 사용 가능)</span>
            </div>
          </div>
        </div>

      </aside>

      <!-- 메인 콘텐츠 - 전체 등급 시스템 -->
      <main class="grade-content">

        <!-- 등급 시스템 안내 -->
        <div class="grade-intro">
          <h2 class="intro-title">
            <span class="intro-icon">👑</span>
            등급 시스템 안내
          </h2>
          <p class="intro-description">
            포인트를 쌓아 등급을 올리세요! 게시글 작성 시 100포인트(3개/일), 댓글 작성 시 10포인트(20개/일)를 획득합니다.
            하루 최대 500포인트까지 획득 가능하며, 등급이 올라가면 채팅 이모티콘이 4개씩 해금됩니다.
          </p>
        </div>

        <!-- 등급 목록 -->
        <div class="grades-list">

          <!-- 씨앗 등급 -->
          <div class="grade-item achieved">
            <div class="grade-header">
              <div class="grade-info">
                <div class="grade-icon-wrapper">
                  <div class="grade-icon seed-grade">⚡</div>
                </div>
                <div class="grade-text">
                  <h3 class="grade-title">
                    씨앗 (Seed)
                    <span class="grade-badge achieved-badge">달성</span>
                  </h3>
                  <p class="grade-desc">요리를 시작하는 단계</p>
                </div>
              </div>
            </div>
            <div class="grade-details">
              <div class="upgrade-conditions">
                <h4 class="detail-title">
                  <span class="detail-icon">🏅</span>
                  승급 조건
                </h4>
                <div class="condition-box">
                  <div class="points-requirement">
                    <div class="points-range">0 ~ 999</div>
                    <div class="points-unit">포인트</div>
                  </div>
                  <div class="earning-methods">
                    <div class="method-item">
                      <span class="method-icon">✏️</span>
                      <span>게시글: +100포인트 (3개/일)</span>
                    </div>
                    <div class="method-item">
                      <span class="method-icon">💬</span>
                      <span>댓글: +10포인트 (20개/일)</span>
                    </div>
                    <div class="method-item full-width">
                      <span class="method-icon">⏰</span>
                      <span>하루 최대 500포인트 제한</span>
                    </div>
                  </div>
                </div>
              </div>
              <div class="grade-benefits">
                <h4 class="detail-title">
                  <span class="detail-icon">🎁</span>
                  등급 혜택
                </h4>
                <div class="benefits-list">
                  <div class="benefit-item">
                    <span class="benefit-icon">⭐</span>
                    <span>기본 채팅 기능 이용</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 뿌리 등급 -->
          <div class="grade-item current">
            <div class="grade-header">
              <div class="grade-info">
                <div class="grade-icon-wrapper">
                  <div class="grade-icon root-grade">⚓</div>
                </div>
                <div class="grade-text">
                  <h3 class="grade-title">
                    뿌리 (Root)
                    <span class="grade-badge current-badge">현재 등급</span>
                  </h3>
                  <p class="grade-desc">요리 기초를 다지는 단계</p>
                </div>
              </div>
            </div>
            <div class="grade-details">
              <div class="upgrade-conditions">
                <h4 class="detail-title">
                  <span class="detail-icon">🏅</span>
                  승급 조건
                </h4>
                <div class="condition-box">
                  <div class="points-requirement">
                    <div class="points-range">1,000 ~ 1,999</div>
                    <div class="points-unit">포인트</div>
                  </div>
                  <div class="earning-methods">
                    <div class="method-item">
                      <span class="method-icon">✏️</span>
                      <span>게시글: +100포인트 (3개/일)</span>
                    </div>
                    <div class="method-item">
                      <span class="method-icon">💬</span>
                      <span>댓글: +10포인트 (20개/일)</span>
                    </div>
                    <div class="method-item full-width">
                      <span class="method-icon">⏰</span>
                      <span>하루 최대 500포인트 제한</span>
                    </div>
                  </div>
                </div>
              </div>
              <div class="grade-benefits">
                <h4 class="detail-title">
                  <span class="detail-icon">🎁</span>
                  등급 혜택
                </h4>
                <div class="benefits-list">
                  <div class="benefit-item">
                    <span class="benefit-icon">⭐</span>
                    <span>🎭 이모티콘 +4개 해금 (총 8개 사용 가능)</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 새싹 등급 -->
          <div class="grade-item">
            <div class="grade-header">
              <div class="grade-info">
                <div class="grade-icon-wrapper">
                  <div class="grade-icon sprout-grade">🌱</div>
                </div>
                <div class="grade-text">
                  <h3 class="grade-title">새싹 (Sprout)</h3>
                  <p class="grade-desc">요리 실력이 성장하는 단계</p>
                </div>
              </div>
            </div>
            <div class="grade-details">
              <div class="upgrade-conditions">
                <h4 class="detail-title">
                  <span class="detail-icon">🏅</span>
                  승급 조건
                </h4>
                <div class="condition-box">
                  <div class="points-requirement">
                    <div class="points-range">2,000 ~ 2,999</div>
                    <div class="points-unit">포인트</div>
                  </div>
                  <div class="earning-methods">
                    <div class="method-item">
                      <span class="method-icon">✏️</span>
                      <span>게시글: +100포인트 (3개/일)</span>
                    </div>
                    <div class="method-item">
                      <span class="method-icon">💬</span>
                      <span>댓글: +10포인트 (20개/일)</span>
                    </div>
                    <div class="method-item full-width">
                      <span class="method-icon">⏰</span>
                      <span>하루 최대 500포인트 제한</span>
                    </div>
                  </div>
                </div>
              </div>
              <div class="grade-benefits">
                <h4 class="detail-title">
                  <span class="detail-icon">🎁</span>
                  등급 혜택
                </h4>
                <div class="benefits-list">
                  <div class="benefit-item">
                    <span class="benefit-icon">⭐</span>
                    <span>🎭 이모티콘 +4개 해금 (총 12개 사용 가능)</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 나무 등급 -->
          <div class="grade-item">
            <div class="grade-header">
              <div class="grade-info">
                <div class="grade-icon-wrapper">
                  <div class="grade-icon tree-grade">🌲</div>
                </div>
                <div class="grade-text">
                  <h3 class="grade-title">나무 (Tree)</h3>
                  <p class="grade-desc">탄탄한 요리 실력을 갖춘 단계</p>
                </div>
              </div>
            </div>
            <div class="grade-details">
              <div class="upgrade-conditions">
                <h4 class="detail-title">
                  <span class="detail-icon">🏅</span>
                  승급 조건
                </h4>
                <div class="condition-box">
                  <div class="points-requirement">
                    <div class="points-range">3,000 ~ 3,999</div>
                    <div class="points-unit">포인트</div>
                  </div>
                  <div class="earning-methods">
                    <div class="method-item">
                      <span class="method-icon">✏️</span>
                      <span>게시글: +100포인트 (3개/일)</span>
                    </div>
                    <div class="method-item">
                      <span class="method-icon">💬</span>
                      <span>댓글: +10포인트 (20개/일)</span>
                    </div>
                    <div class="method-item full-width">
                      <span class="method-icon">⏰</span>
                      <span>하루 최대 500포인트 제한</span>
                    </div>
                  </div>
                </div>
              </div>
              <div class="grade-benefits">
                <h4 class="detail-title">
                  <span class="detail-icon">🎁</span>
                  등급 혜택
                </h4>
                <div class="benefits-list">
                  <div class="benefit-item">
                    <span class="benefit-icon">⭐</span>
                    <span>🎭 이모티콘 +4개 해금 (총 16개 사용 가능)</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 숲 등급 -->
          <div class="grade-item">
            <div class="grade-header">
              <div class="grade-info">
                <div class="grade-icon-wrapper">
                  <div class="grade-icon forest-grade">🌳</div>
                </div>
                <div class="grade-text">
                  <h3 class="grade-title">숲 (Forest)</h3>
                  <p class="grade-desc">요리 마스터 최고 등급</p>
                </div>
              </div>
            </div>
            <div class="grade-details">
              <div class="upgrade-conditions">
                <h4 class="detail-title">
                  <span class="detail-icon">🏅</span>
                  승급 조건
                </h4>
                <div class="condition-box">
                  <div class="points-requirement">
                    <div class="points-range">4,000+</div>
                    <div class="points-unit">포인트</div>
                  </div>
                  <div class="earning-methods">
                    <div class="method-item">
                      <span class="method-icon">✏️</span>
                      <span>게시글: +100포인트 (3개/일)</span>
                    </div>
                    <div class="method-item">
                      <span class="method-icon">💬</span>
                      <span>댓글: +10포인트 (20개/일)</span>
                    </div>
                    <div class="method-item full-width">
                      <span class="method-icon">⏰</span>
                      <span>하루 최대 500포인트 제한</span>
                    </div>
                  </div>
                </div>
              </div>
              <div class="grade-benefits">
                <h4 class="detail-title">
                  <span class="detail-icon">🎁</span>
                  등급 혜택
                </h4>
                <div class="benefits-list">
                  <div class="benefit-item">
                    <span class="benefit-icon">⭐</span>
                    <span>🎭 이모티콘 +4개 해금 (총 20개 사용 가능)</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

        </div>

        <!-- 포인트 획득 가이드 -->
        <div class="points-guide">
          <div class="guide-header">
            <span class="guide-icon">✨</span>
            <h3>포인트 획득 가이드</h3>
          </div>
          <div class="guide-content">
            <div class="guide-columns">
              <div class="guide-column">
                <h4 class="guide-title">
                  <span class="guide-method-icon">✏️</span>
                  게시글 작성으로 포인트 획득
                </h4>
                <ul class="guide-list">
                  <li class="guide-item">
                    <span class="guide-bullet">⭐</span>
                    레시피 게시글: 100포인트
                  </li>
                  <li class="guide-item">
                    <span class="guide-bullet">⭐</span>
                    고품질 사진과 상세한 설명 필수
                  </li>
                  <li class="guide-item">
                    <span class="guide-bullet">⭐</span>
                    하루 3개까지 작성 가능 (300포인트)
                  </li>
                </ul>
              </div>
              <div class="guide-column">
                <h4 class="guide-title">
                  <span class="guide-method-icon">💬</span>
                  댓글 작성으로 포인트 획득
                </h4>
                <ul class="guide-list">
                  <li class="guide-item">
                    <span class="guide-bullet">⭐</span>
                    댓글 1개: 10포인트
                  </li>
                  <li class="guide-item">
                    <span class="guide-bullet">⭐</span>
                    하루 20개까지만 포인트 적용
                  </li>
                  <li class="guide-item">
                    <span class="guide-bullet">⭐</span>
                    의미있는 댓글 작성 권장
                  </li>
                </ul>
              </div>
            </div>

            <div class="limit-system">
              <h4 class="limit-title">
                <span class="limit-icon">⏰</span>
                일일 포인트 제한 시스템
              </h4>
              <div class="limit-cards">
                <div class="limit-card daily">
                  <div class="limit-label">하루 최대</div>
                  <div class="limit-value">500포인트</div>
                </div>
                <div class="limit-card posts">
                  <div class="limit-label">게시글 제한</div>
                  <div class="limit-value">3개/일</div>
                </div>
                <div class="limit-card comments">
                  <div class="limit-label">댓글 제한</div>
                  <div class="limit-value">20개/일</div>
                </div>
                <div class="limit-card reset">
                  <div class="limit-label">리셋 시간</div>
                  <div class="limit-value">매일 00:00</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  </div>
</main>
<script>
  // Lucide 아이콘 초기화
  lucide.createIcons();
</script>
<jsp:include page="/common/footer.jsp"/>
</body>
</html>