<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý bài Test</title>
        <jsp:include page="/layout/import.jsp" />

        <script>
            function toggleMode() {
                let mode = document.querySelector("input[name='mode']:checked").value;

                document.getElementById("manualQuizBox").style.display = (mode === "custom") ? "block" : "none";
                document.getElementById("randomBox").style.display = (mode === "random") ? "flex" : "none";
            }

            window.onload = toggleMode;
        </script>
    </head>

    <body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
        <jsp:include page="/layout/header.jsp" />

        <div class="container mx-auto px-4 py-8 max-w-5xl">
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

            <c:if test="${not empty success}">
                <div class="mb-6 p-4 bg-green-50 border-l-4 border-green-500 text-green-800 rounded-lg shadow-sm animate-fade-in">
                    <div class="flex items-center">
                        <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="font-semibold">${success}</span>
                    </div>
                </div>
            </c:if>

            <!-- CREATE/UPDATE FORM CONTAINER -->
            <div class="bg-white rounded-xl shadow-xl overflow-hidden mb-8">
                <!-- Header with gradient -->
                <div class="bg-gradient-to-r from-blue-600 to-blue-700 px-8 py-6">
                    <h1 class="text-3xl font-bold text-white flex items-center">
                        <svg class="w-8 h-8 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                        <c:choose>
                            <c:when test="${not empty editTest}">Cập nhật bài Test</c:when>
                            <c:otherwise>Tạo bài Test mới</c:otherwise>
                        </c:choose>
                    </h1>
                    <p class="text-blue-100 mt-2">Quản lý và cấu hình bài kiểm tra cho khóa học</p>
                    <div class="flex justify-end mb-4">
                        <a href="${pageContext.request.contextPath}/managerTest"
                           class="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition">
                            ⬅ Quay về danh sách Test
                        </a>
                    </div>

                </div>

                <div class="p-8">
                    <!-- CHỌN KHÓA HỌC -->
                    <form method="GET" action="${pageContext.request.contextPath}/instructor/test" class="mb-8">
                        <div class="bg-gradient-to-r from-blue-50 to-indigo-50 p-6 rounded-lg border border-blue-200">
                            <label class="block text-sm font-semibold text-gray-700 mb-3 flex items-center">
                                <svg class="w-5 h-5 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                                </svg>
                                Chọn khóa học
                            </label>
                            <select name="courseId" onchange="this.form.submit()" required 
                                    class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all bg-white">
                                <option value="">-- Chọn khóa học để bắt đầu --</option>
                                <c:forEach items="${courses}" var="c">
                                    <option value="${c.id}" <c:if test="${selectedCourse == c.id}">selected</c:if>>
                                        ${c.title}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>

                    <!-- FORM POST TẠO/UPDATE -->
                    <form method="POST" action="${pageContext.request.contextPath}/instructor/test" class="space-y-6">

                        <input type="hidden" name="courseId" value="${selectedCourse}">
                        <c:if test="${not empty editTest}">
                            <input type="hidden" name="id" value="${editTest.id}">
                        </c:if>

                        <!-- Basic Information Section -->
                        <div class="border-l-4 border-blue-500 pl-4 mb-6">
                            <h3 class="text-lg font-bold text-gray-800 mb-4">Thông tin cơ bản</h3>
                        </div>

                        <!-- SECTION -->
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

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-center">
                            <label class="font-semibold text-gray-700">Test Code</label>
                            <div class="md:col-span-2">
                                <input type="text" name="code" required value="${editTest.code}"
                                       class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                       placeholder="VD: TEST001">
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-center">
                            <label class="font-semibold text-gray-700">Tiêu đề</label>
                            <div class="md:col-span-2">
                                <input type="text" name="title" required value="${editTest.title}"
                                       class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                       placeholder="Nhập tiêu đề bài test">
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-start">
                            <label class="font-semibold text-gray-700 pt-3">Mô tả</label>
                            <div class="md:col-span-2">
                                <textarea name="description" required rows="4"
                                          class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all resize-none"
                                          placeholder="Mô tả chi tiết về bài test...">${editTest.description}</textarea>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="flex items-center gap-4">
                                <label class="font-semibold text-gray-700 whitespace-nowrap">Thời gian (phút)</label>
                                <input type="number" name="duration" required value="${editTest.timeInterval}"
                                       class="flex-1 px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                       placeholder="60">
                            </div>

                            <div class="flex items-center gap-4">
                                <label class="font-semibold text-gray-700 whitespace-nowrap">Điểm tối thiểu</label>
                                <input type="number" name="minGrade" required value="${editTest.minGrade}"
                                       class="flex-1 px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                       placeholder="50">
                            </div>
                        </div>

                        <!-- Question Selection Section -->
                        <div class="border-l-4 border-purple-500 pl-4 mt-8 mb-6">
                            <h3 class="text-lg font-bold text-gray-800 mb-4">Cấu hình câu hỏi</h3>
                        </div>

                        <div class="bg-gradient-to-r from-purple-50 to-pink-50 p-6 rounded-lg border border-purple-200">
                            <div class="flex gap-6 mb-4">
                                <label class="flex items-center cursor-pointer group">
                                    <input type="radio" name="mode" value="random" onclick="toggleMode()"
                                           <c:if test='${empty selectedQuizIds}'>checked</c:if>
                                               class="w-4 h-4 text-blue-600 focus:ring-2 focus:ring-blue-500">
                                           <span class="ml-3 font-semibold text-gray-700 group-hover:text-blue-600 transition-colors">
                                               🎲 Random số lượng câu
                                           </span>
                                    </label>

                                    <label class="flex items-center cursor-pointer group">
                                        <input type="radio" name="mode" value="custom" onclick="toggleMode()"
                                        <c:if test='${not empty selectedQuizIds}'>checked</c:if>
                                            class="w-4 h-4 text-blue-600 focus:ring-2 focus:ring-blue-500">
                                        <span class="ml-3 font-semibold text-gray-700 group-hover:text-blue-600 transition-colors">
                                            ✋ Chọn thủ công
                                        </span>
                                    </label>
                                </div>

                                <!-- RANDOM MODE BOX -->
                                <div id="randomBox" class="hidden items-center gap-4 mt-4">
                                    <label class="font-semibold text-gray-700">Số câu hỏi:</label>
                                    <input type="number" name="randomCount" min="1" placeholder="Ví dụ: 10"
                                           class="flex-1 px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                                </div>

                                <!-- CUSTOM MODE BOX -->
                                <div id="manualQuizBox" class="hidden bg-white p-4 rounded-lg max-h-64 overflow-y-auto border-2 border-gray-200 mt-4 shadow-inner">
                                    <p class="text-sm text-gray-600 mb-3 font-medium">Chọn các câu hỏi bạn muốn đưa vào bài test:</p>
                                <c:forEach items="${quizList}" var="q">
                                    <label class="flex items-start p-3 mb-2 cursor-pointer hover:bg-blue-50 rounded-lg transition-colors border border-transparent hover:border-blue-200">
                                        <input type="checkbox" name="quizId" value="${q.id}"
                                               <c:if test="${not empty selectedQuizIds && selectedQuizIds.contains(q.id)}">checked</c:if>
                                                   class="mt-1 w-4 h-4 text-blue-600 focus:ring-2 focus:ring-blue-500 rounded">
                                               <span class="ml-3 text-sm text-gray-700">
                                                   <span class="font-semibold text-blue-600">[${q.id}]</span> ${q.question}
                                        </span>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="flex justify-end pt-6 border-t border-gray-200">
                            <button type="submit" name="action"
                                    value="<c:choose><c:when test='${not empty editTest}'>update</c:when><c:otherwise>create</c:otherwise></c:choose>"
                                            class="px-8 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white font-semibold rounded-lg hover:from-blue-700 hover:to-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                                    <c:choose>
                                        <c:when test="${not empty editTest}">
                                            <span class="flex items-center">
                                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-8l-4-4m0 0L8 8m4-4v12"/>
                                                </svg>
                                                Cập nhật Test
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="flex items-center">
                                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                                                </svg>
                                                Tạo Test Mới
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                            </button>
                        </div>

                    </form>
                </div>
            </div>

            <!-- LIST TEST -->
            <div class="bg-white rounded-xl shadow-xl overflow-hidden">
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
                                        <c:choose>

                                            <c:when test="${t.courseSectionId == 0}">
                                                <a href="${pageContext.request.contextPath}/instructor/test-course?action=edit&id=${t.id}"
                                                   class="btn-edit">Sửa</a>
                                            </c:when>

                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/instructor/test?action=edit&id=${t.id}"
                                                   class="btn-edit">Sửa</a>
                                            </c:otherwise>

                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />
    </body>
</html>