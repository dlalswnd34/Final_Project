// CheForest 게시글 상세보기 JS
document.addEventListener("DOMContentLoaded", function () {
    const commentTextarea = document.getElementById("commentTextarea");
    const commentForm = document.getElementById("commentForm");
    const commentsList = document.getElementById("commentsList");

    const boardId = window.boardId || document.querySelector("input[name='boardId']")?.value;
    const loginUser = window.loginUser || null;

    if (boardId) loadComments(boardId);

    // -------- utils --------
    function formatDate(dateString) {
        if (!dateString) return "";
        return new Date(dateString).toLocaleString("ko-KR");
    }
    function autoResize(t) {
        t.style.height = "auto";
        t.style.height = t.scrollHeight + "px";
    }
    function prepareTextarea(t) {
        t.removeAttribute("style");
        t.removeAttribute("cols");
        t.removeAttribute("rows");
        autoResize(t);
        t.addEventListener("input", () => autoResize(t));
        t.focus();
    }

    // -------- fetch comments --------
    function loadComments(boardId) {
        fetch(`/reviews/board/${boardId}`)
            .then(res => res.json())
            .then(data => {
                commentsList.innerHTML = "";
                if (!data.length) {
                    commentsList.innerHTML = '<div class="empty-box">아직 댓글이 없습니다.</div>';
                } else {
                    data.forEach(review => commentsList.appendChild(renderComment(review)));
                }
                lucide.createIcons();
            })
            .catch(err => console.error("댓글 불러오기 실패:", err));
    }

    // -------- write comment --------
    if (commentForm) {
        commentForm.addEventListener("submit", function (e) {
            e.preventDefault();
            const content = commentTextarea.value.trim();
            if (!content) return;

            fetch("/reviews", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    boardId,
                    writerIdx: loginUser.memberIdx,
                    nickname: loginUser.nickname,
                    authorGrade: loginUser.grade,
                    content,
                    parentId: null,
                }),
            })
                .then(res => res.json())
                .then(data => {
                    commentsList.prepend(renderComment(data));
                    commentTextarea.value = "";
                    lucide.createIcons();
                })
                .catch(err => console.error("댓글 등록 실패:", err));
        });
    }

    // -------- comment DOM --------
    function renderComment(review) {
        const div = document.createElement("div");
        div.classList.add("comment-item");
        div.setAttribute("data-review-id", review.reviewId);

        div.innerHTML = `
      <div class="comment-header">
        <div class="commenter-info" style="display:flex; gap:1rem; align-items:flex-start;">
          <div class="commenter-avatar">
            <img src="${review.authorImage || "/images/default_profile.png"}" class="avatar-img">
          </div>
          <div class="commenter-details">
            <div class="commenter-name-line">
              <span class="commenter-name">${review.nickname}</span>
              <span class="user-grade grade-${review.authorGrade}">${review.authorGrade}</span>
            </div>
            <div class="comment-time">${formatDate(review.insertTime)}</div>
            <div class="comment-body">${review.content}</div>
          </div>
        </div>
      </div>
      <div class="comment-actions">
        <button class="vote-btn like-vote ${review.isLiked ? "liked" : ""}" data-id="${review.reviewId}">
          <i data-lucide="thumbs-up"></i><span class="vote-count">${review.likes || 0}</span>
        </button>
        <button class="reply-btn" data-parent-id="${review.reviewId}">
          <i data-lucide="corner-up-left"></i> 답글
        </button>
        ${String(review.writerIdx) === String(loginUser?.memberIdx) ? `
          <button class="edit-btn" data-id="${review.reviewId}">수정</button>
          <button class="delete-btn" data-id="${review.reviewId}">삭제</button>
        ` : ""}
      </div>
      <div class="replies"></div>
    `;

        div.querySelector(".like-vote").addEventListener("click", () =>
            toggleLike(review.reviewId, div.querySelector(".like-vote"))
        );
        div.querySelector(".reply-btn").addEventListener("click", () =>
            showReplyForm(review.reviewId, div)
        );
        const editBtn = div.querySelector(".edit-btn");
        if (editBtn) editBtn.addEventListener("click", () => showEditForm(review, div));

        const deleteBtn = div.querySelector(".delete-btn");
        if (deleteBtn) deleteBtn.addEventListener("click", () => deleteReview(review.reviewId, div));

        const repliesContainer = div.querySelector(".replies");
        if (review.replies?.length) review.replies.forEach(r => repliesContainer.appendChild(renderReply(r)));

        return div;
    }

    // -------- reply DOM --------
    function renderReply(reply) {
        const div = document.createElement("div");
        div.classList.add("reply-item");
        div.innerHTML = `
      <div class="reply-border">
        <div class="reply-avatar">
          <img src="${reply.authorImage || "/images/default_profile.png"}" class="avatar-img">
        </div>
        <div class="reply-details">
          <div class="reply-author-line">
            <div>
              <span class="reply-author">${reply.nickname}</span>
              <span class="user-grade grade-${reply.authorGrade}">${reply.authorGrade}</span>
            </div>
            <div class="reply-time">${formatDate(reply.insertTime)}</div>
          </div>
          <p class="reply-text">${reply.content}</p>
          <div class="reply-actions">
            <button class="vote-btn like-vote small ${reply.isLiked ? "liked" : ""}" data-id="${reply.reviewId}">
              <i data-lucide="thumbs-up"></i>
              ${reply.likes > 0 ? `<span class="vote-count">${reply.likes}</span>` : ""}
            </button>
            ${String(reply.writerIdx) === String(loginUser?.memberIdx) ? `
              <button class="edit-btn small" data-id="${reply.reviewId}">수정</button>
              <button class="delete-btn small" data-id="${reply.reviewId}">삭제</button>
            ` : ""}
          </div>
        </div>
      </div>
    `;

        div.querySelector(".like-vote").addEventListener("click", () =>
            toggleLike(reply.reviewId, div.querySelector(".like-vote"))
        );
        const editBtn = div.querySelector(".edit-btn");
        if (editBtn) editBtn.addEventListener("click", () => showEditForm(reply, div));
        const deleteBtn = div.querySelector(".delete-btn");
        if (deleteBtn) deleteBtn.addEventListener("click", () => deleteReview(reply.reviewId, div));

        return div;
    }

    // -------- edit --------
    function showEditForm(review, element) {
        const body = element.querySelector(".comment-body, .reply-text");
        if (!body) return;

        const originalContent = review.content;

        // 회색 박스 없이, 내부만 교체
        body.classList.add("comment-edit"); // 레이아웃 힌트(테두리/배경은 CSS에서 제거)
        body.innerHTML = `
      <textarea class="edit-textarea">${originalContent}</textarea>
      <div class="edit-actions">
        <button class="cancel-btn">취소</button>
        <button class="save-btn">저장</button>
      </div>
    `;

        const textarea = body.querySelector(".edit-textarea");
        prepareTextarea(textarea);

        body.querySelector(".cancel-btn").addEventListener("click", () => {
            body.innerHTML = originalContent;
            body.classList.remove("comment-edit");
        });

        body.querySelector(".save-btn").addEventListener("click", () => {
            const newContent = textarea.value.trim();
            if (!newContent) return;

            fetch(`/reviews/${review.reviewId}`, {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ ...review, content: newContent }),
            })
                .then(res => res.json())
                .then(updated => {
                    body.innerHTML = updated.content;
                    body.classList.remove("comment-edit");
                    lucide.createIcons();
                })
                .catch(err => console.error("댓글 수정 실패:", err));
        });
    }

    // -------- delete --------
    function deleteReview(reviewId, element) {
        if (!confirm("정말 삭제하시겠습니까?")) return;
        fetch(`/reviews/${reviewId}`, { method: "DELETE" })
            .then(res => { if (res.ok) element.remove(); })
            .catch(err => console.error("댓글 삭제 실패:", err));
    }

    // -------- like --------
    function toggleLike(reviewId, btn) {
        fetch(`/reviews/${reviewId}/vote`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ like: true }),
        })
            .then(res => res.json())
            .then(data => {
                btn.classList.toggle("liked", data.isLiked);
                btn.querySelector(".vote-count").textContent = data.likes;
            })
            .catch(err => console.error("좋아요 실패:", err));
    }

    // -------- reply write --------
    function showReplyForm(parentId, commentElement) {
        const repliesContainer = commentElement.querySelector(".replies");
        let replyForm = commentElement.querySelector(".reply-write");
        if (replyForm) { replyForm.remove(); return; }

        replyForm = document.createElement("div");
        replyForm.classList.add("reply-write"); // (CSS에서 테두리/배경 제거)
        replyForm.innerHTML = `
      <form>
        <textarea class="reply-textarea" placeholder="답글을 입력하세요"></textarea>
        <div class="reply-actions">
          <button type="button" class="cancel-btn">취소</button>
          <button type="submit" class="reply-submit-btn"><i data-lucide="send"></i> 답글 등록</button>
        </div>
      </form>
    `;
        repliesContainer.prepend(replyForm);
        lucide.createIcons();

        const rta = replyForm.querySelector(".reply-textarea");
        prepareTextarea(rta);

        replyForm.querySelector(".cancel-btn").addEventListener("click", () => replyForm.remove());
        replyForm.querySelector("form").addEventListener("submit", e => {
            e.preventDefault();
            const content = rta.value.trim();
            if (!content) return;

            fetch("/reviews", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    boardId,
                    writerIdx: loginUser.memberIdx,
                    nickname: loginUser.nickname,
                    authorGrade: loginUser.grade,
                    content,
                    parentId,
                }),
            })
                .then(res => res.json())
                .then(data => {
                    repliesContainer.appendChild(renderReply(data));
                    replyForm.remove();
                    lucide.createIcons();
                })
                .catch(err => console.error("답글 등록 실패:", err));
        });
    }
});
