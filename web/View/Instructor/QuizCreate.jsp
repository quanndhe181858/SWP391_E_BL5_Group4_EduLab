<%-- Document : addQuiz Created on : Dec 5, 2024 Author : Le Minh Duc --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <%@page import="java.util.List" %>
                <%@page import="model.QuizAnswer" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                        <title>${quiz != null ? 'Chỉnh sửa câu hỏi' : 'Thêm câu hỏi mới'} - EduLab</title>
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
                                        <h1 class="text-3xl font-bold text-gray-900">${quiz != null ? 'Chỉnh sửa câu hỏi' : 'Thêm câu hỏi mới'}</h1>
                                        <p class="text-lg text-gray-600 mt-1">${quiz != null ? 'Cập nhật thông tin và câu trả lời' : 'Tạo câu hỏi trắc nghiệm mới cho khóa học của bạn'}</p>
                                    </div>
                                </div>
                            </div>

                    <div class="flex flex-col lg:flex-row gap-6">
                        <aside class="w-full lg:w-1/4">
                            <div class="bg-white p-6 rounded-lg shadow-sm sticky top-4">
                                <h2 class="text-xl font-bold text-gray-900 mb-6">Hướng dẫn</h2>

                                <div class="space-y-4">
                                    <div class="flex items-start gap-3">
                                        <div
                                            class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center flex-shrink-0">
                                            <svg class="w-4 h-4 text-blue-600" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z">
                                                </path>
                                            </svg>
                                        </div>
                                        <div>
                                            <h3 class="text-sm font-semibold text-gray-900">Câu hỏi rõ ràng</h3>
                                            <p class="text-xs text-gray-600">Viết câu hỏi rõ ràng, ngắn gọn và dễ hiểu.</p>
                                        </div>
                                    </div>

                                    <div class="flex items-start gap-3">
                                        <div
                                            class="w-8 h-8 bg-green-100 rounded-lg flex items-center justify-center flex-shrink-0">
                                            <svg class="w-4 h-4 text-green-600" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                            </svg>
                                        </div>
                                        <div>
                                            <h3 class="text-sm font-semibold text-gray-900">Chọn đúng loại</h3>
                                            <p class="text-xs text-gray-600">Chọn loại câu hỏi phù hợp dựa trên định dạng câu trả lời.</p>
                                        </div>
                                    </div>

                                    <div class="flex items-start gap-3">
                                        <div
                                            class="w-8 h-8 bg-purple-100 rounded-lg flex items-center justify-center flex-shrink-0">
                                            <svg class="w-4 h-4 text-purple-600" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A2 2 0 013 12V7a4 4 0 014-4z">
                                                </path>
                                            </svg>
                                        </div>
                                        <div>
                                            <h3 class="text-sm font-semibold text-gray-900">Danh mục phù hợp</h3>
                                            <p class="text-xs text-gray-600">Phân loại câu hỏi để tổ chức và lọc tốt hơn.</p>
                                        </div>
                                    </div>
                                </div>

                                <hr class="my-6 border-gray-200">

                                <div class="bg-blue-50 p-4 rounded-lg">
                                    <h3 class="text-sm font-semibold text-blue-900 mb-2">Cần trợ giúp?</h3>
                                    <p class="text-xs text-blue-700">Xem tài liệu của chúng tôi để biết các mẹo tạo câu hỏi hiệu quả.</p>
                                </div>
                            </div>
                        </aside>

                        <main class="w-full lg:w-3/4">
                            <div class="bg-white rounded-lg shadow-sm">
                                <div class="p-6 border-b border-gray-200">
                                    <h2 class="text-xl font-bold text-gray-900">Chi tiết câu hỏi</h2>
                                    <p class="text-sm text-gray-600 mt-1">Điền thông tin bên dưới để tạo câu hỏi của bạn</p>
                                </div>

                                <div class="p-6">
                                    <% if (request.getAttribute("error") !=null) { %>
                                        <div
                                            class="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg flex items-start gap-3">
                                            <svg class="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" fill="none"
                                                stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                            </svg>
                                            <div>
                                                <h3 class="text-sm font-semibold text-red-800">Lỗi</h3>
                                                <p class="text-sm text-red-700">
                                                    <%= request.getAttribute("error") %>
                                                </p>
                                            </div>
                                        </div>
                                        <% } %>

                                            <form action="${pageContext.request.contextPath}/instructor/quizes"
                                                method="POST">
                                                <input type="hidden" name="action" value="${quiz != null ? 'update' : 'create'}">
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
                                                              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"><c:choose><c:when test="${quiz != null}">${quiz.question}</c:when><c:otherwise><%= request.getParameter("question") != null ? request.getParameter("question") : "" %></c:otherwise></c:choose></textarea>
                                                    <p class="mt-2 text-xs text-gray-500">Nhập đầy đủ nội dung câu hỏi. Hãy rõ ràng và cụ thể.</p>
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
                                                            <option value="Multiple Choice" 
                                                                    <c:if test="${quiz != null && quiz.type == 'Multiple Choice'}">selected</c:if>
                                                                    <%="Multiple Choice".equals(request.getParameter("type")) ? "selected" : "" %>>
                                                                Trắc nghiệm
                                                            </option>
                                                            <option value="True/False" 
                                                                    <c:if test="${quiz != null && quiz.type == 'True/False'}">selected</c:if>
                                                                    <%="True/False".equals(request.getParameter("type")) ? "selected" : "" %>>
                                                                Đúng/Sai
                                                            </option>
                                                            <option value="Short Answer" 
                                                                    <c:if test="${quiz != null && quiz.type == 'Short Answer'}">selected</c:if>
                                                                    <%="Short Answer".equals(request.getParameter("type")) ? "selected" : "" %>>
                                                                Câu trả lời ngắn
                                                            </option>
                                                        </select>
                                                        <p class="mt-2 text-xs text-gray-500">Chọn định dạng cho câu hỏi.</p>
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
                                                                <option value="${cat.id}" 
                                                                        <c:if test="${quiz != null && cat.id == quiz.category_id}">selected</c:if>
                                                                        <c:if test="${cat.id == param.categoryId}">selected</c:if>>
                                                                    ${cat.name}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                        <p class="mt-2 text-xs text-gray-500">Chọn danh mục để sắp xếp.</p>
                                                    </div>
                                                </div>

                                                <div
                                                    class="flex flex-col sm:flex-row gap-3 pt-6 border-t border-gray-200">
                                                    <button type="submit"
                                                        class="inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition shadow-sm">
                                                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M12 4v16m8-8H4"></path>
                                                        </svg>
                                                        Tạo câu hỏi
                                                    </button>
                                                    <a href="${pageContext.request.contextPath}/instructor/quizes?action=list"
                                                        class="inline-flex items-center justify-center px-6 py-3 bg-white border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition">
                                                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                                                        </svg>
                                                        Hủy
                                                    </a>
                                                </div>
                                            </form>
                                </div>
                            </div>
                        </main>
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
                    let answerCount = 0;

                    function addAnswer() {
                        answerCount++;
                        const answersContainer = document.getElementById('answersContainer');
                        
                        const answerDiv = document.createElement('div');
                        answerDiv.className = 'flex items-start gap-3 p-4 border border-gray-200 rounded-lg bg-gray-50';
                        answerDiv.id = 'answer-' + answerCount;
                        
                        answerDiv.innerHTML = `
                            <div class="flex items-center pt-2">
                                <input type="checkbox" 
                                       name="answerIsCorrect[]" 
                                       value="${answerCount}"
                                       class="w-5 h-5 text-green-600 border-gray-300 rounded focus:ring-green-500"
                                       title="Đánh dấu là câu trả lời đúng">
                            </div>
                            <div class="flex-grow">
                                <label class="block text-xs font-medium text-gray-600 mb-1">
                                    Câu trả lời #${answerCount}
                                </label>
                                <input type="text" 
                                       name="answerContent[]" 
                                       required
                                       placeholder="Nhập nội dung câu trả lời..."
                                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                <input type="hidden" name="answerIndex[]" value="${answerCount}">
                            </div>
                            <button type="button" 
                                    onclick="removeAnswer(${answerCount})"
                                    class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition"
                                    title="Xóa câu trả lời">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                </svg>
                            </button>
                        `;
                        
                        answersContainer.appendChild(answerDiv);
                    }

                    function removeAnswer(id) {
                        const answerDiv = document.getElementById('answer-' + id);
                        if (answerDiv) {
                            answerDiv.remove();
                        }
                    }

                    // Form validation
                    document.querySelector('form').addEventListener('submit', function(e) {
                        const answersContainer = document.getElementById('answersContainer');
                        const answerDivs = answersContainer.querySelectorAll('[id^="answer-"]');
                        
                        if (answerDivs.length === 0) {
                            e.preventDefault();
                            showToast('Vui lòng thêm ít nhất một câu trả lời', 'warning', 3000, 'right');
                            return false;
                        }
                        
                        const checkedBoxes = answersContainer.querySelectorAll('input[name="answerIsCorrect[]"]:checked');
                        if (checkedBoxes.length === 0) {
                            e.preventDefault();
                            showToast('Vui lòng chọn ít nhất một câu trả lời đúng', 'warning', 3000, 'right');
                            return false;
                        }
                        
                        return true;
                    });

                    // Add initial answer on page load
                    document.addEventListener('DOMContentLoaded', function() {
                        addAnswer();
                    });
                </script>
            </body>

            </html>