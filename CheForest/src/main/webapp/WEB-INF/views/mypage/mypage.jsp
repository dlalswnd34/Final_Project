<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/style.css" />
    <link rel="stylesheet" href="/css/sidebar.css" />
    <link rel="stylesheet" href="/css/mypage.css" />
    <link rel="stylesheet" href="/css/pagination.css">
    <jsp:include page="/common/header.jsp" />
</head>
<body>
<div class="main-flex">
    <div class="sidebar">
        <jsp:include page="/common/sidebar.jsp" />
    </div>

    <div class="content-area">
        <div class="tab-menu">
            <div id="tab-myPosts" class="active" onclick="showSection('myPostsSection', this)">
                <i class="bi bi-pencil-square"></i>
                <span>내가 작성한 글 <span class="post-count">(${myPostsTotalCount}개)</span></span>
            </div>
            <div id="tab-likedPosts" onclick="showSection('likedPostsSection', this)">
                <i class="bi bi-heart-fill"></i>
                <span>좋아요 남긴 글
                    <span class="like-count">(<span id="likedCountNum">${likedRecipesTotalCount + likedPostsTotalCount}</span>개)</span>
                </span>
            </div>
        </div>

        <div id="myPostsSection" style="display: block;">
            <form id="myPostsSearchForm" method="get" action="${pageContext.request.contextPath}/mypage/mypage" class="search-area" style="margin-bottom:0;">
                <input type="hidden" name="tab" value="myboard"/>
                <input type="hidden" name="myPostsPage" value="1"/>
                <input type="text" name="searchKeyword" id="searchMyPosts" class="form-control form-control-sm search-input"
                       value="${param.searchKeyword}" placeholder="내가 작성한 글 검색" />
                <button type="submit" class="search-btn">
                    <i class="bi bi-search"></i>
                </button>
            </form>
            <table id="myPostsTable" class="table table-hover post-table">
                <thead>
                <tr>
                    <th class="text-center" style="width: 55%;">제목</th>
                    <th class="text-center" style="width: 25%;">작성일</th>
                    <th class="text-center" style="width: 10%;">조회수</th>
                    <th class="text-center" style="width: 10%;">좋아요</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="post" items="${myPosts}">
                    <tr>
                        <td class="text-start"><a href="${pageContext.request.contextPath}/board/view?boardId=${post.boardId}" class="post-title-link">${post.title}</a></td>
                            <%-- [수정] 날짜 형식을 'YYYY-MM-DD'로 변경하고 'T'를 제거합니다. --%>
                        <td class="text-center">${post.insertTime.toLocalDate()}</td>
                        <td class="text-center">${post.viewCount}</td>
                        <td class="text-center">${post.likeCount}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty myPosts}">
                    <tr>
                        <td colspan="4" class="text-secondary text-center">아직 작성한 게시글이 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
            <div class="flex-center" id="paginationMyPostsWrap" style="display: flex;">
                <ul class="pagination" id="paginationMyPosts"></ul>
            </div>
        </div>

        <div id="likedPostsSection" style="display: none;">
            <form id="likedPostsSearchForm" method="get" action="${pageContext.request.contextPath}/mypage/mypage" class="search-area" style="margin-bottom:0;">
                <input type="hidden" name="tab" value="mylike"/>
                <input type="hidden" name="likedPostsPage" value="1"/>
                <input type="text" name="searchKeyword" id="searchLikedPosts" class="form-control form-control-sm search-input"
                       value="${param.searchKeyword}" placeholder="좋아요 남긴 글 검색" />
                <button type="submit" class="search-btn">
                    <i class="bi bi-search"></i>
                </button>
            </form>
            <div class="like-subtabs mb-3">
                <div id="subtab-likedRecipe" class="like-subtab active" onclick="showLikeTab('likedRecipeTable', this)">
                    <i class="bi bi-bookmark-heart"></i> 레시피
                </div>
                <div id="subtab-likedBoard" class="like-subtab" onclick="showLikeTab('likedBoardTable', this)">
                    <i class="bi bi-file-earmark-text"></i> 게시글
                </div>
            </div>
            <table id="likedRecipeTable" class="table table-hover post-table" style="display: table;">
                <thead>
                <tr>
                    <th class="text-center" style="width: 55%;">레시피명</th>
                    <th class="text-center" style="width: 25%;">카테고리</th>
                    <th class="text-center" style="width: 10%;">좋아요</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="recipe" items="${likedRecipes}">
                    <tr>
                            <%-- [수정] DTO의 실제 필드명(titleKr, categoryKr, likeCount)과 일치시킵니다. --%>
                        <td class="text-start"><a href="${pageContext.request.contextPath}/recipe/view?recipeId=${recipe.recipeId}" class="post-title-link">${recipe.titleKr}</a></td>
                        <td class="text-center">${recipe.categoryKr}</td>
                        <td class="text-center">${recipe.likeCount}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty likedRecipes}">
                    <tr>
                        <td colspan="3" class="text-secondary text-center">좋아요를 남긴 레시피가 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>

            <table id="likedBoardTable" class="table table-hover post-table" style="display: none;">
                <thead>
                <tr>
                    <th class="text-center" style="width: 35%;">제목</th>
                    <th class="text-center" style="width: 15%;">작성자</th>
                    <th class="text-center" style="width: 20%;">작성일</th>
                    <th class="text-center" style="width: 10%;">조회수</th>
                    <th class="text-center" style="width: 10%;">좋아요</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="like" items="${likedPosts}">
                    <tr>
                        <td class="text-start"><a href="${pageContext.request.contextPath}/board/view?boardId=${like.boardId}" class="post-title-link">${like.title}</a></td>
                        <td class="text-center">${like.writerName}</td>
                            <%-- [수정] 날짜 형식을 통일하고 LocalDateTime 에러를 방지합니다. --%>
                        <td class="text-center">${like.writeDate.toLocalDate()}</td>
                        <td class="text-center">${like.viewCount}</td>
                        <td class="text-center">${like.likeCount}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty likedPosts}">
                    <tr>
                        <td colspan="5" class="text-secondary text-center">좋아요를 남긴 게시글이 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
            <div class="flex-center" id="paginationLikedPostsWrap" style="display: none;">
                <ul class="pagination" id="paginationLikedPosts"></ul>
            </div>
        </div>
    </div>
</div>

<c:if test="${updateSuccess}">
    <script>
        alert("회원 정보가 성공적으로 수정되었습니다.");
    </script>
</c:if>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>
<script>
    // [참고] 이 스크립트 부분은 '좋아요' 탭의 페이지네이션 문제를 해결하기 위해 추가적인 수정이 필요합니다.
    // 현재 코드는 화면 표시 에러만 해결된 상태입니다.
    function initPagination(selector, totalPages, startPage, visiblePages, tabName, pageParamName) {
        if ($(selector).data('twbs-pagination')) {
            $(selector).twbsPagination('destroy');
        }
        $(selector).twbsPagination({
            totalPages: Number(totalPages) || 1,
            startPage: Number(startPage) || 1,
            visiblePages: Number(visiblePages) || 5,
            initiateStartPageClick: false,
            first: '&laquo;',
            prev: '&lt;',
            next: '&gt;',
            last: '&raquo;',
            onPageClick: function(event, page) {
                var params = new URLSearchParams(window.location.search);
                params.set('tab', tabName);
                params.set(pageParamName, page);

                var searchInputId = (tabName === 'myboard') ? 'searchMyPosts' : 'searchLikedPosts';
                var searchValue = document.getElementById(searchInputId) ? document.getElementById(searchInputId).value : '';
                params.set('searchKeyword', searchValue);

                window.location.search = params.toString();
            }
        });
    }

    $(function() {
        initPagination(
            '#paginationMyPosts',
            parseInt('${myPostsPaginationInfo.totalPages}'),
            parseInt('${myPostsPaginationInfo.number + 1}'),
            parseInt('${myPostsPaginationInfo.size}'),
            'myboard',
            'myPostsPage'
        );
        initPagination(
            '#paginationLikedPosts',
            parseInt('${likedPostsPaginationInfo.totalPages}'),
            parseInt('${likedPostsPaginationInfo.number + 1}'),
            parseInt('${likedPostsPaginationInfo.size}'),
            'mylike',
            'likedPostsPage'
        );
    });
</script>
<jsp:include page="/common/footer.jsp"></jsp:include>
</body>
</html>