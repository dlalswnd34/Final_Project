// CheForest 비밀번호 찾기 페이지 JavaScript
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

// ==============================
// ✅ 이메일 인증 타이머 (5분 카운트다운)
// ==============================
let emailTimer; // 전역 타이머
let timeLeft = 300; // 5분 (초 단위)

function startEmailTimer() {
    clearInterval(emailTimer);
    timeLeft = 300;

    const codeGroup = document.getElementById("code-group");

    // 남은 시간 표시용 span 없으면 생성
    let timerEl = document.getElementById("email-timer");
    if (!timerEl) {
        timerEl = document.createElement("div");
        timerEl.id = "email-timer";
        timerEl.style.marginTop = "6px";
        timerEl.style.fontSize = "0.85rem";
        timerEl.style.color = "#d32f2f";
        codeGroup.appendChild(timerEl);
    }

    emailTimer = setInterval(() => {
        const min = Math.floor(timeLeft / 60);
        const sec = timeLeft % 60;
        timerEl.textContent = `⏳ 남은 시간: ${min}:${sec < 10 ? "0" : ""}${sec}`;

        if (timeLeft <= 0) {
            clearInterval(emailTimer);
            timerEl.textContent = "❌ 인증번호가 만료되었습니다. 다시 요청해주세요.";
            showModal("인증번호가 만료되었습니다. 다시 요청해주세요.");
            disableVerifyStep();
        }

        timeLeft--;
    }, 1000);
}

// 만료 시 입력창 비활성화
function disableVerifyStep() {
    const codeInput = document.getElementById("email-code");
    const verifyBtn = document.getElementById("btn-verify-code");
    if (codeInput) codeInput.disabled = true;
    if (verifyBtn) verifyBtn.disabled = true;
}

// ==============================
// 초기화
// ==============================
document.addEventListener('DOMContentLoaded', function() {
    initializeFindPasswordPage();
});

// 페이지 초기화
function initializeFindPasswordPage() {
    const btnBack = document.getElementById('btn-back');
    const btnSendCode = document.getElementById('btn-send-code');
    const btnVerifyCode = document.getElementById('btn-verify-code');
    const emailCodeInput = document.getElementById('email-code');
    const resetForm = document.getElementById('reset-form');
    const btnFooterFindId = document.getElementById('btn-footer-find-id');
    const btnFooterLogin = document.getElementById('btn-footer-login');

    if (btnBack) btnBack.addEventListener('click', () => goToLogin());
    if (btnFooterFindId) btnFooterFindId.addEventListener('click', () => window.location.href = '/auth/find-id');
    if (btnFooterLogin) btnFooterLogin.addEventListener('click', () => window.location.href = '/auth/login');
    if (btnSendCode) btnSendCode.addEventListener('click', sendEmailCode);
    if (btnVerifyCode) btnVerifyCode.addEventListener('click', verifyEmailCode);
    if (emailCodeInput) emailCodeInput.addEventListener('keypress', (e) => { if (e.key === 'Enter') verifyEmailCode(); });
    if (resetForm) resetForm.addEventListener('submit', (e) => { e.preventDefault(); submitNewPassword(); });

    console.log("비밀번호 찾기 페이지 초기화 완료");
}

// ==============================
// 인증 관련
// ==============================

// 이메일 인증번호 발송
function sendEmailCode() {
    const userId = document.getElementById('user-id').value.trim();
    const email = document.getElementById('email').value.trim();

    if (!validateUserId(userId) || !validateEmail(email)) return;

    showLoadingState('btn-send-code');

    fetch("/auth/find-password/send-code", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded", [csrfHeader]: csrfToken },
        body: new URLSearchParams({ loginId: userId, email: email })
    })
        .then(res => res.text())
        .then(result => {
            hideLoadingState('btn-send-code');
            if (result === "OK") {
                showCodeInput();
                updateSendCodeButtonText('발송완료');
                showModal("인증번호가 발송되었습니다. 이메일을 확인해주세요.");
                startEmailTimer(); // ✅ 타이머 시작
            } else {
                showModal(result);
            }
        })
        .catch(err => {
            hideLoadingState('btn-send-code');
            console.error(err);
            showModal("서버 오류가 발생했습니다.");
        });
}

// 인증번호 확인
function verifyEmailCode() {
    const code = document.getElementById('email-code').value.trim();
    if (!validateCode(code)) return;

    showLoadingState('btn-verify-code');

    fetch("/auth/find-password/verify-code", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded", [csrfHeader]: csrfToken },
        body: new URLSearchParams({ code: code })
    })
        .then(res => res.text())
        .then(result => {
            hideLoadingState('btn-verify-code');
            if (result.trim().toUpperCase() === "OK") {
                clearInterval(emailTimer); // ✅ 타이머 중단
                const timerEl = document.getElementById("email-timer");
                if (timerEl) timerEl.remove(); // ✅ 타이머 표시 제거

                showModal("이메일 인증이 완료되었습니다. 새 비밀번호를 설정해주세요.");
                showResetStep();
            } else {
                showModal(result);
            }
        })
        .catch(err => {
            hideLoadingState('btn-verify-code');
            console.error(err);
            showModal("서버 오류가 발생했습니다.");
        });
}

// ==============================
// 비밀번호 재설정
// ==============================

function showResetStep() {
    const verificationStep = document.getElementById('verification-step');
    const resetStep = document.getElementById('reset-step');
    const cardFooter = document.getElementById('card-footer');

    if (verificationStep) verificationStep.style.display = 'none';
    if (cardFooter) cardFooter.style.display = 'none';
    if (resetStep) resetStep.style.display = 'block';
}

function submitNewPassword() {
    const newPw = document.getElementById('new-password').value.trim();
    const confirmPw = document.getElementById('confirm-password').value.trim();

    if (!newPw || newPw.length < 8) {
        showModal("비밀번호는 8자 이상이어야 합니다.");
        return;
    }
    if (newPw !== confirmPw) {
        showModal("비밀번호가 일치하지 않습니다.");
        return;
    }

    fetch("/auth/find-password/reset", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded", [csrfHeader]: csrfToken },
        body: new URLSearchParams({ newPassword: newPw })
    })
        .then(res => res.text())
        .then(result => {
            if (result === "OK") {
                showModal("비밀번호가 성공적으로 변경되었습니다. 로그인 페이지로 이동합니다.");
                setTimeout(() => { window.location.href = "/auth/login"; }, 2000);
            } else {
                showModal(result);
            }
        })
        .catch(err => {
            console.error(err);
            showModal("서버 오류가 발생했습니다.");
        });
}

// ==============================
// 유틸
// ==============================

function showCodeInput() {
    const codeGroup = document.getElementById('code-group');
    if (codeGroup) codeGroup.style.display = 'flex';
}

function validateUserId(userId) {
    if (!userId) { showModal("아이디를 입력해주세요."); return false; }
    if (userId.length < 4) { showModal("아이디는 4자 이상이어야 합니다."); return false; }
    return true;
}
function validateEmail(email) {
    if (!email) { showModal("이메일을 입력해주세요."); return false; }
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!regex.test(email)) { showModal("올바른 이메일 형식이 아닙니다."); return false; }
    return true;
}
function validateCode(code) {
    if (!code) { showModal("인증번호를 입력해주세요."); return false; }
    if (code.length !== 6) { showModal("인증번호는 6자리여야 합니다."); return false; }
    return true;
}

function showModal(message) {
    const modal = document.getElementById("alertModal");
    const msg = document.getElementById("alertModalMessage");
    const closeBtn = document.getElementById("alertModalClose");

    if (modal && msg) {
        msg.textContent = message;
        modal.style.display = "block";
    }
    if (closeBtn) {
        closeBtn.onclick = () => { modal.style.display = "none"; };
    }
    window.onclick = (e) => {
        if (e.target === modal) modal.style.display = "none";
    };
}

function showLoadingState(buttonId) {
    const btn = document.getElementById(buttonId);
    if (btn) { btn.classList.add("loading"); btn.disabled = true; }
}
function hideLoadingState(buttonId) {
    const btn = document.getElementById(buttonId);
    if (btn) { btn.classList.remove("loading"); btn.disabled = false; }
}
function updateSendCodeButtonText(text) {
    const btn = document.getElementById('btn-send-code');
    const span = btn.querySelector('.btn-text');
    if (span) span.textContent = text;
}
function goToLogin() {
    window.location.href = "/auth/login";
}
