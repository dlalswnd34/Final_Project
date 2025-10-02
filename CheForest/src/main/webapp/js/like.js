// ✅ CSRF 토큰 전역 세팅
const csrfToken  = document.querySelector("meta[name='_csrf']").getAttribute("content");
const csrfHeader = document.querySelector("meta[name='_csrf_header']").getAttribute("content");

function initLikeButton({ likeType, boardId, recipeId, memberIdx }) {
    const $btn       = $("#likeBtn");
    const $countText = $("#likeCountText");

    // 숫자 출력 헬퍼
    function renderCount(raw) {
        const n = parseInt(raw, 10);
        const safe = (isNaN(n) || n < 0) ? 0 : n;
        $countText.text(safe);
    }

    // 초기 좋아요 수 불러오기
    $.get("/like/count", { likeType, boardId, recipeId }, renderCount);

    // 로그인 상태라면 초기 좋아요 여부 확인
    if (memberIdx) {
        $.get("/like/check",
            { likeType, boardId, recipeId, memberIdx },
            function (res) {
                if (res === true || res === "true") {
                    $btn.addClass("liked"); // 빨간 하트 표시
                }
            }
        );
    }

    // 버튼 클릭 이벤트
    $btn.on("click", function () {
        if (!memberIdx) {
            alert("로그인 후 이용해주세요 😊");
            const redirectUrl = encodeURIComponent(location.pathname + location.search);
            return (location.href = "/auth/login?redirect=" + redirectUrl);
        }

        const isLiked = $btn.hasClass("liked");
        const url     = isLiked ? "/like/remove" : "/like/add";

        // ✅ 중복 클릭 방지
        $btn.prop("disabled", true);

        $.ajax({
            url,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ likeType, boardId, recipeId, memberIdx }),
            // ✅ CSRF 토큰 헤더 추가
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function (res) {
                // 하트 토글
                if (isLiked) {
                    $btn.removeClass("liked");
                } else {
                    $btn.addClass("liked");
                }

                // ✅ 서버에서 최신 count 반영
                if (res && res.likeCount !== undefined) {
                    renderCount(res.likeCount);
                }

                // ✅ 혹시 서버 응답이 비어있어도 강제로 최신화
                $.get("/like/count", { likeType, boardId, recipeId }, renderCount);
            },
            error: function (xhr) {
                console.error("좋아요 요청 실패:", xhr.responseText);
                // 에러 나도 최신 숫자 강제 동기화
                $.get("/like/count", { likeType, boardId, recipeId }, renderCount);
            },
            complete: function () {
                // ✅ 완료 후 버튼 다시 활성화
                $btn.prop("disabled", false);
            }
        });
    });
}
