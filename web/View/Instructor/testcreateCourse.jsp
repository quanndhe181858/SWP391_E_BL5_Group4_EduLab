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
            window.onload = toggleMode;
        </script>
    </head>

    <body class="bg-gray-100 min-h-screen">

        <jsp:include page="/layout/header.jsp" />

        <div class="max-w-5xl mx-auto px-6 py-10">

            <!-- TITLE -->
            <div class="bg-gradient-to-r from-blue-600 to-blue-700 p-6 rounded-xl shadow-lg mb-6">
                <h1 class="text-3xl text-white font-semibold flex items-center">
                    <svg class="w-8 h-8 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    Tạo Test cho Khóa học
                </h1>
                <p class="text-blue-100 mt-1">Áp dụng cho toàn bộ khóa học</p>
                <div class="flex justify-end mb-4">
                    <a href="${pageContext.request.contextPath}/managerTest"
                       class="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition">
                        ⬅ Quay về danh sách Test
                    </a>
                </div>

            </div>

            <!-- ERROR / SUCCESS -->
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


            <form method="GET" action="${pageContext.request.contextPath}/instructor/test-course" 
                  class="bg-white p-4 rounded-lg shadow mb-8">

                <label class="font-semibold text-gray-700">Chọn khóa học</label>

                <select name="courseId"
                        onchange="this.form.submit()"
                        <c:if test="${not empty editTest}">disabled</c:if>
                            required
                            class="w-full px-4 py-3 border rounded-lg mt-2
                        <c:if test='${not empty editTest}'>bg-gray-100 cursor-not-allowed</c:if>">

                            <option value="">-- Chọn khóa học --</option>
                        <c:forEach items="${courses}" var="c">
                            <option value="${c.id}" <c:if test="${selectedCourse == c.id}">selected</c:if>>
                                ${c.title}
                            </option>
                        </c:forEach>
                </select>

                <c:if test="${not empty editTest}">
                    <input type="hidden" name="courseId" value="${selectedCourse}">
                </c:if>

            </form>


            <!-- MAIN FORM CREATE / UPDATE -->
            <form method="POST" action="${pageContext.request.contextPath}/instructor/test-course"
                  class="bg-white p-8 rounded-xl shadow-lg space-y-6">

                <input type="hidden" name="testScope" value="course">
                <input type="hidden" name="sectionId" value="0">
                <input type="hidden" name="courseId" value="${selectedCourse}">

                <c:if test="${not empty editTest}">
                    <input type="hidden" name="id" value="${editTest.id}">
                </c:if>

                <!-- Code / Title -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="font-semibold">Test Code</label>
                        <input type="text" name="code" required
                               value="${editTest.code}"
                               class="w-full px-4 py-3 border rounded-lg"
                               placeholder="VD: FINAL001">
                    </div>

                    <div>
                        <label class="font-semibold">Tiêu đề</label>
                        <input type="text" name="title" required
                               value="${editTest.title}"
                               class="w-full px-4 py-3 border rounded-lg"
                               placeholder="Nhập tiêu đề bài test">
                    </div>
                </div>

                <!-- Description -->
                <div>
                    <label class="font-semibold">Mô tả</label>
                    <textarea name="description" rows="4" required
                              class="w-full px-4 py-3 border rounded-lg">${editTest.description}</textarea>
                </div>

                <!-- Duration / Min grade -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="font-semibold">Thời gian (phút)</label>
                        <input type="number" name="duration" required
                               value="${editTest.timeInterval}"
                               class="w-full px-4 py-3 border rounded-lg">
                    </div>

                    <div>
                        <label class="font-semibold">Điểm tối thiểu</label>
                        <input type="number" name="minGrade" required
                               value="${editTest.minGrade}"
                               class="w-full px-4 py-3 border rounded-lg">
                    </div>
                </div>

                <!-- QUIZ MODE -->
                <div class="bg-gray-50 p-6 rounded-lg border">
                    <h3 class="font-bold mb-3">Cấu hình câu hỏi</h3>

                    <div class="flex gap-6 mb-4">
                        <label class="flex items-center gap-2">
                            <input type="radio" name="mode" value="random" onclick="toggleMode()"
                                   <c:if test="${empty selectedQuizIds}">checked</c:if>>
                                   <span>Random</span>
                            </label>

                            <label class="flex items-center gap-2">
                                <input type="radio" name="mode" value="custom" onclick="toggleMode()"
                                <c:if test="${not empty selectedQuizIds}">checked</c:if>>
                                <span>Chọn thủ công</span>
                            </label>
                        </div>

                        <!-- RANDOM -->
                        <div id="randomBox"
                             class="<c:if test='${not empty selectedQuizIds}'>hidden</c:if> flex gap-3 items-center">
                            <label>Số câu hỏi:</label>
                            <input type="number" name="randomCount" min="1"
                                   class="px-4 py-2 border rounded-lg w-24">
                        </div>

                        <!-- CUSTOM -->
                        <div id="manualQuizBox"
                             class="<c:if test='${empty selectedQuizIds}'>hidden</c:if> bg-white p-4 rounded-lg max-h-64 overflow-y-auto border mt-4">

                        <c:forEach items="${quizList}" var="q">
                            <label class="flex items-start gap-3 mb-2 cursor-pointer">
                                <input type="checkbox" name="quizId" value="${q.id}"
                                       <c:if test="${selectedQuizIds != null && selectedQuizIds.contains(q.id)}">checked</c:if>>
                                <span>[${q.id}] ${q.question}</span>
                            </label>
                        </c:forEach>

                    </div>

                </div>

                <!-- Submit -->
                <button type="submit" name="action"
                        value="<c:choose><c:when test='${not empty editTest}'>update</c:when><c:otherwise>create</c:otherwise></c:choose>"
                                class="w-full py-3 bg-blue-600 text-white rounded-lg font-semibold">
                        <c:choose>
                            <c:when test="${not empty editTest}">Cập nhật Test</c:when>
                            <c:otherwise>Tạo Test</c:otherwise>
                        </c:choose>
                </button>

            </form>

            <!-- LIST TEST -->
            <div class="bg-white rounded-xl shadow-xl overflow-hidden mt-10">
                <div class="bg-gradient-to-r from-indigo-600 to-purple-700 px-8 py-6">
                    <h2 class="text-2xl font-bold text-white">Danh sách Test của khóa học</h2>
                </div>

                <table class="w-full">
                    <thead>
                        <tr class="bg-gray-50 border-b border-gray-200">
                            <th class="px-6 py-4 text-left text-xs font-bold">ID</th>
                            <th class="px-6 py-4 text-left text-xs font-bold">Code</th>
                            <th class="px-6 py-4 text-left text-xs font-bold">Title</th>
                            <th class="px-6 py-4 text-left text-xs font-bold">Action</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">

                        <c:forEach items="${testList}" var="t">
                            <tr class="hover:bg-blue-50">
                                <td class="px-6 py-4">${t.id}</td>
                                <td class="px-6 py-4 font-semibold">${t.code}</td>
                                <td class="px-6 py-4">${t.title}</td>
                                <td class="px-6 py-4">
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

                        <!-- FIX: Nếu không có test -->
                        <c:if test="${empty testList}">
                            <tr>
                                <td colspan="4" class="px-6 py-4 text-center text-gray-500">Chưa có test nào cho khóa này</td>
                            </tr>
                        </c:if>

                    </tbody>
                </table>
            </div>

        </div>

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />

    </body>
</html>
