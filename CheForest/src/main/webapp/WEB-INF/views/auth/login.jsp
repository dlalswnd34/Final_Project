<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>로그인 & 회원가입</title>
    <link rel="stylesheet" href="/css/login.css" />
</head>
<body>
<div class="wrapper">
    <div class="container">
        <!-- 왼쪽 이미지 슬라이드 -->
        <div class="left-slide">
            <img src="${pageContext.request.contextPath}/images/슬라이드/라비올리.jpg" class="slide-image"/>
            <img src="${pageContext.request.contextPath}/images/슬라이드/삼겹살.jpg" class="slide-image"/>
            <img src="${pageContext.request.contextPath}/images/슬라이드/수프.jpg" class="slide-image"/>
            <img src="${pageContext.request.contextPath}/images/슬라이드/토마토.jpg" class="slide-image"/>
            <img src="${pageContext.request.contextPath}/images/슬라이드/브런치.jpg" class="slide-image"/>
            <img src="${pageContext.request.contextPath}/images/슬라이드/부르기뇽.jpg" class="slide-image"/>
            <img src="${pageContext.request.contextPath}/images/슬라이드/부찌.jpg" class="slide-image"/>
        </div>

        <div class="right-login">

            <!-- 로그인 폼 -->
            <form class="form-box" id="loginForm" method="post" action="${pageContext.request.contextPath}/auth/login">
                <!-- CSRF 토큰 추가 -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="home-icon-wrapper">
                    <a href="${pageContext.request.contextPath}/">
                        <img class="gohome" src="${pageContext.request.contextPath}/images/home.png" alt="홈으로" />
                    </a>
                </div>

                <h1>LOGIN</h1>
                <input type="text" name="loginId" placeholder="아이디" required />
                <input type="password" name="password" placeholder="비밀번호" required />

                <c:if test="${param.error eq 'true'}">
                    <div class="error">❌ 로그인 실패: 아이디/비밀번호를 확인하세요.</div>
                </c:if>
                <c:if test="${param.logout eq 'true'}">
                    <div class="success">✅ 로그아웃 되었습니다.</div>
                </c:if>
                <c:if test="${param.success eq 'true'}">
                    <div class="success">✅ 회원가입이 완료되었습니다. 로그인 해주세요.</div>
                </c:if>

                <button class="submit-btn" type="submit">시작하기</button>
                <span class="toggle-link" onclick="toggleForm('signup')">회원가입</span>

                <div class="find">
                    <a href="${pageContext.request.contextPath}/auth/find-id">아이디 찾기</a> &nbsp;
                    <a href="${pageContext.request.contextPath}/auth/find-password">비밀번호 찾기</a>
                </div>

                <!-- 카카오 로그인 -->
                <div id="kakaoLoginContainer" style="margin-top: 10px;">
                    <a href="${kakaoLink}">
                        <img src="https://developers.kakao.com/assets/img/about/logos/kakaologin/kr/kakao_account_login_btn_medium_narrow.png"
                             alt="카카오 로그인"
                             style="width: 100%; max-width: 180px; display: block; margin: 0 auto;" />
                    </a>
                </div>
            </form>

            <!-- 회원가입 폼 -->
            <form class="form-box" id="signupForm" method="post"
                  action="${pageContext.request.contextPath}/auth/register/addition"
                  style="display: none;" onsubmit="return validateForm()">

                <div class="home-icon-wrapper">
                    <a href="${pageContext.request.contextPath}/">
                        <img class="gohome" src="${pageContext.request.contextPath}/images/home.png" alt="홈으로" />
                    </a>
                </div>

                <h1>WELCOME!</h1>

                <!-- 아이디 -->
                <div class="form-group">
                    <input type="text" id="loginId" name="loginId" placeholder="아이디 (8~20자)" required minlength="8" maxlength="20">
                    <button type="button" onclick="checkId()">중복확인</button>
                </div>
                <span id="idStatus"></span>

                <!-- 이메일 인증 -->
                <div class="form-group">
                    <input type="email" id="email" name="email" placeholder="인증 이메일" required />
                    <button type="button" onclick="sendEmailCode()">인증요청</button>
                </div>
                <div class="form-group">
                    <input type="text" id="emailCode" name="emailAuthCode" placeholder="인증번호 입력" />
                    <button type="button" id="verifyBtn" onclick="verifyEmailCode()">인증확인</button>
                </div>
                <span id="emailStatus"></span>
                <span id="countdown"></span>

                <!-- 비밀번호 -->
                <input type="password" id="password" name="password" placeholder="비밀번호 (영문+숫자+특수문자 10자 이상)" required />
                <input type="password" id="passwordConfirm" placeholder="비밀번호 확인" required onkeyup="checkPasswordMatch()" />
                <span id="pwStatus"></span>

                <!-- 닉네임 -->
                <div class="form-group">
                    <input type="text" id="nickname" name="nickname" placeholder="닉네임" required />
                    <button type="button" onclick="checkNickname()">중복확인</button>
                </div>
                <span id="nicknameStatus"></span>

                <button class="submit-btn" type="submit">가입하기</button>
                <span class="toggle-link" onclick="toggleForm('login')">로그인</span>
            </form>
        </div>
    </div>
</div>

<script>
    /* ===== 이미지 슬라이드 ===== */
    document.addEventListener('DOMContentLoaded', function () {
        const slides = document.querySelectorAll('.slide-image');
        let currentSlide = 0;
        slides[currentSlide].classList.add('active');
        setInterval(() => {
            slides[currentSlide].classList.remove('active');
            currentSlide = (currentSlide + 1) % slides.length;
            slides[currentSlide].classList.add('active');
        }, 5000);
    });

    /* ===== 회원가입 유효성 검증 ===== */
    let emailVerified = false;
    let nicknameChecked = false;
    let idChecked = false;
    let timerInterval;

    function toggleForm(mode) {
        const loginForm = document.getElementById('loginForm');
        const signupForm = document.getElementById('signupForm');
        if (mode === 'signup') {
            loginForm.style.display = 'none';
            signupForm.style.display = 'block';
        } else {
            loginForm.style.display = 'block';
            signupForm.style.display = 'none';
        }
    }

    function validateForm() {
        const pw = document.getElementById('password').value;
        const pwc = document.getElementById('passwordConfirm').value;

        const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[~!@#$%^&*()_+]).{10,}$/;
        if (!pwRegex.test(pw)) {
            alert("비밀번호는 영문, 숫자, 특수문자를 포함해 10자 이상이어야 합니다.");
            return false;
        }

        if (pw !== pwc) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }
        if (!emailVerified) {
            alert("이메일 인증을 완료해주세요.");
            return false;
        }
        if (!nicknameChecked) {
            alert("닉네임 중복 확인을 완료해주세요.");
            return false;
        }
        if (!idChecked) {
            alert("아이디 중복 확인을 완료해주세요.");
            return false;
        }
        return true;
    }

    /* ===== Ajax 요청 (경로 수정 완료) ===== */
    function checkId() {
        const id = document.getElementById('loginId').value.trim();
        if (id === "") return alert("아이디를 입력해주세요.");

        fetch('${pageContext.request.contextPath}/auth/check-id?loginId=' + encodeURIComponent(id))
            .then(res => res.json())
            .then(result => {
                if (result) {
                    idChecked = true;
                    document.getElementById('idStatus').textContent = "사용 가능한 아이디입니다.";
                    document.getElementById('idStatus').style.color = "green";
                } else {
                    idChecked = false;
                    document.getElementById('idStatus').textContent = "이미 사용 중인 아이디입니다.";
                    document.getElementById('idStatus').style.color = "red";
                }
            });
    }

    function checkNickname() {
        const nickname = document.getElementById('nickname').value.trim();
        if (nickname === "") return alert("닉네임을 입력해주세요.");

        fetch('${pageContext.request.contextPath}/auth/check-nickname?nickname=' + encodeURIComponent(nickname))
            .then(res => res.json())
            .then(result => {
                if (result) {
                    nicknameChecked = true;
                    document.getElementById('nicknameStatus').textContent = "사용 가능한 닉네임입니다.";
                    document.getElementById('nicknameStatus').style.color = "green";
                } else {
                    nicknameChecked = false;
                    document.getElementById('nicknameStatus').textContent = "이미 사용 중인 닉네임입니다.";
                    document.getElementById('nicknameStatus').style.color = "red";
                }
            });
    }

    function sendEmailCode() {
        const email = document.getElementById('email').value.trim();
        if (email === "") return alert("이메일을 입력해주세요.");

        fetch('${pageContext.request.contextPath}/auth/send-email-code', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'email=' + encodeURIComponent(email)
        })
            .then(res => res.text())
            .then(result => {
                alert("인증번호가 이메일로 전송되었습니다.");
                emailVerified = false;
                startCountdown(300);
            })
            .catch(() => alert("서버 오류가 발생했습니다."));
    }

    function verifyEmailCode() {
        const emailCode = document.getElementById('emailCode').value.trim();
        const statusEl = document.getElementById('emailStatus');
        const countdownEl = document.getElementById('countdown');
        const emailCodeInput = document.getElementById('emailCode');

        if (emailCode === "") {
            alert("인증번호를 입력해주세요.");
            return;
        }

        fetch('${pageContext.request.contextPath}/auth/verify-email-code', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'code=' + encodeURIComponent(emailCode)
        })
            .then(res => res.json())
            .then(result => {
                if (result === true) {
                    emailVerified = true;
                    statusEl.textContent = "이메일 인증 완료 ✅";
                    statusEl.style.color = "green";

                    // 인증번호 입력창 잠금
                    emailCodeInput.readOnly = true;
                    emailCodeInput.style.backgroundColor = "#eee";
                    emailCodeInput.style.color = "#555";

                    const verifyBtn = document.querySelector('button[onclick="verifyEmailCode()"]');
                    verifyBtn.disabled = true;
                    verifyBtn.style.backgroundColor = "#aaa";
                    verifyBtn.style.cursor = "not-allowed";

                    // 타이머 종료 + 숨김
                    if (timerInterval) clearInterval(timerInterval);
                    if (countdownEl) {
                        countdownEl.textContent = "";
                        countdownEl.style.display = "none";
                    }
                } else {
                    emailVerified = false;
                    statusEl.textContent = "❌ 인증번호가 일치하지 않습니다.";
                    statusEl.style.color = "red";
                }
            })
            .catch(() => {
                alert("서버 오류가 발생했습니다.");
            });
    }


    /* ===== 비밀번호 확인 ===== */
    function checkPasswordMatch() {
        const pw = document.getElementById('password').value;
        const pwc = document.getElementById('passwordConfirm').value;
        const status = document.getElementById('pwStatus');
        if (pw === "" || pwc === "") {
            status.textContent = "";
            return;
        }
        if (pw === pwc) {
            status.textContent = "비밀번호가 일치합니다.";
            status.style.color = "green";
        } else {
            status.textContent = "비밀번호가 일치하지 않습니다.";
            status.style.color = "red";
        }
    }

    function startCountdown(duration) {
        let timeLeft = duration;
        const countdownDisplay = document.getElementById("countdown");
        clearInterval(timerInterval);

        timerInterval = setInterval(() => {
            const minutes = String(Math.floor(timeLeft / 60)).padStart(2, '0');
            const seconds = String(timeLeft % 60).padStart(2, '0');
            countdownDisplay.textContent = "남은 인증 유효시간 " + minutes + ":" + seconds;

            if (timeLeft-- <= 0) {
                clearInterval(timerInterval);
                countdownDisplay.textContent = "인증 유효시간 만료됨";
                alert("인증 유효시간이 만료되었습니다. 다시 요청해주세요.");
            }
        }, 1000);
    }

    /* ===== 페이지 로드 시 mode 파라미터 처리 ===== */
    window.onload = function () {
        const params = new URLSearchParams(window.location.search);
        const mode = params.get("mode");
        if (mode === "signup") {
            toggleForm('signup');
        } else {
            toggleForm('login');
        }
    };
</script>
</body>
</html>
