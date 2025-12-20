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
                    <!-- ⭐ KIỂM TRA KHÔNG CÓ COURSE -->
                    <c:if test="${empty courses}">
                        <div class="text-center py-16">
                            <svg class="w-24 h-24 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                  d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                            </svg>
                            <h3 class="text-xl font-bold text-gray-700 mb-2">Chưa có khóa học nào</h3>
                            <p class="text-gray-500 mb-6">Bạn cần tạo khóa học trước khi có thể tạo bài test.</p>
                            <a href="${pageContext.request.contextPath}/instructor/courses" 
                               class="inline-flex items-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                                </svg>
                                Tạo khóa học mới
                            </a>
                        </div>
                    </c:if>

                    <!-- ⭐ CÓ COURSE → HIỂN THỊ FORM -->
                    <c:if test="${not empty courses}">
                        <form method="GET" action="${pageContext.request.contextPath}/instructor/test" class="mb-8">
                            <div class="bg-gradient-to-r from-blue-50 to-indigo-50 p-6 rounded-lg border border-blue-200">
                                <label class="block text-sm font-semibold text-gray-700 mb-3 flex items-center">
                                    <svg class="w-5 h-5 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13
                                          C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13
                                          C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13
                                          C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                                    </svg>
                                    Chọn khóa học
                                </label>

                                <select name="courseId"
                                        onchange="this.form.submit()"
                                        required
                                        <c:if test="${not empty editTest}">disabled</c:if>
                                            class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm
                                            focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all
                                        <c:if test='${not empty editTest}'>bg-gray-100 cursor-not-allowed</c:if>">

                                            <option value="">-- Chọn khóa học để bắt đầu --</option>
                                        <c:forEach items="${courses}" var="c">
                                            <option value="${c.id}" <c:if test="${selectedCourse == c.id}">selected</c:if>>
                                                ${c.title}
                                            </option>
                                        </c:forEach>
                                </select>

                                <c:if test="${not empty editTest}">
                                    <input type="hidden" name="courseId" value="${selectedCourse}">
                                </c:if>
                            </div>
                        </form>

                        <!-- ⭐ KIỂM TRA KHÔNG CÓ SECTION -->
                        <c:if test="${not empty selectedCourse and empty sections}">
                            <div class="bg-yellow-50 border-l-4 border-yellow-400 p-6 rounded-lg mb-8">
                                <div class="flex items-start">
                                    <svg class="w-6 h-6 text-yellow-600 mr-3 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                                    </svg>
                                    <div>
                                        <h3 class="text-lg font-bold text-yellow-800 mb-2">Khóa học chưa có section nào</h3>
                                        <p class="text-yellow-700 mb-4">Bạn cần tạo ít nhất một section (bài học) trong khóa học này trước khi tạo bài test.</p>
                                        <a href="${pageContext.request.contextPath}/instructor/courses?cid=${selectedCourse}&type=edit" 
                                           class="inline-flex items-center px-4 py-2 bg-yellow-600 text-white font-semibold rounded-lg hover:bg-yellow-700 transition">
                                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                                            </svg>
                                            Thêm Section cho khóa học
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- ⭐ CÓ SECTION → HIỂN THỊ FORM TẠO TEST -->
                        <c:if test="${not empty sections or not empty editTest}">
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
                                        <input type="number" name="minGrade" required value="${editTest.minGrade}" min="40" max="100"
                                               class="flex-1 px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                               placeholder="50">
                                    </div>
                                </div>

                                <!-- Question Selection Section -->
                                <div class="border-l-4 border-purple-500 pl-4 mt-8 mb-6">
                                    <h3 class="text-lg font-bold text-gray-800 mb-4">Cấu hình câu hỏi</h3>
                                </div>

                                <!-- ⭐ KIỂM TRA KHÔNG CÓ QUIZ -->
                                <c:choose>
                                    <c:when test="${empty quizList}">
                                        <div class="bg-orange-50 border-l-4 border-orange-400 p-6 rounded-lg">
                                            <div class="flex items-start">
                                                <svg class="w-6 h-6 text-orange-600 mr-3 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
                                                </svg>
                                                <div>
                                                    <h3 class="text-lg font-bold text-orange-800 mb-2">Chưa có câu hỏi nào</h3>
                                                    <p class="text-orange-700">Không có câu hỏi (quiz) nào phù hợp với category của khóa học này. Vui lòng tạo quiz trước.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
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
                                                    <input type="number" name="randomCount" min="1" max="${quizList.size()}" 
                                                       placeholder="Tối đa: ${quizList.size()}"
                                                       class="flex-1 px-4 py-3 border-2 border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                                                <span class="text-sm text-gray-600">Có ${quizList.size()} câu hỏi</span>
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
                                    </c:otherwise>
                                </c:choose>

                                <div class="flex justify-end pt-6 border-t border-gray-200">
                                    <button type="submit" name="action"
                                            value="<c:choose><c:when test='${not empty editTest}'>update</c:when><c:otherwise>create</c:otherwise></c:choose>"
                                                    class="px-8 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white font-semibold rounded-lg hover:from-blue-700 hover:to-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5"
                                            <c:if test="${empty quizList}">disabled</c:if>>
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
                        </c:if>
                    </c:if>
                </div>
            </div>
        </div>

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />
    </body>
</html>