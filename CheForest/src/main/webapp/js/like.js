function initLikeButton({ likeType, boardId, recipeId, memberIdx }) {
  const $btn       = $("#likeBtn");
  const $countText = $("#likeCountText");

  // 🚀 countText 업데이트 헬퍼
  function renderCount(n) {
    const safe = (isNaN(n) || n < 0) ? 0 : n;

    if (likeType === "BOARD") {
      // 게시판: “좋아요 n개”
      $countText.html(`좋아요 <span>${safe}</span>개`);
    } else {
      // 레시피: 숫자만
      $countText.text(safe);
    }
  }

  // 1) 초기 좋아요 수 불러오기
  $.get("/like/count", { likeType, boardId, recipeId }, renderCount);

  // 2) 로그인된 경우 → 상태 확인
  if (memberIdx) {
    $.get("/like/check",
        { likeType, boardId, recipeId, memberIdx },
        function (res) {
          if (res === true || res === "true") {
            $btn.text("♥").addClass("liked");
          }
        }
    );
  }

  // 3) 클릭 이벤트
  $btn.on("click", function () {
    if (!memberIdx) {
      alert("로그인 후 이용해주세요 😊");
      const redirectUrl = encodeURIComponent(location.pathname + location.search);
      return (location.href = "/member/login?redirect=" + redirectUrl);
    }
    if (likeType === "RECIPE" && (!recipeId || !String(recipeId).trim())) {
      console.warn("🚫 recipeId 없음 → 좋아요 요청 막음");
      return;
    }

    const isLiked = $btn.hasClass("liked");
    const url     = isLiked ? "/like/remove" : "/like/add";

    $.ajax({
      url,
      type: "POST",
      contentType: "application/json",
      data: JSON.stringify({ likeType, boardId, recipeId, memberIdx }),
      success: function (res) {
        // 서버가 LikeRes 반환 → 최신 likeCount 바로 사용
        renderCount(res.likeCount);

        // 하트 토글
        $btn.text(isLiked ? "♡" : "♥").toggleClass("liked");
      },
      error: function (xhr) {
        console.error("좋아요 요청 실패:", xhr.responseText);
      }
    });
  });
}
