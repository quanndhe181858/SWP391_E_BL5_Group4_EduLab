<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý bài Test</title>

    <style>
        body {
            font-family: Arial;
            background: #f4f6f9;
            padding: 25px;
        }

        .container {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.15);
            max-width: 900px;
            margin: auto;
        }

        .header-title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #333;
        }

        .row {
            margin-bottom: 14px;
            display: flex;
            align-items: center;
        }

        .row label {
            width: 160px;
            font-weight: bold;
            color: #444;
        }

        .row select, .row input, .row textarea {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        textarea {
            height: 90px;
        }

        .mode-box {
            margin: 10px 0 15px 0;
            display: flex;
            gap: 30px;
            font-size: 15px;
            font-weight: bold;
        }

        .quiz-list {
            background: #fafafa;
            border: 1px solid #ddd;
            padding: 10px 15px;
            border-radius: 6px;
            max-height: 180px;
            overflow-y: auto;
            display: none;
        }

        .random-box {
            display: none;
        }

        button {
            padding: 12px 25px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
            margin-top: 10px;
        }
        button:hover { background: #005fcc; }

        .test-table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        .test-table th, .test-table td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        .test-table th {
            background: #e9ecef;
        }

        .msg-error { color:red; font-weight:bold; }
        .msg-success { color:green; font-weight:bold; }

    </style>

    <script>
        function toggleMode() {
            let mode = document.querySelector("input[name='mode']:checked").value;

            document.getElementById("manualQuizBox").style.display = (mode === "custom") ? "block" : "none";
            document.getElementById("randomBox").style.display = (mode === "random") ? "block" : "none";
        }

        window.onload = toggleMode;
    </script>

</head>

<body>

<div class="container">

    <div class="header-title">
        <c:choose>
            <c:when test="${not empty editTest}">Cập nhật bài Test</c:when>
            <c:otherwise>Tạo bài Test mới</c:otherwise>
        </c:choose>
    </div>

    <!-- CHỌN KHÓA HỌC -->
    <form method="GET" action="${pageContext.request.contextPath}/instructor/test" class="row">
        <label>Khóa học:</label>
        <select name="courseId" onchange="this.form.submit()" required>
            <option value="">-- Chọn khóa học --</option>

            <c:forEach items="${courses}" var="c">
                <option value="${c.id}"
                        <c:if test="${selectedCourse == c.id}">selected</c:if>>
                    ${c.title}
                </option>
            </c:forEach>
        </select>
    </form>

    <!-- FORM POST TẠO/UPDATE -->
    <form method="POST" action="${pageContext.request.contextPath}/instructor/test">

        <input type="hidden" name="courseId" value="${selectedCourse}">
        <c:if test="${not empty editTest}">
            <input type="hidden" name="id" value="${editTest.id}">
        </c:if>

        <!-- SECTION -->
        <div class="row">
            <label>Section:</label>
            <select name="sectionId" required>
                <option value="">-- Chọn Section --</option>
                <c:forEach items="${sections}" var="s">
                    <option value="${s.id}"
                        <c:if test="${not empty editTest && editTest.courseSectionId == s.id}">selected</c:if>>
                        ${s.title}
                    </option>
                </c:forEach>
            </select>
        </div>

        <!-- INFO -->
        <div class="row">
            <label>Test Code:</label>
            <input type="text" name="code" required value="${editTest.code}">
        </div>

        <div class="row">
            <label>Title:</label>
            <input type="text" name="title" required value="${editTest.title}">
        </div>

        <div class="row">
            <label>Description:</label>
            <textarea name="description" required>${editTest.description}</textarea>
        </div>

        <div class="row">
            <label>Thời gian (phút):</label>
            <input type="number" name="duration" required value="${editTest.timeInterval}">
        </div>

        <div class="row">
            <label>Điểm tối thiểu:</label>
            <input type="number" name="minGrade" required value="${editTest.minGrade}">
        </div>

        <!-- MODE -->
        <h3 style="margin-top:20px;">Cách lấy câu hỏi:</h3>

        <div class="mode-box">
            <label>
                <input type="radio" name="mode" value="random"
                       onclick="toggleMode()"
                       <c:if test='${empty selectedQuizIds}'>checked</c:if>>
                Random số lượng câu
            </label>

            <label>
                <input type="radio" name="mode" value="custom"
                       onclick="toggleMode()"
                       <c:if test='${not empty selectedQuizIds}'>checked</c:if>>
                Chọn thủ công
            </label>
        </div>

        <!-- RANDOM MODE BOX -->
        <div id="randomBox" class="row random-box">
            <label>Số câu random:</label>
            <input type="number" name="randomCount" min="1" placeholder="Ví dụ: 10">
        </div>

        <!-- CUSTOM MODE BOX -->
        <div id="manualQuizBox" class="quiz-list">
            <c:forEach items="${quizList}" var="q">
                <label style="display:block; margin-bottom:5px;">
                    <input type="checkbox" name="quizId" value="${q.id}"
                           <c:if test="${not empty selectedQuizIds && selectedQuizIds.contains(q.id)}">checked</c:if>>
                    [${q.id}] ${q.question}
                </label>
            </c:forEach>
        </div>

        <button type="submit" name="action"
                value="<c:choose><c:when test='${not empty editTest}'>update</c:when><c:otherwise>create</c:otherwise></c:choose>">
            <c:choose>
                <c:when test="${not empty editTest}">Cập nhật</c:when>
                <c:otherwise>Tạo mới</c:otherwise>
            </c:choose>
        </button>

    </form>

</div>

<!-- LIST TEST -->
<div class="container">
    <h2>Danh sách Test</h2>

    <table class="test-table">
        <tr>
            <th>ID</th>
            <th>Code</th>
            <th>Title</th>
            <th>Action</th>
        </tr>

        <c:forEach items="${testList}" var="t">
            <tr>
                <td>${t.id}</td>
                <td>${t.code}</td>
                <td>${t.title}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/instructor/test?action=edit&id=${t.id}">
                        Sửa
                    </a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<!-- MESSAGES -->
<c:if test="${not empty error}">
    <div class="msg-error">${error}</div>
</c:if>

<c:if test="${not empty success}">
    <div class="msg-success">${success}</div>
</c:if>

</body>
</html>
