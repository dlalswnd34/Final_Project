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
  <title><c:out value="${board.title}" default="게시글 상세보기"/> - CheForest</title>

  <link rel="stylesheet" href="/css/common/common.css">
  <link rel="stylesheet" href="/css/board/boardview.css">
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum:wght@400&display=swap" rel="stylesheet">
</head>
<body>
<jsp:include page="/common/header.jsp"/>

<div class="detail-container">

  <!-- 상단 네비게이션 (단일 블록) -->
  <div class="nav-content">
    <button class="back-btn" onclick="location.href='/board/list'">
      <i data-lucide="arrow-left"></i>
      <span>게시판으로</span>
    </button>

    <!-- 작성자에게만 수정/삭제 노출: principal.nickname == board.nickname -->
    <div class="nav-actions">
      <sec:authorize access="isAuthenticated()">
        <c:set var="currentNickname"><sec:authentication property="principal.nickname"/></c:set>
        <c:if test="${not empty currentNickname and currentNickname == board.nickname}">
          <button class="edit-btn" onclick="location.href='/board/edit?boardId=${board.boardId}'">
            <i data-lucide="pencil"></i> 수정
          </button>
          <button class="delete-btn"
                  onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='/board/delete?boardId=${board.boardId}'">
            <i data-lucide="trash-2"></i> 삭제
          </button>
        </c:if>
      </sec:authorize>
    </div>
  </div>
  <!-- // 상단 네비게이션 -->

  <c:choose>
    <c:when test="${board != null}">
      <div class="detail-content">

        <!-- 게시글 헤더 -->
        <div class="post-header">
          <div class="post-meta">
            <span class="category-badge"><c:out value="${board.category}" default="기타"/></span>
            <h1 class="post-title"><c:out value="${board.title}" default="제목없음"/></h1>
          </div>

          <!-- 작성자 -->
          <div class="author-section">
            <div class="author-info">
              <div class="author-avatar">
                <img src="<c:out value='${board.profile}' default='/images/default_profile.png'/>"
                     alt="작성자 프로필"
                     class="avatar-img">
              </div>
              <div>
                <div class="author-name-line">
                  <span class="author-name"><c:out value="${board.nickname}" default="익명"/></span>
                  <span class="user-grade grade-${board.grade}"><c:out value="${board.grade}"/></span>
                </div>
                <span class="post-date">${board.insertTimeStr}</span>
              </div>
            </div>
            <div class="action-buttons">
              <button class="action-btn like-btn" id="likeBtn" type="button">
                <i data-lucide="heart"></i>
                <span class="count"><c:out value="${board.likeCount}" default="0"/></span>
              </button>
              <div class="action-btn view-btn">
                <i data-lucide="eye"></i>
                <span class="count"><c:out value="${board.viewCount}" default="0"/></span>
              </div>
            </div>
          </div>
        </div>

        <!-- 메인 이미지 -->
        <div class="post-image">
          <img src="<c:out value='${board.thumbnail}' default='/images/default_thumbnail.png'/>"
               alt="게시글 이미지"
               class="main-image"
               onerror="this.src='/images/default_thumbnail.png'">
        </div>

        <!-- 재료/조리법 탭 -->
        <div class="tabs-container">
          <div class="tabs-list">
            <button class="tab-trigger active" data-tab="ingredients">재료</button>
            <button class="tab-trigger" data-tab="instructions">조리법</button>
          </div>
          <div class="tab-content active" id="ingredientsContent">
            <c:out value="${board.prepare}" default="등록된 재료가 없습니다."/>
          </div>
          <div class="tab-content" id="instructionsContent">
            <c:out value="${board.content}" default="등록된 조리법이 없습니다."/>
          </div>
        </div>

        <!-- 댓글 -->
        <div class="comments-section">
          <div class="comments-header">
            <h3 class="comments-title">💬 댓글</h3>
          </div>

          <!-- 댓글 작성폼 (로그인 시 표시) -->
          <sec:authorize access="isAuthenticated()">
            <div class="comment-write">
              <form id="commentForm">
                <div class="write-header" style="display:flex; gap:1rem; align-items:center;">
                  <div class="writer-avatar">
                    <img src="<sec:authentication property='principal.profile' />"
                         alt="<sec:authentication property='principal.nickname' />"
                         class="avatar-img">
                  </div>
                  <div class="writer-info">
                    <span class="writer-name"><sec:authentication property="principal.nickname"/></span>
                    <span class="user-grade grade-<sec:authentication property='principal.grade' />">
                      <sec:authentication property="principal.grade"/>
                    </span>
                  </div>
                </div>
                <div class="write-form" style="margin-top:0.5rem;">
                  <textarea id="commentTextarea"
                            class="comment-textarea"
                            placeholder="이 레시피에 대한 생각을 나눠주세요! ✨ 팀이나 변형 레시피도 환영해요!"
                            required></textarea>
                </div>
                <div class="comment-guide">🔔 따뜻한 댓글로 요리의 즐거움을 나눠보세요</div>
                <div class="write-footer">
                  <button type="submit" class="submit-btn">
                    <i data-lucide="send"></i> 댓글 등록
                  </button>
                </div>
                <input type="hidden" name="boardId" value="${board.boardId}">
              </form>
            </div>
          </sec:authorize>

          <!-- 댓글 목록 -->
          <div class="comments-list" id="commentsList"></div>
        </div>
      </div>
    </c:when>
    <c:otherwise>
      <div class="detail-content">
        <div class="empty-box">존재하지 않거나 삭제된 게시글입니다.</div>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    lucide.createIcons();
  });
</script>

<!-- 로그인 사용자 정보 (JS에서 사용) -->
<sec:authorize access="isAuthenticated()">
  <script>
    window.boardId = <c:out value="${board.boardId}" default="0"/>;
    window.loginUser = {
      memberIdx: "<sec:authentication property='principal.memberIdx' />",
      nickname: "<sec:authentication property='principal.nickname' />",
      grade: "<sec:authentication property='principal.grade' />",
      profile: "<sec:authentication property='principal.profile' />"
    };
  </script>
</sec:authorize>

<sec:authorize access="!isAuthenticated()">
  <script>
    window.boardId = <c:out value="${board.boardId}" default="0"/>;
    window.loginUser = null;
  </script>
</sec:authorize>

<script src="/js/board/boardview.js"></script>
<jsp:include page="/common/footer.jsp"/>
</body>
</html>
