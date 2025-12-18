<%-- Document : quizList Created on : Dec 5, 2024 Author : Le Minh Duc --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <%@page import="java.util.List" %>
                <%@page import="model.Quiz" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                        <title>Quản lý câu hỏi - EduLab</title>
                        <jsp:include page="/layout/import.jsp" />
                    </head>

                    <body class="bg-gray-50">
                        <jsp:include page="/layout/header.jsp" />

                        <div class="container mx-auto px-4 py-8">
                            <div class="mb-8">
                                <div
                                    class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                                    <div>
                                        <h1 class="text-3xl font-bold text-gray-900">Quản lý câu hỏi</h1>
                                        <p class="text-lg text-gray-600 mt-1">Tạo, chỉnh sửa và quản lý các câu hỏi của
                                            bạn</p>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/instructor/quizzes?action=add"
                                        class="inline-flex items-center px-4 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition shadow-sm">
                                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M12 4v16m8-8H4"></path>
                                        </svg>
                                        Thêm câu hỏi mới
                                    </a>
                                </div>
                            </div>

                            <form id="filterForm" method="get"
                                action="${pageContext.request.contextPath}/instructor/quizzes">
                                <input type="hidden" name="action" value="list">
                                <input type="hidden" name="page" id="pageInput"
                                    value="${param.page != null ? param.page : 1}">

                                <div class="flex flex-col lg:flex-row gap-6">
                                    <aside class="w-full lg:w-1/4">
                                        <div class="bg-white p-6 rounded-lg shadow-sm sticky top-4">
                                            <h2 class="text-xl font-bold text-gray-900 mb-6">Bộ lọc</h2>

                                            <div class="mb-6">
                                                <label for="search"
                                                    class="block text-sm font-semibold text-gray-700 mb-2">Tìm
                                                    kiếm</label>
                                                <div class="relative">
                                                    <input
                                                        class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                                        type="text" placeholder="Tìm câu hỏi..." id="search"
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
                                                <label for="type"
                                                    class="block text-sm font-semibold text-gray-700 mb-2">Loại câu
                                                    hỏi</label>
                                                <select id="type" name="type"
                                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white"
                                                    onchange="submitFilter()">
                                                    <option value="">Tất cả các loại</option>
                                                    <option value="Multiple Choice" ${param.type=='Multiple Choice'
                                                        ? 'selected' : '' }>Multiple Choice</option>
                                                    <option value="Single Choice" ${param.type=='Single Choice'
                                                        ? 'selected' : '' }>Single Choice</option>
                                                </select>
                                            </div>

                                            <div class="mb-6">
                                                <label for="categoryId"
                                                    class="block text-sm font-semibold text-gray-700 mb-2">Danh
                                                    mục</label>
                                                <select id="categoryId" name="categoryId"
                                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white"
                                                    onchange="submitFilter()">
                                                    <option value="">Tất cả danh mục</option>
                                                    <c:forEach var="category" items="${categories}">
                                                        <option value="${category.id}" ${param.categoryId==category.id
                                                            ? 'selected' : '' }> ${category.name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <button type="button" onclick="clearFilters()"
                                                class="w-full px-4 py-2 text-sm font-medium text-blue-600 border border-blue-600 rounded-lg hover:bg-blue-50 transition">
                                                Xóa tất cả bộ lọc
                                            </button>
                                        </div>
                                    </aside>

                                    <main class="w-full lg:w-3/4">
                                        <div class="bg-white rounded-lg shadow-sm">
                                            <div class="p-6 border-b border-gray-200">
                                                <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                                                    <div class="bg-blue-50 p-4 rounded-lg">
                                                        <p class="text-sm text-blue-600 font-semibold">Tổng số câu hỏi
                                                        </p>
                                                        <p class="text-2xl font-bold text-gray-900 mt-1">${totalQuizzes
                                                            != null ? totalQuizzes : 0}</p>
                                                    </div>
                                                    <div class="bg-green-50 p-4 rounded-lg">
                                                        <p class="text-sm text-green-600 font-semibold">Multiple Choice
                                                        </p>
                                                        <p class="text-2xl font-bold text-gray-900 mt-1">
                                                            ${multipleChoiceCount != null ? multipleChoiceCount : 0}</p>
                                                    </div>
                                                    <div class="bg-yellow-50 p-4 rounded-lg">
                                                        <p class="text-sm text-yellow-600 font-semibold">Single Choice
                                                        </p>
                                                        <p class="text-2xl font-bold text-gray-900 mt-1">
                                                            ${singleChoiceCount != null ? singleChoiceCount : 0}</p>
                                                    </div>
                                                </div>

                                                <div
                                                    class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                                                    <div>
                                                        <p class="text-sm text-gray-600">Hiển thị ${startItem != null ?
                                                            startItem : 1}-${endItem != null ? endItem : 0}
                                                            trong tổng số
                                                            ${totalQuizzes != null ? totalQuizzes : 0} câu hỏi</p>
                                                    </div>
                                                    <div class="flex items-center gap-3">
                                                        <label class="text-sm text-gray-700">Sắp xếp:</label>
                                                        <select name="sortBy"
                                                            class="px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm bg-white"
                                                            onchange="submitFilter()">
                                                            <option value="updated_desc" ${param.sortBy=='updated_desc'
                                                                ? 'selected' : '' }>Mới cập nhật</option>
                                                            <option value="question_asc" ${param.sortBy=='question_asc'
                                                                ? 'selected' : '' }>Câu hỏi (A-Z)</option>
                                                            <option value="created_desc" ${param.sortBy=='created_desc'
                                                                || param.sortBy==null ? 'selected' : '' }>Mới nhất
                                                            </option>
                                                            <option value="created_asc" ${param.sortBy=='created_asc'
                                                                ? 'selected' : '' }>Cũ nhất</option>
                                                        </select>
                                                    </div>
                                                </div>
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
                                                                    <span class="sr-only">Trước</span>
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
                                                                        class="relative inline-flex items-center px-4 py-2 border border-blue-500 bg-blue-50 text-sm font-medium text-blue-600">
                                                                        ${i}
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a href="javascript:void(0)"
                                                                        onclick="goToPage(${i})"
                                                                        class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
                                                                        ${i}
                                                                    </a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>

                                                        <c:choose>
                                                            <c:when test="${page < totalPages}">
                                                                <a href="javascript:void(0)"
                                                                    onclick="goToPage(${page + 1})"
                                                                    class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                                                    <span class="sr-only">Sau</span>
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
                                            <div class="p-6">
                                                <div class="overflow-x-auto">
                                                    <table class="min-w-full divide-y divide-gray-200">
                                                        <thead class="bg-gray-50">
                                                            <tr>
                                                                <th scope="col"
                                                                    class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider w-16">
                                                                    ID</th>
                                                                <th scope="col"
                                                                    class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider">
                                                                    Câu hỏi</th>
                                                                <th scope="col"
                                                                    class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider w-32">
                                                                    Loại</th>
                                                                <th scope="col"
                                                                    class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider w-40">
                                                                    Danh mục</th>
                                                                <th scope="col"
                                                                    class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider w-32">
                                                                    Trạng thái</th>
                                                                <th scope="col"
                                                                    class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider w-48">
                                                                    Thao tác</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody class="bg-white divide-y divide-gray-200">
                                                            <% List<Quiz> quizList = (List<Quiz>)
                                                                    request.getAttribute("quizList");
                                                                    if (quizList != null && !quizList.isEmpty()) {
                                                                    for (Quiz quiz : quizList) { %>
                                                                    <tr class="hover:bg-gray-50 transition-colors">
                                                                        <td
                                                                            class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                                            #<%= quiz.getId() %>
                                                                        </td>
                                                                        <td class="px-6 py-4">
                                                                            <div class="text-sm text-gray-900 font-medium line-clamp-2"
                                                                                title="<%= quiz.getQuestion() %>">
                                                                                <%= quiz.getQuestion() %>
                                                                            </div>
                                                                            <div class="text-xs text-gray-400 mt-1">
                                                                                Cập nhật: <%= quiz.getUpdated_at()
                                                                                    !=null ? quiz.getUpdated_at()
                                                                                    : "N/A" %>
                                                                            </div>
                                                                        </td>
                                                                        <td class="px-6 py-4 whitespace-nowrap">
                                                                            <span class="px-2.5 py-1 inline-flex text-xs leading-4 font-semibold rounded-full
                                                          <%= " Multiple Choice".equals(quiz.getType())
                                                                                ? "bg-purple-100 text-purple-800"
                                                                                : "bg-blue-100 text-blue-800" %>">
                                                                                <%= quiz.getType() %>
                                                                            </span>
                                                                        </td>
                                                                        <td
                                                                            class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                                            <%= quiz.getCategory() !=null ?
                                                                                quiz.getCategory().getName() : "N/A" %>
                                                                        </td>
                                                                        <td class="px-6 py-4 whitespace-nowrap">
                                                                            <% boolean isHidden="Hidden"
                                                                                .equalsIgnoreCase(quiz.getStatus()); %>
                                                                                <span class="px-2.5 py-1 inline-flex text-xs leading-4 font-semibold rounded-full
                                                          <%= isHidden ? " bg-red-100 text-red-800"
                                                                                    : "bg-green-100 text-green-800" %>">
                                                                                    <%= isHidden ? "Bị khoá bởi quản trị viên"
                                                                                        : "Đang hoạt động" %>
                                                                                </span>
                                                                        </td>
                                                                        <td
                                                                            class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                                                            <div class="flex items-center gap-3">
                                                                                <% if (!isHidden) { %>
                                                                                    <a href="${pageContext.request.contextPath}/instructor/quizzes?action=edit&id=<%= quiz.getId() %>#answers-section"
                                                                                        class="text-green-600 hover:text-green-900 flex items-center"
                                                                                        title="Thêm câu trả lời">
                                                                                        <svg class="w-4 h-4" fill="none"
                                                                                            stroke="currentColor"
                                                                                            viewBox="0 0 24 24">
                                                                                            <path stroke-linecap="round"
                                                                                                stroke-linejoin="round"
                                                                                                stroke-width="2"
                                                                                                d="M12 4v16m8-8H4">
                                                                                            </path>
                                                                                        </svg>
                                                                                    </a>
                                                                                    <a href="${pageContext.request.contextPath}/instructor/quizzes?action=edit&id=<%= quiz.getId() %>"
                                                                                        class="text-blue-600 hover:text-blue-900 flex items-center"
                                                                                        title="Sửa">
                                                                                        <svg class="w-4 h-4" fill="none"
                                                                                            stroke="currentColor"
                                                                                            viewBox="0 0 24 24">
                                                                                            <path stroke-linecap="round"
                                                                                                stroke-linejoin="round"
                                                                                                stroke-width="2"
                                                                                                d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z">
                                                                                            </path>
                                                                                        </svg>
                                                                                    </a>
                                                                                    <% String
                                                                                        safeQuestion=quiz.getQuestion()
                                                                                        !=null ?
                                                                                        quiz.getQuestion().replace("\"", "&quot;"
                                                                                        ).replace("\n", " "
                                                                                        ).replace("\r", "" ) : "" ; %>
                                                                                        <button type="button"
                                                                                            class="delete-quiz-btn text-red-600 hover:text-red-900 flex items-center"
                                                                                            data-id="<%= quiz.getId() %>"
                                                                                            data-question="<%= safeQuestion %>"
                                                                                            title="Xóa">
                                                                                            <svg class="w-4 h-4"
                                                                                                fill="none"
                                                                                                stroke="currentColor"
                                                                                                viewBox="0 0 24 24">
                                                                                                <path
                                                                                                    stroke-linecap="round"
                                                                                                    stroke-linejoin="round"
                                                                                                    stroke-width="2"
                                                                                                    d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16">
                                                                                                </path>
                                                                                            </svg>
                                                                                        </button>
                                                                                        <% } else { %>
                                                                                            <span
                                                                                                class="text-gray-400 italic text-xs">Không
                                                                                                có hành động</span>
                                                                                            <% } %>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <% } } else { %>
                                                                        <tr>
                                                                            <td colspan="6"
                                                                                class="px-6 py-12 text-center">
                                                                                <svg class="mx-auto h-12 w-12 text-gray-400"
                                                                                    fill="none" stroke="currentColor"
                                                                                    viewBox="0 0 24 24">
                                                                                    <path stroke-linecap="round"
                                                                                        stroke-linejoin="round"
                                                                                        stroke-width="2"
                                                                                        d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z">
                                                                                    </path>
                                                                                </svg>
                                                                                <h3
                                                                                    class="mt-2 text-sm font-medium text-gray-900">
                                                                                    Không tìm thấy câu hỏi nào</h3>
                                                                                <p class="mt-1 text-sm text-gray-500">
                                                                                    Bắt đầu bằng cách tạo một câu hỏi
                                                                                    mới.</p>
                                                                                <div class="mt-6">
                                                                                    <a href="${pageContext.request.contextPath}/instructor/quizzes?action=add"
                                                                                        class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                                                                        Thêm câu hỏi mới
                                                                                    </a>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <% } %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </main>
                                </div>
                            </form>
                        </div>

                        <div id="deleteModal"
                            class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 z-50 flex items-center justify-center p-4">
                            <div class="bg-white rounded-xl shadow-2xl w-full max-w-md">
                                <div class="flex items-center justify-between p-6 border-b border-gray-200">
                                    <h2 class="text-xl font-bold text-gray-900">Xóa câu hỏi</h2>
                                    <button onclick="closeDeleteModal()"
                                        class="text-gray-400 hover:text-gray-600 transition">
                                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M6 18L18 6M6 6l12 12"></path>
                                        </svg>
                                    </button>
                                </div>

                                <div class="p-6">
                                    <div
                                        class="flex items-center justify-center w-12 h-12 mx-auto bg-red-100 rounded-full mb-4">
                                        <svg class="w-6 h-6 text-red-600" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z">
                                            </path>
                                        </svg>
                                    </div>
                                    <h3 class="text-lg font-medium text-gray-900 text-center mb-2">Bạn có chắc chắn muốn
                                        xóa câu hỏi này không?</h3>
                                    <p class="text-sm text-gray-500 text-center mb-4">Hành động này không thể hoàn tác.
                                    </p>
                                    <div class="bg-gray-50 rounded-lg p-4 mb-4">
                                        <p class="text-sm text-gray-700 font-medium">Câu hỏi:</p>
                                        <p id="deleteQuizQuestion" class="text-sm text-gray-600 mt-1 line-clamp-3"></p>
                                    </div>
                                </div>

                                <form action="${pageContext.request.contextPath}/instructor/quizzes" method="POST">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" id="deleteQuizId">

                                    <!-- Hidden inputs to maintain state after redirect -->
                                    <input type="hidden" name="page" id="deletePage" value="${param.page}">
                                    <input type="hidden" name="search" id="deleteSearch" value="${param.search}">
                                    <input type="hidden" name="type" id="deleteType" value="${param.type}">
                                    <input type="hidden" name="categoryId" id="deleteCategoryId"
                                        value="${param.categoryId}">
                                    <input type="hidden" name="sortBy" id="deleteSortBy" value="${param.sortBy}">

                                    <div
                                        class="flex flex-col sm:flex-row gap-3 p-6 border-t border-gray-200 bg-gray-50 rounded-b-xl">
                                        <button type="submit"
                                            class="inline-flex items-center justify-center px-6 py-3 bg-red-600 text-white font-semibold rounded-lg hover:bg-red-700 transition shadow-sm">
                                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16">
                                                </path>
                                            </svg>
                                            Xóa câu hỏi
                                        </button>
                                        <button type="button" onclick="closeDeleteModal()"
                                            class="inline-flex items-center justify-center px-6 py-3 bg-white border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition">
                                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M6 18L18 6M6 6l12 12"></path>
                                            </svg>
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
                            // Submit filter form
                            function submitFilter() {
                                document.getElementById('pageInput').value = '1';
                                document.getElementById('filterForm').submit();
                            }

                            // Navigate to specific page
                            function goToPage(pageNum) {
                                document.getElementById('pageInput').value = pageNum;
                                document.getElementById('filterForm').submit();
                            }

                            // Clear all filters
                            function clearFilters() {
                                window.location.href = '${pageContext.request.contextPath}/instructor/quizzes?action=list';
                            }

                            // Search on Enter key
                            document.getElementById('search').addEventListener('keypress', function (e) {
                                if (e.key === 'Enter') {
                                    e.preventDefault();
                                    submitFilter();
                                }
                            });

                            // Delete Quiz functionality
                            document.querySelectorAll('.delete-quiz-btn').forEach(function (btn) {
                                btn.addEventListener('click', function (e) {
                                    e.preventDefault();
                                    e.stopPropagation();

                                    var id = this.getAttribute('data-id');
                                    var question = this.getAttribute('data-question');

                                    document.getElementById('deleteQuizId').value = id;
                                    document.getElementById('deleteQuizQuestion').textContent = question;
                                    document.getElementById('deleteModal').classList.remove('hidden');
                                    document.body.style.overflow = 'hidden';
                                });
                            });
                            // Close Delete Modal
                            function closeDeleteModal() {
                                var modal = document.getElementById('deleteModal');
                                if (modal) {
                                    modal.classList.add('hidden');
                                    document.body.style.overflow = 'auto';
                                }
                            }
                        </script>

                    </body>

                    </html>