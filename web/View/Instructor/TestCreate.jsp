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

<<<<<<< Updated upstream
        .row label {
            width: 160px;
            font-weight: bold;
            color: #444;
        }
=======
        <div class="container mx-auto px-4 py-8 max-w-5xl">

            <!-- LIST TEST -->
            <div class="bg-white rounded-xl shadow-xl overflow-hidden mb-8">
                <div class="bg-gradient-to-r from-indigo-600 to-purple-700 px-8 py-6">
                    <h2 class="text-2xl font-bold text-white flex items-center">
                        <svg class="w-7 h-7 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                        Danh sách Test
                    </h2>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead>
                            <tr class="bg-gray-50 border-b border-gray-200">
                                <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">ID</th>
                                <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Code</th>
                                <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Title</th>
                                <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Action</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach items="${testList}" var="t">
                                <tr class="hover:bg-blue-50 transition-colors">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${t.id}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700 font-semibold">${t.code}</td>
                                    <td class="px-6 py-4 text-sm text-gray-700">${t.title}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm">
                                        <a href="${pageContext.request.contextPath}/instructor/test?action=edit&id=${t.id}"
                                           class="inline-flex items-center px-4 py-2 bg-blue-100 text-blue-700 font-semibold rounded-lg hover:bg-blue-200 transition-colors">
                                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                            </svg>
                                            Sửa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- MESSAGES AT TOP -->
            <c:if test="${not empty error}">
                <div class="mb-6 p-4 bg-red-50 border-l-4 border-red-500 text-red-800 rounded-lg shadow-sm animate-fade-in">
                    <div class="flex items-center">
                        <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                        </svg>
                        <span class="font-semibold">${error}</span>
                    </div>
                </div>
            </c:if>
>>>>>>> Stashed changes

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

<<<<<<< Updated upstream
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
=======
                    <!-- FORM POST TẠO/UPDATE -->
                    <form method="POST" action="${pageContext.request.contextPath}/instructor/test" class="space-y-6">
                        <input type="hidden" name="courseId" value="${selectedCourse}">
                        <c:if test="${not empty editTest}">
                            <input type="hidden" name="id" value="${editTest.id}">
                        </c:if>
>>>>>>> Stashed changes

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

<<<<<<< Updated upstream
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
=======
                        <!-- Section -->
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-center">
                            <label class="font-semibold text-gray-700">Section</label>
                            <div class="md:col-span-2">
                                <select name="sectionId" required 
                                        class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all">
                                    <option value="">-- Chọn Section --</option>
                                    <c:forEach items="${sections}" var="s">
                                        <option value="${s.id}" <c:if test="${not empty editTest && editTest.courseSectionId == s.id}">selected</c:if>>
                                            ${s.title}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <!-- Test Code -->
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-center">
                            <label class="font-semibold text-gray-700">Test Code</label>
                            <div class="md:col-span-2">
                                <input type="text" name="code" required value="${editTest.code}"
                                       class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                       placeholder="VD: TEST001">
                            </div>
                        </div>

                        <!-- Title -->
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-center">
                            <label class="font-semibold text-gray-700">Tiêu đề</label>
                            <div class="md:col-span-2">
                                <input type="text" name="title" required value="${editTest.title}"
                                       class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                       placeholder="Nhập tiêu đề bài test">
                            </div>
                        </div>

                        <!-- Description -->
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-start">
                            <label class="font-semibold text-gray-700 pt-3">Mô tả</label>
                            <div class="md:col-span-2">
                                <textarea name="description" required rows="4"
                                          class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all resize-none"
                                          placeholder="Mô tả chi tiết về bài test...">${editTest.description}</textarea>
                            </div>
                        </div>

                        <!-- Duration & MinGrade -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="flex items-center gap-4">
                                <label class="font-semibold text-gray-700 whitespace-nowrap">Thời gian (phút)</label>
                                <input type="number" name="duration" required value="${editTest.timeInterval}"
                                       class="flex-1 px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                       placeholder="60">
                            </div>
>>>>>>> Stashed changes

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

<<<<<<< Updated upstream
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
=======
                        <!-- SUBMIT BUTTON -->
                        <div class="mt-6">
                            <button type="submit" class="w-full md:w-auto px-8 py-3 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-lg shadow-md transition-colors">
                                <c:choose>
                                    <c:when test="${not empty editTest}">Cập nhật Test</c:when>
                                    <c:otherwise>Tạo Test</c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />
    </body>
>>>>>>> Stashed changes
</html>
