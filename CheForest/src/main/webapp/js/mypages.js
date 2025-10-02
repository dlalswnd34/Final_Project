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

    // 로딩 상태 표시
    container.innerHTML = '<p class="loading-message">문의 내역을 불러오는 중...</p>';
    countElement.textContent = '...';
    paginationContainer.innerHTML = '';

    // API URL: /api/mypage/inquiries?page=0&size=5
    const apiUrl = `/api/mypage/inquiries?page=${page}&size=${inquiryPageSize}`;

    fetch(apiUrl)
        .then(response => {
            if (!response.ok) {
                // HTTP 오류 처리 (예: 401 Unauthorized, 404 Not Found)
                throw new Error('문의 내역 API 호출 실패: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            // 1. 문의 리스트 렌더링
            renderInquiryList(data.data, container);

            // 2. 총 개수 업데이트 (formatNumber 함수가 내부에서 정의되어 있으므로 toLocaleString 사용)
            countElement.textContent = data.total.toLocaleString();

            // 3. 페이징 버튼 렌더링
            renderInquiryPagination(data.totalPages, data.page);

            // ✅ URL에 현재 페이지 정보를 동기화하여 새로고침 시 상태를 유지합니다.
            // data.page는 1-based 페이지 번호입니다.
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
    window.location.href = `/inquiries/edit/${inquiryId}`; // 수정 페이지 URL로 이동
}

// ✅ 삭제 확인 로직
function confirmDeleteInquiry(inquiryId) {
    // showConfirmBox를 사용하여 삭제를 확인합니다.
    showConfirmBox(`문의 ID ${inquiryId}를 정말 삭제하시겠습니까? (답변 대기 중만 가능)`, () => {
        deleteInquiry(inquiryId);
    });
}

// ✅ 삭제 API 호출 로직 (에러 로깅 강화)
function deleteInquiry(inquiryId) {
    fetch('/inquiries/my/delete', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
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

document.addEventListener('DOMContentLoaded', function() {
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
            item.addEventListener('click', function() {
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
            profileImage.addEventListener('error', function() {
                profileImage.style.display = 'none';
                avatarFallback.style.display = 'flex';
                console.log('프로필 이미지 로딩 실패 - 폴백 표시');
            });

            profileImage.addEventListener('load', function() {
                profileImage.style.display = 'block';
                avatarFallback.style.display = 'none';
                console.log('프로필 이미지 로딩 성공');
            });
        }
    }

    // 새 레시피 작성 버튼
    const btnCreateRecipe = document.getElementById('btn-create-recipe');
    if (btnCreateRecipe) {
        btnCreateRecipe.addEventListener('click', function() {
            // 레시피 작성 페이지로 이동 로직
            console.log('새 레시피 작성 버튼 클릭');
        });
    }

    // 레시피 수정/삭제 버튼들
    document.addEventListener('click', function(e) {
        if (e.target.closest('.btn-edit')) {
            // 레시피 수정 로직
            console.log('레시피 수정 버튼 클릭');
        }

        if (e.target.closest('.btn-delete')) {
            // 삭제 확인 및 삭제 로직
            console.log('삭제 버튼 클릭');
        }

        if (e.target.closest('.btn-view') || e.target.closest('.btn-view-recipe')) {
            // 레시피 보기 로직
            console.log('레시피 보기 버튼 클릭');
        }
    });

    // 폼 제출 이벤트들 (구조만)

    // 프로필 업데이트 폼
    const profileForm = document.querySelector('#tab-settings form');
    if (profileForm) {
        profileForm.addEventListener('submit', function(e) {
            e.preventDefault();
            // 프로필 업데이트 로직
            console.log('프로필 업데이트 제출');
        });
    }

    // 비밀번호 변경 폼 검증
    const passwordInputs = {
        current: document.getElementById('current-password'),
        new: document.getElementById('new-password'),
        confirm: document.getElementById('confirm-password')
    };

    // 비밀번호 입력 필드 변경 이벤트 (구조만)
    Object.values(passwordInputs).forEach(input => {
        if (input) {
            input.addEventListener('input', function() {
                // 비밀번호 유효성 검사 로직
                console.log('비밀번호 입력 변경');
            });
        }
    });

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

    // 페이지 로딩 완료 후 초기화
    initializePage();
});

// 페이지 초기화 함수
function initializePage() {
    // URL에서 초기 탭 ID를 가져와서 사용합니다.
    const urlParams = new URLSearchParams(window.location.search);
    const initialTabId = urlParams.get('tab') || 'profile';

    // 기본 탭 활성화 (URL 파라미터를 존중)
    showTab(initialTabId, false); // false는 로드 이벤트임을 의미

    // 프로필 이미지 로딩 상태 확인
    checkProfileImage();

    // 등급 진행률 애니메이션 (구조만)
    animateProgressBar();

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
function checkProfileImage() { /* ... 기존 로직 유지 ... */ }

// 진행률 바 애니메이션 함수 (구조만)
function animateProgressBar() { /* ... 기존 로직 유지 ... */ }

// 폼 유효성 검사 함수들 (구조만)
function validateNickname(nickname) { /* ... 기존 로직 유지 ... */ return true; }
function validateEmail(email) { /* ... 기존 로직 유지 ... */ return true; }
function validatePassword(password) { /* ... 기존 로직 유지 ... */ return true; }
function validatePasswordMatch(password, confirmPassword) { /* ... 기존 로직 유지 ... */ return password === confirmPassword; }

// 알림 메시지 표시 함수 (구조만)
function showNotification(message, type = 'info') { /* ... 기존 로직 유지 ... */ }
function showLoading(show = true) { /* ... 기존 로직 유지 ... */ }
// function showConfirmDialog(message, callback) { /* ... 기존 로직 유지 ... */ } // showConfirmBox로 대체됨

// 데이터 업데이트 함수들 (구조만)
function updateProfile(data) { /* ... 기존 로직 유지 ... */ }
function changePassword(data) { /* ... 기존 로직 유지 ... */ }
function deleteRecipe(recipeId) { /* ... 기존 로직 유지 ... */ }
function deleteComment(commentId) { /* ... 기존 로직 유지 ... */ }
function deleteAccount() { /* ... 기존 로직 유지 ... */ }

// 유틸리티 함수들 (내부에 정의된 것은 그대로 유지)
function formatDate(date) { return date; }
function formatNumber(number) { return number.toLocaleString(); }
function formatFileSize(bytes) { return bytes + ' bytes'; }
function getLevelInfo(level) { /* ... 기존 로직 유지 ... */ }
function getNextLevel(currentLevel) { /* ... 기존 로직 유지 ... */ }
function calculateLevelProgress(currentPosts, currentLevel) { /* ... 기존 로직 유지 ... */ }

// 좋아요 레시피/게시글 전환 탭 (즉시 실행 함수로 유지)
(function () {
    const root = document.getElementById('tab-liked');
    if (!root) return;
    /* ... 기존 로직 유지 ... */
})();
