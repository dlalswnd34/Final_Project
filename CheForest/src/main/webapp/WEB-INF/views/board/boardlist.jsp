<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>요리정보 카테고리 게시판</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
	<link rel="stylesheet" href="/css/style.css">
	<link rel="stylesheet" href="/css/boardlist.css">
	<link rel="stylesheet" href="/css/sidebar.css" />
	<link rel="stylesheet" href="/css/pagination.css">
	<jsp:include page="/common/header.jsp" />
</head>

<body>
<div class="main-flex">
	<!-- 사이드바 영역 -->
	<div class="sidebar">
		<jsp:include page="/common/sidebar.jsp" />
	</div>

	<!-- 본문 컨텐츠 영역 -->
	<div class="content-area">

		<!-- 카테고리 탭 -->
		<div class="category-tabs">
			<a href="${pageContext.request.contextPath}/board/list"
			   class="category-tab${empty param.category ? ' active' : ''}">전체</a>
			<a href="${pageContext.request.contextPath}/board/list?category=한식"
			   class="category-tab${param.category eq '한식' ? ' active' : ''}">한식</a>
			<a href="${pageContext.request.contextPath}/board/list?category=양식"
			   class="category-tab${param.category eq '양식' ? ' active' : ''}">양식</a>
			<a href="${pageContext.request.contextPath}/board/list?category=중식"
			   class="category-tab${param.category eq '중식' ? ' active' : ''}">중식</a>
			<a href="${pageContext.request.contextPath}/board/list?category=일식"
			   class="category-tab${param.category eq '일식' ? ' active' : ''}">일식</a>
			<a href="${pageContext.request.contextPath}/board/list?category=디저트"
			   class="category-tab${param.category eq '디저트' ? ' active' : ''}">디저트</a>
		</div>

		<!-- 글쓰기 버튼 -->
		<c:choose>
			<c:when test="${empty sessionScope.loginUser}">
				<a href="${pageContext.request.contextPath}/member/login?redirect=/board/add"
				   class="write-btn"><i class="bi bi-pencil-square"></i> 글쓰기</a>
			</c:when>
			<c:otherwise>
				<a href="${pageContext.request.contextPath}/board/add"
				   class="write-btn"><i class="bi bi-pencil-square"></i> 글쓰기</a>
			</c:otherwise>
		</c:choose>

		<!-- 검색창 -->
		<form action="${pageContext.request.contextPath}/board/list" method="get" class="search-area">
			<input type="hidden" name="category" value="${param.category}" />
			<input type="text" class="search-input" id="searchKeyword" name="keyword"
				   value="${empty param.keyword ? '' : param.keyword}"
				   placeholder="제목으로 검색">
			<button type="submit" class="search-btn">
				<div class="sbtn"><i class="bi bi-search"></i></div>
			</button>
		</form>

		<!-- 인기게시글 -->
		<div class="popular-posts-section">
			<div class="popular-posts-title">
				<h3>🎉 인기 게시글</h3>
			</div>
			<div class="top-posts-row">
				<c:choose>
					<c:when test="${not empty bestPosts}">
						<c:forEach var="board" items="${bestPosts}">
							<div class="top-post-card">
								<a href="${pageContext.request.contextPath}/board/view?boardId=${board.boardId}">
									<img src="${empty board.thumbnail ? '/images/no-image.png' : board.thumbnail}"
										 class="top-thumb-img" alt="썸네일"/>
									<div class="top-title"><b>${board.title}</b></div>
									<div class="top-author">${board.nickname}</div>
								</a>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div style="color: #aaa; font-size: 1rem;">인기 게시글이 아직 없습니다.</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<!-- 최신글 테이블 -->
		<table class="post-table">
			<thead>
			<tr>
				<th style="width: 50%;">제목</th>
				<th style="width: 10%;">작성자</th>
				<th style="width: 20%;">작성일</th>
				<th style="width: 10%;">조회수</th>
				<th style="width: 10%;">좋아요</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="board" items="${boards}">
				<tr>
					<td class="bold-cell" style="text-align: left;">
						<a href="${pageContext.request.contextPath}/board/view?boardId=${board.boardId}"
						   class="bold-cell">${board.title}</a>
					</td>
					<td class="bold-cell">${board.nickname}</td>
					<td class="bold-cell">
						<c:out value="${board.insertTime}" />
					</td>
					<td class="bold-cell">${board.viewCount}</td>
					<td class="bold-cell">${board.likeCount}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>

		<!-- 페이지네이션 -->
		<div class="flex-center">
			<ul class="pagination" id="pagination"></ul>
		</div>
	</div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/twbs-pagination@1.4.2/jquery.twbsPagination.min.js"></script>

<script>
	// 검색창 엔터키 처리
	document.addEventListener("DOMContentLoaded", () => {
		const input = document.querySelector("#searchKeyword");
		input?.addEventListener("keydown", (e) => {
			if (e.key === "Enter") {
				e.preventDefault();
				input.form?.submit();
			}
		});
	});

	// 페이징 처리
	$('#pagination').twbsPagination({
		totalPages: ${pageInfo.totalPages},   // 총 페이지 수
		startPage: ${pageInfo.number + 1},    // 현재 페이지 (0부터 시작하므로 +1)
		visiblePages: 5,                      // 한 번에 보여줄 페이지 버튼 개수
		initiateStartPageClick: false,
		first: '&laquo;',
		prev: '&lt;',
		next: '&gt;',
		last: '&raquo;',
		onPageClick: function (event, page) {
			var params = new URLSearchParams(window.location.search);
			params.set('page', page - 1); // Spring Data JPA는 0부터 시작
			window.location.search = params.toString();
		}
	});
</script>

<jsp:include page="/common/footer.jsp"/>
</body>
</html>
