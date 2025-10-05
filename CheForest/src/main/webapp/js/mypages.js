/**
 * 마이페이지 전용 JavaScript (탭 전환, 문의 내역 동적 로딩 등)
 */

// =================================================================================
// [0] 필수: alert/confirm 대체 Custom UI 함수 (인프라 제약 조건 충족)
// =================================================================================

// 임시 메시지 박스 컨테이너를 생성하거나 가져옵니다.
function createMessageBox() {
    let box = document.getElementById('mypage-message-box');
    if (!box) {
        box = document.createElement('div');
        box.id = 'mypage-message-box';
        // 최소한의 스타일로 페이지 우측 상단에 고정합니다.
        box.style.cssText = 'position: fixed; top: 20px; right: 20px; background: #fff; border: 1px solid #ccc; padding: 15px; z-index: 1000; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); max-width: 300px; transition: opacity 0.3s ease; opacity: 0; pointer-events: none;';
        document.body.appendChild(box);
    }
    return box;
}

/** alert()를 대체하여 사용자에게 메시지를 보여주는 함수 */
function showMessageBox(message, type = 'info') {
    const box = createMessageBox();
    let bgColor = '#e0f7fa'; // info (light blue)
    if (type === 'error') bgColor = '#ffebee'; // error (light red)
    if (type === 'success') bgColor = '#e8f5e9'; // success (light green)

    box.style.backgroundColor = bgColor;
    box.innerHTML = `<p style="margin: 0; color: #333; font-weight: 500;">${message}</p>`;
    box.style.opacity = 1;
    box.style.pointerEvents = 'auto';
    box.style.display = 'block';

    setTimeout(() => {
        box.style.opacity = 0;
        box.style.pointerEvents = 'none';
    }, 4000);
}

/** confirm()을 대체하는 함수 (실제로는 커스텀 모달로 구현해야 함) */
function showConfirmBox(message, onConfirm) {
    // 커스텀 모달 구현 전까지는 임시로 window.confirm을 사용하고, 사용자에게 변경이 필요함을 알립니다.
    const isConfirmed = window.confirm(message);
    if (isConfirmed) {
        onConfirm();
    }
}


// =================================================================================
// [1] 문의 내역 연동 관련 전역 변수 및 함수 (HTML onclick에서 직접 호출되므로 외부에 위치)
// =================================================================================

let currentInquiryPage = 0; // 현재 페이지 번호 (0부터 시작)
const inquiryPageSize = 5; // 한 페이지당 문의 개수 (백엔드와 일치하도록 설정)

/**
 * 문의 내역 API를 호출하고 결과를 렌더링합니다.
 * 이 함수는 탭 전환 시 또는 페이징 버튼 클릭 시 호출됩니다.
 * @param {number} page - 요청할 페이지 번호 (0부터 시작)
 */
function fetchMyInquiries(page) {
    currentInquiryPage = page;
    const container = document.getElementById('inquiries-list-container');
    const countElement = document.getElementById('inquiry-count');
    const paginationContainer = document.getElementById('inquiries-pagination');

    // ✅ 추가: 선택된 상태/정렬 값 읽기
    const statusSelect = document.getElementById('inquiry-status');
    const sortSelect = document.getElementById('inquiry-sort');
    const status = statusSelect ? statusSelect.value : 'all';
    const sortDir = sortSelect ? sortSelect.value : 'desc';

    // 로딩 상태 표시
    container.innerHTML = '<p class="loading-message">문의 내역을 불러오는 중...</p>';
    countElement.textContent = '...';
    paginationContainer.innerHTML = '';

    // API URL: /api/mypage/inquiries?page=0&size=5
    const apiUrl = `/api/mypage/inquiries?page=${page}&size=${inquiryPageSize}&status=${encodeURIComponent(status)}&sort=createdAt,${sortDir}`;

    fetch(apiUrl)
        .then(response => {
            if (!response.ok) throw new Error('문의 내역 API 호출 실패: ' + response.statusText);
            return response.json();
        })
        .then(data => {
            renderInquiryList(data.data, container);
            countElement.textContent = data.total.toLocaleString();
            renderInquiryPagination(data.totalPages, data.page);
            const url = `${window.location.pathname}?tab=inquiries&page=${data.page}`;
            window.history.replaceState(null, '', url);
        })
        .catch(error => {
            console.error('문의 내역을 불러오는 중 오류 발생:', error);
            container.innerHTML = '<p class="error-message">문의 내역을 불러올 수 없습니다.</p>';
            countElement.textContent = '0';
        });
}

/**
 * 문의 내역 데이터를 HTML 카드로 변환하여 컨테이너에 삽입합니다.
 */
function renderInquiryList(inquiries, container) {
    if (inquiries.length === 0) {
        container.innerHTML = '<p class="no-data-message">작성된 문의 내역이 없습니다.</p>';
        return;
    }

    let html = '';
    inquiries.forEach(inquiry => {
        const isCompleted = inquiry.answerStatus === '답변완료';
        const statusClass = isCompleted ? 'completed' : 'in-progress';
        const statusText = isCompleted ? '답변완료' : '답변대기';

        // 문의 생성일 날짜 포맷팅 (YYYY-MM-DD 형식으로 변환)
        const formattedDate = new Date(inquiry.createdAt).toLocaleDateString('ko-KR', {
            year: 'numeric', month: '2-digit', day: '2-digit'
        }).replace(/\. /g, '-').replace(/\./g, '');

        // 답변 완료일 포맷팅 (answerAt 필드를 사용하도록 수정)
        // DTO 필드명: answerAt
        let answeredAtDate = 'N/A';
        if (inquiry.answerAt) {
            const dateObj = new Date(inquiry.answerAt);
            if (!isNaN(dateObj.getTime())) { // 유효한 Date 객체인지 확인
                answeredAtDate = dateObj.toLocaleDateString('ko-KR', {
                    year: 'numeric', month: '2-digit', day: '2-digit'
                }).replace(/\. /g, '-').replace(/\./g, '');
            }
        }


        // 버튼 영역: 상태에 따라 다르게 표시
        let actionsHtml = '';
        if (isCompleted) {
            // 답변 완료 시: 답변 보기 토글 버튼
            actionsHtml = `<button class="btn btn-outline btn-toggle-answer" onclick="toggleInquiryAnswer(this)">답변 보기</button>`;
        } else {
            // 답변 대기 시: 수정하기, 삭제하기 버튼 표시 (삭제 기능 활성화)
            actionsHtml = `
                <button class="btn btn-outline" onclick="editInquiry(${inquiry.inquiryId})">수정하기</button>
                <button class="btn btn-outline delete" onclick="confirmDeleteInquiry(${inquiry.inquiryId})">삭제하기</button>
            `;
        }

        html += `
            <div class="inquiry-card" id="inquiry-${inquiry.inquiryId}">
              <div class="inquiry-header">
                <div class="inquiry-title">${inquiry.title}</div>
                <span class="status-badge ${statusClass}">${statusText}</span>
              </div>
              <div class="inquiry-meta">
                <span class="inquiry-date">${formattedDate}</span>
              </div>
              <div class="inquiry-content">
                ${inquiry.questionContent.substring(0, 100)}${inquiry.questionContent.length > 100 ? '...' : ''}
              </div>
              
              <!-- 문의 답변 영역 추가 (기본 hidden) -->
              ${isCompleted ? `
                <div class="inquiry-answer-container hidden" style="display: none; margin-top: 15px; padding: 15px; border-top: 1px dashed #ccc; background-color: #f5f8ff; border-radius: 4px;">
                    <div style="font-weight: bold; margin-bottom: 8px; color: #1565c0; display: flex; justify-content: space-between;">
                        <span>[문의 답변]</span>
                        <!-- 답변일 표시 (answerAt 필드 사용) -->
                        <span style="font-weight: normal; font-size: 0.85em; color: #777;">작성일: ${answeredAtDate}</span>
                    </div>
                    <div class="answer-content" style="white-space: pre-wrap; color: #333; line-height: 1.6;">
                        ${inquiry.answerContent || '답변 내용이 없습니다.'}
                    </div>
                </div>
              ` : ''}

              <div class="inquiry-actions">
                ${actionsHtml}
              </div>
            </div>
        `;
    });
    container.innerHTML = html;
}

/**
 * 문의 내역의 페이징 UI를 렌더링합니다.
 */
function renderInquiryPagination(totalPages, currentPage1Based) {
    const paginationContainer = document.getElementById('inquiries-pagination');
    if (totalPages <= 1) {
        paginationContainer.innerHTML = ''; // 페이지가 1개 이하일 경우 버튼 숨김
        return;
    }

    let html = '';
    const currentPage0Based = currentPage1Based - 1; // 0부터 시작하는 페이지 번호

    // 이전 페이지 버튼
    const isPrevDisabled = currentPage0Based === 0;
    html += `<button class="page-btn nav-btn" onclick="if(!${isPrevDisabled}) fetchMyInquiries(${currentPage0Based - 1})" ${isPrevDisabled ? 'disabled' : ''}>&lt;</button>`;


    for (let i = 0; i < totalPages; i++) {
        const pageNumber = i + 1;
        const activeClass = (i === currentPage0Based) ? 'active' : '';
        // 페이지 버튼 클릭 시 fetchMyInquiries(i) 호출
        html += `<button class="page-btn ${activeClass}" onclick="fetchMyInquiries(${i})">${pageNumber}</button>`;
    }

    // 다음 페이지 버튼
    const isNextDisabled = currentPage0Based === totalPages - 1;
    html += `<button class="page-btn nav-btn" onclick="if(!${isNextDisabled}) fetchMyInquiries(${currentPage0Based + 1})" ${isNextDisabled ? 'disabled' : ''}>&gt;</button>`;

    paginationContainer.innerHTML = html;
}

// =================================================================================
// [2] 문의 관련 버튼 클릭 이벤트 핸들러 (전역 함수)
// =================================================================================

function goToInquiry() {
    // 버튼을 누르면 이 함수가 실행되고, 지정된 URL로 이동합니다.
    window.location.href = 'http://localhost:8080/qna';
}

/**
 * 답변 보기 버튼 클릭 시 답변 영역을 토글하는 기능
 * @param {HTMLElement} buttonElement - 클릭된 '답변 보기' 버튼 요소
 */
function toggleInquiryAnswer(buttonElement) {
    const card = buttonElement.closest('.inquiry-card');
    const answerContainer = card ? card.querySelector('.inquiry-answer-container') : null;

    if (answerContainer) {
        if (answerContainer.style.display === 'none' || answerContainer.classList.contains('hidden')) {
            // 펼치기
            answerContainer.style.display = 'block';
            answerContainer.classList.remove('hidden');
            buttonElement.textContent = '답변 숨기기';
        } else {
            // 접기
            answerContainer.style.display = 'none';
            answerContainer.classList.add('hidden');
            buttonElement.textContent = '답변 보기';
        }
    }
}


function editInquiry(inquiryId) {
    // 기존 데이터 불러오기 (간단하게 제목/내용만)
    const card = document.getElementById(`inquiry-${inquiryId}`);
    const title = card.querySelector(".inquiry-title").textContent;
    const content = card.querySelector(".inquiry-content").textContent;

    // 모달 열기
    document.getElementById("edit-inquiry-id").value = inquiryId;
    document.getElementById("edit-inquiry-title").value = title;
    document.getElementById("edit-inquiry-content").value = content;
    document.getElementById("edit-inquiry-modal").classList.remove("hidden");
}

// 모달 닫기
document.getElementById("cancel-edit").addEventListener("click", () => {
    document.getElementById("edit-inquiry-modal").classList.add("hidden");
});

// 수정 폼 제출
document.getElementById("edit-inquiry-form").addEventListener("submit", function (e) {
    e.preventDefault();

    const inquiryId = document.getElementById("edit-inquiry-id").value;
    const newTitle = document.getElementById("edit-inquiry-title").value.trim();
    const newContent = document.getElementById("edit-inquiry-content").value.trim();

    if (!newTitle || !newContent) {
        showMessageBox("❌ 제목과 내용을 모두 입력해야 합니다.", "error");
        return;
    }

    const csrfToken  = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

    fetch("/inquiries/my/update", {
        method: "POST",
        headers: { "Content-Type": "application/json", [csrfHeader]: csrfToken },
        body: JSON.stringify({ inquiryId, title: newTitle, content: newContent })
    })
        .then(response => response.text())
        .then(msg => {
            showMessageBox(msg, "success");
            document.getElementById("edit-inquiry-modal").classList.add("hidden");
            fetchMyInquiries(currentInquiryPage); // 목록 새로고침
        })
        .catch(err => {
            console.error("수정 오류:", err);
            showMessageBox("❌ 문의 수정 중 오류가 발생했습니다.", "error");
        });
});

// ✅ 삭제 확인 로직
function confirmDeleteInquiry(inquiryId) {
    // showConfirmBox를 사용하여 삭제를 확인합니다.
    showConfirmBox(`문의 ID ${inquiryId}를 정말 삭제하시겠습니까? (답변 대기 중만 가능)`, () => {
        deleteInquiry(inquiryId);
    });
}

// ✅ 삭제 API 호출 로직 (에러 로깅 강화)
function deleteInquiry(inquiryId) {
    const csrfToken  = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

    fetch('/inquiries/my/delete', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', [csrfHeader]: csrfToken},
        body: JSON.stringify({ inquiryId: inquiryId })
    })
        .then(response => {
            if (response.ok) {
                return response.text().then(text => ({ success: true, message: text || "성공적으로 삭제되었습니다." }));
            }
            // HTTP 오류 발생 시 (403 포함)
            return response.text().then(text => {
                // 응답 본문(JSON 형태의 에러 메시지일 가능성 높음)을 콘솔에 출력
                console.error(`API Error ${response.status}:`, text);
                return {
                    success: false,
                    message: `삭제에 실패했습니다. (HTTP 상태코드: ${response.status})`
                };
            });
        })
        .then(result => {
            // alert() 대신 showMessageBox() 사용
            showMessageBox(result.message, result.success ? 'success' : 'error');
            if (result.success) {
                // 삭제 성공 시 현재 페이지를 새로고침하여 목록을 업데이트
                fetchMyInquiries(currentInquiryPage);
            }
        })
        .catch(error => {
            // alert() 대신 showMessageBox() 사용
            showMessageBox("삭제 중 네트워크 또는 서버 오류가 발생했습니다.", 'error');
            console.error('삭제 오류 (네트워크):', error);
        });
}

// =================================================================================
// [3] DOMContentLoaded 블록 (기존 로직 통합)
// =================================================================================

// 게시글 삭제
function performDelete(url, itemName, itemElement) {
    // 1. 즉시 UI를 '삭제 중' 상태로 변경 (Optimistic UI)
    //    - 항목을 반투명하게 만들고 클릭 불가능하게 처리하여 사용자에게 작업이 진행 중임을 알립니다.
    if (itemElement) {
        itemElement.style.transition = 'opacity 0.3s ease';
        itemElement.style.opacity = '0.5';
        itemElement.style.pointerEvents = 'none'; // 중복 클릭 방지
    }

    // CSRF 토큰 가져오기
    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

    // 2. 서버에 실제 삭제 요청 (fetch)
    fetch(url, {
        method: 'DELETE',
        headers: {
            [csrfHeader]: csrfToken
        }
    })
        .then(response => {
            if (response.ok) {
                return response.json();
            }
            return response.json().then(err => Promise.reject(err));
        })
        .then(data => {
            // 3. 성공 시: 성공 메시지를 표시하고, UI에서 완전히 제거합니다.
            alert(data.message || `${itemName}이(가) 성공적으로 삭제되었습니다.`);

            if (itemElement) {
                // 부드럽게 사라지는 효과를 위해 opacity를 0으로 먼저 변경
                itemElement.style.opacity = '0';
                // 애니메이션 시간(0.5초)이 지난 후 DOM에서 완전히 제거
                setTimeout(() => itemElement.remove(), 500);
            }
        })
        .catch(error => {
            // 4. 실패 시: 실패 메시지를 표시하고, UI를 원래 상태로 복구합니다.
            console.error(`${itemName} 삭제 중 오류 발생:`, error);
            alert(error.message || '삭제에 실패했습니다. 다시 시도해주세요.');

            if (itemElement) {
                // '삭제 중' 상태(반투명)를 해제하고 다시 클릭 가능하게 만듭니다.
                itemElement.style.opacity = '1';
                itemElement.style.pointerEvents = 'auto';
            }
        });
}

// 좋아요 삭제
function performUnlike(likeType, id, itemElement) {
    // 1. 즉시 UI를 '삭제 중' 상태로 변경
    if (itemElement) {
        itemElement.style.transition = 'opacity 0.3s ease';
        itemElement.style.opacity = '0.5';
        itemElement.style.pointerEvents = 'none';
    }

    // [추가] JSP에 저장된 memberIdx 가져오기
    const memberIdx = document.querySelector('.mypage-main').dataset.memberIdx;
    if (!memberIdx) {
        alert('사용자 정보를 찾을 수 없습니다. 다시 로그인해주세요.');
        // UI 원상 복구
        if (itemElement) {
            itemElement.style.opacity = '1';
            itemElement.style.pointerEvents = 'auto';
        }
        return;
    }

    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

    // 컨트롤러에 보낼 데이터 구성
    const requestData = {
        likeType: likeType,
        memberIdx: memberIdx,
    };
    if (likeType === 'RECIPE') {
        requestData.recipeId = id;
    } else if (likeType === 'BOARD') {
        requestData.boardId = id;
    }

    // 2. 서버에 POST 방식으로 좋아요 취소 요청
    fetch('/like/remove', { // 컨트롤러의 @PostMapping("/remove") 주소
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            [csrfHeader]: csrfToken
        },
        body: JSON.stringify(requestData)
    })
        .then(response => {
            if (response.ok) {
                return response.json();
            }
            return response.json().then(err => Promise.reject(err));
        })
        .then(data => {
            // 3. 성공 시
            alert('좋아요가 취소되었습니다.');
            if (itemElement) {
                itemElement.style.opacity = '0';
                setTimeout(() => itemElement.remove(), 500);
            }
        })
        .catch(error => {
            // 4. 실패 시
            console.error('좋아요 취소 중 오류 발생:', error);
            alert(error.message || '좋아요 취소에 실패했습니다.');
            if (itemElement) {
                itemElement.style.opacity = '1';
                itemElement.style.pointerEvents = 'auto';
            }
        });
}

document.addEventListener('DOMContentLoaded', function() {

    const profileUpdateForm = document.getElementById('profile-update-form');

    if (profileUpdateForm) {
        profileUpdateForm.addEventListener('submit', function (event) {
            // ✅ 1. form의 기본 동작(페이지 새로고침)을 막습니다.
            event.preventDefault();

            // 2. CSRF 토큰과 form 데이터를 가져옵니다.
            const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
            const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
            const formData = new FormData(profileUpdateForm);

            // 3. fetch API를 사용해 서버에 비동기 요청을 보냅니다.
            fetch('/auth/update', {
                method: 'POST',
                headers: {
                    [csrfHeader]: csrfToken
                },
                body: new URLSearchParams(formData) // form 데이터를 URL-encoded 형식으로 전송
            })
                .then(response => response.json()) // 4. 서버로부터 받은 JSON 응답을 파싱합니다.
                .then(data => {
                    // ✅ 5. 응답 받은 메시지로 alert 창을 띄웁니다.
                    alert(data.message);

                    // 6. 성공했을 경우, 페이지의 닉네임도 동적으로 변경해줍니다.
                    if (data.success) {
                        const newNickname = formData.get('nickname');
                        // 페이지 상단 헤더의 닉네임과 form 안의 닉네임 값을 모두 변경
                        document.querySelector('.profile-title').textContent = newNickname + '님의 마이페이지';
                        document.getElementById('nickname').value = newNickname;

                        const headerNicknameElement = document.querySelector('#header-nickname');
                        if (headerNicknameElement) {
                            headerNicknameElement.textContent = newNickname;
                        }
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('❌ 요청 처리 중 오류가 발생했습니다.');
                });
        });
    }

    // 아이콘 초기화
    if (window.lucide && lucide.createIcons) lucide.createIcons();
    // 탭 전환 기능 초기화
    initializeTabSwitching();

    // ⭐⭐⭐ initializeTabSwitching 함수 수정됨 (클릭 시 URL 업데이트) ⭐⭐⭐
    function initializeTabSwitching() {
        const menuItems = document.querySelectorAll('.menu-item');
        const tabContents = document.querySelectorAll('.tab-content');

        // 메뉴 항목 클릭 이벤트 (하나의 루프로 통합)
        menuItems.forEach(item => {
            item.addEventListener('click', function () {
                const tabId = this.dataset.tab;

                // 모든 메뉴 항목에서 active 클래스 제거
                menuItems.forEach(menu => menu.classList.remove('active'));

                // 클릭한 메뉴 항목에 active 클래스 추가
                this.classList.add('active');

                // 탭 클릭 시 URL만 변경하고, showTab을 호출하여 콘텐츠를 로드합니다.
                // profile 탭이 아닌 경우에만 tab=... 파라미터를 추가합니다.
                const url = tabId === 'profile' ? window.location.pathname : `${window.location.pathname}?tab=${tabId}&page=1`;
                window.history.replaceState(null, '', url);

                showTab(tabId, true); // true는 클릭 이벤트임을 의미

                console.log('탭 전환:', tabId);
            });
        });
    }

    // 프로필 이미지 로딩 실패 시 폴백 처리
    initializeProfileImage();

    function initializeProfileImage() {
        const profileImage = document.getElementById('profile-image');
        const avatarFallback = document.getElementById('avatar-fallback');

        if (profileImage && avatarFallback) {
            profileImage.addEventListener('error', function () {
                profileImage.style.display = 'none';
                avatarFallback.style.display = 'flex';
                console.log('프로필 이미지 로딩 실패 - 폴백 표시');
            });

            profileImage.addEventListener('load', function () {
                profileImage.style.display = 'block';
                avatarFallback.style.display = 'none';
                console.log('프로필 이미지 로딩 성공');
            });
        }
    }

    // 새 레시피 작성 버튼
    const btnCreateRecipe = document.getElementById('btn-create-recipe');
    if (btnCreateRecipe) {
        btnCreateRecipe.addEventListener('click', function () {
            // 레시피 작성 페이지로 이동 로직
            console.log('새 레시피 작성 버튼 클릭');
        });
    }

    // 페이지 내 모든 클릭 이벤트를 여기서 한 번에 처리 (이벤트 위임)
    document.addEventListener('click', function (e) {
        // [수정 버튼] .btn-edit - 페이지 이동으로 동작하므로 특별한 로직 불필요
        if (e.target.closest('.btn-edit')) {
            console.log('레시피 수정 버튼 클릭');
            return; // 여기서 함수 종료
        }

        // [조회 버튼] .btn-view - 페이지 이동으로 동작하므로 특별한 로직 불필요
        if (e.target.closest('.btn-view') || e.target.closest('.btn-view-recipe')) {
            console.log('레시피 보기 버튼 클릭');
            return; // 여기서 함수 종료
        }

        // [삭제 버튼] .btn-delete
        const deleteBtn = e.target.closest('.btn-delete');
        if (deleteBtn) {
            e.preventDefault(); // form 태그 안에 있을 경우를 대비해 기본 동작 방지

            // [추가] 좋아요 취소 버튼(.btn-unlike)인 경우 별도 처리
            if (deleteBtn.classList.contains('btn-unlike')) {
                const id = deleteBtn.dataset.id;
                const likeType = deleteBtn.dataset.likeType;
                const itemElement = deleteBtn.closest('.mypage-like-item');

                if (!id || !likeType) return;

                showConfirmBox('이 항목의 좋아요를 취소하시겠습니까?', () => {
                    performUnlike(likeType, id, itemElement);
                });
                return; // 좋아요 취소 처리 후 함수 종료
            }

            const id = deleteBtn.dataset.id;
            if (!id) return; // data-id 속성이 없으면 실행 중지

            // 삭제 대상이 '레시피'인지 '댓글'인지 식별
            const recipeItem = deleteBtn.closest('.recipe-item');
            const commentItem = deleteBtn.closest('.comment-item');

            let url, itemName, itemElement;

            if (recipeItem) {
                // '내 레시피'(게시글) 삭제일 경우
                url = `/api/boards/${id}`; // 게시글 삭제 API URL
                itemName = '게시글';
                itemElement = recipeItem;
            } else if (commentItem) {
                // '내 댓글' 삭제일 경우
                url = `/reviews/${id}`; // 댓글 삭제 API URL
                itemName = '댓글';
                itemElement = commentItem;
            } else {
                // 처리 대상이 아니면 함수 종료 (예: 좋아요 탭의 비활성화된 삭제 버튼)
                return;
            }

            // 사용자에게 삭제 여부 최종 확인
            showConfirmBox(`이 ${itemName}을(를) 정말 삭제하시겠습니까?`, () => {
                performDelete(url, itemName, itemElement); // 확인 시 삭제 함수 호출
            });
        }
    });

    // 폼 제출 이벤트들 (구조만)

// 비밀번호 변경 폼 검증/제출
    const passwordChangeForm = document.getElementById('password-change-form');
    if (passwordChangeForm) {  // ✅ 폼이 있을 때만 리스너 등록
        passwordChangeForm.addEventListener('submit', function (event) {
            event.preventDefault();

            const currentPassword = document.getElementById('current-password').value.trim();
            const newPassword     = document.getElementById('new-password').value.trim();
            const confirmPassword = document.getElementById('confirm-password').value.trim();

            // === 유효성 검사 ===
            const pwPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z0-9])(?!.*\s).{10,20}$/;

            if (!pwPattern.test(newPassword)) {
                alert("❌ 비밀번호는 공백 없이 10~20자, 영문/숫자/특수문자를 모두 포함해야 합니다.");
                return;
            }
            if (newPassword !== confirmPassword) {
                alert("❌ 새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
                return;
            }

            // === CSRF 토큰 ===
            const csrfToken  = document.querySelector('meta[name="_csrf"]').getAttribute('content');
            const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

            // 중복 제출 방지
            const submitBtn = passwordChangeForm.querySelector('button[type="submit"]');
            if (submitBtn) submitBtn.disabled = true;

            // === 서버 요청 ===
            fetch('/auth/change-password', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    [csrfHeader]: csrfToken
                },
                body: JSON.stringify({ currentPassword, newPassword })
            })
                .then(response => {
                    if (!response.ok) {
                        return response.text().then(text => { throw new Error(text || '비밀번호 변경 실패'); });
                    }
                    return response.text();
                })
                .then(message => {
                    alert(message || '✅ 비밀번호가 성공적으로 변경되었습니다.');
                    passwordChangeForm.reset();
                })
                .catch(error => {
                    console.error('비밀번호 변경 오류:', error);
                    alert(error.message || '❌ 서버 오류가 발생했습니다.');
                })
                .finally(() => {
                    if (submitBtn) submitBtn.disabled = false;
                });
        });
    }

    // 계정 삭제 버튼
    const btnDeleteAccount = document.querySelector('.btn-danger');
    if (btnDeleteAccount) {
        btnDeleteAccount.addEventListener('click', function() {
            // 계정 삭제 확인 다이얼로그 로직
            console.log('계정 삭제 버튼 클릭');
        });
    }

    // 통계 카드 호버 애니메이션 (구조만)
    const statCards = document.querySelectorAll('.stat-card');
    statCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            // 호버 애니메이션 로직
            console.log('통계 카드 호버');
        });
    });

    // 반응형 사이드바 메뉴 스크롤 처리 (구조만)
    const menuList = document.querySelector('.menu-list');
    if (menuList && window.innerWidth <= 1024) {
        // 모바일에서 메뉴 스크롤 처리 로직
        console.log('모바일 메뉴 초기화');
    }

    // 창 크기 변경 이벤트
    window.addEventListener('resize', function() {
        // 반응형 처리 로직
        console.log('창 크기 변경');
    });

    // ✅ 문의 필터 드롭다운 변경 시 이벤트 등록
    const statusSelect = document.getElementById('inquiry-status');
    const sortSelect = document.getElementById('inquiry-sort');

    if (statusSelect && sortSelect) {
        statusSelect.addEventListener('change', () => fetchMyInquiries(0));
        sortSelect.addEventListener('change', () => fetchMyInquiries(0));
    }

    // 페이지 로딩 완료 후 초기화
    initializePage();
});

document.addEventListener('DOMContentLoaded', function () {
    const settingsTab = document.querySelector('[data-tab="settings"]');
    if (settingsTab) {
        settingsTab.addEventListener('click', function (e) {
            e.preventDefault();

            const provider = document.getElementById('provider')?.value || '';
            const isSocial = provider !== '';

            if (isSocial) {
                showTab('settings', true);
            } else {
                showPasswordVerifyModal();
            }
        });
    }
});

// 비밀번호 확인 모달
function showPasswordVerifyModal() {
    // 기존 모달이 있으면 제거
    const existingModal = document.getElementById('password-verify-modal');
    if (existingModal) existingModal.remove();

    const modal = document.createElement('div');
    modal.id = 'password-verify-modal';
    modal.classList.add('modal-overlay');
    modal.innerHTML = `
      <div class="modal-content">
        <h2>🔒 비밀번호 확인</h2>
        <p>계정 설정에 접근하려면 비밀번호를 입력하세요.</p>
        <input type="password" id="verify-password" placeholder="비밀번호 입력" />
        <div class="modal-actions">
          <button id="verify-btn" class="btn-confirm">확인</button>
          <button id="cancel-btn" class="btn-cancel">취소</button>
        </div>
      </div>
    `;

    // 최소 스타일 (Tailwind나 기존 CSS 입히면 더 예쁨)
    modal.style.cssText = `
      position: fixed; top:0; left:0; width:100%; height:100%;
      background: rgba(0,0,0,0.5); display:flex; justify-content:center; align-items:center; z-index:2000;
    `;
    modal.querySelector('.modal-content').style.cssText = `
      background:#fff; padding:20px; border-radius:8px; width:350px; text-align:center;
    `;
    modal.querySelector('.modal-actions').style.cssText = `
      margin-top:15px; display:flex; justify-content:space-around;
    `;

    document.body.appendChild(modal);

    // 버튼 이벤트
    document.getElementById('verify-btn').addEventListener('click', () => {
        const password = document.getElementById('verify-password').value.trim();
        verifyPassword(password, modal);
    });
    document.getElementById('cancel-btn').addEventListener('click', () => {
        modal.remove();
        showTab('profile'); // 프로필 탭으로 강제 이동
    });

    // 엔터 키 입력 시 확인 버튼 트리거
    document.getElementById('verify-password').addEventListener('keydown', function (e) {
        if (e.key === 'Enter') {
            e.preventDefault(); // 기본 Enter 제출 방지
            document.getElementById('verify-btn').click(); // 확인 버튼 클릭 이벤트 실행
        }
    });
}

// 서버에 비밀번호 검증 요청
function verifyPassword(password, modal) {
    if (!password) {
        alert("비밀번호를 입력해주세요.");
        return;
    }

    const csrfToken  = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

    fetch('/mypage/verify-settings', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            [csrfHeader]: csrfToken
        },
        body: JSON.stringify({ password })
    })
        .then(res => {
            if (res.ok) {
                modal.remove();
                // ✅ 인증 성공 시 settings 탭 강제 열기
                showTab('settings', true);
            } else {
                alert("❌ 비밀번호가 올바르지 않습니다.");
            }
        })
        .catch(err => {
            console.error("비밀번호 검증 오류:", err);
            alert("서버 오류가 발생했습니다.");
        });
}

// 페이지 초기화 함수
function initializePage() {
    // URL에서 초기 탭 ID를 가져와서 사용합니다.
    const urlParams = new URLSearchParams(window.location.search);
    const initialTabId = urlParams.get('tab') || 'profile';

    // 기본 탭 활성화 (URL 파라미터를 존중)
    showTab(initialTabId, false); // false는 로드 이벤트임을 의미

    // 프로필 이미지 로딩 상태 확인
    checkProfileImage();

    console.log('마이페이지 초기화 완료');
}

// 탭 표시 함수
// isClickEvent: true면 사용자가 탭을 클릭한 것, false면 페이지 로드 시 초기화된 것
function showTab(tabId, isClickEvent = false) {
    // 모든 탭 비활성화
    const tabContents = document.querySelectorAll('.tab-content');
    const menuItems = document.querySelectorAll('.menu-item');

    tabContents.forEach(tab => {
        tab.classList.remove('active');
    });

    menuItems.forEach(item => {
        item.classList.remove('active');
    });

    // 선택된 탭 활성화
    const selectedTab = document.getElementById(`tab-${tabId}`);
    const selectedMenu = document.querySelector(`[data-tab="${tabId}"]`);

    if (selectedTab) {
        // 선택한 탭 컨텐츠 표시 (애니메이션을 위한 약간의 지연)
        setTimeout(() => {
            selectedTab.classList.add('active');
        }, 50);


        // 문의 탭일 경우 데이터 로드 로직
        if (tabId === 'inquiries') {
            const urlParams = new URLSearchParams(window.location.search);
            let pageToLoad = 0; // 기본값: 0 (첫 페이지)

            if (!isClickEvent) {
                // 페이지 새로고침 시: URL에서 페이지 번호 읽기
                const pageParam = parseInt(urlParams.get('page'));
                if (!isNaN(pageParam) && pageParam > 0) {
                    pageToLoad = pageParam - 1; // 1-based to 0-based
                }
            } else {
                // 클릭 시: 항상 첫 페이지(0) 로드 (URL에서 page=1로 설정했으므로)
                pageToLoad = 0;
            }

            // 데이터 로드 실행
            fetchMyInquiries(pageToLoad);
        }
    }

    if (selectedMenu) {
        selectedMenu.classList.add('active');
    }

    console.log('탭 전환:', tabId);
}

// 프로필 이미지 체크 함수
function checkProfileImage() {
    const profileImage = document.getElementById('profile-image');
    const avatarFallback = document.getElementById('avatar-fallback');

    if (profileImage && avatarFallback) {
        // 이미지 로딩 실패 시 폴백 표시 로직
        profileImage.style.display = 'block';
        avatarFallback.style.display = 'none';

        console.log('프로필 이미지 상태 확인');
    }
}

// 폼 유효성 검사 함수들 (구조만)

// 닉네임 유효성 검사
function validateNickname(nickname) {
    // 닉네임 검증 로직
    console.log('닉네임 검증:', nickname);
    return true;
}

// 이메일 유효성 검사
function validateEmail(email) {
    // 이메일 검증 로직
    console.log('이메일 검증:', email);
    return true;
}

// 비밀번호 유효성 검사
function validatePassword(password) {
    // 비밀번호 검증 로직
    console.log('비밀번호 검증');
    return true;
}

// 비밀번호 일치 확인
function validatePasswordMatch(password, confirmPassword) {
    // 비밀번호 일치 검증 로직
    console.log('비밀번호 일치 확인');
    return password === confirmPassword;
}

// 알림 메시지 표시 함수 (구조만)
function showNotification(message, type = 'info') {
    // 알림 메시지 표시 로직
    console.log('알림:', message, type);
}

// 로딩 상태 표시 함수 (구조만)
function showLoading(show = true) {
    // 로딩 스피너 표시/숨김 로직
    console.log('로딩 상태:', show);
}

// 확인 다이얼로그 함수 (구조만)
function showConfirmDialog(message, callback) {
    // 확인 다이얼로그 표시 로직
    console.log('확인 다이얼로그:', message);
    // callback 실행 로직
}

// 데이터 업데이트 함수들 (구조만)

// 프로필 정보 업데이트
function updateProfile(data) {
    // 프로필 업데이트 API 호출 로직
    console.log('프로필 업데이트:', data);
}

// 유틸리티 함수들

// 날짜 포맷팅
function formatDate(date) {
    // 날짜 포맷팅 로직
    return date;
}

// 숫자 포맷팅 (천 단위 콤마)
function formatNumber(number) {
    // 숫자 포맷팅 로직
    return number.toLocaleString();
}

// 파일 크기 포맷팅
function formatFileSize(bytes) {
    // 파일 크기 포맷팅 로직
    return bytes + ' bytes';
}

//  좋아요 레시피/게시글 전환 탭
(function () {
    const root = document.getElementById('tab-liked');
    if (!root) return;

    const btns = root.querySelectorAll('.mypage-like-tabbtn');
    const panes = root.querySelectorAll('.mypage-like-pane');

    btns.forEach(btn => {
        btn.addEventListener('click', () => {
            const key = btn.getAttribute('data-like-tab'); // 'admin' | 'user'

            // 버튼 on/off
            btns.forEach(b => b.classList.toggle('is-active', b === btn));

            // 패널 on/off
            panes.forEach(p => {
                const isMatch = p.id === `mypage-like-pane-${key}`;
                p.classList.toggle('is-active', isMatch);
            });

            // 접근성 속성 업데이트
            btns.forEach(b => b.setAttribute('aria-selected', b === btn ? 'true' : 'false'));
        });
    });
})();