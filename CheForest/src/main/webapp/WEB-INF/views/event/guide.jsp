<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>PDF 보기</title>
    <style>
        body { margin: 0; padding: 0; }
        iframe {
            width: 100%;
            height: 100vh; /* 화면 전체 높이 */
            border: none;
        }
    </style>
</head>
<body>

<iframe src="src/main/webapp/WEB-INF/view/guide.pdf" title="PDF 미리보기"></iframe>


</body>
</html>