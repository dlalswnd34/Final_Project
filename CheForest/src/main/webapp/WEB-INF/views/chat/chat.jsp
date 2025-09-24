<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>chat test</title>
</head>
<body>

<h4>와글와글 요리이야기</h4>

<div id="chatBox" style="border:1px solid #000000; width:300px; height:350px; overflow-y:scroll;"></div>

<input type="text" id="msgInput" placeholder="메시지를 입력하세요..." onkeydown="handleKey(event)" style="width:300px; height:30px;">


<%--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--%>


<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>

<script>
  // let : 변수
  // const : 상수
  // function : 함수
  // document : html 접근 (dom)
  // async : 비동기 처리

  let stompClient = null;
  // 연결
  function connect() {
    const socket = new SockJS("/ws")
    stompClient = Stomp.over(socket);

    stompClient.connect({}, () => {
      // 구독
      stompClient.subscribe("/sub/message", (msg) => {
        const chat = JSON.parse(msg.body);
        showMessage(chat)
      })

      loadChatHistory();
    });
  }

  // 이전 채팅 불러오기
  async function loadChatHistory() {
    const res = await fetch("/chat/history");
    const messages = await res.json();
    messages.forEach(chat => {
      showMessage(chat);
    });
  }

  // 출력
  function showMessage(chat) {
    const chatBox = document.getElementById("chatBox");

    const msgDiv = document.createElement("div");

    // 프로필 이미지
    const img = document.createElement("img");
    img.src = chat.profile || "/image/default.png";
    img.width = 25; img.height = 25;
    img.style.borderRadius = "50%";

    // 닉네임 + 메시지
    const span = document.createElement("span");
    span.textContent = chat.sender + ": " + chat.message + " " + chat.time;

    msgDiv.appendChild(img);
    msgDiv.appendChild(span);

    chatBox.appendChild(msgDiv);
    chatBox.scrollTop = chatBox.scrollHeight;
  }

  // 발행
  function sendMessage() {
    const input = document.getElementById("msgInput").value.trim();

    if (!input) {
      alert("메시지를 입력하세요.");
      return;
    }

    const message = {
      message: input
    };
    stompClient.send("/pub/message", {}, JSON.stringify(message));
    document.getElementById("msgInput").value = "";
  }

  // 엔터키로 전송
  function handleKey(event) {
    if (event.key === "Enter") {
      sendMessage();
      event.preventDefault();
    }
  }

  connect();

</script>
</body>
</html>

