<%-- Document : addQuiz Created on : Dec 5, 2024 Author : Le Minh Duc --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Add New Quiz - EduLab</title>
                <jsp:include page="/layout/import.jsp" />
            </head>

            <body class="bg-gray-50">
                <jsp:include page="/layout/header.jsp" />

                <div class="container mx-auto px-4 py-8">
                    <!-- Page Header -->
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
                                        Back to Quiz List
                                    </a>
                                </div>
                                <h1 class="text-3xl font-bold text-gray-900">Add New Quiz</h1>
                                <p class="text-lg text-gray-600 mt-1">Create a new quiz question for your courses</p>
                            </div>
                        </div>
                    </div>

                    <div class="flex flex-col lg:flex-row gap-6">
                        <!-- Sidebar Info -->
                        <aside class="w-full lg:w-1/4">
                            <div class="bg-white p-6 rounded-lg shadow-sm sticky top-4">
                                <h2 class="text-xl font-bold text-gray-900 mb-6">Guidelines</h2>

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
                                            <h3 class="text-sm font-semibold text-gray-900">Clear Questions</h3>
                                            <p class="text-xs text-gray-600">Write clear and concise questions that are
                                                easy to understand.</p>
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
                                            <h3 class="text-sm font-semibold text-gray-900">Choose Right Type</h3>
                                            <p class="text-xs text-gray-600">Select the appropriate question type based
                                                on the answer format.</p>
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
                                            <h3 class="text-sm font-semibold text-gray-900">Proper Category</h3>
                                            <p class="text-xs text-gray-600">Categorize your quiz for better
                                                organization and filtering.</p>
                                        </div>
                                    </div>
                                </div>

                                <hr class="my-6 border-gray-200">

                                <div class="bg-blue-50 p-4 rounded-lg">
                                    <h3 class="text-sm font-semibold text-blue-900 mb-2">Need Help?</h3>
                                    <p class="text-xs text-blue-700">Check out our documentation for tips on creating
                                        effective quiz questions.</p>
                                </div>
                            </div>
                        </aside>

                        <!-- Main Form -->
                        <main class="w-full lg:w-3/4">
                            <div class="bg-white rounded-lg shadow-sm">
                                <div class="p-6 border-b border-gray-200">
                                    <h2 class="text-xl font-bold text-gray-900">Quiz Details</h2>
                                    <p class="text-sm text-gray-600 mt-1">Fill in the information below to create your
                                        quiz question</p>
                                </div>

                                <div class="p-6">
                                    <!-- Error Message -->
                                    <% if (request.getAttribute("error") !=null) { %>
                                        <div
                                            class="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg flex items-start gap-3">
                                            <svg class="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" fill="none"
                                                stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                            </svg>
                                            <div>
                                                <h3 class="text-sm font-semibold text-red-800">Error</h3>
                                                <p class="text-sm text-red-700">
                                                    <%= request.getAttribute("error") %>
                                                </p>
                                            </div>
                                        </div>
                                        <% } %>

                                            <form action="${pageContext.request.contextPath}/instructor/quizes"
                                                method="POST">
                                                <input type="hidden" name="action" value="create">

                                                <!-- Question Field -->
                                                <div class="mb-6">
                                                    <label for="question"
                                                        class="block text-sm font-semibold text-gray-700 mb-2">
                                                        Question <span class="text-red-500">*</span>
                                                    </label>
                                                    <textarea id="question" name="question" required rows="4"
                                                        placeholder="Enter your quiz question here..."
                                                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"><%= request.getParameter("question") != null ? request.getParameter("question") : "" %></textarea>
                                                    <p class="mt-2 text-xs text-gray-500">Enter the complete question
                                                        text. Be clear and specific.</p>
                                                </div>

                                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                                    <!-- Type Field -->
                                                    <div>
                                                        <label for="type"
                                                            class="block text-sm font-semibold text-gray-700 mb-2">
                                                            Question Type <span class="text-red-500">*</span>
                                                        </label>
                                                        <select id="type" name="type" required
                                                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                                            <option value="">-- Select Question Type --</option>
                                                            <option value="Multiple Choice" <%="Multiple Choice"
                                                                .equals(request.getParameter("type")) ? "selected" : ""
                                                                %>>
                                                                Multiple Choice
                                                            </option>
                                                            <option value="True/False" <%="True/False"
                                                                .equals(request.getParameter("type")) ? "selected" : ""
                                                                %>>
                                                                True/False
                                                            </option>
                                                            <option value="Short Answer" <%="Short Answer"
                                                                .equals(request.getParameter("type")) ? "selected" : ""
                                                                %>>
                                                                Short Answer
                                                            </option>
                                                            <option value="Essay" <%="Essay"
                                                                .equals(request.getParameter("type")) ? "selected" : ""
                                                                %>>
                                                                Essay
                                                            </option>
                                                            <option value="Fill in the Blank" <%="Fill in the Blank"
                                                                .equals(request.getParameter("type")) ? "selected" : ""
                                                                %>>
                                                                Fill in the Blank
                                                            </option>
                                                            <option value="Matching" <%="Matching"
                                                                .equals(request.getParameter("type")) ? "selected" : ""
                                                                %>>
                                                                Matching
                                                            </option>
                                                        </select>
                                                        <p class="mt-2 text-xs text-gray-500">Select the type of
                                                            question format.</p>
                                                    </div>

                                                    <!-- Category Field -->
                                                    <div>
                                                        <label for="categoryId"
                                                            class="block text-sm font-semibold text-gray-700 mb-2">
                                                            Category <span class="text-red-500">*</span>
                                                        </label>
                                                        <select id="categoryId" name="categoryId" required
                                                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                                            <option value="">-- Select Category --</option>
                                                            <c:forEach var="cat" items="${categories}">
                                                                <option value="${cat.id}" 
                                                                    <c:if test="${cat.id == param.categoryId}">selected</c:if>>
                                                                    ${cat.name}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                        <p class="mt-2 text-xs text-gray-500">Choose the category for
                                                            organization.</p>
                                                    </div>
                                                </div>

                                                <!-- Form Actions -->
                                                <div
                                                    class="flex flex-col sm:flex-row gap-3 pt-6 border-t border-gray-200">
                                                    <button type="submit"
                                                        class="inline-flex items-center justify-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition shadow-sm">
                                                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M12 4v16m8-8H4"></path>
                                                        </svg>
                                                        Create Quiz
                                                    </button>
                                                    <a href="${pageContext.request.contextPath}/instructor/quizes?action=list"
                                                        class="inline-flex items-center justify-center px-6 py-3 bg-white border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition">
                                                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
                                                            viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                                                        </svg>
                                                        Cancel
                                                    </a>
                                                </div>
                                            </form>
                                </div>
                            </div>
                        </main>
                    </div>
                </div>

                <jsp:include page="/layout/footer.jsp" />
            </body>

            </html>