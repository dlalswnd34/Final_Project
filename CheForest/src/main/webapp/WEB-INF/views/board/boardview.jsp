<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>게시글 상세보기 - CheForest</title>
  <link rel="stylesheet" href="/css/common.css">
  <link rel="stylesheet" href="/css/board/boardview.css">
  <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum:wght@400&display=swap" rel="stylesheet">
</head>
<body>
<div class="detail-container">
  <!-- 상단 네비게이션 -->
  <div>
    <div class="nav-content">
      <button class="back-btn" id="backBtn">
        <svg class="back-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
          <path d="m15 18-6-6 6-6"/>
        </svg>
        <span>게시판으로</span>
      </button>
      <div class="nav-actions">
        <button class="edit-btn" id="editBtn">
          <svg class="edit-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
            <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
            <path d="m18.5 2.5 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
          </svg>
          수정
        </button>
      </div>
    </div>
  </div>

  <div class="detail-content">
    <!-- 게시글 헤더 -->
    <div class="post-header">
      <div class="post-meta">
        <span class="category-badge">한식</span>
        <h1 class="post-title">게시글 제목 자리</h1>
        <p class="post-description">게시글 설명 자리입니다. 게시글에 대한 간단한 설명이 들어갑니다.</p>
      </div>

      <!-- 작성자 정보 -->
      <div class="author-section">
        <div class="author-info">
          <div class="author-avatar">
            <img src="https://images.unsplash.com/photo-1595152772835-219674b2a8a6?w=100&h=100&fit=crop&crop=face"
                 alt="작성자 프로필" class="avatar-img">
          </div>
          <div class="author-details">
            <div class="author-name-line">
              <span class="author-name">작성자 닉네임 자리</span>
              <span class="level-badge level-tree">🌳 나무</span>
            </div>
            <span class="post-date">2024년 1월 20일 작성</span>
          </div>
        </div>

        <!-- 액션 버튼들 -->
        <div class="action-buttons">
          <button class="action-btn like-btn" id="likeBtn">
            <svg class="heart-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
              <path d="M19.5 12.5 12 20l-7.5-7.5a5 5 0 0 1 7.5-7 5 5 0 0 1 7.5 7Z"/></svg>
            <span class="count">123</span>
          </button>
          <button class="action-btn bookmark-btn" id="bookmarkBtn">
            <svg class="bookmark-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
              <path d="m19 21-7-4-7 4V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v16z"/>
            </svg>
            <span class="count">45</span>
          </button>
          <button class="action-btn view-btn">
            <svg class="eye-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
              <path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/>
              <circle cx="12" cy="12" r="3"/>
            </svg>
            <span class="count">1,234</span>
          </button>
        </div>
      </div>

      <!-- 게시글 기본 정보 -->
      <div class="post-info-grid">
        <div class="info-item">
          <svg class="info-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
            <circle cx="12" cy="12" r="10"/>
            <polyline points="12,6 12,12 16,14"/>
          </svg>
          <p class="info-label">작성시간</p>
          <p class="info-value">오전 10:30</p>
        </div>
        <div class="info-item">
          <svg class="info-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
            <path d="M6 9H4.5a2.5 2.5 0 0 1 0-5H6"/>
            <path d="M18 9h1.5a2.5 2.5 0 0 0 0-5H18"/>
            <path d="M4 22h16"/>
            <path d="M10 14.66V17c0 .55-.47.98-.97 1.21C7.85 18.75 7 20.24 7 22"/>
            <path d="M14 14.66V17c0 .55.47.98.97 1.21C16.15 18.75 17 20.24 17 22"/>
            <path d="M18 2H6v7a6 6 0 0 0 12 0V2Z"/>
          </svg>
          <p class="info-label">분류</p>
          <span class="difficulty-badge difficulty-easy">자유게시판</span>
        </div>
      </div>
    </div>

    <!-- 메인 이미지 -->
    <div class="post-image">
      <img src="https://images.unsplash.com/photo-1603133872878-684f208fb84b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxraW1jaGklMjBmcmllZCUyMHJpY2V8ZW58MXx8fHwxNzU3NTgwMDE5fDA&ixlib=rb-4.1.0&q=80&w=1080"
           alt="게시글 이미지" class="main-image">
    </div>

    <!-- 탭 콘텐츠 (재료/조리법) -->
    <div class="tabs-container">
      <!-- 탭 버튼들 -->
      <div class="tabs-list">
        <button class="tab-trigger active" id="ingredientsTab" data-tab="ingredients">재료</button>
        <button class="tab-trigger" id="instructionsTab" data-tab="instructions">조리법</button>
      </div>

      <!-- 재료 탭 내용 -->
      <div class="tab-content active" id="ingredientsContent">
        <div class="ingredients-card">
          <div class="ingredients-header">
            <h3 class="ingredients-title">필요한 재료</h3>
          </div>
          <div class="ingredients-grid">
            <!-- JSP forEach로 반복할 재료 아이템 (예시로 하나만) -->
            <div class="ingredient-item">
              <span class="ingredient-name">재료명 자리</span>
              <span class="ingredient-amount">수량 자리</span>
            </div>
            <!-- 더미 데이터로 몇 개 더 표시 -->
            <div class="ingredient-item">
              <span class="ingredient-name">밥</span>
              <span class="ingredient-amount">2공기</span>
            </div>
            <div class="ingredient-item">
              <span class="ingredient-name">스팸</span>
              <span class="ingredient-amount">1/2캔</span>
            </div>
            <div class="ingredient-item">
              <span class="ingredient-name">대파</span>
              <span class="ingredient-amount">1대</span>
            </div>
            <div class="ingredient-item">
              <span class="ingredient-name">참기름</span>
              <span class="ingredient-amount">1큰술</span>
            </div>
            <div class="ingredient-item">
              <span class="ingredient-name">설탕</span>
              <span class="ingredient-amount">1/2큰술</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 조리법 탭 내용 -->
      <div class="tab-content" id="instructionsContent">
        <div class="instructions-list">
          <!-- JSP forEach로 반복할 조리법 아이템 (예시로 하나만) -->
          <div class="instruction-item">
            <div class="instruction-content">
              <div class="instruction-image">
                <img src="https://images.unsplash.com/photo-1581833971358-2c8b550f87b3?w=400&h=300&fit=crop"
                     alt="조리 과정 이미지" class="step-image">
              </div>
              <div class="instruction-text">
                <p class="step-description">조리 과정 설명 자리입니다. 실제 조리 과정이 여기에 표시됩니다.</p>
              </div>
            </div>
          </div>
          <!-- 더미 데이터로 몇 개 더 표시 -->
          <div class="instruction-item">
            <div class="instruction-content">
              <div class="instruction-image">
                <img src="https://images.unsplash.com/photo-1574484284002-952d92456975?w=400&h=300&fit=crop"
                     alt="조리 과정 2" class="step-image">
              </div>
              <div class="instruction-text">
                <p class="step-description">팬에 기름을 두르고 스팸을 먼저 볶다가 김치를 넣고 함께 볶아주세요. 김치가 노릇해질 때까지 볶습니다.</p>
              </div>
            </div>
          </div>
          <div class="instruction-item">
            <div class="instruction-content">
              <div class="instruction-image">
                <img src="https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=400&h=300&fit=crop"
                     alt="조리 과정 3" class="step-image">
              </div>
              <div class="instruction-text">
                <p class="step-description">밥을 넣고 간장, 설탕, 참기름을 넣어 간을 맞춘 후 잘 섞어가며 볶아주세요.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 댓글 섹션 -->
    <div class="comments-section">
      <div class="comments-divider"></div>

      <!-- 댓글 헤더 -->
      <div class="comments-header">
        <h3 class="comments-title">💬 댓글 (3)</h3>
      </div>

      <!-- 댓글 작성 -->
      <div class="comment-write">
        <div class="write-content">
          <div class="write-header">
            <div class="writer-avatar">
              <img src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&h=100&fit=crop&crop=face"
                   alt="내 프로필" class="avatar-img">
            </div>
            <div class="writer-info">
              <div class="writer-name-line">
                <span class="writer-name">현재사용자</span>
                <span class="level-badge level-seed">🌱 씨앗</span>
              </div>
            </div>
          </div>
          <div class="write-form">
                            <textarea id="commentTextarea" class="comment-textarea"
                                      placeholder="이 게시글에 대한 생각을 나눠주세요! 👨‍🍳✨
팁이나 의견도 환영해요!"></textarea>
            <button class="emoji-btn" id="emojiBtn">
              <svg class="emoji-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                <circle cx="12" cy="12" r="10"/>
                <path d="m9 9 1.5 1.5L12 9"/>
                <path d="m21 21-4.35-4.35"/>
              </svg>
            </button>
          </div>
          <div class="write-footer">
            <div class="write-tip">
              <span>💡 따뜻한 댓글로 소통의 즐거움을 나눠보세요</span>
            </div>
            <button class="submit-btn" id="commentSubmitBtn">
              <svg class="send-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                <line x1="22" x2="11" y1="2" y2="13"/>
                <polygon points="22,2 15,22 11,13 2,9 22,2"/>
              </svg>
              댓글 등록
            </button>
          </div>
        </div>
      </div>

      <!-- 댓글 목록 (하나의 댓글 아이템만 구현, JSP에서 반복) -->
      <div class="comments-list">
        <div class="comment-item">
          <div class="comment-content">
            <!-- 댓글 헤더 -->
            <div class="comment-header">
              <div class="commenter-info">
                <div class="commenter-avatar">
                  <img src="https://images.unsplash.com/photo-1494790108755-2616b332c75c?w=100&h=100&fit=crop&crop=face"
                       alt="댓글 작성자" class="avatar-img">
                </div>
                <div class="commenter-details">
                  <div class="commenter-name-line">
                    <span class="commenter-name">댓글 작성자 닉네임</span>
                    <span class="level-badge level-sprout">🌱 새싹</span>
                  </div>
                  <span class="comment-time">2시간 전</span>
                </div>
              </div>
              <button class="comment-menu-btn" id="commentMenuBtn">
                <svg class="menu-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                  <circle cx="12" cy="12" r="1"/>
                  <circle cx="19" cy="12" r="1"/>
                  <circle cx="5" cy="12" r="1"/>
                </svg>
              </button>
            </div>

            <!-- 댓글 내용 -->
            <div class="comment-body">
              <p class="comment-text">댓글 내용 자리입니다. 실제 댓글 내용이 여기에 표시됩니다. 👍✨</p>
            </div>

            <!-- 댓글 액션 -->
            <div class="comment-actions">
              <div class="comment-buttons">
                <div class="vote-buttons">
                  <button class="vote-btn like-vote" id="commentLikeBtn">
                    <svg class="thumbs-up-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                      <path d="M7 10v12"/>
                      <path d="M15 5.88 14 10h5.83a2 2 0 0 1 1.92 2.56l-2.33 8A2 2 0 0 1 17.5 22H4a2 2 0 0 1-2-2v-8a2 2 0 0 1 2-2h2.76a2 2 0 0 0 1.79-1.11L12 2h3.73a2 2 0 0 1 1.92 2.56z"/>
                    </svg>
                    <span class="vote-count">12</span>
                  </button>
                  <button class="vote-btn dislike-vote" id="commentDislikeBtn">
                    <svg class="thumbs-down-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                      <path d="M17 14V2"/>
                      <path d="M9 18.12 10 14H4.17a2 2 0 0 1-1.92-2.56l2.33-8A2 2 0 0 1 6.5 2H20a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2h-2.76a2 2 0 0 0-1.79 1.11L12 22h-3.73a2 2 0 0 1-1.92-2.56z"/>
                    </svg>
                  </button>
                </div>
                <button class="reply-btn" id="replyBtn">
                  <svg class="reply-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                    <polyline points="9,17 4,12 9,7"/>
                    <path d="M20 18v-2a4 4 0 0 0-4-4H4"/>
                  </svg>
                  답글
                </button>
              </div>
              <div class="comment-stats">
                <span class="likes-text">👍 12명이 좋아해요</span>
              </div>
            </div>

            <!-- 답글 작성 영역 (숨김/표시) -->
            <div class="reply-write" id="replyWrite" style="display: none;">
              <div class="reply-content">
                <div class="reply-header">
                  <div class="reply-avatar">
                    <img src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&h=100&fit=crop&crop=face"
                         alt="내 프로필" class="avatar-img">
                  </div>
                </div>
                <div class="reply-form">
                                        <textarea id="replyTextarea" class="reply-textarea"
                                                  placeholder="@댓글 작성자 닉네임님에게 답글을 작성해보세요! 💬"></textarea>
                  <div class="reply-actions">
                    <button class="cancel-btn" id="replyCancelBtn">취소</button>
                    <button class="reply-submit-btn" id="replySubmitBtn">
                      <svg class="send-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                        <line x1="22" x2="11" y1="2" y2="13"/>
                        <polygon points="22,2 15,22 11,13 2,9 22,2"/>
                      </svg>
                      답글 등록
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <!-- 답글 목록 (하나의 답글 아이템만 구현) -->
            <div class="replies-list">
              <div class="reply-item">
                <div class="reply-border">
                  <div class="reply-avatar">
                    <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop&crop=face"
                         alt="답글 작성자" class="avatar-img">
                  </div>
                  <div class="reply-details">
                    <div class="reply-author-line">
                      <span class="reply-author">답글 작성자 닉네임</span>
                      <span class="level-badge level-tree">🌳 나무</span>
                      <span class="reply-time">1시간 전</span>
                    </div>
                    <p class="reply-text">답글 내용 자리입니다! 😊</p>
                    <div class="reply-vote">
                      <button class="vote-btn like-vote small">
                        <svg class="thumbs-up-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                          <path d="M7 10v12"/>
                          <path d="M15 5.88 14 10h5.83a2 2 0 0 1 1.92 2.56l-2.33 8A2 2 0 0 1 17.5 22H4a2 2 0 0 1-2-2v-8a2 2 0 0 1 2-2h2.76a2 2 0 0 0 1.79-1.11L12 2h3.73a2 2 0 0 1 1.92 2.56z"/>
                        </svg>
                        <span class="vote-count">5</span>
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 더 많은 댓글 보기 -->
      <div class="load-more-comments">
        <button class="load-more-btn" id="loadMoreBtn">
          <svg class="message-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
          </svg>
          더 많은 댓글 보기 (127개)
        </button>
      </div>

      <!-- 댓글 가이드 -->
      <div class="comment-guide">
        <div class="guide-content">
          <div class="guide-icon">💡</div>
          <div class="guide-text">
            <h4 class="guide-title">CheForest 댓글 가이드</h4>
            <p class="guide-description">
              • 요리 팁과 경험을 공유해주세요 • 서로 존중하는 따뜻한 소통을 해주세요
              • 스팸이나 광고성 댓글은 삭제될 수 있습니다
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="/js/board/boardview.js"></script>
</body>
</html>