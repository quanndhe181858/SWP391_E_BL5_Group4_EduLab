<%-- Document : View Quiz Detail Created on : Dec 17, 2025 Author : Le Minh Duc --%>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                    <title>Quiz Detail - #${quiz.id}</title>
                    <jsp:include page="/layout/import.jsp" />
                </head>

                <body class="bg-gray-50">
                    <jsp:include page="/layout/header.jsp" />

                    <div class="container mx-auto px-4 py-8">
                        <div class="mb-6">
                            <a href="${pageContext.request.contextPath}/admin/quizzes"
                                class="text-indigo-600 hover:text-indigo-800 flex items-center">
                                <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                                </svg>
                                Back to Quiz List
                            </a>
                        </div>

                        <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                            <div class="px-4 py-5 sm:px-6 flex justify-between items-center">
                                <div>
                                    <h3 class="text-lg leading-6 font-medium text-gray-900">
                                        Quiz Detail #${quiz.id}
                                    </h3>
                                    <p class="mt-1 max-w-2xl text-sm text-gray-500">
                                        Detailed information about the quiz question and answers.
                                    </p>
                                </div>
                                <div>
                                    <span
                                        class="px-3 py-1 inline-flex text-sm leading-5 font-semibold rounded-full ${quiz.status == 'Hidden' ? 'bg-red-100 text-red-800' : 'bg-green-100 text-green-800'}">
                                        ${quiz.status != null ? quiz.status : 'Active'}
                                    </span>
                                </div>
                            </div>
                            <div class="border-t border-gray-200">
                                <dl>
                                    <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                        <dt class="text-sm font-medium text-gray-500">
                                            Question
                                        </dt>
                                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2 font-semibold">
                                            ${quiz.question}
                                        </dd>
                                    </div>
                                    <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                        <dt class="text-sm font-medium text-gray-500">
                                            Type
                                        </dt>
                                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                            ${quiz.type}
                                        </dd>
                                    </div>
                                    <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                        <dt class="text-sm font-medium text-gray-500">
                                            Category
                                        </dt>
                                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                            <c:choose>
                                                <c:when test="${not empty quiz.category}">
                                                    ${quiz.category.name} (ID: ${quiz.category_id})
                                                </c:when>
                                                <c:otherwise>
                                                    ID: ${quiz.category_id}
                                                </c:otherwise>
                                            </c:choose>
                                        </dd>
                                    </div>
                                    <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                        <dt class="text-sm font-medium text-gray-500">
                                            Created At
                                        </dt>
                                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                            <fmt:formatDate value="${quiz.created_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                                            <c:if test="${not empty creator}">
                                                by <span class="font-medium">${creator.first_name}
                                                    ${creator.last_name}</span> (ID: ${quiz.created_by})
                                            </c:if>
                                            <c:if test="${empty creator && quiz.created_by > 0}">
                                                by User ID: ${quiz.created_by}
                                            </c:if>
                                        </dd>
                                    </div>
                                    <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                        <dt class="text-sm font-medium text-gray-500">
                                            Updated At
                                        </dt>
                                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                            <fmt:formatDate value="${quiz.updated_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                                            <c:if test="${not empty updater}">
                                                by <span class="font-medium">${updater.first_name}
                                                    ${updater.last_name}</span> (ID: ${quiz.updated_by})
                                            </c:if>
                                            <c:if test="${empty updater && quiz.updated_by > 0}">
                                                by User ID: ${quiz.updated_by}
                                            </c:if>
                                        </dd>
                                    </div>
                                </dl>
                            </div>
                        </div>

                        <!-- Answers Section -->
                        <div class="mt-8">
                            <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                                Answers
                            </h3>
                            <div class="bg-white shadow overflow-hidden sm:rounded-md">
                                <ul role="list" class="divide-y divide-gray-200">
                                    <c:forEach items="${quiz.answers}" var="answer">
                                        <li
                                            class="px-4 py-4 sm:px-6 hover:bg-gray-50 transition duration-150 ease-in-out">
                                            <div class="flex items-center justify-between">
                                                <div class="text-sm font-medium text-gray-900 truncate">
                                                    ${answer.content}
                                                </div>
                                                <div class="ml-2 flex-shrink-0 flex">
                                                    <c:choose>
                                                        <c:when test="${answer.is_true}">
                                                            <span
                                                                class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                                                Correct Answer
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">
                                                                Incorrect
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${empty quiz.answers}">
                                        <li class="px-4 py-4 sm:px-6 text-sm text-gray-500">
                                            No answers found for this quiz.
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>

                        <div class="mt-6 flex justify-end space-x-3">
                            <c:choose>
                                <c:when test="${quiz.status == 'Hidden'}">
                                    <a href="${pageContext.request.contextPath}/admin/quizzes?action=show&id=${quiz.id}"
                                        class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                                        Show Quiz
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/quizzes?action=hide&id=${quiz.id}"
                                        class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                                        Hide Quiz
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <jsp:include page="/layout/footer.jsp" />
                </body>

                </html>