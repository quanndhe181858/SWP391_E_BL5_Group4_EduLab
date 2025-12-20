<%-- Document : QuizManage (Create/Update with Answers) Created on : Dec 12, 2025 Author : Le Minh Duc --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <%@page import="java.util.List" %>
                    <%@page import="model.QuizAnswer" %>
                        <!DOCTYPE html>
                        <html class="scroll-smooth">

                        <head>
                            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                            <title>${quiz != null ? 'Chỉnh sửa câu hỏi' : 'Thêm câu hỏi mới'} - EduLab</title>
                            <jsp:include page="/layout/import.jsp" />
                        </head>

                        <body class="bg-gray-50">
                            <jsp:include page="/layout/header.jsp" />

                            <div class="container mx-auto px-4 py-8">
                                <div class="mb-8">
                                    <div
                                        class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                                        <div>
                                            <div class="flex items-center gap-3 mb-2">
                                                <a href="${pageContext.request.contextPath}/instructor/quizzes?action=list"
                                                    class="inline-flex items-center text-gray-600 hover:text-blue-600 transition">
                                                    <svg class="w-5 h-5 mr-1" fill="none" stroke="currentColor"
                                                        viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                                                    </svg>
                                                    Quay lại danh sách câu hỏi
                                                </a>
                                            </div>
                                            <h1 class="text-3xl font-bold text-gray-900">${quiz != null ? 'Chỉnh sửa câu
                                                hỏi' : 'Thêm câu hỏi mới'}</h1>
                                            <p class="text-lg text-gray-600 mt-1">${quiz != null ? 'Cập nhật thông tin
                                                và quản lý câu trả lời' : 'Tạo câu hỏi trắc nghiệm mới cho khóa học của
                                                bạn'}</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex flex-col lg:flex-row gap-6">
                                    <!-- Main Content -->
                                    <main class="w-full">
                                        <!-- Quiz Details Form -->
                                        <div class="bg-white rounded-lg shadow-sm mb-6">
                                            <div class="p-6 border-b border-gray-200">
                                                <h2 class="text-xl font-bold text-gray-900">Chi tiết câu hỏi</h2>
                                                <p class="text-sm text-gray-600 mt-1">Điền thông tin bên dưới để ${quiz
                                                    != null ? 'cập nhật' : 'tạo'} câu hỏi của bạn</p>
                                            </div>

                                            <div class="p-6">
                                                <form id="quizForm"
                                                    action="${pageContext.request.contextPath}/instructor/quizzes"
                                                    method="POST">
                                                    <input type="hidden" name="action"
                                                        value="${quiz != null ? 'update' : 'create'}">
                                                    <c:if test="${quiz != null}">
                                                        <input type="hidden" name="id" value="${quiz.id}">
                                                    </c:if>

                                                    <div class="mb-6">
                                                        <label for="question"
                                                            class="block text-sm font-semibold text-gray-700 mb-2">
                                                            Câu hỏi <span class="text-red-500">*</span>
                                                        </label>
                                                        <textarea id="question" name="question" required rows="4"
                                                            placeholder="Nhập nội dung câu hỏi tại đây..."
                                                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"><c:if test="${quiz != null}">${quiz.question}</c:if></textarea>
                                                        <p class="mt-2 text-xs text-gray-500">Nhập đầy đủ nội dung câu
                                                            hỏi. Hãy rõ ràng và cụ thể.</p>
                                                    </div>

                                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                                        <div>
                                                            <label for="type"
                                                                class="block text-sm font-semibold text-gray-700 mb-2">
                                                                Loại câu hỏi <span class="text-red-500">*</span>
                                                            </label>
                                                            <select id="type" name="type" required
                                                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                                                <option value="">-- Chọn loại câu hỏi --</option>
                                                                <option value="Multiple Choice" <c:if
                                                                    test="${quiz != null && fn:trim(quiz.type) == 'Multiple Choice'}">
                                                                    selected</c:if>>Multiple Choice</option>
                                                                <option value="Single Choice" <c:if
                                                                    test="${quiz != null && fn:trim(quiz.type) == 'Single Choice'}">
                                                                    selected</c:if>>Single Choice</option>
                                                            </select>
                                                        </div>

                                                        <div>
                                                            <label for="categoryId"
                                                                class="block text-sm font-semibold text-gray-700 mb-2">
                                                                Danh mục <span class="text-red-500">*</span>
                                                            </label>
                                                            <select id="categoryId" name="categoryId" required
                                                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                                                <option value="">-- Chọn danh mục --</option>
                                                                <c:forEach var="cat" items="${categories}">
                                                                    <option value="${cat.id}" <c:if
                                                                        test="${quiz != null && cat.id == quiz.category_id}">
                                                                        selected</c:if>>${cat.name}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="flex gap-3 pt-6 border-t border-gray-200">
                                                        <button type="submit"
                                                            class="inline-flex items-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition">
                                                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                            </svg>
                                                            ${quiz != null ? 'Cập nhật câu hỏi' : 'Tạo câu hỏi'}
                                                        </button>
                                                        <a href="${pageContext.request.contextPath}/instructor/quizzes?action=list"
                                                            class="inline-flex items-center px-6 py-3 bg-white border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition">
                                                            Hủy
                                                        </a>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                        <!-- Answers Management Section -->
                                        <div id="answers-section" class="bg-white rounded-lg shadow-sm scroll-mt-4">
                                            <div class="p-6 border-b border-gray-200">
                                                <div class="flex justify-between items-center">
                                                    <div>
                                                        <h2 class="text-xl font-bold text-gray-900">
                                                            <c:choose>
                                                                <c:when test="${quiz != null}">Quản lý câu trả lời
                                                                </c:when>
                                                                <c:otherwise>Câu trả lời</c:otherwise>
                                                            </c:choose>
                                                        </h2>
                                                        <p class="text-sm text-gray-600 mt-1">
                                                            <c:choose>
                                                                <c:when test="${quiz != null}">Thêm, chỉnh sửa hoặc xóa
                                                                    các câu trả lời cho câu hỏi này</c:when>
                                                                <c:otherwise>Thêm các câu trả lời cho câu hỏi mới (Lưu
                                                                    câu hỏi trước để quản lý câu trả lời)</c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                    </div>
                                                    <c:if test="${quiz != null}">
                                                        <button type="button" onclick="showAddAnswerModal()"
                                                            class="inline-flex items-center px-4 py-2 bg-green-600 text-white font-semibold rounded-lg hover:bg-green-700 transition">
                                                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2" d="M12 4v16m8-8H4"></path>
                                                            </svg>
                                                            Thêm câu trả lời
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </div>

                                            <c:if test="${quiz != null}">

                                                <div class="p-6">
                                                    <c:choose>
                                                        <c:when test="${not empty quizAnswers}">
                                                            <div class="space-y-3">
                                                                <c:forEach var="answer" items="${quizAnswers}">
                                                                    <div class="flex items-start gap-3 p-4 border-2 ${answer.is_true ? 'border-green-300 bg-green-50' : 'border-gray-200 bg-white'} rounded-lg hover:shadow-md transition"
                                                                        id="answer-${answer.id}">
                                                                        <div class="flex items-center pt-1">
                                                                            <c:choose>
                                                                                <c:when test="${answer.is_true}">
                                                                                    <svg class="w-6 h-6 text-green-600"
                                                                                        fill="currentColor"
                                                                                        viewBox="0 0 20 20">
                                                                                        <path fill-rule="evenodd"
                                                                                            d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                                                                                            clip-rule="evenodd" />
                                                                                    </svg>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <svg class="w-6 h-6 text-gray-400"
                                                                                        fill="none"
                                                                                        stroke="currentColor"
                                                                                        viewBox="0 0 24 24">
                                                                                        <path stroke-linecap="round"
                                                                                            stroke-linejoin="round"
                                                                                            stroke-width="2"
                                                                                            d="M6 18L18 6M6 6l12 12" />
                                                                                    </svg>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                        <div class="flex-grow">
                                                                            <p
                                                                                class="text-base font-medium ${answer.is_true ? 'text-green-900' : 'text-gray-900'}">
                                                                                ${answer.content}</p>
                                                                            <p
                                                                                class="text-xs ${answer.is_true ? 'text-green-600' : 'text-gray-500'} mt-1">
                                                                                ${answer.is_true ? '✓ Câu trả lời đúng'
                                                                                : 'Câu trả lời sai'}
                                                                            </p>
                                                                        </div>
                                                                        <div class="flex gap-2">
                                                                            <button type="button"
                                                                                onclick='editAnswer(${answer.id}, ${quiz.id}, "${answer.content.replace("'", "\\'").replace("\"", "&quot;" )}",${answer.is_true})'
                                                                                class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition"
                                                                                title="Chỉnh sửa">
                                                                                <svg class="w-5 h-5" fill="none"
                                                                                    stroke="currentColor"
                                                                                    viewBox="0 0 24 24">
                                                                                    <path stroke-linecap="round"
                                                                                        stroke-linejoin="round"
                                                                                        stroke-width="2"
                                                                                        d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                                                                                </svg>
                                                                            </button>
                                                                            <button type="button"
                                                                                onclick="deleteAnswer(${answer.id}, ${quiz.id})"
                                                                                class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition"
                                                                                title="Xóa">
                                                                                <svg class="w-5 h-5" fill="none"
                                                                                    stroke="currentColor"
                                                                                    viewBox="0 0 24 24">
                                                                                    <path stroke-linecap="round"
                                                                                        stroke-linejoin="round"
                                                                                        stroke-width="2"
                                                                                        d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                                                                </svg>
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="text-center py-12">
                                                                <svg class="mx-auto h-12 w-12 text-gray-400" fill="none"
                                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                                                </svg>
                                                                <h3 class="mt-2 text-sm font-medium text-gray-900">Chưa
                                                                    có câu trả lời</h3>
                                                                <p class="mt-1 text-sm text-gray-500">Bắt đầu bằng cách
                                                                    thêm câu trả lời đầu tiên cho câu hỏi này.</p>
                                                                <div class="mt-6">
                                                                    <button type="button" onclick="showAddAnswerModal()"
                                                                        class="inline-flex items-center px-4 py-2 bg-green-600 text-white font-medium rounded-lg hover:bg-green-700">
                                                                        <svg class="w-5 h-5 mr-2" fill="none"
                                                                            stroke="currentColor" viewBox="0 0 24 24">
                                                                            <path stroke-linecap="round"
                                                                                stroke-linejoin="round" stroke-width="2"
                                                                                d="M12 4v16m8-8H4"></path>
                                                                        </svg>
                                                                        Thêm câu trả lời
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                        </div>

                                        <!-- Message for Create Mode -->
                                        <c:if test="${quiz == null}">
                                            <div class="p-12 text-center">
                                                <svg class="mx-auto h-16 w-16 text-gray-300" fill="none"
                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                                </svg>
                                                <h3 class="mt-4 text-lg font-medium text-gray-900">Lưu câu hỏi trước
                                                </h3>
                                                <p class="mt-2 text-sm text-gray-500 max-w-md mx-auto">
                                                    Vui lòng lưu câu hỏi trước, sau đó bạn có thể quay lại trang này để
                                                    thêm, chỉnh sửa và quản lý các câu trả lời.
                                                </p>
                                                <div class="mt-6">
                                                    <button type="button"
                                                        onclick="document.getElementById('quizForm').requestSubmit()"
                                                        class="inline-flex items-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition">
                                                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                        </svg>
                                                        Lưu câu hỏi ngay
                                                    </button>
                                                </div>
                                            </div>
                                        </c:if>
                                        </c:if>
                                </div>
                                </main>
                            </div>
                            </div>

                            <!-- Add/Edit Answer Modal -->
                            <div id="answerModal"
                                class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 z-50 flex items-center justify-center p-4">
                                <div class="bg-white rounded-xl shadow-2xl w-full max-w-lg">
                                    <div class="flex items-center justify-between p-6 border-b border-gray-200">
                                        <h2 id="modalTitle" class="text-2xl font-bold text-gray-900">Thêm câu trả lời
                                        </h2>
                                        <button onclick="closeAnswerModal()"
                                            class="text-gray-400 hover:text-gray-600 transition">
                                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M6 18L18 6M6 6l12 12"></path>
                                            </svg>
                                        </button>
                                    </div>

                                    <form id="answerForm">
                                        <input type="hidden" id="answerId" name="answerId">
                                        <input type="hidden" id="quizIdInput" name="quizId"
                                            value="${quiz != null ? quiz.id : ''}">
                                        <input type="hidden" id="formAction" name="action">

                                        <div class="p-6 space-y-4">
                                            <div>
                                                <label for="answerContent"
                                                    class="block text-sm font-semibold text-gray-700 mb-2">
                                                    Nội dung câu trả lời <span class="text-red-500">*</span>
                                                </label>
                                                <textarea id="answerContent" name="content" required rows="3"
                                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                                    placeholder="Nhập nội dung câu trả lời..."></textarea>
                                            </div>

                                            <div class="flex items-center">
                                                <input type="checkbox" id="isCorrect" name="isCorrect"
                                                    class="w-5 h-5 text-green-600 border-gray-300 rounded focus:ring-green-500">
                                                <label for="isCorrect" class="ml-3 text-sm font-medium text-gray-700">
                                                    Đây là câu trả lời đúng
                                                </label>
                                            </div>
                                        </div>

                                        <div class="flex gap-3 p-6 border-t border-gray-200 bg-gray-50 rounded-b-xl">
                                            <button type="submit"
                                                class="flex-1 inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition">
                                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                </svg>
                                                Lưu
                                            </button>
                                            <button type="button" onclick="closeAnswerModal()"
                                                class="flex-1 inline-flex items-center justify-center px-6 py-3 bg-white border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition">
                                                Hủy
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <jsp:include page="/layout/footer.jsp" />
                            <jsp:include page="/layout/importBottom.jsp" />

                            <c:if test="${not empty sessionScope.notification}">
                                <script>
                                    showToast("${sessionScope.notification}", "${not empty sessionScope.notificationType ? sessionScope.notificationType : 'info'}", 3000, "right");
                                </script>
                                <c:remove var="notification" scope="session" />
                                <c:remove var="notificationType" scope="session" />
                            </c:if>

                            <script>
                                const contextPath = '${pageContext.request.contextPath}';
                                const quizId = '${quiz != null ? quiz.id : ''}';

                                // Scroll to answers section if hash is present
                                document.addEventListener('DOMContentLoaded', function () {
                                    if (window.location.hash === '#answers-section') {
                                        const answersSection = document.getElementById('answers-section');
                                        if (answersSection) {
                                            setTimeout(() => {
                                                answersSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
                                                // Optionally highlight the section briefly
                                                answersSection.classList.add('ring-2', 'ring-blue-500', 'ring-opacity-50');
                                                setTimeout(() => {
                                                    answersSection.classList.remove('ring-2', 'ring-blue-500', 'ring-opacity-50');
                                                }, 2000);
                                            }, 300);
                                        }
                                    }
                                });

                                function showAddAnswerModal() {
                                    // Check for max 6 answers
                                    const answerCount = document.querySelectorAll('#answers-section .border-2').length;
                                    // Also count if there is a 'No answers' placeholder, but here we count actual answer elements
                                    // The class .border-2 is used on answer divs

                                    if (answerCount >= 6) {
                                        showToast('Tối đa 6 câu trả lời!', 'error', 2000, 'right');
                                        return;
                                    }

                                    document.getElementById('modalTitle').textContent = 'Thêm câu trả lời';
                                    document.getElementById('formAction').value = 'createAnswer';
                                    document.getElementById('answerId').value = '';
                                    document.getElementById('answerContent').value = '';

                                    const isCorrectInput = document.getElementById('isCorrect');
                                    isCorrectInput.checked = false;
                                    isCorrectInput.disabled = false;
                                    isCorrectInput.title = "";

                                    // Check if Single Choice and already has correct answer
                                    // Using JSP EL to get type might be tricky if not in a JS var, but we can check the select box which is present
                                    const typeSelect = document.getElementById('type');
                                    // Or use the hidden type if available, or just check DOM for green ticks

                                    // safer to check DOM for green checkmarks
                                    const correctAnswers = document.querySelectorAll('#answers-section .text-green-600.w-6'); // identifying ticks

                                    // Need to know quiz type. 
                                    // In Edit mode, the type select is populated.
                                    if (typeSelect && typeSelect.value === 'Single Choice') {
                                        if (correctAnswers.length > 0) {
                                            isCorrectInput.disabled = true;
                                            isCorrectInput.title = "Câu hỏi Single Choice chỉ được có 1 đáp án đúng.";
                                            // Add a small helper text if needed, or just rely on disability
                                        }
                                    }

                                    document.getElementById('answerModal').classList.remove('hidden');
                                    document.body.style.overflow = 'hidden';
                                }

                                function editAnswer(answerId, quizId, content, isCorrect) {
                                    document.getElementById('modalTitle').textContent = 'Chỉnh sửa câu trả lời';
                                    document.getElementById('formAction').value = 'updateAnswer';
                                    document.getElementById('answerId').value = answerId;
                                    document.getElementById('quizIdInput').value = quizId;
                                    document.getElementById('answerContent').value = content;

                                    const isCorrectInput = document.getElementById('isCorrect');
                                    isCorrectInput.checked = isCorrect;
                                    isCorrectInput.disabled = false;
                                    isCorrectInput.title = "";

                                    const typeSelect = document.getElementById('type');
                                    if (typeSelect && typeSelect.value === 'Single Choice') {
                                        // If this answer is NOT correct, and there IS a correct answer elsewhere, disable it
                                        // If this answer IS correct, keep it enabled (so they can uncheck it if they want, though usually required 1)

                                        if (!isCorrect) {
                                            const correctAnswers = document.querySelectorAll('#answers-section .text-green-600.w-6');
                                            if (correctAnswers.length > 0) {
                                                isCorrectInput.disabled = true;
                                                isCorrectInput.title = "Câu hỏi Single Choice chỉ được có 1 đáp án đúng.";
                                            }
                                        }
                                    }

                                    document.getElementById('answerModal').classList.remove('hidden');
                                    document.body.style.overflow = 'hidden';
                                }

                                function closeAnswerModal() {
                                    document.getElementById('answerModal').classList.add('hidden');
                                    document.body.style.overflow = 'auto';
                                }

                                function deleteAnswer(answerId, quizId) {
                                    Swal.fire({
                                        title: 'Xác nhận xóa?',
                                        text: 'Bạn có chắc chắn muốn xóa câu trả lời này?',
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonColor: '#dc2626',
                                        cancelButtonColor: '#6b7280',
                                        confirmButtonText: 'Xóa',
                                        cancelButtonText: 'Hủy'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            $.ajax({
                                                url: contextPath + '/instructor/quiz-answers',
                                                type: 'POST',
                                                data: {
                                                    action: 'delete',
                                                    answerId: answerId,
                                                    quizId: quizId
                                                },
                                                success: function (response) {
                                                    showToast('Xóa câu trả lời thành công!', 'success', 2000, 'right');
                                                    setTimeout(() => window.location.reload(), 1000);
                                                },
                                                error: function (xhr) {
                                                    showToast('Lỗi khi xóa câu trả lời!', 'error', 3000, 'right');
                                                }
                                            });
                                        }
                                    });
                                }

                                // Handle form submission for add/edit answer
                                document.getElementById('answerForm').addEventListener('submit', function (e) {
                                    e.preventDefault();

                                    const formData = new FormData(this);
                                    const data = Object.fromEntries(formData);

                                    $.ajax({
                                        url: contextPath + '/instructor/quiz-answers',
                                        type: 'POST',
                                        data: data,
                                        success: function (response) {
                                            showToast(data.action === 'createAnswer' ? 'Thêm câu trả lời thành công!' : 'Cập nhật câu trả lời thành công!', 'success', 2000, 'right');
                                            closeAnswerModal();
                                            setTimeout(() => window.location.reload(), 1000);
                                        },
                                        error: function (xhr) {
                                            showToast('Lỗi khi lưu câu trả lời!', 'error', 3000, 'right');
                                        }
                                    });
                                });

                                // Close modal when clicking outside
                                document.getElementById('answerModal').addEventListener('click', function (e) {
                                    if (e.target === this) {
                                        closeAnswerModal();
                                    }
                                });
                            </script>
                        </body>

                        </html>