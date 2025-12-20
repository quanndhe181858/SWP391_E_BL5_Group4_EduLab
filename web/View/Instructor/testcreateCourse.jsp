<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>Tạo Test cho Khóa học</title>
        <jsp:include page="/layout/import.jsp" />

        <script>
            function toggleMode() {
                const mode = document.querySelector("input[name='mode']:checked")?.value;
                document.getElementById("manualQuizBox").style.display = (mode === "custom") ? "block" : "none";
                document.getElementById("randomBox").style.display = (mode === "random") ? "flex" : "none";
            }

            function validateForm(event) {
                const mode = document.querySelector("input[name='mode']:checked").value;

                if (mode === "random") {
                    const randomCount = document.querySelector("input[name='randomCount']").value;

                    if (!randomCount || randomCount < 1) {
                        event.preventDefault();
                        alert("⚠️ Vui lòng nhập số lượng câu hỏi (tối thiểu 1 câu)!");
                        return false;
                    }
                } else if (mode === "custom") {
                    const checkedBoxes = document.querySelectorAll("input[name='quizId']:checked");

                    if (checkedBoxes.length === 0) {
                        event.preventDefault();
                        alert("⚠️ Vui lòng chọn ít nhất 1 câu hỏi!");
                        return false;
                    }
                }

                return true;
            }


            window.onload = toggleMode;
        </script>
    </head>

    <body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">

        <jsp:include page="/layout/header.jsp" />

        <div class="max-w-5xl mx-auto px-6 py-10">
            <div class="bg-gradient-to-r from-blue-600 to-blue-700 p-6 rounded-xl shadow-lg mb-6">
                <h1 class="text-3xl text-white font-semibold flex items-center">
                    <svg class="w-8 h-8 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    <c:choose>
                        <c:when test="${not empty editTest}">Cập nhật Test cho Khóa học</c:when>
                        <c:otherwise>Tạo Test cho Khóa học</c:otherwise>
                    </c:choose>
                </h1>
                <p class="text-blue-100 mt-1">Test cuối khóa áp dụng cho toàn bộ khóa học</p>
                <div class="flex justify-end mt-4">
                    <a href="${pageContext.request.contextPath}/managerTest"
                       class="px-4 py-2 bg-white/20 backdrop-blur-sm text-white rounded-lg hover:bg-white/30 transition">
                        ⬅ Quay về danh sách Test
                    </a>
                </div>
            </div>

            <!-- MESSAGES -->
            <c:if test="${not empty error}">
                <div class="mb-6 p-4 bg-red-50 border-l-4 border-red-500 text-red-800 rounded-lg shadow-sm animate-fade-in">
                    <div class="flex items-center">
                        <svg class="w-5 h-5 mr-2 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                        </svg>
                        <span class="font-semibold">${error}</span>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="mb-6 p-4 bg-green-50 border-l-4 border-green-500 text-green-800 rounded-lg shadow-sm animate-fade-in">
                    <div class="flex items-center">
                        <svg class="w-5 h-5 mr-2 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="font-semibold">${success}</span>
                    </div>
                </div>
            </c:if>

            <!-- ⭐ KIỂM TRA KHÔNG CÓ COURSE -->
            <c:if test="${empty courses}">
                <div class="bg-white rounded-xl shadow-xl p-16 text-center">
                    <svg class="w-24 h-24 mx-auto text-gray-300 mb-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                          d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                    </svg>
                    <h3 class="text-2xl font-bold text-gray-700 mb-3">Chưa có khóa học nào</h3>
                    <p class="text-gray-500 mb-8 max-w-md mx-auto">
                        Bạn cần tạo khóa học trước khi có thể tạo bài test cuối khóa. 
                        Bài test cuối khóa sẽ đánh giá kiến thức tổng hợp của học viên.
                    </p>
                    <a href="${pageContext.request.contextPath}/instructor/courses" 
                       class="inline-flex items-center px-8 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white font-semibold rounded-lg hover:from-blue-700 hover:to-blue-800 transition shadow-lg hover:shadow-xl">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                        </svg>
                        Tạo khóa học mới
                    </a>
                </div>
            </c:if>

            <!-- ⭐ CÓ COURSE → HIỂN THỊ FORM -->
            <c:if test="${not empty courses}">
                <!-- COURSE SELECTOR -->
                <form method="GET" action="${pageContext.request.contextPath}/instructor/test-course" 
                      class="bg-white p-6 rounded-xl shadow-lg mb-6">
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
                                <c:if test="${not empty editTest}">disabled</c:if>
                                    required
                                    class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm
                                    focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all
                                <c:if test='${not empty editTest}'>bg-gray-100 cursor-not-allowed</c:if>">

                                    <option value="">-- Chọn khóa học để tạo test cuối khóa --</option>
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

                <!-- ⭐ KIỂM TRA KHÔNG CÓ QUIZ -->
                <c:if test="${not empty selectedCourse and empty quizList}">
                    <div class="bg-white rounded-xl shadow-lg p-12">
                        <div class="bg-orange-50 border-l-4 border-orange-400 p-6 rounded-lg">
                            <div class="flex items-start">
                                <svg class="w-6 h-6 text-orange-600 mr-3 flex-shrink-0 mt-1" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
                                </svg>
                                <div class="flex-1">
                                    <h3 class="text-lg font-bold text-orange-800 mb-2">Chưa có câu hỏi nào</h3>
                                    <p class="text-orange-700 mb-4">
                                        Không có câu hỏi (quiz) nào phù hợp với danh mục của khóa học này. 
                                        Bạn cần tạo câu hỏi trước khi tạo bài test.
                                    </p>
                                    <a href="${pageContext.request.contextPath}/instructor/quiz" 
                                       class="inline-flex items-center px-4 py-2 bg-orange-600 text-white font-semibold rounded-lg hover:bg-orange-700 transition">
                                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                                        </svg>
                                        Tạo câu hỏi mới
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- ⭐ CÓ QUIZ → HIỂN THỊ FORM TẠO TEST -->
                <c:if test="${not empty quizList or not empty editTest}">
                    <!-- MAIN FORM CREATE / UPDATE -->
                    <form method="POST" action="${pageContext.request.contextPath}/instructor/test-course"
                          class="bg-white p-8 rounded-xl shadow-lg space-y-6"
                          onsubmit="return validateForm(event)"
                          >

                        <input type="hidden" name="testScope" value="course">
                        <input type="hidden" name="sectionId" value="0">
                        <input type="hidden" name="courseId" value="${selectedCourse}">

                        <c:if test="${not empty editTest}">
                            <input type="hidden" name="id" value="${editTest.id}">
                        </c:if>

                        <!-- Basic Information Section -->
                        <div class="border-l-4 border-blue-500 pl-4 mb-6">
                            <h3 class="text-lg font-bold text-gray-800 mb-1">Thông tin cơ bản</h3>
                            <p class="text-sm text-gray-600">Cấu hình thông tin chi tiết cho bài test</p>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block font-semibold text-gray-700 mb-2">Test Code</label>
                                <input type="text" name="code" required
                                       value="${editTest.code}"
                                       class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm
                                       focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                       placeholder="VD: FINAL001">
                            </div>
                            <div>
                                <label class="block font-semibold text-gray-700 mb-2">Tiêu đề</label>
                                <input type="text" name="title" required
                                       value="${editTest.title}"
                                       class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm
                                       focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                       placeholder="Nhập tiêu đề bài test">
                            </div>
                        </div>

                        <div>
                            <label class="block font-semibold text-gray-700 mb-2">Mô tả</label>
                            <textarea name="description" rows="4" required
                                      class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm
                                      focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all resize-none"
                                      placeholder="Mô tả chi tiết về bài test cuối khóa...">${editTest.description}</textarea>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block font-semibold text-gray-700 mb-2">Thời gian (phút)</label>
                                <input type="number" name="duration" required min="1"
                                       value="${editTest.timeInterval}"
                                       class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm
                                       focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                       placeholder="60">
                            </div>
                            <div>
                                <label class="block font-semibold text-gray-700 mb-2">Điểm tối thiểu</label>
                                <input type="number" name="minGrade" required min="40" max="100"
                                       value="${editTest.minGrade}"
                                       class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-sm
                                       focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                       placeholder="50">
                            </div>
                        </div>

                        <!-- Question Selection Section -->
                        <div class="border-l-4 border-purple-500 pl-4 mt-8 mb-6">
                            <h3 class="text-lg font-bold text-gray-800 mb-1">Cấu hình câu hỏi</h3>
                            <p class="text-sm text-gray-600">Chọn cách thức thêm câu hỏi vào bài test</p>
                        </div>

                        <div class="bg-gradient-to-r from-purple-50 to-pink-50 p-6 rounded-lg border border-purple-200">
                            <div class="flex gap-6 mb-4">
                                <label class="flex items-center cursor-pointer group">
                                    <input type="radio" name="mode" value="random" onclick="toggleMode()"
                                           <c:if test="${empty selectedQuizIds}">checked</c:if>
                                               class="w-4 h-4 text-blue-600 focus:ring-2 focus:ring-blue-500">
                                           <span class="ml-3 font-semibold text-gray-700 group-hover:text-blue-600 transition-colors">
                                               🎲 Random số lượng câu
                                           </span>
                                    </label>
                                    <label class="flex items-center cursor-pointer group">
                                        <input type="radio" name="mode" value="custom" onclick="toggleMode()"
                                        <c:if test="${not empty selectedQuizIds}">checked</c:if>
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
                                       class="flex-1 px-4 py-3 border-2 border-gray-300 rounded-lg text-sm
                                       focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                                <span class="text-sm text-gray-600 whitespace-nowrap">Có <strong>${quizList.size()}</strong> câu hỏi</span>
                            </div>

                            <!-- CUSTOM MODE BOX -->
                            <div id="manualQuizBox" class="hidden bg-white p-4 rounded-lg max-h-64 overflow-y-auto border-2 border-gray-200 mt-4 shadow-inner">
                                <p class="text-sm text-gray-600 mb-3 font-medium">Chọn các câu hỏi bạn muốn đưa vào bài test:</p>
                                <c:forEach items="${quizList}" var="q">
                                    <label class="flex items-start p-3 mb-2 cursor-pointer hover:bg-blue-50 rounded-lg transition-colors border border-transparent hover:border-blue-200">
                                        <input type="checkbox" name="quizId" value="${q.id}"
                                               <c:if test="${selectedQuizIds != null && selectedQuizIds.contains(q.id)}">checked</c:if>
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
                                            class="px-8 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white font-semibold rounded-lg
                                            hover:from-blue-700 hover:to-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300
                                            transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5"
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

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />

    </body>
</html>