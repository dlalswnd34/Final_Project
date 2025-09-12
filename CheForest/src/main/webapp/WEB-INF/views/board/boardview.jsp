<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<head>
    <meta charset="UTF-8">
    <title>요리 게시글 상세조회</title>
    <link rel="stylesheet" href="/css/style.css" />
    <link rel="stylesheet" href="/css/sidebar.css" />
    <link rel="stylesheet" href="/css/boardview.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <jsp:include page="/common/header.jsp" />
</head>
<body>
<div class="main-wrap">
    <!-- 사이드바 -->
    <div class="sidebar-wrap">
        <jsp:include page="/common/sidebar.jsp" />
    </div>

    <!-- 게시글 상세 -->
    <div class="board-wrap">
        <!-- 타이틀 -->
        <div class="board-title">
            <span class="icon">🍽️</span>
            <span id="board-title-text">
                <c:choose>
                    <c:when test="${board.category eq '한식'}">한식 게시판</c:when>
                    <c:when test="${board.category eq '양식'}">양식 게시판</c:when>
                    <c:when test="${board.category eq '중식'}">중식 게시판</c:when>
                    <c:when test="${board.category eq '일식'}">일식 게시판</c:when>
                    <c:when test="${board.category eq '디저트'}">디저트 게시판</c:when>
                    <c:otherwise>게시판</c:otherwise>
                </c:choose>
            </span>
        </div>

        <!-- 카테고리 탭 -->
        <div class="category-tabs">
            <div class="category-tab${empty board.category ? ' active' : ''}" onclick="moveCategory('')">전체</div>
            <div class="category-tab${board.category eq '한식' ? ' active' : ''}" onclick="moveCategory('한식')">한식</div>
            <div class="category-tab${board.category eq '양식' ? ' active' : ''}" onclick="moveCategory('양식')">양식</div>
            <div class="category-tab${board.category eq '중식' ? ' active' : ''}" onclick="moveCategory('중식')">중식</div>
            <div class="category-tab${board.category eq '일식' ? ' active' : ''}" onclick="moveCategory('일식')">일식</div>
            <div class="category-tab${board.category eq '디저트' ? ' active' : ''}" onclick="moveCategory('디저트')">디저트</div>
        </div>

        <!-- 상단 정보 -->
        <div class="board-title-row">
            <span class="board-title-main">🧑🏻‍🍳 ${board.title}</span>
            <div class="board-title-info">
                <span class="category-badge">${board.category}</span>
                작성자: <b>${board.nickname}</b>
                | 작성일: ${board.insertTime}
                | 조회수: ${board.viewCount}
            </div>
        </div>

        <!-- 상세 내용 -->
        <div class="post-section-title">재료준비</div>
        <div class="post-content">
            <c:out value="${board.prepare}" escapeXml="false"/>
        </div>

        <div class="post-section-title">조리법</div>
        <div class="post-content">
            <c:out value="${board.content}" escapeXml="false"/>
        </div>

        <!-- 첨부 이미지 -->
        <c:if test="${not empty fileList}">
            <div class="post-section-title">사진</div>
            <div class="post-image-list">
                <c:forEach var="file" items="${fileList}">
                    <img src="/file/download?fileId=${file.fileId}" alt="요리사진" class="post-img-multi" />
                </c:forEach>
            </div>
        </c:if>

        <!-- 좋아요 버튼 -->
        <div class="like-btn-wrap">
            <button type="button" class="like-btn" id="likeBtn"
                    data-board-id="${board.boardId}"
                    data-member-idx="${loginUser != null ? loginUser.memberIdx : 0}">♡</button>
            <div class="like-count-text" id="likeCountText">좋아요 0개</div>
        </div>

        <!-- 삭제용 hidden form -->
        <form id="deleteForm" action="${pageContext.request.contextPath}/board/delete"
              method="post" style="display: none;">
            <input type="hidden" name="boardId" value="${board.boardId}" />
            <input type="hidden" name="category" value="${board.category}" />
        </form>

        <!-- 버튼 영역 -->
        <div class="post-btns" style="margin-top: 10px;">
            <a href="/board/list?category=${board.category}" class="btn btn-secondary btn-sm">목록</a>

            <c:if test="${loginUser != null && loginUser.memberIdx eq board.writerIdx}">
                <a href="/board/edition?boardId=${board.boardId}" class="btn btn-success btn-sm">수정</a>
                <form action="${pageContext.request.contextPath}/board/delete" method="post" style="display:inline;">
                    <input type="hidden" name="boardId" value="${board.boardId}" />
                    <input type="hidden" name="category" value="${board.category}" />
                    <button type="submit" class="btn btn-danger btn-sm"
                            onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                </form>
            </c:if>

            <c:if test="${loginUser != null && fn:toUpperCase(loginUser.role) eq 'ADMIN'}">
                <form action="${pageContext.request.contextPath}/board/admin/delete" method="post" style="display:inline;">
                    <input type="hidden" name="boardId" value="${board.boardId}" />
                    <input type="hidden" name="category" value="${board.category}" />
                    <button type="submit" class="btn btn-danger btn-sm"
                            onclick="return confirm('⚠️ 관리자 권한으로 삭제하시겠습니까?');">
                        관리자 강제 삭제
                    </button>
                </form>
            </c:if>
        </div>

        <!-- 댓글 영역 -->
        <div class="comment-section mt-4">
            <h6 class="mb-2">댓글 <span>(${fn:length(reviews)})</span></h6>

            <c:choose>
                <c:when test="${empty loginUser}">
                    <div class="comment-login-notice">
                        댓글을 남기시려면 <a href="/member/login" class="btn btn-dark btn-sm">로그인</a> 해주세요
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="comment-write-wrap">
                        <form action="/review/add" method="post" class="comment-form">
                            <input type="hidden" name="boardId" value="${board.boardId}">
                            <textarea name="content" class="comment-textarea"
                                      id="commentContent" maxlength="300" required
                                      placeholder="댓글을 입력하세요" oninput="updateCharCount();"></textarea>
                            <button type="submit" class="comment-submit-btn">댓글등록</button>
                        </form>
                        <div class="comment-char-count">
                            <span id="charCount">0</span> / 300
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="comment-list">
                <c:forEach var="review" items="${reviews}">
                    <div class="comment-item">
                        <div class="comment-row">
                            <div class="comment-content" id="reviewContent${review.reviewId}">
                                    ${review.content}
                            </div>
                            <div class="comment-meta">
                                <span class="comment-nickname">${review.nickname}</span>
                                <span class="comment-date">${review.insertTime}</span>
                            </div>

                            <!-- 본인 댓글에만 수정/삭제 버튼 -->
                            <c:if test="${loginUser != null && loginUser.memberIdx == review.writerIdx}">
                                <div class="comment-btn-group">
                                    <button type="button" class="comment-edit-btn"
                                            onclick="showEditForm('${review.reviewId}')">수정</button>
                                    <form action="/review/delete" method="post" style="display:inline;">
                                        <input type="hidden" name="reviewId" value="${review.reviewId}" />
                                        <input type="hidden" name="boardId" value="${board.boardId}" />
                                        <button type="submit" class="comment-delete-btn">삭제</button>
                                    </form>
                                </div>

                                <!-- 인라인 수정 폼 -->
                                <form id="editForm${review.reviewId}" action="/review/edit" method="post"
                                      style="display:none; margin-top:5px;">
                                    <input type="hidden" name="reviewId" value="${review.reviewId}" />
                                    <input type="hidden" name="boardId" value="${board.boardId}" />
                                    <textarea name="content" id="editContent${review.reviewId}">${review.content}</textarea>
                                    <button type="submit">저장</button>
                                    <button type="button" onclick="hideEditForm(${review.reviewId})">취소</button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${fn:length(reviews) == 0}">
                    <div class="comment-empty">아직 댓글이 없습니다.</div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<script>
    function moveCategory(category) {
        window.location.href = '/board/list?category=' + category;
    }

    function updateCharCount() {
        const textarea = document.getElementById("commentContent");
        if (textarea) {
            document.getElementById("charCount").innerText = textarea.value.length;
        }
    }

    $(document).ready(function () {
        initLikeButton({
            likeType: "BOARD",
            boardId: "${board.boardId}",
            memberIdx: "${loginUser != null ? loginUser.memberIdx : 0}"
        });
    });

    function fn_delete() {
        if (confirm("정말 삭제하시겠습니까? 복구되지 않습니다.")) {
            document.getElementById("deleteForm").submit();
        }
    }

    function showEditForm(reviewId) {
        document.getElementById('reviewContent' + reviewId).style.display = 'none';
        document.getElementById('editForm' + reviewId).style.display = '';
        var origin = document.getElementById('reviewContent' + reviewId).innerText;
        document.getElementById('editContent' + reviewId).value = origin;
    }

    function hideEditForm(reviewId) {
        document.getElementById('reviewContent' + reviewId).style.display = '';
        document.getElementById('editForm' + reviewId).style.display = 'none';
    }
</script>
<script src="/js/like.js"></script>
<jsp:include page="/common/footer.jsp"></jsp:include>
</body>
</html>
