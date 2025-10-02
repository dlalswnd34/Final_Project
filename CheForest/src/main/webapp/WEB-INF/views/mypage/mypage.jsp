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
  

  <%-- JSTL: URL 파라미터를 확인하여 현재 활성화할 탭을 결정합니다. 기본값은 'profile'입니다. --%>
  <c:set var="activeTab" value="${empty param.tab ? 'profile' : param.tab}" />

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

  <section class="content-section">
    <div class="container">
      <div class="content-layout">
        <aside class="sidebar">
          <div class="sidebar-content">
            <h3 class="sidebar-title"><span class="sidebar-icon">👤</span>마이메뉴</h3>
            <div class="menu-list">
              <%-- JSTL: activeTab에 따라 active 클래스 적용 --%>
              <button class="menu-item ${activeTab == 'profile' ? 'active' : ''}" data-tab="profile"><span class="menu-icon">👤</span><span class="menu-text">프로필</span></button>
              <button class="menu-item ${activeTab == 'recipes' ? 'active' : ''}" data-tab="recipes"><span class="menu-icon">👨‍🍳</span><span class="menu-text">내 레시피</span></button>
              <button class="menu-item ${activeTab == 'comments' ? 'active' : ''}" data-tab="comments"><span class="menu-icon">💬</span><span class="menu-text">내 댓글</span></button>
              <button class="menu-item ${activeTab == 'liked' ? 'active' : ''}" data-tab="liked"><span class="menu-icon">❤️</span><span class="menu-text">좋아요</span></button>
              <button class="menu-item ${activeTab == 'inquiries' ? 'active' : ''}" data-tab="inquiries"><span class="menu-icon">❓</span><span class="menu-text">문의 내역</span></button>
              <button class="menu-item ${activeTab == 'settings' ? 'active' : ''}" data-tab="settings"><span class="menu-icon">⚙️</span><span class="menu-text">설정</span></button>
            </div>
          </div>
        </aside>

        <section class="main-content">

          <%-- JSTL: activeTab에 따라 active 클래스 적용 --%>
          <div class="tab-content ${activeTab == 'profile' ? 'active' : ''}" id="tab-profile">
            <div class="content-grid">
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

          <%-- JSTL: activeTab에 따라 active 클래스 적용 --%>
          <div class="tab-content ${activeTab == 'recipes' ? 'active' : ''}" id="tab-recipes">
            <div class="tab-header">
              <h2 class="tab-title">작성한 레시피 (<c:out value="${myPostsTotalCount}" default="0"/>개)</h2>

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
                    <img src="${__thumb}" alt="썸네일" class="recipe-image" />

                    <div class="recipe-info">
                      <div class="recipe-title">
                        <c:out value="${post.title}" />
                      </div>

                      <div class="recipe-meta">
                        <span class="category-badge" data-category="${__cat}"><c:out value="${__cat}" /></span>
                        <span class="recipe-stat">🔍 <c:out value="${post.viewCount}" default="0"/></span>
                        <span class="recipe-stat">❤️ <c:out value="${post.likeCount}" default="0"/></span>
                          <%-- fmt로 날짜변환 코드 (기존 로직 유지) --%>
                        <c:set var="dtStr" value="${post.insertTime}" />
                        <c:set var="dtStr" value="${fn:replace(dtStr, 'T', ' ')}" />

                        <c:choose>
                          <c:when test="${fn:length(dtStr) == 16}">
                            <fmt:parseDate value="${dtStr}" pattern="yyyy-MM-dd HH:mm" var="dt"/>
                          </c:when>
                          <c:otherwise>
                            <fmt:parseDate value="${dtStr}" pattern="yyyy-MM-dd HH:mm:ss" var="dt"/>
                          </c:otherwise>
                        </c:choose>

                        <span class="recipe-stat">
                                <fmt:formatDate value="${dt}" pattern="yyyy년 MM월 dd일 a hh시 mm분"/>
                                </span>
                      </div>
                    </div>

                    <c:url var="viewUrl" value="/board/view">
                      <c:param name="boardId" value="${post.boardId}"/>
                    </c:url>
                    <c:url var="editUrl" value="/board/edition">
                      <c:param name="boardId" value="${post.boardId}"/>
                    </c:url>

                    <div class="recipe-actions">
                      <a href="${viewUrl}" class="btn-view">조회</a>

                      <a href="${editUrl}" class="btn-edit">수정</a>
                      <button type="button" class="btn-delete" data-id="${post.boardId}">삭제</button>
                    </div>
                  </div>
                </c:forEach>
              </div>
              <!-- 페이지네이션: 작성한 레시피 리스트 하단에 삽입 -->
              <c:if test="${not empty myPostsPaginationInfo and myPostsPaginationInfo.totalPages >= 1}">
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
                  <c:set var="prevBlock" value="${blockStart - blockSize}"/>
                  <c:if test="${prevBlock < 1}">
                    <c:set var="prevBlock" value="1"/>
                  </c:if>
                  <c:url var="prevBlockUrl" value="/mypage">
                    <c:param name="tab" value="${activeTab}"/> <%-- tab 파라미터 추가 --%>
                    <c:param name="myPostsPage" value="${prevBlock}"/>
                  </c:url>
                  <a href="${prevBlockUrl}" class="btn-view ${blockStart == 1 ? 'disabled' : ''}">«</a>

                  <c:forEach var="i" begin="${blockStart}" end="${blockEnd}">
                    <c:url var="numUrl" value="/mypage">
                      <c:param name="tab" value="${activeTab}"/> <%-- tab 파라미터 추가 --%>
                      <c:param name="myPostsPage" value="${i}"/>
                    </c:url>
                    <a href="${numUrl}" class="btn-view ${i == current ? 'active' : ''}">${i}</a>
                  </c:forEach>

                  <c:set var="nextBlock" value="${blockStart + blockSize}"/>
                  <c:if test="${nextBlock > totalPages}">
                    <c:set var="nextBlock" value="${totalPages}"/>
                  </c:if>
                  <c:url var="nextBlockUrl" value="/mypage">
                    <c:param name="tab" value="${activeTab}"/> <%-- tab 파라미터 추가 --%>
                    <c:param name="myPostsPage" value="${nextBlock}"/>
                  </c:url>
                  <a href="${nextBlockUrl}" class="btn-view ${blockEnd == totalPages ? 'disabled' : ''}">»</a>
                </nav>
              </c:if>

            </c:if>
          </div>

          <%-- JSTL: activeTab에 따라 active 클래스 적용 --%>
          <div class="tab-content ${activeTab == 'comments' ? 'active' : ''}" id="tab-comments">
            <h2 class="tab-title">작성한 댓글 (156개)</h2>
            <div class="comment-list">

              <!-- 비어있을 때 -->
              <c:if test="${empty myReviews}">
                <p class="mypage-like-empty">작성한 댓글이 없습니다.</p>
              </c:if>

              <!-- 반복 렌더링 -->
              <c:forEach var="rv" items="${myReviews}">
                <!-- 카드 전체 클릭 이동 (좋아요 탭과 동일 패턴) -->
                <div class="comment-item link-card"
                     data-href="/board/view?boardId=${rv.boardId}">
                  <div class="comment-header">
                    <h3 class="comment-recipe-title"><c:out value="${rv.boardTitle}"/></h3>
                    <span class="comment-date">
            <c:choose>
              <c:when test="${not empty rv.insertTime}">
                <fmt:formatDate value="${rv.insertTime}" pattern="yyyy-MM-dd"/>
              </c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </span>
                  </div>

                  <p class="comment-content"><c:out value="${rv.content}"/></p>

                  <!-- 조회/삭제 (카드 클릭과 충돌 방지: stopPropagation) -->
                  <c:url var="boardViewUrl" value="/board/view">
                    <c:param name="boardId" value="${rv.boardId}"/>
                  </c:url>
                  <div class="comment-actions">
                    <a class="btn-view" href="${boardViewUrl}" onclick="event.stopPropagation();">레시피 보기</a>
                    <button type="button" class="btn-delete" data-id="${rv.reviewId}" onclick="event.stopPropagation();">삭제</button>
                  </div>
                </div>
              </c:forEach>
            </div>

            <!-- ===== 페이지네이션(1페이지라도 노출) ===== -->
            <c:if test="${not empty myReviewsPaginationInfo and myReviewsPaginationInfo.totalPages >= 1}">
              <c:set var="page" value="${myReviewsPaginationInfo}"/>
              <c:set var="current" value="${page.number + 1}"/>  <%-- 1-based --%>
              <c:set var="totalPages" value="${page.totalPages}"/>
              <c:set var="blockSize" value="10"/>
              <c:set var="blockStart" value="${((current-1) / blockSize) * blockSize + 1}"/>
              <c:set var="blockEnd" value="${blockStart + blockSize - 1}"/>
              <c:if test="${blockEnd > totalPages}">
                <c:set var="blockEnd" value="${totalPages}"/>
              </c:if>

              <nav class="pagination" aria-label="myReviews pagination">
                <!-- « 이전 블록 -->
                <c:set var="prevBlock" value="${blockStart - blockSize}"/>
                <c:if test="${prevBlock < 1}">
                  <c:set var="prevBlock" value="1"/>
                </c:if>
                <c:url var="prevBlockUrl" value="/mypage">
                  <c:param name="tab" value="comments"/>
                  <c:param name="myReviewsPage" value="${prevBlock}"/>
                </c:url>
                <a href="${prevBlockUrl}" class="btn-view ${blockStart == 1 ? 'disabled' : ''}">«</a>

                <!-- 번호 -->
                <c:forEach var="i" begin="${blockStart}" end="${blockEnd}">
                  <c:url var="numUrl" value="/mypage">
                    <c:param name="tab" value="comments"/>
                    <c:param name="myReviewsPage" value="${i}"/>
                  </c:url>
                  <a href="${numUrl}" class="btn-view ${i == current ? 'active' : ''}">${i}</a>
                </c:forEach>

                <!-- » 다음 블록 -->
                <c:set var="nextBlock" value="${blockStart + blockSize}"/>
                <c:if test="${nextBlock > totalPages}">
                  <c:set var="nextBlock" value="${totalPages}"/>
                </c:if>
                <c:url var="nextBlockUrl" value="/mypage">
                  <c:param name="tab" value="comments"/>
                  <c:param name="myReviewsPage" value="${nextBlock}"/>
                </c:url>
                <a href="${nextBlockUrl}" class="btn-view ${blockEnd == totalPages ? 'disabled' : ''}">»</a>
              </nav>
            </c:if>
          </div>


          <%-- JSTL: activeTab에 따라 active 클래스 적용 --%>
          <div class="tab-content ${activeTab == 'liked' ? 'active' : ''}" id="tab-liked">
            <div class="mypage-like-head">
              <h2 class="tab-title">좋아요한 레시피</h2>

              <div class="mypage-like-tabs" role="tablist">
                <button type="button"
                        class="mypage-like-tabbtn is-active"
                        data-like-tab="admin"
                        aria-controls="mypage-like-pane-admin"
                        aria-selected="true">
                  <i data-lucide="chef-hat" class="h-5 w-5 text-orange-500"></i>
                  <span class="brand-gradient">CheForest</span>
                  <span>레시피</span>
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

            <div id="mypage-like-pane-admin" class="mypage-like-pane is-active" role="tabpanel">
              <div class="mypage-like-list">

                <c:if test="${empty likedRecipes}">
                  <p class="empty">좋아요한 레시피가 없습니다.</p>
                </c:if>

                <c:forEach var="r" items="${likedRecipes}">
                  <div class="mypage-like-item link-card"
                       data-href="/recipe/view?recipeId=${r.recipeId}">

                    <div class="mypage-like-left">
                      <img class="mypage-like-thumb"
                           src="${empty r.thumbnail ? '/images/default_recipe.jpg' : r.thumbnail}"
                           alt="<c:out value='${r.titleKr}'/>"
                           onerror="this.src='/images/default_recipe.jpg'"/>

                      <div class="mypage-like-info">
                        <div class="mypage-like-title"><c:out value="${r.titleKr}"/></div>

                        <div class="mypage-like-meta">
                          <span class="category-badge" data-category="${r.categoryKr}"><c:out value="${r.categoryKr}"/></span>
                        </div>
                      </div>
                    </div>

                    <c:url var="recipeViewUrl" value="/recipe/view">
                      <c:param name="recipeId" value="${r.recipeId}"/>
                    </c:url>

                    <div class="mypage-like-actions">
                      <a href="${recipeViewUrl}" class="btn-view" onclick="event.stopPropagation();">조회</a>

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
                  <c:set var="prevBlock" value="${blockStart - blockSize}"/>
                  <c:if test="${prevBlock < 1}">
                    <c:set var="prevBlock" value="1"/>
                  </c:if>
                  <c:url var="prevBlockUrl" value="/mypage">
                    <c:param name="tab" value="${activeTab}"/>
                    <c:param name="myPostsPage" value="${empty param.myPostsPage ? 1 : param.myPostsPage}"/>
                    <c:param name="likedRecipesPage" value="${prevBlock}"/> <%-- likedPostsPage -> likedRecipesPage 수정 (오타 정정) --%>
                  </c:url>
                  <a href="${prevBlockUrl}" class="btn-view ${blockStart == 1 ? 'disabled' : ''}">«</a>

                  <c:forEach var="i" begin="${blockStart}" end="${blockEnd}">
                    <c:url var="numUrl" value="/mypage">
                      <c:param name="tab" value="${activeTab}"/>
                      <c:param name="myPostsPage" value="${empty param.myPostsPage ? 1 : param.myPostsPage}"/>
                      <c:param name="likedRecipesPage" value="${i}"/> <%-- likedPostsPage -> likedRecipesPage 수정 (오타 정정) --%>
                    </c:url>
                    <a href="${numUrl}" class="btn-view ${i == current ? 'active' : ''}">${i}</a>
                  </c:forEach>

                  <c:set var="nextBlock" value="${blockStart + blockSize}"/>
                  <c:if test="${nextBlock > totalPages}">
                    <c:set var="nextBlock" value="${totalPages}"/>
                  </c:if>
                  <c:url var="nextBlockUrl" value="/mypage">
                    <c:param name="tab" value="${activeTab}"/>
                    <c:param name="myPostsPage" value="${empty param.myPostsPage ? 1 : param.myPostsPage}"/>
                    <c:param name="likedRecipesPage" value="${nextBlock}"/> <%-- likedPostsPage -> likedRecipesPage 수정 (오타 정정) --%>
                  </c:url>
                  <a href="${nextBlockUrl}" class="btn-view ${blockEnd == totalPages ? 'disabled' : ''}">»</a>
                </nav>
              </c:if>

            </div>



            <div id="mypage-like-pane-user" class="mypage-like-pane" role="tabpanel">
              <div class="mypage-like-list">

                <c:if test="${empty likedPosts}">
                  <p class="mypage-like-empty">좋아요한 사용자 레시피가 없습니다.</p>
                </c:if>

                <c:forEach var="p" items="${likedPosts}">
                  <div class="mypage-like-item link-card"
                       data-href="/board/view?boardId=${p.boardId}">

                    <div class="mypage-like-left">
                      <img class="mypage-like-thumb"
                           src="${empty p.thumbnail ? '/images/default_thumbnail.png' : p.thumbnail}"
                           alt="<c:out value='${p.title}'/>"
                           onerror="this.src='/images/default_thumbnail.png'"/>

                      <div class="mypage-like-info">
                        <div class="mypage-like-title"><c:out value="${p.title}"/></div>

                        <div class="mypage-like-meta">
                          <span class="meta-author">by <c:out value="${p.writerName}"/></span>
                          <span class="category-badge" data-category="${p.category}"><c:out value="${p.category}"/></span>
                          <span class="meta-date">
                          </span>
                        </div>
                      </div>
                    </div>

                    <c:url var="postViewUrl" value="/board/view">
                      <c:param name="boardId" value="${p.boardId}"/>
                    </c:url>

                    <div class="mypage-like-actions">
                      <a class="mypage-like-viewbtn"
                         href="${postViewUrl}"
                         onclick="event.stopPropagation();">조회</a>

                        <%-- alert()를 console.log()로 대체하여 사용자에게 블로킹 팝업이 뜨는 것을 방지 --%>
                      <button type="button" class="btn-delete"
                              onclick="event.stopPropagation(); console.log('삭제(좋아요 해제)는 곧 제공됩니다.');">
                        삭제
                      </button>
                    </div>
                  </div>
                </c:forEach>

              </div>

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

                  <c:forEach var="i" begin="${blockStart}" end="${blockEnd}">
                    <c:url var="numUrl" value="/mypage">
                      <c:param name="tab" value="${activeTab}"/>
                      <c:param name="myPostsPage" value="${empty param.myPostsPage ? 1 : param.myPostsPage}"/>
                      <c:param name="likedPostsPage" value="${i}"/>
                    </c:url>
                    <a href="${numUrl}" class="btn-view ${i == current ? 'active' : ''}">${i}</a>
                  </c:forEach>

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








          <%-- 문의 내역 관련 --%>
          <%-- JSTL: activeTab에 따라 active 클래스 적용 --%>
          <div class="tab-content ${activeTab == 'inquiries' ? 'active' : ''}" id="tab-inquiries"> <div class="tab-header">
            <h2>문의 내역 (<span id="inquiry-count">...</span>개)</h2>
            <button class="btn btn-primary" onclick="goToInquiry()">새 문의하기</button>
          </div>

            <div class="inquiries-list" id="inquiries-list-container">
              <p class="loading-message">문의 내역을 불러오는 중...</p>
            </div>

            <div class="pagination-container" id="inquiries-pagination">
            </div>
          </div>
          <%-- 문의 내역 관련 끝--%>









          <%-- JSTL: activeTab에 따라 active 클래스 적용 --%>
          <div class="tab-content ${activeTab == 'settings' ? 'active' : ''}" id="tab-settings">
            <div class="settings-grid">
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

        </section> </div> </div> </section> </main> <jsp:include page="/common/footer.jsp"/>

<script src="/js/common.js"></script>
<script src="/js/mypages.js"></script>
</body>
</html>
