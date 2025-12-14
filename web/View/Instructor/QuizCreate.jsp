<%-- Document : QuizCreate (Create with Answers) Created on : Dec 12, 2025 Author : Le Minh Duc --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html class="scroll-smooth">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thêm câu hỏi mới - EduLab</title>
    <jsp:include page="/layout/import.jsp" />
</head>

<body class="bg-gray-50">
    <jsp:include page="/layout/header.jsp" />

    <div class="container mx-auto px-4 py-8">
        <div class="mb-8">
            <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                <div>
                    <div class="flex items-center gap-3 mb-2">
                        <a href="${pageContext.request.contextPath}/instructor/quizes?action=list"
                           class="inline-flex items-center text-gray-600 hover:text-blue-600 transition">
                            <svg class="w-5 h-5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                            </svg>
                            Quay lại danh sách câu hỏi
                        </a>
                    </div>
                    <h1 class="text-3xl font-bold text-gray-900">Thêm câu hỏi mới</h1>
                    <p class="text-lg text-gray-600 mt-1">Tạo câu hỏi trắc nghiệm mới cùng với các câu trả lời</p>
                </div>
            </div>
        </div>

        <div class="flex flex-col lg:flex-row gap-6">
            <!-- Main Content -->
            <main class="w-full">
                <!-- Quiz Create Form -->
                <form id="createQuizForm" action="${pageContext.request.contextPath}/instructor/quizes" method="POST" onsubmit="return validateForm()">
                    <input type="hidden" name="action" value="create">

                    <!-- Question Details -->
                    <div class="bg-white rounded-lg shadow-sm mb-6">
                        <div class="p-6 border-b border-gray-200">
                            <h2 class="text-xl font-bold text-gray-900">Chi tiết câu hỏi</h2>
                            <p class="text-sm text-gray-600 mt-1">Điền thông tin bên dưới để tạo câu hỏi của bạn</p>
                        </div>

                        <div class="p-6">
                            <div class="mb-6">
                                <label for="question" class="block text-sm font-semibold text-gray-700 mb-2">
                                    Câu hỏi <span class="text-red-500">*</span>
                                </label>
                                <textarea id="question" name="question" required rows="4"
                                          placeholder="Nhập nội dung câu hỏi tại đây..."
                                          class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none">${question}</textarea>
                                <p class="mt-2 text-xs text-gray-500">Nhập đầy đủ nội dung câu hỏi. Hãy rõ ràng và cụ thể.</p>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <label for="type" class="block text-sm font-semibold text-gray-700 mb-2">
                                        Loại câu hỏi <span class="text-red-500">*</span>
                                    </label>
                                    <select id="type" name="type" required
                                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                        <option value="">-- Chọn loại câu hỏi --</option>
                                        <option value="Multiple Choice" ${type == 'Multiple Choice' ? 'selected' : ''}>Trắc nghiệm</option>
                                        <option value="True/False" ${type == 'True/False' ? 'selected' : ''}>Đúng/Sai</option>
                                        <option value="Short Answer" ${type == 'Short Answer' ? 'selected' : ''}>Câu trả lời ngắn</option>
                                    </select>
                                </div>

                                <div>
                                    <label for="categoryId" class="block text-sm font-semibold text-gray-700 mb-2">
                                        Danh mục <span class="text-red-500">*</span>
                                    </label>
                                    <select id="categoryId" name="categoryId" required
                                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                        <option value="">-- Chọn danh mục --</option>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.id}" ${categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Answers Section -->
                    <div class="bg-white rounded-lg shadow-sm mb-6">
                        <div class="p-6 border-b border-gray-200 flex justify-between items-center">
                            <div>
                                <h2 class="text-xl font-bold text-gray-900">Câu trả lời</h2>
                                <p class="text-sm text-gray-600 mt-1">Thêm các lựa chọn câu trả lời (tối thiểu 2)</p>
                            </div>
                            <button type="button" onclick="addAnswerField()"
                                    class="inline-flex items-center px-4 py-2 bg-green-600 text-white font-semibold rounded-lg hover:bg-green-700 transition">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                </svg>
                                Thêm dòng
                            </button>
                        </div>

                        <div class="p-6">
                            <div id="answersContainer" class="space-y-4">
                                <!-- Answers will be added here dynamically -->
                                <c:choose>
                                    <c:when test="${not empty answerContents}">
                                        <!-- Re-populate answers if validation failed -->
                                        <c:forEach var="content" items="${answerContents}" varStatus="status">
                                            <div class="flex items-start gap-4 p-4 border border-gray-200 rounded-lg bg-gray-50 answer-row" id="answer-row-${status.index}">
                                                <div class="pt-3">
                                                    <input type="checkbox" name="answerIsCorrect" value="${status.index}"
                                                           class="w-5 h-5 text-green-600 border-gray-300 rounded focus:ring-green-500 cursor-pointer"
                                                           title="Đánh dấu là câu trả lời đúng">
                                                </div>
                                                <div class="flex-grow">
                                                    <label class="block text-xs font-medium text-gray-600 mb-1">
                                                        Câu trả lời ${status.index + 1}
                                                    </label>
                                                    <textarea name="answerContent" required rows="2"
                                                              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                                              placeholder="Nhập nội dung câu trả lời...">${content}</textarea>
                                                </div>
                                                <div class="pt-1">
                                                    <button type="button" onclick="removeAnswerField(${status.index})"
                                                            class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition"
                                                            title="Xóa dòng này">
                                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                                        </svg>
                                                    </button>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Initial empty answer fields (2 by default) -->
                                        <!-- Will be populated by JS on load -->
                                    </c:otherwise>
                                </c:choose>
                            </div>
                             <p class="mt-4 text-sm text-gray-500 italic">
                                * Lưu ý: Tích vào ô vuông bên trái câu trả lời để đánh dấu là câu trả lời ĐÚNG. Phải có ít nhất 1 câu đúng.
                            </p>
                        </div>
                    </div>

                    <div class="flex gap-3 pt-6 border-t border-gray-200">
                        <button type="submit" class="inline-flex items-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                            </svg>
                            Tạo câu hỏi
                        </button>
                        <a href="${pageContext.request.contextPath}/instructor/quizes?action=list"
                           class="inline-flex items-center px-6 py-3 bg-white border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition">
                            Hủy
                        </a>
                    </div>
                </form>
            </main>
        </div>
    </div>

    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/importBottom.jsp" />

    <c:if test="${not empty notification}">
        <script>
            showToast("${notification}", "${not empty notificationType ? notificationType : 'info'}", 3000, "right");
        </script>
        <% session.removeAttribute("notification"); %>
        <% session.removeAttribute("notificationType"); %>
    </c:if>

    <script>
        let answerCounter = 0;

        function createAnswerHtml(index, content = '') {
            return `
                <div class="flex items-start gap-4 p-4 border border-gray-200 rounded-lg bg-gray-50 answer-row" id="answer-row-` + index + `">
                    <div class="pt-3">
                        <input type="checkbox" name="answerIsCorrect" value="` + index + `"
                               class="w-5 h-5 text-green-600 border-gray-300 rounded focus:ring-green-500 cursor-pointer"
                               title="Đánh dấu là câu trả lời đúng">
                    </div>
                    <div class="flex-grow">
                        <label class="block text-xs font-medium text-gray-600 mb-1">
                            Câu trả lời ` + (index + 1) + `
                        </label>
                        <textarea name="answerContent" required rows="2"
                                  class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                  placeholder="Nhập nội dung câu trả lời...">` + content + `</textarea>
                    </div>
                    <div class="pt-1">
                        <button type="button" onclick="removeAnswerField(` + index + `)"
                                class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition"
                                title="Xóa dòng này">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            `;
        }

        function addAnswerField() {
            const container = document.getElementById('answersContainer');
            const div = document.createElement('div');
            // We use a temporary wrapper to insert HTML
            div.innerHTML = createAnswerHtml(answerCounter);
            // Append the first child (the actual answer row)
            container.appendChild(div.firstElementChild);
            answerCounter++;
            updateAnswerIndices();
        }

        function removeAnswerField(index) {
            // Don't allow removing if there are only 2 answers left
            const rows = document.querySelectorAll('.answer-row');
            if (rows.length <= 2) {
                showToast('Phải có ít nhất 2 câu trả lời!', 'warning', 2000, 'right');
                return;
            }

            const row = document.getElementById('answer-row-' + index);
            if (row) {
                row.remove();
                updateAnswerIndices();
            }
        }

        // Re-index displayed labels and values to ensure submission array is consistent
        function updateAnswerIndices() {
            const rows = document.querySelectorAll('.answer-row');
            answerCounter = 0; // Reset counter basics to avoid huge numbers, but use independent IDs if complexity increases
            
            rows.forEach((row, index) => {
                // Update label
                const label = row.querySelector('label');
                if (label) label.textContent = 'Câu trả lời ' + (index + 1);

                // Update checkbox value so backend receives 0, 1, 2... matching the answerContent array order
                const checkbox = row.querySelector('input[type="checkbox"]');
                if (checkbox) checkbox.value = index;
                
                // Update row ID for easy removal reference (optional but cleaner)
                // row.id = 'answer-row-' + index; 
                // Note: Changing ID might break the remove function closure if not careful, 
                // but since we pass 'index' directly to removeAnswerField, we should just update the onclick handler.
                
                const removeBtn = row.querySelector('button');
                if (removeBtn) {
                    removeBtn.setAttribute('onclick', 'removeAnswerField(' + index + ')');
                }
                
                row.id = 'answer-row-' + index;

                answerCounter = index + 1;
            });
        }

        function validateForm() {
            const rows = document.querySelectorAll('.answer-row');
            if (rows.length < 2) {
                showToast('Vui lòng nhập ít nhất 2 câu trả lời!', 'error', 3000, 'right');
                return false;
            }

            const checked = document.querySelectorAll('input[name="answerIsCorrect"]:checked');
            if (checked.length < 1) {
                showToast('Vui lòng chọn ít nhất 1 câu trả lời đúng!', 'error', 3000, 'right');
                return false;
            }

            return true;
        }

        // Initialize with 2 empty answers if no existing data (e.g. not a failed submit)
        document.addEventListener('DOMContentLoaded', function() {
            const container = document.getElementById('answersContainer');
            if (container.children.length === 0) {
                addAnswerField();
                addAnswerField();
            } else {
                // If we repopulated, we need to correct the counter
                updateAnswerIndices();
            }
        });
    </script>
</body>
</html>