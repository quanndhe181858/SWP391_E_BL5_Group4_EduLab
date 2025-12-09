<%-- Document : QuizAnswerList Created on : Dec 7, 2024 Author : Le Minh Duc --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.List" %>
<%@page import="model.QuizAnswer" %>
<%@page import="model.Quiz" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý câu trả lời - EduLab</title>
        <jsp:include page="/layout/import.jsp" />
        <style>
            .toast {
                visibility: hidden;
                min-width: 250px;
                text-align: center;
                border-radius: 8px;
                padding: 16px 24px;
                position: fixed;
                z-index: 1000;
                left: 50%;
                bottom: 30px;
                transform: translateX(-50%);
                font-weight: 500;
            }

            .toast.show {
                visibility: visible;
                animation: fadein 0.5s, fadeout 0.5s 2.5s;
            }

            .toast.error {
                background-color: #FEE2E2;
                color: #DC2626;
                border: 1px solid #FECACA;
            }

            .toast.success {
                background-color: #D1FAE5;
                color: #059669;
                border: 1px solid #A7F3D0;
            }

            @keyframes fadein {
                from {
                    bottom: 0;
                    opacity: 0;
                }

                to {
                    bottom: 30px;
                    opacity: 1;
                }
            }

            @keyframes fadeout {
                from {
                    bottom: 30px;
                    opacity: 1;
                }

                to {
                    bottom: 0;
                    opacity: 0;
                }
            }
        </style>
    </head>

    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp" />

        <div class="container mx-auto px-4 py-8">
            <div class="mb-8">
                <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">Quản lý câu trả lời</h1>
                        <p class="text-lg text-gray-600 mt-1">Tạo, chỉnh sửa và quản lý các câu trả lời trắc nghiệm
                        </p>
                    </div>
                    <button type="button" onclick="openAddModal()"
                            class="inline-flex items-center px-4 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition shadow-sm">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                             viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M12 4v16m8-8H4"></path>
                        </svg>
                        Thêm câu trả lời mới
                    </button>
                </div>
            </div>

            <form id="filterForm" method="get"
                  action="${pageContext.request.contextPath}/instructor/quiz-answers">
                <input type="hidden" name="action" value="list">
                <input type="hidden" name="page" id="pageInput"
                       value="${param.page != null ? param.page : 1}">

                <div class="flex flex-col lg:flex-row gap-6">
                    <aside class="w-full lg:w-1/4">
                        <div class="bg-white p-6 rounded-lg shadow-sm sticky top-4">
                            <h2 class="text-xl font-bold text-gray-900 mb-6">Bộ lọc</h2>

                            <div class="mb-6">
                                <label for="search"
                                       class="block text-sm font-semibold text-gray-700 mb-2">Tìm kiếm</label>
                                <div class="relative">
                                    <input
                                        class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                        type="text" placeholder="Tìm câu trả lời..." id="search"
                                        name="search"
                                        value="${param.search != null ? param.search : ''}" />
                                    <svg class="absolute right-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400"
                                         fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                          stroke-width="2"
                                          d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                                    </svg>
                                </div>
                            </div>

                            <div class="mb-6">
                                <label for="quizId"
                                       class="block text-sm font-semibold text-gray-700 mb-2">Câu hỏi (Quiz)</label>
                                <select id="quizId" name="quizId"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white"
                                        onchange="submitFilter()">
                                    <option value="">Tất cả câu hỏi</option>
                                    <% List<Quiz> quizzes = (List<Quiz>)
                                            request.getAttribute("quizzes");
                                            String selectedQuizId = request.getParameter("quizId");
                                            if (quizzes != null) {
                                            for (Quiz quiz : quizzes) { %>
                                    <option value="<%= quiz.getId() %>"
                                            <%=String.valueOf(quiz.getId()).equals(selectedQuizId)
                                                       ? "selected" : "" %>>
                                        Câu #<%= quiz.getId() %>: <%= quiz.getQuestion()
                                                !=null && quiz.getQuestion().length()> 30 ?
                                                quiz.getQuestion().substring(0, 30) + "..."
                                                : quiz.getQuestion() %>
                                    </option>
                                    <% } } %>
                                </select>
                            </div>

                            <div class="mb-6">
                                <label for="isTrue"
                                       class="block text-sm font-semibold text-gray-700 mb-2">Loại đáp án</label>
                                <select id="isTrue" name="isTrue"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white"
                                        onchange="submitFilter()">
                                    <option value="">Tất cả</option>
                                    <option value="true" ${param.isTrue=='true' ? 'selected' : '' }>
                                        Đáp án Đúng</option>
                                    <option value="false" ${param.isTrue=='false' ? 'selected' : ''
                                            }>Đáp án Sai</option>
                                </select>
                            </div>

                            <button type="button" onclick="clearFilters()"
                                    class="w-full px-4 py-2 text-sm font-medium text-blue-600 border border-blue-600 rounded-lg hover:bg-blue-50 transition">
                                Xóa bộ lọc
                            </button>
                        </div>
                    </aside>

                    <main class="w-full lg:w-3/4">
                        <div class="bg-white rounded-lg shadow-sm">
                            <div class="p-6 border-b border-gray-200">
                                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                                    <div class="bg-blue-50 p-4 rounded-lg">
                                        <p class="text-sm text-blue-600 font-semibold">Tổng số câu trả lời
                                        </p>
                                        <p class="text-2xl font-bold text-gray-900 mt-1">
                                            ${totalAnswers != null ? totalAnswers : 0}</p>
                                    </div>
                                    <div class="bg-green-50 p-4 rounded-lg">
                                        <p class="text-sm text-green-600 font-semibold">Đáp án Đúng</p>
                                        <p class="text-2xl font-bold text-gray-900 mt-1">
                                            ${correctAnswerCount != null ? correctAnswerCount : 0}
                                        </p>
                                    </div>
                                    <div class="bg-red-50 p-4 rounded-lg">
                                        <p class="text-sm text-red-600 font-semibold">Đáp án Sai</p>
                                        <p class="text-2xl font-bold text-gray-900 mt-1">
                                            ${incorrectAnswerCount != null ? incorrectAnswerCount :
                                              0}</p>
                                    </div>
                                </div>

                                <div
                                    class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                                    <div>
                                        <p class="text-sm text-gray-600">Hiển thị ${startItem != null
                                                                                     ? startItem : 1}-${endItem != null ? endItem : 0} trong tổng số
                                                                                   ${totalAnswers != null ? totalAnswers : 0} câu trả lời</p>
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <label class="text-sm text-gray-700">Sắp xếp:</label>
                                        <select name="sortBy"
                                                class="px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm bg-white"
                                                onchange="submitFilter()">
                                            <option value="updated_desc"
                                                    ${param.sortBy=='updated_desc' || param.sortBy==null
                                                          ? 'selected' : '' }>Mới cập nhật</option>
                                            <option value="content_asc"
                                                    ${param.sortBy=='content_asc' ? 'selected' : '' }>
                                                Nội dung (A-Z)</option>
                                            <option value="quiz_id_asc"
                                                    ${param.sortBy=='quiz_id_asc' ? 'selected' : '' }>
                                                ID Câu hỏi</option>
                                            <option value="created_desc"
                                                    ${param.sortBy=='created_desc' ? 'selected' : '' }>
                                                Mới nhất</option>
                                            <option value="created_asc"
                                                    ${param.sortBy=='created_asc' ? 'selected' : '' }>
                                                Cũ nhất</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="p-6">
                                <div class="space-y-4">
                                    <% List<QuizAnswer> answerList = (List<QuizAnswer>)
                                            request.getAttribute("answerList");
                                            if (answerList != null && !answerList.isEmpty()) {
                                            for (QuizAnswer answer : answerList) { %>
                                    <div
                                        class="border border-gray-200 rounded-lg p-6 hover:shadow-md transition">
                                        <div class="flex flex-col md:flex-row gap-6">
                                            <div class="w-full md:w-16 h-16 <%= answer.isIs_true() 
                                                                                ? "bg-gradient-to-br from-green-400 to-green-600" : "bg-gradient-to-br from-red-400 to-red-600" %>
                                                 rounded-lg flex-shrink-0 flex items-center justify-center">
                                                <% if (answer.isIs_true()) { %>
                                                <svg class="w-8 h-8 text-white"
                                                     fill="none" stroke="currentColor"
                                                     viewBox="0 0 24 24">
                                                <path stroke-linecap="round"
                                                      stroke-linejoin="round"
                                                      stroke-width="2"
                                                      d="M5 13l4 4L19 7"></path>
                                                </svg>
                                                <% } else { %>
                                                <svg class="w-8 h-8 text-white"
                                                     fill="none"
                                                     stroke="currentColor"
                                                     viewBox="0 0 24 24">
                                                <path stroke-linecap="round"
                                                      stroke-linejoin="round"
                                                      stroke-width="2"
                                                      d="M6 18L18 6M6 6l12 12">
                                                </path>
                                                </svg>
                                                <% } %>
                                            </div>

                                            <div class="flex-grow">
                                                <div
                                                    class="flex items-start justify-between mb-2">
                                                    <div class="flex-grow">
                                                        <div
                                                            class="flex items-center gap-2 mb-2 flex-wrap">
                                                            <span class="px-2 py-1 text-xs font-semibold <%= 
                                                                                            answer.isIs_true() ? "text-green-600 bg-green-100" : "text-red-600 bg-red-100" %> rounded">
                                                                <%= answer.isIs_true() ? "Đúng" : "Sai" %>
                                                            </span>
                                                            <% if (answer.getType() !=null
                                                                    &&
                                                                    !answer.getType().isEmpty())
                                                                    { %>
                                                            <span
                                                                class="px-2 py-1 text-xs font-semibold text-purple-600 bg-purple-100 rounded">
                                                                <%= answer.getType() %> (theo quiz)
                                                            </span>
                                                            <% } %>
                                                        </div>
                                                        <p
                                                            class="text-lg font-medium text-gray-900 mb-2 line-clamp-2">
                                                            <%= answer.getContent() %>
                                                        </p>
                                                    </div>
                                                </div>

                                                <div
                                                    class="flex flex-wrap items-center gap-4 text-sm text-gray-600 mb-4">
                                                    <div class="flex items-center">
                                                        <svg class="w-4 h-4 mr-1"
                                                             fill="none"
                                                             stroke="currentColor"
                                                             viewBox="0 0 24 24">
                                                        <path stroke-linecap="round"
                                                              stroke-linejoin="round"
                                                              stroke-width="2"
                                                              d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z">
                                                        </path>
                                                        </svg>
                                                        <span>Ngày tạo: <%=
                                                                    answer.getCreated_at()
                                                                    !=null ?
                                                                    answer.getCreated_at()
                                                                    : "N/A" %></span>
                                                    </div>
                                                    <div class="flex items-center">
                                                        <svg class="w-4 h-4 mr-1"
                                                             fill="none"
                                                             stroke="currentColor"
                                                             viewBox="0 0 24 24">
                                                        <path stroke-linecap="round"
                                                              stroke-linejoin="round"
                                                              stroke-width="2"
                                                              d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z">
                                                        </path>
                                                        </svg>
                                                        <span>Cập nhật: <%=
                                                                    answer.getUpdated_at()
                                                                    !=null ?
                                                                    answer.getUpdated_at()
                                                                    : "N/A" %></span>
                                                    </div>
                                                </div>

                                                <div class="flex flex-wrap gap-2">
                                                    <% String
                                                            contentText=answer.getContent();
                                                            String safeContent="" ; if
                                                            (contentText !=null) {
                                                            safeContent=contentText.replace("\"", "&quot;"
                                                            ).replace("\n", " "
                                                            ).replace("\r", "" ); } %>
                                                    <button type="button"
                                                            class="edit-answer-btn inline-flex items-center px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 transition"
                                                            data-id="<%= answer.getId() %>"
                                                            data-quiz-id="<%= answer.getQuiz_id() %>"
                                                            data-is-true="<%= answer.isIs_true() %>"
                                                            data-content="<%= safeContent %>">
                                                        <svg class="w-4 h-4 mr-1"
                                                             fill="none"
                                                             stroke="currentColor"
                                                             viewBox="0 0 24 24">
                                                        <path stroke-linecap="round"
                                                              stroke-linejoin="round"
                                                              stroke-width="2"
                                                              d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z">
                                                        </path>
                                                        </svg>
                                                        Sửa
                                                    </button>
                                                    <button type="button"
                                                            class="delete-answer-btn inline-flex items-center px-4 py-2 bg-red-600 text-white text-sm font-medium rounded-lg hover:bg-red-700 transition"
                                                            data-id="<%= answer.getId() %>"
                                                            data-content="<%= safeContent %>">
                                                        <svg class="w-4 h-4 mr-1"
                                                             fill="none"
                                                             stroke="currentColor"
                                                             viewBox="0 0 24 24">
                                                        <path stroke-linecap="round"
                                                              stroke-linejoin="round"
                                                              stroke-width="2"
                                                              d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16">
                                                        </path>
                                                        </svg>
                                                        Xóa
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <% } } else { %>
                                    <div class="text-center py-12">
                                        <svg class="mx-auto h-12 w-12 text-gray-400"
                                             fill="none" stroke="currentColor"
                                             viewBox="0 0 24 24">
                                        <path stroke-linecap="round"
                                              stroke-linejoin="round" stroke-width="2"
                                              d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z">
                                        </path>
                                        </svg>
                                        <h3
                                            class="mt-2 text-sm font-medium text-gray-900">
                                            Không tìm thấy câu trả lời nào</h3>
                                        <p class="mt-1 text-sm text-gray-500">Bắt đầu bằng cách tạo một câu trả lời mới.</p>
                                        <div class="mt-6">
                                            <button type="button"
                                                    onclick="openAddModal()"
                                                    class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                                <svg class="w-5 h-5 mr-2" fill="none"
                                                     stroke="currentColor"
                                                     viewBox="0 0 24 24">
                                                <path stroke-linecap="round"
                                                      stroke-linejoin="round"
                                                      stroke-width="2"
                                                      d="M12 4v16m8-8H4"></path>
                                                </svg>
                                                Thêm câu trả lời mới
                                            </button>
                                        </div>
                                    </div>
                                    <% } %>
                                </div>

                                <c:if test="${totalPages > 1}">
                                    <div class="mt-8 flex justify-center">
                                        <nav class="inline-flex rounded-md shadow-sm -space-x-px"
                                             aria-label="Pagination">
                                            <c:choose>
                                                <c:when test="${page > 1}">
                                                    <a href="javascript:void(0)"
                                                       onclick="goToPage(${page - 1})"
                                                       class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                                        <svg class="h-5 w-5" fill="currentColor"
                                                             viewBox="0 0 20 20">
                                                        <path fill-rule="evenodd"
                                                              d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                                                              clip-rule="evenodd" />
                                                        </svg>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span
                                                        class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-gray-100 text-sm font-medium text-gray-400 cursor-not-allowed">
                                                        <svg class="h-5 w-5" fill="currentColor"
                                                             viewBox="0 0 20 20">
                                                        <path fill-rule="evenodd"
                                                              d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                                                              clip-rule="evenodd" />
                                                        </svg>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <c:choose>
                                                    <c:when test="${i == page}">
                                                        <span
                                                            class="relative inline-flex items-center px-4 py-2 border border-blue-500 bg-blue-50 text-sm font-medium text-blue-600">${i}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="javascript:void(0)"
                                                           onclick="goToPage(${i})"
                                                           class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">${i}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>

                                            <c:choose>
                                                <c:when test="${page < totalPages}">
                                                    <a href="javascript:void(0)"
                                                       onclick="goToPage(${page + 1})"
                                                       class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                                        <svg class="h-5 w-5" fill="currentColor"
                                                             viewBox="0 0 20 20">
                                                        <path fill-rule="evenodd"
                                                              d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                                                              clip-rule="evenodd" />
                                                        </svg>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span
                                                        class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-gray-100 text-sm font-medium text-gray-400 cursor-not-allowed">
                                                        <svg class="h-5 w-5" fill="currentColor"
                                                             viewBox="0 0 20 20">
                                                        <path fill-rule="evenodd"
                                                              d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                                                              clip-rule="evenodd" />
                                                        </svg>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </nav>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </main>
                </div>
            </form>
        </div>

        <jsp:include page="/layout/footer.jsp" />

        <% String notification=(String) session.getAttribute("notification");
                String nType=(String)
                session.getAttribute("notificationType");
                if (notification !=null) { %>
        <div id="snackbar" class="toast <%= nType %>">
            <%= notification %>
        </div>
        <script>
            var x = document.getElementById("snackbar");
            x.className += " show";
            setTimeout(function () {
                x.className = x.className.replace(" show", "");
            }, 3000);
        </script>
        <% session.removeAttribute("notification"); session.removeAttribute("notificationType");
                } %>

        <script>
            function submitFilter() {
                document.getElementById('pageInput').value = '1';
                document.getElementById('filterForm').submit();
            }

            function goToPage(pageNum) {
                document.getElementById('pageInput').value = pageNum;
                document.getElementById('filterForm').submit();
            }

            function clearFilters() {
                window.location.href = '${pageContext.request.contextPath}/instructor/quiz-answers?action=list';
            }

            document.getElementById('search').addEventListener('keypress', function (e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    submitFilter();
                }
            });
            // Add Modal
            function openAddModal() {
                document.getElementById('addModal').classList.remove('hidden');
                document.body.style.overflow = 'hidden';
            }

            function closeAddModal() {
                document.getElementById('addModal').classList.add('hidden');
                document.body.style.overflow = 'auto';
            }

            // Edit Modal
            document.querySelectorAll('.edit-answer-btn').forEach(function (btn) {
                btn.addEventListener('click', function (e) {
                    e.preventDefault();
                    e.stopPropagation();

                    var id = this.getAttribute('data-id');
                    var quizId = this.getAttribute('data-quiz-id');
                    var isTrue = this.getAttribute('data-is-true');
                    var content = this.getAttribute('data-content');

                    document.getElementById('editAnswerId').value = id;
                    document.getElementById('editQuizId').value = quizId;
                    document.getElementById('editIsTrue').value = isTrue;
                    document.getElementById('editContent').value = content;

                    // Update the edit type display field with the quiz type
                    if(typeof window.updateEditQuizType === 'function') {
                        setTimeout(window.updateEditQuizType, 0);
                    }

                    document.getElementById('editModal').classList.remove('hidden');
                    document.body.style.overflow = 'hidden';
                });
            });

            function closeEditModal() {
                document.getElementById('editModal').classList.add('hidden');
                document.body.style.overflow = 'auto';
            }

            // Delete Modal
            document.querySelectorAll('.delete-answer-btn').forEach(function (btn) {
                btn.addEventListener('click', function (e) {
                    e.preventDefault();
                    e.stopPropagation();

                    var id = this.getAttribute('data-id');
                    var content = this.getAttribute('data-content');

                    document.getElementById('deleteAnswerId').value = id;
                    document.getElementById('deleteAnswerContent').textContent = content;
                    document.getElementById('deleteModal').classList.remove('hidden');
                    document.body.style.overflow = 'hidden';
                });
            });

            function closeDeleteModal() {
                var modal = document.getElementById('deleteModal');
                if (modal) {
                    modal.classList.add('hidden');
                    document.body.style.overflow = 'auto';
                }
            }

            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    closeAddModal();
                    closeEditModal();
                    closeDeleteModal();
                }
            });
        </script>

        <div id="addModal"
             class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 z-50 flex items-center justify-center p-4">
            <div
                class="bg-white rounded-xl shadow-2xl w-full max-w-2xl max-h-[90vh] overflow-y-auto">
                <div class="flex items-center justify-between p-6 border-b border-gray-200">
                    <h2 class="text-2xl font-bold text-gray-900">Thêm câu trả lời mới</h2>
                    <button onclick="closeAddModal()"
                            class="text-gray-400 hover:text-gray-600 transition">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor"
                             viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>

                <form action="${pageContext.request.contextPath}/instructor/quiz-answers"
                      method="POST">
                    <input type="hidden" name="action" value="create">

                    <div class="p-6 space-y-6">
                        <div>
                            <label for="addQuizId"
                                   class="block text-sm font-semibold text-gray-700 mb-2">Câu hỏi (Quiz)
                                <span class="text-red-500">*</span></label>
                            <select id="addQuizId" name="quizId" required
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                <option value="">-- Chọn câu hỏi --</option>
                                <% if (quizzes !=null) { for (Quiz quiz : quizzes) { %>
                                <option value="<%= quiz.getId() %>">Câu #<%=
                                              quiz.getId() %>: <%= quiz.getQuestion() !=null
                                            && quiz.getQuestion().length()> 50 ?
                                            quiz.getQuestion().substring(0, 50) + "..."
                                            : quiz.getQuestion() %></option>
                                <% } } %>
                            </select>
                        </div>

                        <div>
                            <label for="addContent"
                                   class="block text-sm font-semibold text-gray-700 mb-2">Nội dung câu trả lời
                                <span class="text-red-500">*</span></label>
                            <textarea id="addContent" name="content" required rows="4"
                                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                      placeholder="Nhập nội dung câu trả lời..."></textarea>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label for="addIsTrue"
                                       class="block text-sm font-semibold text-gray-700 mb-2">Là đáp án đúng?
                                    <span
                                        class="text-red-500">*</span></label>
                                <select id="addIsTrue" name="isTrue" required
                                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                    <option value="false">Không (Sai)</option>
                                    <option value="true">Có (Đúng)</option>
                                </select>
                            </div>
                            <div>
                                <label for="addTypeDisplay"
                                       class="block text-sm font-semibold text-gray-700 mb-2">Loại (theo câu hỏi)</label>
                                <input type="text" id="addTypeDisplay" name="typeDisplay" readonly
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg bg-gray-100 text-gray-700"
                                       placeholder="Chọn câu hỏi để hiển thị loại...">
                            </div>
                        </div>
                        <script>
                            // Show type of selected quiz (in Add Modal)
                            document.addEventListener('DOMContentLoaded', function () {
                                var quizzes = [];
                                <% if (quizzes != null) { for (Quiz quiz : quizzes) { %>
                                    quizzes.push({id: "<%= quiz.getId() %>", type: "<%= quiz.getType() != null ? quiz.getType().replace("\"", "&quot;") : "" %>"});
                                <% } } %>
                                function updateAddQuizType() {
                                    var select = document.getElementById('addQuizId');
                                    var typeInput = document.getElementById('addTypeDisplay');
                                    var selectedId = select.value;
                                    var q = quizzes.find(function(qz){ return qz.id === selectedId; });
                                    typeInput.value = q ? q.type : '';
                                }
                                var selectQuiz = document.getElementById('addQuizId');
                                if(selectQuiz) {
                                    selectQuiz.addEventListener('change', updateAddQuizType);
                                    updateAddQuizType();
                                }
                            });
                        </script>
                    </div>

                    <div
                        class="flex flex-col sm:flex-row gap-3 p-6 border-t border-gray-200 bg-gray-50 rounded-b-xl">
                        <button type="submit"
                                class="inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition shadow-sm">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                 viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                  stroke-width="2" d="M12 4v16m8-8H4"></path>
                            </svg>
                            Thêm câu trả lời
                        </button>
                        <button type="button" onclick="closeAddModal()"
                                class="inline-flex items-center justify-center px-6 py-3 bg-white border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition">
                            Hủy
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <div id="editModal"
             class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 z-50 flex items-center justify-center p-4">
            <div
                class="bg-white rounded-xl shadow-2xl w-full max-w-2xl max-h-[90vh] overflow-y-auto">
                <div class="flex items-center justify-between p-6 border-b border-gray-200">
                    <h2 class="text-2xl font-bold text-gray-900">Chỉnh sửa câu trả lời</h2>
                    <button onclick="closeEditModal()"
                            class="text-gray-400 hover:text-gray-600 transition">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor"
                             viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>

                <form action="${pageContext.request.contextPath}/instructor/quiz-answers"
                      method="POST">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" id="editAnswerId">

                    <div class="p-6 space-y-6">
                        <div>
                            <label for="editQuizId"
                                   class="block text-sm font-semibold text-gray-700 mb-2">Câu hỏi (Quiz)
                                <span class="text-red-500">*</span></label>
                            <select id="editQuizId" name="quizId" required
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                <option value="">-- Chọn câu hỏi --</option>
                                <% if (quizzes !=null) { for (Quiz quiz : quizzes) { %>
                                <option value="<%= quiz.getId() %>">Câu #<%=
                                                                        quiz.getId() %>: <%= quiz.getQuestion() !=null
                                    && quiz.getQuestion().length()> 50 ?
                                            quiz.getQuestion().substring(0, 50) + "..."
                                            : quiz.getQuestion() %></option>
                                <% } } %>
                            </select>
                        </div>

                        <div>
                            <label for="editContent"
                                   class="block text-sm font-semibold text-gray-700 mb-2">Nội dung câu trả lời
                                <span class="text-red-500">*</span></label>
                            <textarea id="editContent" name="content" required rows="4"
                                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                      placeholder="Nhập nội dung câu trả lời..."></textarea>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label for="editIsTrue"
                                       class="block text-sm font-semibold text-gray-700 mb-2">Là đáp án đúng?
                                    <span
                                        class="text-red-500">*</span></label>
                                <select id="editIsTrue" name="isTrue" required
                                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                    <option value="false">Không (Sai)</option>
                                    <option value="true">Có (Đúng)</option>
                                </select>
                            </div>
                            <div>
                                <label for="editTypeDisplay"
                                       class="block text-sm font-semibold text-gray-700 mb-2">Loại (theo câu hỏi)</label>
                                <input type="text" id="editTypeDisplay" name="typeDisplay" readonly
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg bg-gray-100 text-gray-700"
                                       placeholder="Chọn câu hỏi để hiển thị loại...">
                            </div>
                        </div>
                        <script>
                            // Show type of selected quiz (in Edit Modal)
                            document.addEventListener('DOMContentLoaded', function () {
                                var quizzes = [];
                                <% if (quizzes != null) { for (Quiz quiz : quizzes) { %>
                                    quizzes.push({id: "<%= quiz.getId() %>", type: "<%= quiz.getType() != null ? quiz.getType().replace("\"", "&quot;") : "" %>"});
                                <% } } %>
                                function updateEditQuizType() {
                                    var select = document.getElementById('editQuizId');
                                    var typeInput = document.getElementById('editTypeDisplay');
                                    var selectedId = select.value;
                                    var q = quizzes.find(function(qz){ return qz.id === selectedId; });
                                    typeInput.value = q ? q.type : '';
                                }
                                var selectQuiz = document.getElementById('editQuizId');
                                if(selectQuiz) {
                                    selectQuiz.addEventListener('change', updateEditQuizType);
                                }
                                // Also update when opening edit modal
                                window.updateEditQuizType = updateEditQuizType;
                            });
                        </script>
                    </div>

                    <div
                        class="flex flex-col sm:flex-row gap-3 p-6 border-t border-gray-200 bg-gray-50 rounded-b-xl">
                        <button type="submit"
                                class="inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition shadow-sm">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                 viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                  stroke-width="2" d="M5 13l4 4L19 7"></path>
                            </svg>
                            Lưu thay đổi
                        </button>
                        <button type="button" onclick="closeEditModal()"
                                class="inline-flex items-center justify-center px-6 py-3 bg-white border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition">
                            Hủy
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <div id="deleteModal"
             class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 z-50 flex items-center justify-center p-4">
            <div class="bg-white rounded-xl shadow-2xl w-full max-w-md">
                <div class="flex items-center justify-between p-6 border-b border-gray-200">
                    <h2 class="text-xl font-bold text-gray-900">Xóa câu trả lời</h2>
                    <button onclick="closeDeleteModal()"
                            class="text-gray-400 hover:text-gray-600 transition">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor"
                             viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>

                <div class="p-6">
                    <div
                        class="flex items-center justify-center w-12 h-12 mx-auto bg-red-100 rounded-full mb-4">
                        <svg class="w-6 h-6 text-red-600" fill="none" stroke="currentColor"
                             viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              stroke-width="2"
                              d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z">
                        </path>
                        </svg>
                    </div>
                    <h3 class="text-lg font-medium text-gray-900 text-center mb-2">Bạn có chắc chắn muốn xóa câu trả lời này không?</h3>
                    <p class="text-sm text-gray-500 text-center mb-4">Hành động này không thể hoàn tác.</p>
                    <div class="bg-gray-50 rounded-lg p-4 mb-4">
                        <p class="text-sm text-gray-700 font-medium">Câu trả lời:</p>
                        <p id="deleteAnswerContent"
                           class="text-sm text-gray-600 mt-1 line-clamp-3"></p>
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/instructor/quiz-answers"
                      method="POST">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" id="deleteAnswerId">
                    <div
                        class="flex flex-col sm:flex-row gap-3 p-6 border-t border-gray-200 bg-gray-50 rounded-b-xl">
                        <button type="submit"
                                class="inline-flex items-center justify-center px-6 py-3 bg-red-600 text-white font-semibold rounded-lg hover:bg-red-700 transition shadow-sm">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                 viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                  stroke-width="2"
                                  d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16">
                            </path>
                            </svg>
                            Xóa câu trả lời
                        </button>
                        <button type="button" onclick="closeDeleteModal()"
                                class="inline-flex items-center justify-center px-6 py-3 bg-white border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition">
                            Hủy
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            document.getElementById('addModal').addEventListener('click', function (e) {
                if (e.target === this)
                    closeAddModal();
            });
            document.getElementById('editModal').addEventListener('click', function (e) {
                if (e.target === this)
                    closeEditModal();
            });
            document.getElementById('deleteModal').addEventListener('click', function (e) {
                if (e.target === this)
                    closeDeleteModal();
            });
        </script>
    </body>

</html>