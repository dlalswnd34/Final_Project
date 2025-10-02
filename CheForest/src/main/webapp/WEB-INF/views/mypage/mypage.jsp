<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>마이페이지 - CheForest</title>
  <link rel="stylesheet" href="/css/common/common.css">
  <link rel="stylesheet" href="/css/mypage.css">
</head>
<body>
<jsp:include page="/common/header.jsp"/>
<main class="mypage-main">
  <!-- 1) 총 개수 -->
  <p>좋아요한 게시글 수: <c:out value="${likedPostsTotalCount}" /> 개</p>

  <!-- 2) 한 건만 테스트 -->
  <c:if test="${not empty likedPosts}">
    <p>첫 번째 글 제목: <c:out value="${likedPosts[0].title}" /></p>
    <p>작성자: <c:out value="${likedPosts[0].writerName}" /></p>
    <p>카테고리: <c:out value="${likedPosts[0].category}" /></p>
    <p>좋아요 누른 시각:
      <fmt:formatDate value="${likedPosts[0].likeDate}" pattern="yyyy-MM-dd HH:mm:ss" />
    </p>
    <p>썸네일 경로: <c:out value="${likedPosts[0].thumbnail}" /></p>

    <img
            src="<c:out value='${likedPosts[0].thumbnail}'/>"
            alt="썸네일" width="100"
            onerror="this.src='${pageContext.request.contextPath}/images/default_thumbnail.png';"
    />
  </c:if>

  <!-- 3) 비어있는 경우 안내 -->
  <c:if test="${empty likedPosts}">
    <p>좋아요한 게시글이 없습니다.</p>
  </c:if>

  <!-- 페이지 헤더 -->
  <section class="mypage-header">
    <div class="container">
      <div class="profile-info">
        <div class="profile-avatar">
          <img src="사용자프로필이미지URL" alt="프로필 이미지" id="profile-image">
          <div class="avatar-fallback" id="avatar-fallback">사</div>
        </div>
        <div class="profile-details">
          <sec:authentication var="me" property="principal"/>
          <h1 class="profile-title"><c:out value="${me.member.nickname}"/>님의 마이페이지</h1>
          <div class="profile-meta">
            <span class="level-badge">
              <span class="level-icon">🌳</span>
              <span class="level-text">나무</span>
            </span>
            <span class="join-date">가입일:<c:out value="${joinDate}" default="-" /></span>
          </div>
          <div class="level-progress">
            <span class="progress-label">다음 등급까지</span>
            <div class="progress-bar">
              <div class="progress-fill" style="width: 75%"></div>
            </div>
            <span class="progress-text">75%</span>
          </div>
        </div>
      </div>
    </div>
  </section>



  <!-- 통계 섹션 -->
  <section class="stats-section">
    <div class="container">
      <div class="stats-grid">
        <%-- 작성한 레시피    --%>
        <div class="stat-card stat-recipes">
          <div class="stat-icon">👨‍🍳</div>
          <div class="stat-number">
            <fmt:formatNumber value="${empty myPostsTotalCount ? 0 : myPostsTotalCount}" />
          </div>
          <div class="stat-label">작성한 레시피</div>
        </div>
        <%--  작성한 댓글     --%>
        <div class="stat-card stat-comments">
          <div class="stat-icon">💬</div>
          <div class="stat-number">
            <fmt:formatNumber value="${empty myCommentsTotalCount ? 0 : myCommentsTotalCount}" />
          </div>
          <div class="stat-label">작성한 댓글</div>
        </div>

        <%--  받은 좋아요     --%>
        <div class="stat-card stat-likes">
          <div class="stat-icon">❤️</div>
          <div class="stat-number">
            <fmt:formatNumber value="${empty receivedLikesTotalCount ? 0 : receivedLikesTotalCount}" />
          </div>
          <div class="stat-label">받은 좋아요</div>
        </div>
          <div class="stat-card stat-views">
            <div class="stat-icon">🔍</div>
            <div class="stat-number"><fmt:formatNumber value="${myPostsTotalViewCount}" type="number"/></div>
            <div class="stat-label">총 조회수</div>
          </div>
      </div>
    </div>
  </section>

  <!-- 메인 컨텐츠 -->
  <section class="content-section">
    <div class="container">
      <div class="content-layout">
        <!-- 사이드바 -->
        <aside class="sidebar">
          <div class="sidebar-content">
            <h3 class="sidebar-title"><span class="sidebar-icon">👤</span>마이메뉴</h3>
            <div class="menu-list">
              <button class="menu-item active" data-tab="profile"><span class="menu-icon">👤</span><span class="menu-text">프로필</span></button>
              <button class="menu-item" data-tab="recipes"><span class="menu-icon">👨‍🍳</span><span class="menu-text">내 레시피</span></button>
              <button class="menu-item" data-tab="comments"><span class="menu-icon">💬</span><span class="menu-text">내 댓글</span></button>
              <button class="menu-item" data-tab="liked"><span class="menu-icon">❤️</span><span class="menu-text">좋아요</span></button>
              <button class="menu-item" data-tab="settings"><span class="menu-icon">⚙️</span><span class="menu-text">설정</span></button>
            </div>
          </div>
        </aside>

        <!-- 메인 컨텐츠 본문(※ main 금지, section/div 사용) -->
        <section class="main-content">

          <!-- 프로필 탭 -->
          <div class="tab-content active" id="tab-profile">
            <div class="content-grid">
              <!-- 등급 현황 카드 -->
              <div class="info-card">
                <div class="card-header">
                  <h3 class="card-title"><span class="title-icon">🏆</span>등급 현황</h3>
                </div>
                <div class="card-content">
                  <div class="level-status">
                    <div class="current-level">
                      <h4>현재 등급</h4>
                      <div class="level-display level-tree">
                        <div class="level-emoji">🌳</div>
                        <div class="level-name">나무</div>
                        <div class="level-desc">레시피 24개 작성</div>
                      </div>
                    </div>
                    <div class="next-level">
                      <h4>다음 등급</h4>
                      <div class="level-display level-forest">
                        <div class="level-emoji">🌲</div>
                        <div class="level-name">숲</div>
                        <div class="level-desc">레시피 26개 더 필요</div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- 활동 현황 카드 -->
              <div class="info-card">
                <div class="card-header">
                  <h3 class="card-title"><span class="title-icon">📈</span>활동 현황</h3>
                </div>
                <div class="card-content">
                  <div class="activity-list">
                    <div class="activity-item"><span class="activity-label">이번 달 레시피 작성</span><span class="activity-badge">3개</span></div>
                    <div class="activity-item"><span class="activity-label">이번 달 댓글 작성</span><span class="activity-badge">15개</span></div>
                    <div class="activity-item"><span class="activity-label">평균 레시피 조회수</span><span class="activity-badge">518회</span></div>
                    <div class="activity-item"><span class="activity-label">평균 좋아요 수</span><span class="activity-badge">77개</span></div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 내 레시피 탭 -->

          <div class="tab-content active" id="tab-recipes">
            <div class="tab-header">
              <h2 class="tab-title">작성한 레시피 (<c:out value="${myPostsTotalCount}" default="0"/>개)</h2>

              <!-- 추후 C:OUT 변경 요망  -->
              <a href="/board/write" class="btn-primary" id="btn-create-recipe">
                <span class="btn-icon">👨‍🍳</span> 새 레시피 작성
              </a>
            </div>

            <c:if test="${empty myPosts}">
              <div class="recipe-list">
                <div class="recipe-item">
                  <div class="recipe-info">
                    <div class="recipe-title">작성한 레시피가 없습니다.</div>
                  </div>
                </div>
              </div>
            </c:if>

            <c:if test="${not empty myPosts}">
              <div class="recipe-list">
                <c:forEach var="post" items="${myPosts}">
                  <!-- 맵에서 안전하게 값 꺼내고 기본값 지정 -->
                  <c:set var="__thumbRaw" value="${thumbnailById[post.boardId + '']}" />
                  <c:set var="__thumb" value="/images/default_thumbnail.png" />
                  <c:if test="${not empty __thumbRaw}">
                    <c:set var="__thumb" value="${__thumbRaw}" />
                  </c:if>

                  <c:set var="__catRaw" value="${categoryById[post.boardId + '']}" />
                  <c:set var="__cat" value="기타" />
                  <c:if test="${not empty __catRaw}">
                    <c:set var="__cat" value="${__catRaw}" />
                  </c:if>

                  <div class="recipe-item">
                    <!-- 썸네일 -->
                    <img src="${__thumb}" alt="썸네일" class="recipe-image" />

                    <!-- 본문 -->
                    <div class="recipe-info">
                      <div class="recipe-title">
                        <c:out value="${post.title}" />
                      </div>

                      <div class="recipe-meta">
                        <span class="recipe-category"><c:out value="${__cat}" /></span>
                        <span class="recipe-stat">🔍 <c:out value="${post.viewCount}" default="0"/></span>
                        <span class="recipe-stat">❤️ <c:out value="${post.likeCount}" default="0"/></span>
                        <!-- LocalDateTime 그대로 출력 (형식화 원하면 컨트롤러에서 문자열로 가공) -->
                        <span class="recipe-stat"><c:out value="${post.insertTime}" /></span>
                      </div>
                    </div>

                    <!-- 액션 -->
                    <!-- (반복문 안) 각 카드 렌더링 중, 액션 영역 바로 위에 URL 준비 -->
                    <c:url var="viewUrl" value="/board/view">
                      <c:param name="boardId" value="${post.boardId}"/>
                    </c:url>
                    <c:url var="editUrl" value="/board/edition">
                      <c:param name="boardId" value="${post.boardId}"/>
                    </c:url>

                    <div class="recipe-actions">
                      <!-- ✅ 조회 버튼: 상세 페이지 이동 -->
                      <a href="${viewUrl}" class="btn-view">조회</a>

                      <!-- 기존 버튼들 유지 -->
                      <a href="${editUrl}" class="btn-edit">수정</a>
                      <button type="button" class="btn-delete" data-id="${post.boardId}">삭제</button>
                    </div>
                  </div>
                </c:forEach>
              </div>
              <!-- 페이지네이션: 작성한 레시피 리스트 하단에 삽입 -->
              <c:if test="${not empty myPostsPaginationInfo and myPostsPaginationInfo.totalPages > 1}">
                <c:set var="page" value="${myPostsPaginationInfo}"/>
                <c:set var="current" value="${page.number + 1}"/>   <%-- 1-based --%>
                <c:set var="totalPages" value="${page.totalPages}"/>
                <c:set var="blockSize" value="10"/>
                <c:set var="blockStart" value="${((current-1) / blockSize) * blockSize + 1}"/>
                <c:set var="blockEnd" value="${blockStart + blockSize - 1}"/>
                <c:if test="${blockEnd > totalPages}">
                  <c:set var="blockEnd" value="${totalPages}"/>
                </c:if>

                <nav class="pagination" aria-label="myPosts pagination">
                  <!-- « 이전 블록 -->
                  <c:set var="prevBlock" value="${blockStart - blockSize}"/>
                  <c:if test="${prevBlock < 1}">
                    <c:set var="prevBlock" value="1"/>
                  </c:if>
                  <c:url var="prevBlockUrl" value="/mypage">
                    <c:param name="myPostsPage" value="${prevBlock}"/>
                  </c:url>
                  <a href="${prevBlockUrl}" class="btn-view ${blockStart == 1 ? 'disabled' : ''}">«</a>

                  <!-- 번호 -->
                  <c:forEach var="i" begin="${blockStart}" end="${blockEnd}">
                    <c:url var="numUrl" value="/mypage">
                      <c:param name="myPostsPage" value="${i}"/>
                    </c:url>
                    <a href="${numUrl}" class="btn-view ${i == current ? 'active' : ''}">${i}</a>
                  </c:forEach>

                  <!-- » 다음 블록 -->
                  <c:set var="nextBlock" value="${blockStart + blockSize}"/>
                  <c:if test="${nextBlock > totalPages}">
                    <c:set var="nextBlock" value="${totalPages}"/>
                  </c:if>
                  <c:url var="nextBlockUrl" value="/mypage">
                    <c:param name="myPostsPage" value="${nextBlock}"/>
                  </c:url>
                  <a href="${nextBlockUrl}" class="btn-view ${blockEnd == totalPages ? 'disabled' : ''}">»</a>
                </nav>
              </c:if>

            </c:if>
          </div>


          <!-- 내 댓글 탭 -->
          <div class="tab-content" id="tab-comments">
            <h2 class="tab-title">작성한 댓글 (156개)</h2>
            <div class="comment-list">
              <div class="comment-item">
                <div class="comment-header">
                  <h3 class="comment-recipe-title">레시피 제목 자리</h3>
                  <span class="comment-date">작성일</span>
                </div>
                <p class="comment-content">댓글 내용 자리입니다. 실제 댓글 내용이 여기에 표시됩니다.</p>
                <div class="comment-actions">
                  <button class="btn-view">레시피 보기</button>
                  <button class="btn-delete"><span class="btn-icon">🗑️</span>삭제</button>
                </div>
              </div>
            </div>
          </div>


          <!-- 좋아요 탭 (관리자/사용자 분리) : 더미데이터 버전 -->
          <div class="tab-content" id="tab-liked">
            <div class="mypage-like-head">
              <h2 class="tab-title">좋아요한 레시피</h2>

              <!-- 탭 버튼 -->
              <div class="mypage-like-tabs" role="tablist">
                <button type="button"
                        class="mypage-like-tabbtn is-active"
                        data-like-tab="admin"
                        aria-controls="mypage-like-pane-admin"
                        aria-selected="true">
                  👨‍🍳 관리자 레시피
                </button>
                <button type="button"
                        class="mypage-like-tabbtn"
                        data-like-tab="user"
                        aria-controls="mypage-like-pane-user"
                        aria-selected="false">
                  🧑‍🍳 사용자 레시피
                </button>
              </div>
            </div>

            <!-- 레시피 좋아요 탭 -->
            <div id="mypage-like-pane-admin" class="mypage-like-pane is-active" role="tabpanel">
              <div class="mypage-like-list">

                <c:if test="${empty likedRecipes}">
                  <p class="empty">좋아요한 레시피가 없습니다.</p>
                </c:if>

                <c:forEach var="r" items="${likedRecipes}">
                  <!-- 카드 전체 클릭: js 분리( /js/mypage-like.js ) -->
                  <div class="mypage-like-item link-card"
                       data-href="/recipe/view?recipeId=${r.recipeId}">

                    <div class="mypage-like-left">
                      <img class="mypage-like-thumb"
                           src="${empty r.thumbnail ? '/images/default_recipe.jpg' : r.thumbnail}"
                           alt="<c:out value='${r.titleKr}'/>"
                           onerror="this.src='/images/default_recipe.jpg'"/>

                      <div class="mypage-like-info">
                        <div class="mypage-like-title"><c:out value="${r.titleKr}"/></div>

                        <!-- 카테고리 배지: recipelist.css 규칙에 맞춘 클래스 매핑 -->
                        <c:set var="catCls" value=""/>
                        <c:choose>
                          <c:when test="${r.categoryKr eq '한식'}"><c:set var="catCls" value="korean"/></c:when>
                          <c:when test="${r.categoryKr eq '양식'}"><c:set var="catCls" value="western"/></c:when>
                          <c:when test="${r.categoryKr eq '중식'}"><c:set var="catCls" value="chinese"/></c:when>
                          <c:when test="${r.categoryKr eq '일식'}"><c:set var="catCls" value="japanese"/></c:when>
                          <c:when test="${r.categoryKr eq '디저트'}"><c:set var="catCls" value="dessert"/></c:when>
                        </c:choose>

                        <div class="mypage-like-meta">
                          <span class="category-badge ${catCls}"><c:out value="${r.categoryKr}"/></span>
                          <span class="meta-date"><c:out value="${r.likeDateText}"/></span>
                        </div>
                      </div>
                    </div>

                    <!-- (반복문 안) 액션 영역 바로 위에서 조회 URL 준비 -->
                    <c:url var="recipeViewUrl" value="/recipe/view">
                      <c:param name="recipeId" value="${r.recipeId}"/>
                    </c:url>

                    <div class="mypage-like-actions">
                      <!-- 조회: 레시피 상세 이동. 카드 전체 클릭과 충돌 방지 -->
                      <a href="${recipeViewUrl}" class="btn-view" onclick="event.stopPropagation();">조회</a>

                      <!-- 삭제: 지금은 동작 비활성 (JS 핸들러가 붙지 않도록 클래스 변경) -->
                      <button type="button"
                              class="btn-delete disabled"
                              aria-disabled="true"
                              title="현재 비활성화된 기능입니다"
                              onclick="event.stopPropagation();">
                        삭제
                      </button>
                    </div>
                  </div>
                </c:forEach>

              </div>

              <!-- ===== 페이지네이션: 좋아요한 레시피 하단 (1페이지여도 노출) ===== -->
              <c:if test="${not empty likedRecipesPaginationInfo and likedRecipesPaginationInfo.totalPages >= 1}">
                <c:set var="page" value="${likedRecipesPaginationInfo}"/>
                <c:set var="current" value="${page.number + 1}"/>   <%-- 1-based --%>
                <c:set var="totalPages" value="${page.totalPages}"/>
                <c:set var="blockSize" value="10"/>
                <c:set var="blockStart" value="${((current-1) / blockSize) * blockSize + 1}"/>
                <c:set var="blockEnd" value="${blockStart + blockSize - 1}"/>
                <c:if test="${blockEnd > totalPages}">
                  <c:set var="blockEnd" value="${totalPages}"/>
                </c:if>

                <nav class="pagination" aria-label="likedRecipes pagination">
                  <!-- « 이전 블록 -->
                  <c:set var="prevBlock" value="${blockStart - blockSize}"/>
                  <c:if test="${prevBlock < 1}">
                    <c:set var="prevBlock" value="1"/>
                  </c:if>
                  <c:url var="prevBlockUrl" value="/mypage">
                    <c:param name="tab" value="${activeTab}"/>
                    <c:param name="myPostsPage" value="${empty param.myPostsPage ? 1 : param.myPostsPage}"/>
                    <c:param name="likedPostsPage" value="${prevBlock}"/>
                  </c:url>
                  <a href="${prevBlockUrl}" class="btn-view ${blockStart == 1 ? 'disabled' : ''}">«</a>

                  <!-- 번호 -->
                  <c:forEach var="i" begin="${blockStart}" end="${blockEnd}">
                    <c:url var="numUrl" value="/mypage">
                      <c:param name="tab" value="${activeTab}"/>
                      <c:param name="myPostsPage" value="${empty param.myPostsPage ? 1 : param.myPostsPage}"/>
                      <c:param name="likedPostsPage" value="${i}"/>
                    </c:url>
                    <a href="${numUrl}" class="btn-view ${i == current ? 'active' : ''}">${i}</a>
                  </c:forEach>

                  <!-- » 다음 블록 -->
                  <c:set var="nextBlock" value="${blockStart + blockSize}"/>
                  <c:if test="${nextBlock > totalPages}">
                    <c:set var="nextBlock" value="${totalPages}"/>
                  </c:if>
                  <c:url var="nextBlockUrl" value="/mypage">
                    <c:param name="tab" value="${activeTab}"/>
                    <c:param name="myPostsPage" value="${empty param.myPostsPage ? 1 : param.myPostsPage}"/>
                    <c:param name="likedPostsPage" value="${nextBlock}"/>
                  </c:url>
                  <a href="${nextBlockUrl}" class="btn-view ${blockEnd == totalPages ? 'disabled' : ''}">»</a>
                </nav>
              </c:if>

            </div>



            <!-- 사용자 레시피 좋아요 목록 -->
            <div id="mypage-like-pane-user" class="mypage-like-pane" role="tabpanel">
              <div class="mypage-like-list">

                <c:if test="${empty likedPosts}">
                  <p class="mypage-like-empty">좋아요한 사용자 레시피가 없습니다.</p>
                </c:if>

                <c:forEach var="p" items="${likedPosts}">
                  <!-- 카드 전체 클릭 이동 -->
                  <div class="mypage-like-item link-card"
                       data-href="/board/view?boardId=${p.boardId}">

                    <div class="mypage-like-left">
                      <!-- 썸네일 -->
                      <img class="mypage-like-thumb"
                           src="${empty p.thumbnail ? '/images/default_thumbnail.png' : p.thumbnail}"
                           alt="<c:out value='${p.title}'/>"
                           onerror="this.src='/images/default_thumbnail.png'"/>

                      <!-- 본문 -->
                      <div class="mypage-like-info">
                        <div class="mypage-like-title"><c:out value="${p.title}"/></div>

                        <!-- 메타: 작성자 / 카테고리 / 좋아요일 -->
                        <div class="mypage-like-meta">
                          <span class="meta-author">by <c:out value="${p.writerName}"/></span>
                          <span class="meta-cat"><c:out value="${p.category}"/></span>
                          <span class="meta-date">
                <fmt:formatDate value="${p.likeDate}" pattern="yyyy.MM.dd"/>
              </span>
                        </div>
                      </div>
                    </div>

                    <!-- 우측 버튼: 조회 (카드 전체 클릭과 충돌 방지) -->
                    <c:url var="postViewUrl" value="/board/view">
                      <c:param name="boardId" value="${p.boardId}"/>
                    </c:url>
                    <div class="mypage-like-actions">
                      <a class="mypage-like-viewbtn" href="${postViewUrl}" onclick="event.stopPropagation();">보기 →</a>
                    </div>
                  </div>
                </c:forEach>

              </div>

              <!-- ===== 페이지네이션 (관리자 레시피와 동일 규칙) ===== -->
              <c:if test="${not empty likedPostsPaginationInfo and likedPostsPaginationInfo.totalPages >= 1}">
                <c:set var="page" value="${likedPostsPaginationInfo}"/>
                <c:set var="current" value="${page.number + 1}"/>  <%-- 1-based --%>
                <c:set var="totalPages" value="${page.totalPages}"/>
                <c:set var="blockSize" value="10"/>
                <c:set var="blockStart" value="${((current-1) / blockSize) * blockSize + 1}"/>
                <c:set var="blockEnd" value="${blockStart + blockSize - 1}"/>
                <c:if test="${blockEnd > totalPages}">
                  <c:set var="blockEnd" value="${totalPages}"/>
                </c:if>

                <nav class="pagination" aria-label="likedPosts pagination">
                  <!-- « 이전 블록 -->
                  <c:set var="prevBlock" value="${blockStart - blockSize}"/>
                  <c:if test="${prevBlock < 1}">
                    <c:set var="prevBlock" value="1"/>
                  </c:if>
                  <c:url var="prevBlockUrl" value="/mypage">
                    <c:param name="tab" value="${activeTab}"/>
                    <c:param name="myPostsPage" value="${empty param.myPostsPage ? 1 : param.myPostsPage}"/>
                    <c:param name="likedPostsPage" value="${prevBlock}"/>
                  </c:url>
                  <a href="${prevBlockUrl}" class="btn-view ${blockStart == 1 ? 'disabled' : ''}">«</a>

                  <!-- 번호 -->
                  <c:forEach var="i" begin="${blockStart}" end="${blockEnd}">
                    <c:url var="numUrl" value="/mypage">
                      <c:param name="tab" value="${activeTab}"/>
                      <c:param name="myPostsPage" value="${empty param.myPostsPage ? 1 : param.myPostsPage}"/>
                      <c:param name="likedPostsPage" value="${i}"/>
                    </c:url>
                    <a href="${numUrl}" class="btn-view ${i == current ? 'active' : ''}">${i}</a>
                  </c:forEach>

                  <!-- » 다음 블록 -->
                  <c:set var="nextBlock" value="${blockStart + blockSize}"/>
                  <c:if test="${nextBlock > totalPages}">
                    <c:set var="nextBlock" value="${totalPages}"/>
                  </c:if>
                  <c:url var="nextBlockUrl" value="/mypage">
                    <c:param name="tab" value="${activeTab}"/>
                    <c:param name="myPostsPage" value="${empty param.myPostsPage ? 1 : param.myPostsPage}"/>
                    <c:param name="likedPostsPage" value="${nextBlock}"/>
                  </c:url>
                  <a href="${nextBlockUrl}" class="btn-view ${blockEnd == totalPages ? 'disabled' : ''}">»</a>
                </nav>
              </c:if>
            </div>

          </div>


          <!-- 설정 탭 -->
          <div class="tab-content" id="tab-settings">
            <div class="settings-grid">
              <!-- 계정 정보 카드 -->
              <div class="settings-card">
                <div class="card-header">
                  <h3 class="card-title"><span class="title-icon">👤</span>계정 정보</h3>
                </div>
                <div class="card-content">
                  <div class="form-grid">
                    <div class="form-group">
                      <label for="nickname">닉네임</label>
                      <input type="text" id="nickname" value="사용자닉네임">
                    </div>
                    <div class="form-group">
                      <label for="email">이메일</label>
                      <input type="email" id="email" value="user@example.com">
                    </div>
                  </div>
                  <button class="btn-primary">프로필 업데이트</button>
                </div>
              </div>

              <!-- 비밀번호 변경 카드 -->
              <div class="settings-card">
                <div class="card-header">
                  <h3 class="card-title"><span class="title-icon">🔒</span>비밀번호 변경</h3>
                </div>
                <div class="card-content">
                  <div class="form-group">
                    <label for="current-password">현재 비밀번호</label>
                    <input type="password" id="current-password">
                  </div>
                  <div class="form-group">
                    <label for="new-password">새 비밀번호</label>
                    <input type="password" id="new-password">
                  </div>
                  <div class="form-group">
                    <label for="confirm-password">새 비밀번호 확인</label>
                    <input type="password" id="confirm-password">
                  </div>
                  <button class="btn-primary">비밀번호 변경</button>
                </div>
              </div>

              <!-- 계정 관리 카드 -->
              <div class="settings-card danger-card">
                <div class="card-header">
                  <h3 class="card-title"><span class="title-icon">🛡️</span>계정 관리</h3>
                </div>
                <div class="card-content">
                  <div class="danger-zone">
                    <h4 class="danger-title">계정 삭제</h4>
                    <p class="danger-text">계정을 삭제하면 모든 데이터가 영구적으로 삭제되며 복구할 수 없습니다.</p>
                    <button class="btn-danger">계정 삭제하기</button>
                  </div>
                </div>
              </div>
            </div>
          </div>

        </section> <!-- /.main-content -->
      </div> <!-- /.content-layout -->
    </div> <!-- /.container -->
  </section> <!-- /.content-section -->
</main> <!-- /.mypage-main -->

<!-- 푸터는 제외 -->
<jsp:include page="/common/footer.jsp"/>

<script src="/js/common.js"></script>
<script src="/js/mypage.js"></script>
</body>
</html>