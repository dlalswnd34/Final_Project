// ==============================
// 전역 함수 (JSP inline 이벤트에서도 호출 가능)
// ==============================
function clearError(fieldId) {
    const errorEl = document.getElementById(fieldId + "Error");
    if (errorEl) {
        errorEl.style.display = "none";
        const span = errorEl.querySelector("span");
        if (span) span.textContent = "";
    }
}

// ==============================
// CheForest 회원가입 JavaScript (실시간 검증 + AJAX 방식)
// ==============================
document.addEventListener("DOMContentLoaded", function () {
    // CSRF 토큰 (Spring Security)
    const csrfToken = document.querySelector("meta[name='_csrf']")?.content;
    const csrfHeader = document.querySelector("meta[name='_csrf_header']")?.content;

    // AJAX 공통 요청 함수
    async function ajaxRequest(url, method, data = {}) {
        const headers = {
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        };
        if (csrfHeader && csrfToken && ['POST', 'PUT', 'DELETE', 'PATCH'].includes(method.toUpperCase())) {
            headers[csrfHeader] = csrfToken;
        }

        const options = { method, headers };

        if (method.toUpperCase() === "GET") {
            if (Object.keys(data).length > 0) {
                url += (url.includes("?") ? "&" : "?") + new URLSearchParams(data).toString();
            }
        } else {
            options.body = new URLSearchParams(data).toString();
        }

        try {
            const response = await fetch(url, options);
            const responseText = await response.text(); // 응답을 먼저 텍스트로 받음

            if (!response.ok) {
                throw new Error(responseText || `서버 에러: ${response.status}`);
            }

            const contentType = response.headers.get("content-type");
            if (contentType && contentType.includes("application/json")) {
                return JSON.parse(responseText); // 텍스트를 JSON으로 파싱
            } else {
                return responseText;
            }
        } catch (error) {
            console.error("AJAX 요청 실패:", error);
            throw error;
        }
    }

    // (이하 코드는 이전과 거의 동일하며, 요청사항만 반영하여 수정되었습니다)

    const signupForm = document.getElementById("signupForm");
    const userIdInput = document.getElementById("userId");
    const emailInput = document.getElementById("email");
    const emailCodeInput = document.getElementById("emailCode");
    const passwordInput = document.getElementById("password");
    const confirmPasswordInput = document.getElementById("confirmPassword");
    const nicknameInput = document.getElementById("nickname");

    const emailVerificationSection = document.getElementById("emailVerificationSection");
    const emailSuccess = document.getElementById("emailSuccess");
    const emailSentMessage = document.getElementById("emailSentMessage");
    const nicknameSuccess = document.getElementById("nicknameSuccess");
    const userIdSuccess = document.getElementById("userIdSuccess");

    const sendEmailBtn = document.getElementById("sendEmailBtn");
    const verifyEmailBtn = document.getElementById("verifyEmailBtn");

    const successModal = document.getElementById("successModal");
    const modalTitle = document.getElementById("modalTitle");
    const modalMessage = document.getElementById("modalMessage");
    const modalOkBtn = document.getElementById("modalOkBtn"); // 모달 OK 버튼
    const toast = document.getElementById("toast");
    const toastMessage = document.getElementById("toastMessage");

    let verificationState = {
        userIdChecked: false,
        emailSent: false,
        emailVerified: false,
        nicknameChecked: false,
    };

    let userIdTimer;
    userIdInput.addEventListener("keyup", () => {
        clearTimeout(userIdTimer);
        userIdTimer = setTimeout(async () => {
            const id = userIdInput.value.trim();
            hideElement(userIdSuccess);
            clearError("userId");
            verificationState.userIdChecked = false;

            if (id.length < 8) {
                return showError("userId", "아이디는 최소 8자 이상이어야 합니다.");
            }
            try {
                const result = await ajaxRequest("/auth/check-id", "GET", { loginId: id });
                if (String(result) === 'true') {
                    verificationState.userIdChecked = true;
                    showElement(userIdSuccess);
                    clearError("userId");
                } else {
                    hideElement(userIdSuccess);
                    showError("userId", "이미 사용중인 아이디입니다.");
                }
            } catch (err) {
                // ✅ [수정] 토스트 -> 모달
                showErrorModal("아이디 중복 확인 중 오류가 발생했습니다.");
            }
        }, 300);
    });

    let nicknameTimer;
    nicknameInput.addEventListener("keyup", () => {
        clearTimeout(nicknameTimer);
        nicknameTimer = setTimeout(async () => {
            const nickname = nicknameInput.value.trim();
            hideElement(nicknameSuccess);
            clearError("nickname");
            verificationState.nicknameChecked = false;

            if (nickname.length < 2) {
                return showError("nickname", "닉네임은 최소 2자 이상이어야 합니다.");
            }
            try {
                const result = await ajaxRequest("/auth/check-nickname", "GET", { nickname });
                if (String(result) === 'true') {
                    verificationState.nicknameChecked = true;
                    showElement(nicknameSuccess);
                    clearError("nickname");
                } else {
                    hideElement(nicknameSuccess);
                    showError("nickname", "이미 사용중인 닉네임입니다.");
                }
            } catch (err) {
                // ✅ [수정] 토스트 -> 모달
                showErrorModal("닉네임 중복 확인 중 오류가 발생했습니다.");
            }
        }, 300);
    });

    passwordInput.addEventListener("keyup", () => {
        const password = passwordInput.value.trim();
        const pwPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[~!@#$%^&*()_+\-={}[\]|:;"'<>,.?/]).{10,20}$/;
        if (!pwPattern.test(password)) {
            showError("password", "비밀번호는 영문, 숫자, 특수문자를 포함해 10~20자로 입력하세요.");
        } else {
            clearError("password");
        }
    });

    confirmPasswordInput.addEventListener("keyup", () => {
        if (passwordInput.value !== confirmPasswordInput.value) {
            showError("confirmPassword", "비밀번호가 일치하지 않습니다.");
        } else {
            clearError("confirmPassword");
        }
    });

    emailInput.addEventListener("keyup", () => {
        const email = emailInput.value.trim();
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(email)) {
            showError("email", "올바른 이메일 형식이 아닙니다.");
            sendEmailBtn.disabled = true;
        } else {
            clearError("email");
            sendEmailBtn.disabled = false;
        }
    });

    if (sendEmailBtn) {
        sendEmailBtn.addEventListener("click", async () => {
            const email = emailInput.value.trim();
            if (!email) return showErrorModal("이메일을 입력해주세요.");

            try {
                const result = await ajaxRequest("/auth/send-email-code", "POST", { email });
                if (String(result).trim().toUpperCase() === "OK") {
                    verificationState.emailSent = true;
                    showElement(emailVerificationSection);
                    showElement(emailSentMessage);
                    showToast("인증번호가 발송되었습니다.", "success");
                } else {
                    // ✅ [수정] 토스트 -> 모달
                    showErrorModal("이메일 발송 실패", result);
                }
            } catch (err) {
                // ✅ [수정] 토스트 -> 모달
                showErrorModal("이메일 발송 실패", err.message);
            }
        });
    }

    if (verifyEmailBtn) {
        verifyEmailBtn.addEventListener("click", async () => {
            const code = emailCodeInput.value.trim();
            if (!code) return showErrorModal("인증번호를 입력해주세요.");

            try {
                const result = await ajaxRequest("/auth/verify-email-code", "POST", { code });
                if (String(result) === 'true') {
                    // ✅ [수정] 인증 완료 시 UI 개선
                    verificationState.emailVerified = true;

                    // 입력창과 인증 버튼 숨기기
                    hideElement(emailCodeInput);
                    hideElement(verifyEmailBtn);
                    hideElement(emailSentMessage);

                    // 인증 완료 메시지 보여주기
                    showElement(emailSuccess);

                    // 이메일 재입력 및 재전송 방지
                    emailInput.disabled = true;
                    sendEmailBtn.disabled = true;

                    showToast("이메일 인증이 완료되었습니다.", "success");
                } else {
                    // ✅ [수정] 토스트 -> 모달
                    showErrorModal("인증 실패", "인증번호가 일치하지 않습니다.");
                }
            } catch (err) {
                // ✅ [수정] 토스트 -> 모달
                showErrorModal("인증 실패", err.message);
            }
        });
    }

    if (signupForm) {
        signupForm.addEventListener("submit", async function (e) {
            e.preventDefault();
            if (!validateSignupForm()) return;

            const submitBtn = signupForm.querySelector('button[type="submit"]');

            try {
                if (submitBtn) {
                    submitBtn.disabled = true;
                    submitBtn.textContent = '가입 처리 중...';
                }

                const formData = {
                    loginId: userIdInput.value.trim(),
                    email: emailInput.value.trim(),
                    password: passwordInput.value.trim(),
                    confirmPassword: confirmPasswordInput.value.trim(),
                    nickname: nicknameInput.value.trim(),
                };

                const result = await ajaxRequest("/auth/register/addition", "POST", formData);

                if (String(result).trim().toUpperCase() === "OK") {
                    showSuccessModal("회원가입 완료!", "성공적으로 가입되었습니다. 로그인 페이지로 이동합니다.");
                    if (modalOkBtn) {
                        modalOkBtn.onclick = () => {
                            window.location.href = "/auth/login";
                        };
                    }
                } else {
                    showErrorModal("회원가입 실패", result);
                }
            } catch (err) {
                showErrorModal("회원가입 실패", err.message);
            } finally {
                if (submitBtn) {
                    submitBtn.disabled = false;
                    submitBtn.textContent = '회원가입';
                }
            }
        });
    }

    // 유효성 검증 함수 (실패 시 모달 표시)
    function validateSignupForm() {
        if (!verificationState.userIdChecked) {
            showErrorModal("아이디 중복 확인을 완료해주세요.");
            return false;
        }
        if (!verificationState.nicknameChecked) {
            showErrorModal("닉네임 중복 확인을 완료해주세요.");
            return false;
        }
        if (!verificationState.emailVerified) {
            showErrorModal("이메일 인증을 완료해주세요.");
            return false;
        }
        if (passwordInput.value.trim() === "" || passwordInput.value !== confirmPasswordInput.value) {
            showErrorModal("비밀번호를 확인해주세요.");
            return false;
        }
        return true;
    }

    function showError(fieldId, message) {
        const errorEl = document.getElementById(fieldId + "Error");
        if (errorEl) {
            const span = errorEl.querySelector("span");
            if (span) span.textContent = message;
            errorEl.style.display = "block";
        }
    }

    function showElement(el) { if (el) el.style.display = "block"; }
    function hideElement(el) { if (el) el.style.display = "none"; }

    // ✅ [수정] 모달 함수 분리 (성공/에러)
    function showSuccessModal(title, message) {
        if (modalTitle) modalTitle.textContent = title;
        if (modalMessage) modalMessage.textContent = message;
        if (successModal) successModal.style.display = "flex";
    }

    // (참고) 에러 모달은 HTML/CSS가 별도로 필요할 수 있습니다.
    // 여기서는 기존 성공 모달을 재활용하는 것으로 가정합니다.
    function showErrorModal(title, message = "") {
        if (modalTitle) modalTitle.textContent = title;
        if (modalMessage) modalMessage.textContent = message;
        if (successModal) successModal.style.display = "flex";
        // 확인 버튼 누르면 그냥 닫히도록 설정
        if(modalOkBtn) modalOkBtn.onclick = () => successModal.style.display = 'none';
    }

    function showToast(message, type = "info") {
        if (!toast) return; // 토스트 없으면 그냥 무시
        toastMessage.textContent = message;
        toast.className = `toast ${type}`;
        toast.style.display = "block";
        setTimeout(() => (toast.style.display = "none"), 3000);
    }
});