<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>레시피 리스트</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/recipelist.css">
    <link rel="stylesheet" href="/css/sidebar.css" />
    <link rel="stylesheet" href="/css/pagination.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="main-flex">
    <div class="sidebar">
        <jsp:include page="/common/sidebar.jsp" />
    </div>

    <div class="content-area">
        <!-- 카테고리 탭 -->
        <div class="category-tabs">
            <a href="${pageContext.request.contextPath}/recipe/list"
               class="category-tab${empty categoryKr ? ' active' : ''}">전체</a>
            <a href="${pageContext.request.contextPath}/recipe/list?categoryKr=한식"
               class="category-tab${categoryKr eq '한식' ? ' active' : ''}">한식</a>
            <a href="${pageContext.request.contextPath}/recipe/list?categoryKr=양식"
               class="category-tab${categoryKr eq '양식' ? ' active' : ''}">양식</a>
            <a href="${pageContext.request.contextPath}/recipe/list?categoryKr=중식"
               class="category-tab${categoryKr eq '중식' ? ' active' : ''}">중식</a>
            <a href="${pageContext.request.contextPath}/recipe/list?categoryKr=일식"
               class="category-tab${categoryKr eq '일식' ? ' active' : ''}">일식</a>
            <a href="${pageContext.request.contextPath}/recipe/list?categoryKr=디저트"
               class="category-tab${categoryKr eq '디저트' ? ' active' : ''}">디저트</a>
        </div>

        <!-- 검색창 -->
        <form action="${pageContext.request.contextPath}/recipe/list" method="get" class="search-area">
            <input type="hidden" name="categoryKr" value="${categoryKr}" />
            <input type="text" class="search-input" id="searchKeyword"
                   name="searchKeyword"
                   value="<c:out value='${searchKeyword}'/>"
                   placeholder="레시피명으로 검색">
            <button type="submit" class="search-btn">
                <i class="bi bi-search"></i>
            </button>
        </form>

        <!-- 레시피 리스트 -->
        <div class="recipe-list-section">
            <div class="recipe-grid">
                <c:forEach var="recipe" items="${recipeList}">
                    <div class="recipe-card">
                        <a href="${pageContext.request.contextPath}/recipe/view?recipeId=${recipe.recipeId}">
                            <img src="<c:out value='${recipe.thumbnail}'/>"
                                 loading="lazy"
                                 alt="썸네일" class="recipe-thumb-img" />
                            <div class="recipe-title">
                                <b><c:out value="${recipe.titleKr}"/></b>
                            </div>
                        </a>
                    </div>
                </c:forEach>
                <c:if test="${empty recipeList}">
                    <div class="no-recipe-msg">레시피가 없습니다.</div>
                </c:if>
            </div>
        </div>

        <!-- 페이지네이션 -->
        <div class="flex-center">
            <ul class="pagination" id="pagination"></ul>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/twbs-pagination@1.4.2/jquery.twbsPagination.min.js"></script>

<script>
    $('#pagination').twbsPagination({
        totalPages: ${totalPages},                // ✅ 컨트롤러에서 내려준 값 사용
        startPage: ${currentPage + 1},            // JPA Page는 0-based → +1
        visiblePages: 10,
        initiateStartPageClick: false,
        first: '&laquo;',
        prev: '&lt;',
        next: '&gt;',
        last: '&raquo;',
        onPageClick: function (event, page) {
            var params = new URLSearchParams(window.location.search);
            params.set('page', page - 1);         // JPA는 0-based
            window.location.search = params.toString();
        }
    });
</script>

<jsp:include page="/common/footer.jsp"/>
</body>
</html>
