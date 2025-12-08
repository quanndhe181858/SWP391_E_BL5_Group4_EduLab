<%-- Document : quizList Created on : Dec 5, 2024 Author : Le Minh Duc --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <%@page import="java.util.List" %>
                <%@page import="model.Quiz" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                        <title>Quiz Management - EduLab</title>
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
                            <!-- Page Header -->
                            <div class="mb-8">
                                <div
                                    class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                                    <div>
                                        <h1 class="text-3xl font-bold text-gray-900">Quiz Management</h1>
                                        <p class="text-lg text-gray-600 mt-1">Create, edit, and manage your quiz
                                            questions</p>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/instructor/quizes?action=add"
                                        class="inline-flex items-center px-4 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition shadow-sm">
                                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M12 4v16m8-8H4"></path>
                                        </svg>
                                        Add New Quiz
                                    </a>
                                </div>
                            </div>

                            <form id="filterForm" method="get"
                                action="${pageContext.request.contextPath}/instructor/quizes">
                                <input type="hidden" name="action" value="list">
                                <input type="hidden" name="page" id="pageInput"
                                    value="${param.page != null ? param.page : 1}">

                                <div class="flex flex-col lg:flex-row gap-6">
                                    <!-- Sidebar Filters -->
                                    <aside class="w-full lg:w-1/4">
                                        <div class="bg-white p-6 rounded-lg shadow-sm sticky top-4">
                                            <h2 class="text-xl font-bold text-gray-900 mb-6">Filters</h2>

                                            <!-- Search -->
                                            <div class="mb-6">
                                                <label for="search"
                                                    class="block text-sm font-semibold text-gray-700 mb-2">Search</label>
                                                <div class="relative">
                                                    <input
                                                        class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                                        type="text" placeholder="Search quizzes..." id="search"
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

                                            <!-- Quiz Type Filter -->
                                            <div class="mb-6">
                                                <label for="type"
                                                    class="block text-sm font-semibold text-gray-700 mb-2">Question
                                                    Type</label>
                                                <select id="type" name="type"
                                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white"
                                                    onchange="submitFilter()">
                                                    <option value="">All Types</option>
                                                    <option value="Multiple Choice" ${param.type=='Multiple Choice'
                                                        ? 'selected' : '' }>Multiple Choice</option>
                                                    <option value="True/False" ${param.type=='True/False' ? 'selected'
                                                        : '' }>True/False</option>
                                                    <option value="Short Answer" ${param.type=='Short Answer'
                                                        ? 'selected' : '' }>Short Answer</option>
                                                    <option value="Essay" ${param.type=='Essay' ? 'selected' : '' }>
                                                        Essay</option>
                                                    <option value="Fill in the Blank" ${param.type=='Fill in the Blank'
                                                        ? 'selected' : '' }>Fill in the Blank</option>
                                                    <option value="Matching" ${param.type=='Matching' ? 'selected' : ''
                                                        }>Matching</option>
                                                </select>
                                            </div>

                                            <!-- Category Filter -->
                                            <div class="mb-6">
                                                <label for="categoryId"
                                                    class="block text-sm font-semibold text-gray-700 mb-2">Category</label>
                                                <select id="categoryId" name="categoryId"
                                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white"
                                                    onchange="submitFilter()">
                                                    <option value="">All Categories</option>
                                                    <option value="1" ${param.categoryId=='1' ? 'selected' : '' }>
                                                        Programming</option>
                                                    <option value="2" ${param.categoryId=='2' ? 'selected' : '' }>
                                                        Mathematics</option>
                                                    <option value="3" ${param.categoryId=='3' ? 'selected' : '' }>
                                                        Science</option>
                                                    <option value="4" ${param.categoryId=='4' ? 'selected' : '' }>
                                                        History</option>
                                                    <option value="5" ${param.categoryId=='5' ? 'selected' : '' }>
                                                        Language Arts</option>
                                                    <option value="6" ${param.categoryId=='6' ? 'selected' : '' }>
                                                        Business</option>
                                                </select>
                                            </div>

                                            <button type="button" onclick="clearFilters()"
                                                class="w-full px-4 py-2 text-sm font-medium text-blue-600 border border-blue-600 rounded-lg hover:bg-blue-50 transition">
                                                Clear All Filters
                                            </button>
                                        </div>
                                    </aside>

                                    <!-- Main Content -->
                                    <main class="w-full lg:w-3/4">
                                        <div class="bg-white rounded-lg shadow-sm">
                                            <!-- Header with Stats -->
                                            <div class="p-6 border-b border-gray-200">
                                                <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                                                    <div class="bg-blue-50 p-4 rounded-lg">
                                                        <p class="text-sm text-blue-600 font-semibold">Total Quizzes</p>
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
                                                        <p class="text-sm text-yellow-600 font-semibold">True/False</p>
                                                        <p class="text-2xl font-bold text-gray-900 mt-1">
                                                            ${trueFalseCount != null ? trueFalseCount : 0}</p>
                                                    </div>
                                                    <div class="bg-purple-50 p-4 rounded-lg">
                                                        <p class="text-sm text-purple-600 font-semibold">Other Types</p>
                                                        <p class="text-2xl font-bold text-gray-900 mt-1">
                                                            ${otherTypesCount != null ? otherTypesCount : 0}</p>
                                                    </div>
                                                </div>

                                                <div
                                                    class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                                                    <div>
                                                        <p class="text-sm text-gray-600">Showing ${startItem != null ?
                                                            startItem : 1}-${endItem != null ? endItem : 0} of
                                                            ${totalQuizzes != null ? totalQuizzes : 0} quizzes</p>
                                                    </div>
                                                    <div class="flex items-center gap-3">
                                                        <label class="text-sm text-gray-700">Sort by:</label>
                                                        <select name="sortBy"
                                                            class="px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm bg-white"
                                                            onchange="submitFilter()">
                                                            <option value="updated_desc" ${param.sortBy=='updated_desc'
                                                                || param.sortBy==null ? 'selected' : '' }>Recently
                                                                Updated</option>
                                                            <option value="question_asc" ${param.sortBy=='question_asc'
                                                                ? 'selected' : '' }>Question (A-Z)</option>
                                                            <option value="created_desc" ${param.sortBy=='created_desc'
                                                                ? 'selected' : '' }>Newest First</option>
                                                            <option value="created_asc" ${param.sortBy=='created_asc'
                                                                ? 'selected' : '' }>Oldest First</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                                        <!-- Pagination -->
                                                <c:if test="${totalPages > 1}">
                                                    <div class="mt-8 flex justify-center">
                                                        <nav class="inline-flex rounded-md shadow-sm -space-x-px"
                                                            aria-label="Pagination">
                                                            <!-- Previous Button -->
                                                            <c:choose>
                                                                <c:when test="${page > 1}">
                                                                    <a href="javascript:void(0)"
                                                                        onclick="goToPage(${page - 1})"
                                                                        class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                                                        <span class="sr-only">Previous</span>
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

                                                            <!-- Page Numbers -->
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

                                                            <!-- Next Button -->
                                                            <c:choose>
                                                                <c:when test="${page < totalPages}">
                                                                    <a href="javascript:void(0)"
                                                                        onclick="goToPage(${page + 1})"
                                                                        class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                                                        <span class="sr-only">Next</span>
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
                                            <!-- Quiz List -->
                                            <div class="p-6">
                                                <div class="space-y-4">
                                                    <% List<Quiz> quizList = (List<Quiz>)
                                                            request.getAttribute("quizList");
                                                            if (quizList != null && !quizList.isEmpty()) {
                                                            for (Quiz quiz : quizList) { %>
                                                            <div
                                                                class="border border-gray-200 rounded-lg p-6 hover:shadow-md transition">
                                                                <div class="flex flex-col md:flex-row gap-6">
                                                                    <!-- Quiz Icon -->
                                                                    <div
                                                                        class="w-full md:w-16 h-16 bg-gradient-to-br from-indigo-400 to-indigo-600 rounded-lg flex-shrink-0 flex items-center justify-center">
                                                                        <svg class="w-8 h-8 text-white" fill="none"
                                                                            stroke="currentColor" viewBox="0 0 24 24">
                                                                            <path stroke-linecap="round"
                                                                                stroke-linejoin="round" stroke-width="2"
                                                                                d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z">
                                                                            </path>
                                                                        </svg>
                                                                    </div>

                                                                    <div class="flex-grow">
                                                                        <div
                                                                            class="flex items-start justify-between mb-2">
                                                                            <div class="flex-grow">
                                                                                <div
                                                                                    class="flex items-center gap-2 mb-2 flex-wrap">
                                                                                    <span
                                                                                        class="px-2 py-1 text-xs font-semibold text-indigo-600 bg-indigo-100 rounded">
                                                                                        <%= quiz.getType() %>
                                                                                    </span>
                                                                                    <span
                                                                                        class="px-2 py-1 text-xs font-semibold text-gray-600 bg-gray-100 rounded">Category:
                                                                                        <%= quiz.getCategory_id() %>
                                                                                    </span>
                                                                                    <span
                                                                                        class="px-2 py-1 text-xs font-semibold text-blue-600 bg-blue-100 rounded">ID:
                                                                                        <%= quiz.getId() %>
                                                                                    </span>
                                                                                </div>
                                                                                <h3
                                                                                    class="text-lg font-bold text-gray-900 mb-2 line-clamp-2">
                                                                                    <%= quiz.getQuestion() %>
                                                                                </h3>
                                                                            </div>
                                                                        </div>

                                                                        <div
                                                                            class="flex flex-wrap items-center gap-4 text-sm text-gray-600 mb-4">
                                                                            <div class="flex items-center">
                                                                                <svg class="w-4 h-4 mr-1" fill="none"
                                                                                    stroke="currentColor"
                                                                                    viewBox="0 0 24 24">
                                                                                    <path stroke-linecap="round"
                                                                                        stroke-linejoin="round"
                                                                                        stroke-width="2"
                                                                                        d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z">
                                                                                    </path>
                                                                                </svg>
                                                                                <span>Created: <%= quiz.getCreated_at()
                                                                                        !=null ? quiz.getCreated_at()
                                                                                        : "N/A" %></span>
                                                                            </div>
                                                                            <div class="flex items-center">
                                                                                <svg class="w-4 h-4 mr-1" fill="none"
                                                                                    stroke="currentColor"
                                                                                    viewBox="0 0 24 24">
                                                                                    <path stroke-linecap="round"
                                                                                        stroke-linejoin="round"
                                                                                        stroke-width="2"
                                                                                        d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z">
                                                                                    </path>
                                                                                </svg>
                                                                                <span>Updated: <%= quiz.getUpdated_at()
                                                                                        !=null ? quiz.getUpdated_at()
                                                                                        : "N/A" %></span>
                                                                            </div>
                                                                        </div>

                                                                        <!-- Action Buttons -->
                                                                        <div class="flex flex-wrap gap-2">
                                                                            <% String questionText=quiz.getQuestion();
                                                                                String safeQuestion="" ; if
                                                                                (questionText !=null) {
                                                                                safeQuestion=questionText.replace("\"", "&quot;"
                                                                                ).replace("\n", " " ).replace("\r", ""
                                                                                ); } %>
                                                                                <button type="button"
                                                                                    class="edit-quiz-btn inline-flex items-center px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 transition"
                                                                                    data-id="<%= quiz.getId() %>"
                                                                                    data-question="<%= safeQuestion %>"
                                                                                    data-type="<%= quiz.getType() %>"
                                                                                    data-category="<%= quiz.getCategory_id() %>">
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
                                                                                    Edit
                                                                                </button>
                                                                                <button type="button"
                                                                                    class="delete-quiz-btn inline-flex items-center px-4 py-2 bg-red-600 text-white text-sm font-medium rounded-lg hover:bg-red-700 transition"
                                                                                    data-id="<%= quiz.getId() %>"
                                                                                    data-question="<%= safeQuestion %>">
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
                                                                                    Delete
                                                                                </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <% } } else { %>
                                                                <!-- Empty State -->
                                                                <div class="text-center py-12">
                                                                    <svg class="mx-auto h-12 w-12 text-gray-400"
                                                                        fill="none" stroke="currentColor"
                                                                        viewBox="0 0 24 24">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z">
                                                                        </path>
                                                                    </svg>
                                                                    <h3 class="mt-2 text-sm font-medium text-gray-900">
                                                                        No quizzes found</h3>
                                                                    <p class="mt-1 text-sm text-gray-500">Get started by
                                                                        creating a new quiz question.</p>
                                                                    <div class="mt-6">
                                                                        <a href="${pageContext.request.contextPath}/instructor/quizes?action=add"
                                                                            class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                                                            <svg class="w-5 h-5 mr-2" fill="none"
                                                                                stroke="currentColor"
                                                                                viewBox="0 0 24 24">
                                                                                <path stroke-linecap="round"
                                                                                    stroke-linejoin="round"
                                                                                    stroke-width="2" d="M12 4v16m8-8H4">
                                                                                </path>
                                                                            </svg>
                                                                            Add New Quiz
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                                <% } %>
                                                </div>
                                            </div>
                                        </div>
                                    </main>
                                </div>
                            </form>
                        </div>

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />
        
                        <!-- Toast Notification -->
                        <% String notification=(String) session.getAttribute("notification"); String nType=(String)
                            session.getAttribute("notificationType"); if (notification !=null) { %>
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
                            <% session.removeAttribute("notification"); session.removeAttribute("notificationType"); }
                                %>

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
                                        window.location.href = '${pageContext.request.contextPath}/instructor/quizes?action=list';
                                    }


                                    // Search on Enter key
                                    document.getElementById('search').addEventListener('keypress', function (e) {
                                        if (e.key === 'Enter') {
                                            e.preventDefault();
                                            submitFilter();
                                        }
                                    });

                                    // Open Edit Modal - attach click handlers to edit buttons
                                    document.querySelectorAll('.edit-quiz-btn').forEach(function (btn) {
                                        btn.addEventListener('click', function (e) {
                                            e.preventDefault();
                                            e.stopPropagation();

                                            var id = this.getAttribute('data-id');
                                            var question = this.getAttribute('data-question');
                                            var type = this.getAttribute('data-type');
                                            var categoryId = this.getAttribute('data-category');

                                            document.getElementById('editQuizId').value = id;
                                            document.getElementById('editQuestion').value = question;
                                            document.getElementById('editType').value = type;
                                            document.getElementById('editCategoryId').value = categoryId;
                                            document.getElementById('editModal').classList.remove('hidden');
                                            document.body.style.overflow = 'hidden';
                                        });
                                    });

                                    // Close Edit Modal
                                    function closeEditModal() {
                                        document.getElementById('editModal').classList.add('hidden');
                                        document.body.style.overflow = 'auto';
                                    }

                                    // Close modal when clicking outside
                                    var editModalEl = document.getElementById('editModal');
                                    if (editModalEl) {
                                        editModalEl.addEventListener('click', function (e) {
                                            if (e.target === this) {
                                                closeEditModal();
                                            }
                                        });
                                    }

                                    // Close modal on Escape key
                                    document.addEventListener('keydown', function (e) {
                                        if (e.key === 'Escape') {
                                            closeEditModal();
                                            closeDeleteModal();
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

                                <!-- Edit Quiz Modal -->
                                <div id="editModal"
                                    class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 z-50 flex items-center justify-center p-4">
                                    <div
                                        class="bg-white rounded-xl shadow-2xl w-full max-w-2xl max-h-[90vh] overflow-y-auto">
                                        <!-- Modal Header -->
                                        <div class="flex items-center justify-between p-6 border-b border-gray-200">
                                            <h2 class="text-2xl font-bold text-gray-900">Edit Quiz</h2>
                                            <button onclick="closeEditModal()"
                                                class="text-gray-400 hover:text-gray-600 transition">
                                                <svg class="w-6 h-6" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                                                </svg>
                                            </button>
                                        </div>

                                        <!-- Modal Body -->
                                        <form action="${pageContext.request.contextPath}/instructor/quizes"
                                            method="POST">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="id" id="editQuizId">

                                            <div class="p-6 space-y-6">
                                                <!-- Question Field -->
                                                <div>
                                                    <label for="editQuestion"
                                                        class="block text-sm font-semibold text-gray-700 mb-2">
                                                        Question <span class="text-red-500">*</span>
                                                    </label>
                                                    <textarea id="editQuestion" name="question" required rows="4"
                                                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                                        placeholder="Enter your quiz question here..."></textarea>
                                                </div>

                                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                                    <!-- Type Field -->
                                                    <div>
                                                        <label for="editType"
                                                            class="block text-sm font-semibold text-gray-700 mb-2">
                                                            Question Type <span class="text-red-500">*</span>
                                                        </label>
                                                        <select id="editType" name="type" required
                                                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                                            <option value="">-- Select Question Type --</option>
                                                            <option value="Multiple Choice">Multiple Choice</option>
                                                            <option value="True/False">True/False</option>
                                                            <option value="Short Answer">Short Answer</option>
                                                            <option value="Essay">Essay</option>
                                                            <option value="Fill in the Blank">Fill in the Blank</option>
                                                            <option value="Matching">Matching</option>
                                                        </select>
                                                    </div>

                                                    <!-- Category Field -->
                                                    <div>
                                                        <label for="editCategoryId"
                                                            class="block text-sm font-semibold text-gray-700 mb-2">
                                                            Category <span class="text-red-500">*</span>
                                                        </label>
                                                        <select id="editCategoryId" name="categoryId" required
                                                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                                            <option value="">-- Select Category --</option>
                                                            <option value="1">Programming</option>
                                                            <option value="2">Mathematics</option>
                                                            <option value="3">Science</option>
                                                            <option value="4">History</option>
                                                            <option value="5">Language Arts</option>
                                                            <option value="6">Business</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Modal Footer -->
                                            <div
                                                class="flex flex-col sm:flex-row gap-3 p-6 border-t border-gray-200 bg-gray-50 rounded-b-xl">
                                                <button type="submit"
                                                    class="inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition shadow-sm">
                                                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                                        viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                    </svg>
                                                    Save Changes
                                                </button>
                                                <button type="button" onclick="closeEditModal()"
                                                    class="inline-flex items-center justify-center px-6 py-3 bg-white border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition">
                                                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                                        viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                                                    </svg>
                                                    Cancel
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <!-- Delete Quiz Confirmation Modal -->
                                <div id="deleteModal"
                                    class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 z-50 flex items-center justify-center p-4">
                                    <div class="bg-white rounded-xl shadow-2xl w-full max-w-md">
                                        <!-- Modal Header -->
                                        <div class="flex items-center justify-between p-6 border-b border-gray-200">
                                            <h2 class="text-xl font-bold text-gray-900">Delete Quiz</h2>
                                            <button onclick="closeDeleteModal()"
                                                class="text-gray-400 hover:text-gray-600 transition">
                                                <svg class="w-6 h-6" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                                                </svg>
                                            </button>
                                        </div>

                                        <!-- Modal Body -->
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
                                            <h3 class="text-lg font-medium text-gray-900 text-center mb-2">Are you sure
                                                you want to delete this quiz?</h3>
                                            <p class="text-sm text-gray-500 text-center mb-4">This action cannot be
                                                undone.</p>
                                            <div class="bg-gray-50 rounded-lg p-4 mb-4">
                                                <p class="text-sm text-gray-700 font-medium">Question:</p>
                                                <p id="deleteQuizQuestion"
                                                    class="text-sm text-gray-600 mt-1 line-clamp-3"></p>
                                            </div>
                                        </div>

                                        <!-- Modal Footer -->
                                        <form action="${pageContext.request.contextPath}/instructor/quizes"
                                            method="POST">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" id="deleteQuizId">
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
                                                    Delete Quiz
                                                </button>
                                                <button type="button" onclick="closeDeleteModal()"
                                                    class="inline-flex items-center justify-center px-6 py-3 bg-white border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition">
                                                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                                        viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                                                    </svg>
                                                    Cancel
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <!-- Script for delete modal click-outside -->
                                <script>
                                    // Close delete modal when clicking outside
                                    document.getElementById('deleteModal').addEventListener('click', function (e) {
                                        if (e.target === this) {
                                            closeDeleteModal();
                                        }
                                    });
                                </script>
                    </body>

                    </html>