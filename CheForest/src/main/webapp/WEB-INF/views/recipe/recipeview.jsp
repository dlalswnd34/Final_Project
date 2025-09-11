<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>레시피 페이지_CheForest</title>
  <link rel="stylesheet" href="/css/style.css" />
  <link rel="stylesheet" href="/css/sidebar.css" />
  <link rel="stylesheet" href="/css/recipeview.css" />
  <link rel="stylesheet" href="/css/like-override.css" />  <!-- 최종 적용 -->

  <jsp:include page="/common/header.jsp" />
</head>
<body>
<div class="main-wrap">
  <!-- 사이드바 -->
  <div class="sidebar-wrap">
    <jsp:include page="/common/sidebar.jsp" />
  </div>

  <!-- 본문 -->
  <div class="content-wrap">
    <!-- 상단: 이미지 + 제목 + 카테고리 -->
    <div class="recipe-card-top">
      <div class="recipe-top-row">
        <div class="recipe-img-outer">
          <img src="<c:out value='${recipe.thumbnail}'/>" alt="요리 이미지" width="400px" class="recipe-img" />
        </div>
        <div class="recipe-title-outer">
          <div class="recipe-cat-badge"><c:out value="${recipe.categoryKr}"/></div>
          <div class="recipe-title-main"><c:out value="${recipe.titleKr}"/></div>
        </div>
      </div>

      <!-- 좋아요 버튼 -->
      <div class="like-btn-wrap">
        <button type="button"
                class="like-btn"
                id="likeBtn"
                data-recipe-id="${recipe.recipeId}"
                data-member-idx="${loginUser.memberIdx}">
          ♡
        </button>
        <span class="like-count-text" id="likeCountText">0</span>
      </div>
    </div>

    <!-- 재료 -->
    <div class="recipe-card">
      <div class="section-title" style="display:flex; align-items:center; justify-content:space-between;">
        <span>재료</span>
        <button id="toggle-ingredients" class="category-tab" type="button">숨기기</button>
      </div>
      <div id="ingredients-box">
        <div class="ingredient-table-2col-wrap">
          <ul style="list-style:none; padding-left:0;">
            <c:forEach var="item" items="${recipe.ingredientDisplayList}">
              <li><c:out value="${item}"/></li>
            </c:forEach>
          </ul>
        </div>
      </div>
    </div>

    <!-- 조리법 -->
    <div class="recipe-card">
      <div class="section-title">조리법</div>
      <div class="recipe-content">
        ${recipe.instructionKr} <!-- HTML 태그 허용 -->
      </div>
    </div>
  </div>
</div>

<!-- 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/like.js"></script>
<script>
  const toggleBtn = document.getElementById('toggle-ingredients');
  const box = document.getElementById('ingredients-box');

  toggleBtn.onclick = function() {
    const isHidden = box.style.display === 'none';
    box.style.display = isHidden ? 'block' : 'none';
    toggleBtn.innerText = isHidden ? '숨기기' : '보이기';
  };

  $(document).ready(function () {
    const recipeId  = $("#likeBtn").data("recipe-id");
    const memberIdx = $("#likeBtn").data("member-idx");

    console.log("🔥 recipeId:", recipeId);

    initLikeButton({
      likeType: "RECIPE",
      recipeId: String(recipeId),
      memberIdx
    });
  });
</script>

<jsp:include page="/common/footer.jsp"/>
</body>
</html>
