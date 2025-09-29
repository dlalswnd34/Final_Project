// CheForest 게시글 상세보기 JavaScript
document.addEventListener('DOMContentLoaded', function() {

    const commentSubmitBtn = document.getElementById('commentSubmitBtn');
    const commentTextarea = document.getElementById('commentTextarea');
    const commentsList = document.getElementById('commentsList');

    const boardId = window.boardId || null;
    const loginUser = window.loginUser || { memberIdx: 0, nickname: "익명" };

    // ================= 댓글 초기 로드 =================
    if (boardId) {
        loadComments(boardId);
    }

    function loadComments(boardId) {
        fetch(`/reviews/board/${boardId}`)
            .then(res => res.json())
            .then(data => {
                commentsList.innerHTML = '';
                if (data.length === 0) {
                    commentsList.innerHTML = '<div class="empty-box">아직 댓글이 없습니다.</div>';
                } else {
                    data.forEach(review => renderComment(review));
                }
            })
            .catch(err => console.error("댓글 불러오기 실패:", err));
    }

    // ================= 댓글 등록 =================
    if (commentSubmitBtn && commentTextarea) {
        commentTextarea.addEventListener('input', function() {
            commentSubmitBtn.disabled = this.value.trim().length === 0;
        });

        commentSubmitBtn.addEventListener('click', function() {
            const content = commentTextarea.value.trim();
            if (!content) return;

            fetch('/reviews', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    boardId: boardId,
                    writerIdx: loginUser.memberIdx,   // ✅ 작성자 ID
                    nickname: loginUser.nickname,     // ✅ 작성자 닉네임
                    content: content,
                    parentId: null
                })
            })
                .then(res => {
                    if (!res.ok) throw new Error("댓글 등록 실패");
                    return res.json();
                })
                .then(data => {
                    renderComment(data, true); // 새 댓글은 위에 prepend
                    commentTextarea.value = '';
                    commentSubmitBtn.disabled = true;
                })
                .catch(err => console.error(err));
        });
    }

    // ================= 댓글 DOM 추가 함수 =================
    function renderComment(review, isNew = false) {
        const div = document.createElement('div');
        div.classList.add('comment-item');
        div.setAttribute('data-review-id', review.reviewId);

        let actionBtns = '';
        if (loginUser.memberIdx === review.writerIdx) {
            actionBtns = `
              <div class="comment-actions">
                <button class="edit-btn submit-btn small" data-id="${review.reviewId}">수정</button>
                <button class="delete-btn submit-btn small" data-id="${review.reviewId}">삭제</button>
              </div>
            `;
        }

        div.innerHTML = `
          <div class="comment-header">
            <div class="comment-meta">
              <span class="comment-nickname">${review.nickname || '익명'}</span>
              <span class="comment-date">${formatDate(review.insertTime)}</span>
            </div>
          </div>
          <div class="comment-body">
            <p class="comment-content">${review.content}</p>
            <div class="comment-buttons">
              ${actionBtns}
              <button class="replyBtn submit-btn small" data-parent-id="${review.reviewId}">답글</button>
            </div>
          </div>
          <div class="replies"></div>
        `;

        if (isNew) {
            commentsList.prepend(div);
            // "아직 댓글이 없습니다" 안내 제거
            const emptyBox = commentsList.querySelector('.empty-box');
            if (emptyBox) emptyBox.remove();
        } else {
            commentsList.appendChild(div);
        }

        // 수정/삭제 이벤트
        const editBtn = div.querySelector('.edit-btn');
        if (editBtn) {
            editBtn.addEventListener('click', () => editComment(review.reviewId, div));
        }
        const deleteBtn = div.querySelector('.delete-btn');
        if (deleteBtn) {
            deleteBtn.addEventListener('click', () => deleteComment(review.reviewId, div));
        }

        // 답글 이벤트
        const replyBtn = div.querySelector('.replyBtn');
        if (replyBtn) {
            replyBtn.addEventListener('click', () => showReplyForm(review.reviewId, div));
        }

        // 대댓글도 재귀 렌더링
        if (review.replies && review.replies.length > 0) {
            const repliesContainer = div.querySelector('.replies');
            review.replies.forEach(reply => {
                const replyEl = renderComment(reply);
                repliesContainer.appendChild(replyEl);
            });
        }

        return div;
    }

    // ================= 댓글 수정 =================
    function editComment(reviewId, commentElement) {
        const contentEl = commentElement.querySelector('.comment-content');
        const oldContent = contentEl.textContent;
        const newContent = prompt("댓글을 수정하세요:", oldContent);
        if (!newContent || newContent.trim() === "" || newContent === oldContent) return;

        fetch(`/reviews/${reviewId}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                content: newContent,
                writerIdx: loginUser.memberIdx
            })
        })
            .then(res => {
                if (!res.ok) throw new Error("댓글 수정 실패");
                return res.json();
            })
            .then(data => {
                contentEl.textContent = data.content;
            })
            .catch(err => console.error(err));
    }

    // ================= 댓글 삭제 =================
    function deleteComment(reviewId, commentElement) {
        if (!confirm("정말 이 댓글을 삭제하시겠습니까?")) return;

        fetch(`/reviews/${reviewId}`, { method: 'DELETE' })
            .then(res => {
                if (!res.ok) throw new Error("댓글 삭제 실패");
                return res.text();
            })
            .then(() => {
                commentElement.remove();

                // 댓글 없으면 "아직 댓글이 없습니다" 표시
                if (!commentsList.querySelector('.comment-item')) {
                    commentsList.innerHTML = '<div class="empty-box">아직 댓글이 없습니다.</div>';
                }
            })
            .catch(err => console.error(err));
    }

    // ================= 답글 폼 표시 =================
    function showReplyForm(parentId, commentElement) {
        let replyForm = commentElement.querySelector('.reply-form');
        if (replyForm) {
            replyForm.remove(); // 이미 있으면 토글 제거
            return;
        }

        replyForm = document.createElement('div');
        replyForm.classList.add('reply-form');
        replyForm.innerHTML = `
          <textarea class="reply-textarea" placeholder="답글을 입력하세요"></textarea>
          <button class="reply-submit submit-btn small">등록</button>
        `;

        const repliesContainer = commentElement.querySelector('.replies');
        repliesContainer.prepend(replyForm);

        const replyTextarea = replyForm.querySelector('.reply-textarea');
        const replySubmit = replyForm.querySelector('.reply-submit');

        replySubmit.addEventListener('click', () => {
            const content = replyTextarea.value.trim();
            if (!content) return;

            fetch('/reviews', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    boardId: boardId,
                    writerIdx: loginUser.memberIdx,
                    nickname: loginUser.nickname,
                    content: content,
                    parentId: parentId
                })
            })
                .then(res => {
                    if (!res.ok) throw new Error("답글 등록 실패");
                    return res.json();
                })
                .then(data => {
                    const replyEl = renderComment(data, false);
                    repliesContainer.appendChild(replyEl);
                    replyForm.remove();
                })
                .catch(err => console.error(err));
        });
    }

    // ================= 공통 유틸 =================
    function formatDate(dateString) {
        if (!dateString) return '';
        const date = new Date(dateString);
        return date.toLocaleString('ko-KR');
    }
});
