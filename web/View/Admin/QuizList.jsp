<%-- 
    Document   : QuizList
    Created on : Dec 17, 2025, 10:16:42 PM
    Author     : Le Minh Duc
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - Quiz List</title>
        <jsp:include page="/layout/import.jsp" />
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp" />

        <div class="container mx-auto px-4 py-8">
            <div class="mb-8 flex justify-between items-center">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Quiz Management</h1>
                    <p class="text-gray-600 mt-1">Manage system quizzes and their visibility</p>
                </div>
            </div>

            <c:if test="${not empty sessionScope.notification}">
                <div class="mb-4 p-4 rounded-md ${sessionScope.notificationType == 'success' ? 'bg-green-50 text-green-700' : 'bg-red-50 text-red-700'}">
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
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Question</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Category</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Action</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach items="${quizList}" var="quiz">
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        #${quiz.id}
                                    </td>
                                    <td class="px-6 py-4 text-sm text-gray-900">
                                        <div class="line-clamp-2 max-w-md" title="${quiz.question}">${quiz.question}</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${quiz.type == 'Multiple Choice' ? 'bg-purple-100 text-purple-800' : 'bg-blue-100 text-blue-800'}">
                                            ${quiz.type}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        ${quiz.category_id} <!-- ideally this would be a name from map -->
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${quiz.status == 'Hidden' ? 'bg-red-100 text-red-800' : 'bg-green-100 text-green-800'}">
                                            ${quiz.status != null ? quiz.status : 'Active'}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium space-x-2">
                                        <a href="${pageContext.request.contextPath}/admin/quizzes?action=detail&id=${quiz.id}" class="text-indigo-600 hover:text-indigo-900">View Detail</a>
                                        
                                        <c:choose>
                                            <c:when test="${quiz.status == 'Hidden'}">
                                                <a href="${pageContext.request.contextPath}/admin/quizzes?action=show&id=${quiz.id}" class="text-green-600 hover:text-green-900">Show</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/admin/quizzes?action=hide&id=${quiz.id}" class="text-red-600 hover:text-red-900">Hide</a>
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
                    <div class="bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6">
                        <div class="flex-1 flex justify-between sm:hidden">
                            <c:if test="${currentPage > 1}">
                                <a href="?page=${currentPage - 1}" class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Previous</a>
                            </c:if>
                            <c:if test="${currentPage < totalPages}">
                                <a href="?page=${currentPage + 1}" class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Next</a>
                            </c:if>
                        </div>
                        <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                            <div>
                                <p class="text-sm text-gray-700">
                                    Page <span class="font-medium">${currentPage}</span> of <span class="font-medium">${totalPages}</span>
                                </p>
                            </div>
                            <div>
                                <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <a href="?page=${i}" aria-current="page" class="${currentPage == i ? 'z-10 bg-indigo-50 border-indigo-500 text-indigo-600' : 'bg-white border-gray-300 text-gray-500 hover:bg-gray-50'} relative inline-flex items-center px-4 py-2 border text-sm font-medium">
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

        <jsp:include page="/layout/footer.jsp" />
    </body>
</html>
