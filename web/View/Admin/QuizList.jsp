<%-- Document : QuizList Created on : Dec 17, 2025, 10:16:42 PM Author : Le Minh Duc --%>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Admin - Quiz List</title>
                <jsp:include page="/layout/import.jsp" />
            </head>

            <body class="bg-gray-50">
                <jsp:include page="/layout/header.jsp" />
                <jsp:include page="/layout/admin_sidebar.jsp" />

                <div class="ml-64 pt-6 px-6 pb-8">


                    <div class="mb-8 flex justify-between items-center">
                        <div>
                            <h1 class="text-3xl font-bold text-gray-900">Quiz Management</h1>
                            <p class="text-gray-600 mt-1">Manage system quizzes and their visibility</p>
                        </div>
                    </div>


                    <div class="bg-white rounded-xl shadow-sm p-6 mb-6 border border-gray-100">
                        <form action="${pageContext.request.contextPath}/admin/quizzes" method="get"
                            class="flex flex-wrap gap-4 items-center">

                            <!-- SEARCH INPUT -->
                            <div class="flex-1 min-w-[300px]">
                                <div class="relative">
                                    <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400"
                                        fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                    </svg>

                                    <input type="text" name="keyword" value="${param.keyword}"
                                        placeholder="Search by question..." class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg
                                    focus:ring-2 focus:ring-blue-500 focus:border-transparent" />
                                </div>
                            </div>

                            <!-- SEARCH BUTTON -->
                            <button type="submit" class="flex items-center gap-2 bg-blue-600 text-white px-6 py-2.5
                                rounded-lg hover:bg-blue-700 transition-colors font-semibold">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                </svg>
                                Tìm kiếm
                            </button>

                        </form>
                    </div>
                    <c:if test="${not empty sessionScope.notification}">
                        <div
                            class="mb-4 p-4 rounded-md ${sessionScope.notificationType == 'success' ? 'bg-green-50 text-green-700' : 'bg-red-50 text-red-700'}">
                            ${sessionScope.notification}
                        </div>
                        <c:remove var="notification" scope="session" />
                        <c:remove var="notificationType" scope="session" />
                    </c:if>

                    <div class="bg-white rounded-lg shadow overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            ID</th>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Question</th>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Type</th>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Category</th>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Status</th>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Action</th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach items="${quizList}" var="quiz">
                                        <tr>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                #${quiz.id}
                                            </td>
                                            <td class="px-6 py-4 text-sm text-gray-900">
                                                <div class="line-clamp-2 max-w-md" title="${quiz.question}">
                                                    ${quiz.question}</div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <span
                                                    class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${quiz.type == 'Multiple Choice' ? 'bg-purple-100 text-purple-800' : 'bg-blue-100 text-blue-800'}">
                                                    ${quiz.type}
                                                </span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                ${categoryMap[quiz.category_id] != null ? categoryMap[quiz.category_id]
                                                : quiz.category_id}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <span
                                                    class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${quiz.status == 'Hidden' ? 'bg-red-100 text-red-800' : 'bg-green-100 text-green-800'}">
                                                    ${quiz.status != null ? quiz.status : 'Active'}
                                                </span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium space-x-2">
                                                <a href="${pageContext.request.contextPath}/admin/quizzes?action=detail&id=${quiz.id}"
                                                    class="text-indigo-600 hover:text-indigo-900">View Detail</a>

                                                <c:choose>
                                                    <c:when test="${quiz.status == 'Hidden'}">
                                                        <a href="${pageContext.request.contextPath}/admin/quizzes?action=show&id=${quiz.id}"
                                                            class="text-green-600 hover:text-green-900">Show</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/admin/quizzes?action=hide&id=${quiz.id}"
                                                            class="text-red-600 hover:text-red-900">Hide</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty quizList}">
                                        <tr>
                                            <td colspan="6" class="px-6 py-4 text-center text-sm text-gray-500">
                                                No quizzes found.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div
                                class="bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6">
                                <div class="flex-1 flex justify-between sm:hidden">
                                    <c:if test="${currentPage > 1}">
                                        <a href="?page=${currentPage - 1}${not empty param.keyword ? '&keyword=' : ''}${not empty param.keyword ? param.keyword : ''}"
                                            class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Previous</a>
                                    </c:if>
                                    <c:if test="${currentPage < totalPages}">
                                        <a href="?page=${currentPage + 1}${not empty param.keyword ? '&keyword=' : ''}${not empty param.keyword ? param.keyword : ''}"
                                            class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Next</a>
                                    </c:if>
                                </div>
                                <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                                    <div>
                                        <p class="text-sm text-gray-700">
                                            Page <span class="font-medium">${currentPage}</span> of <span
                                                class="font-medium">${totalPages}</span>
                                        </p>
                                    </div>
                                    <div>
                                        <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px"
                                            aria-label="Pagination">
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <a href="?page=${i}${not empty param.keyword ? '&keyword=' : ''}${not empty param.keyword ? param.keyword : ''}"
                                                    aria-current="page"
                                                    class="${currentPage == i ? 'z-10 bg-indigo-50 border-indigo-500 text-indigo-600' : 'bg-white border-gray-300 text-gray-500 hover:bg-gray-50'} relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                                    ${i}
                                                </a>
                                            </c:forEach>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>

            </body>

            </html>