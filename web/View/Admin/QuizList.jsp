<%-- Document : QuizList Created on : Dec 17, 2025, 10:16:42 PM Author : Le Minh Duc --%>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Admin - Danh sách câu hỏi</title>
                <jsp:include page="/layout/import.jsp" />
            </head>

            <body class="bg-gray-50">
                <jsp:include page="/layout/header.jsp" />
                <jsp:include page="/layout/admin_sidebar.jsp" />

                <div class="ml-64 pt-6 px-6 pb-8">


                    <div class="mb-8 flex justify-between items-center">
                        <div>
                            <h1 class="text-3xl font-bold text-gray-900">Quản lý câu hỏi</h1>
                            <p class="text-gray-600 mt-1">Quản lý câu hỏi và trạng thái hiển thị</p>
                        </div>
                    </div>


                    <div class="bg-white rounded-xl shadow-sm p-6 mb-6 border border-gray-100">
                        <form action="${pageContext.request.contextPath}/admin/quizzes" method="get"
                            class="flex flex-wrap gap-4 items-end">

                            <!-- FILTER: SORT -->
                            <div class="min-w-[150px]">
                                <label class="block text-sm font-medium text-gray-700 mb-1">Sắp xếp</label>
                                <select name="sort"
                                    class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                    <option value="">Mới nhất</option>
                                    <option value="oldest" ${param.sort=='oldest' ? 'selected' : '' }>Cũ nhất</option>
                                    <option value="name_asc" ${param.sort=='name_asc' ? 'selected' : '' }>Tên A-Z
                                    </option>
                                    <option value="name_desc" ${param.sort=='name_desc' ? 'selected' : '' }>Tên Z-A
                                    </option>
                                </select>
                            </div>

                            <!-- FILTER: TYPE -->
                            <div class="min-w-[150px]">
                                <label class="block text-sm font-medium text-gray-700 mb-1">Loại câu hỏi</label>
                                <select name="type"
                                    class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                    <option value="">Tất cả</option>
                                    <option value="Single Choice" ${param.type=='Single Choice' ? 'selected' : '' }>
                                        Single Choice</option>
                                    <option value="Multiple Choice" ${param.type=='Multiple Choice' ? 'selected' : '' }>
                                        Multiple Choice</option>
                                </select>
                            </div>

                            <!-- FILTER: CATEGORY -->
                            <div class="min-w-[150px]">
                                <label class="block text-sm font-medium text-gray-700 mb-1">Danh mục</label>
                                <select name="category"
                                    class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                    <option value="">Tất cả</option>
                                    <c:forEach items="${categories}" var="cat">
                                        <option value="${cat.id}" ${param.category==cat.id ? 'selected' : '' }>
                                            ${cat.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- FILTER: STATUS -->
                            <div class="min-w-[150px]">
                                <label class="block text-sm font-medium text-gray-700 mb-1">Trạng thái</label>
                                <select name="status"
                                    class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                    <option value="">Tất cả</option>
                                    <option value="Active" ${param.status=='Active' ? 'selected' : '' }>Active</option>
                                    <option value="Hidden" ${param.status=='Hidden' ? 'selected' : '' }>Hidden</option>
                                </select>
                            </div>

                            <!-- SEARCH INPUT -->
                            <div class="flex-1 min-w-[200px]">
                                <label class="block text-sm font-medium text-gray-700 mb-1">Tìm kiếm</label>
                                <div class="relative">
                                    <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400"
                                        fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                    </svg>

                                    <input type="text" name="keyword" value="${param.keyword}"
                                        placeholder="Nhập nội dung câu hỏi..." class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg
                                    focus:ring-2 focus:ring-blue-500 focus:border-transparent" />
                                </div>
                            </div>

                            <!-- SEARCH BUTTON -->
                            <div class="pb-0.5">
                                <button type="submit" class="flex items-center gap-2 bg-blue-600 text-white px-6 py-2.5
                                    rounded-lg hover:bg-blue-700 transition-colors font-semibold h-[46px]">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                    </svg>
                                    Lọc
                                </button>
                            </div>

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
                                            Câu hỏi</th>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Loại</th>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Danh mục</th>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Trạng thái</th>
                                        <th scope="col"
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Thao tác</th>
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
                                                    class="text-indigo-600 hover:text-indigo-900">Chi tiết</a>

                                                <c:choose>
                                                    <c:when test="${quiz.status == 'Hidden'}">
                                                        <a href="${pageContext.request.contextPath}/admin/quizzes?action=show&id=${quiz.id}"
                                                            class="text-green-600 hover:text-green-900">Hiện</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/admin/quizzes?action=hide&id=${quiz.id}"
                                                            class="text-red-600 hover:text-red-900">Ẩn</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty quizList}">
                                        <tr>
                                            <td colspan="6" class="px-6 py-4 text-center text-sm text-gray-500">
                                                Không tìm thấy câu hỏi nào.
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
                                        <a href="?page=${currentPage - 1}&keyword=${param.keyword}&type=${param.type}&category=${param.category}&status=${param.status}&sort=${param.sort}"
                                            class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Trước</a>
                                    </c:if>
                                    <c:if test="${currentPage < totalPages}">
                                        <a href="?page=${currentPage + 1}&keyword=${param.keyword}&type=${param.type}&category=${param.category}&status=${param.status}&sort=${param.sort}"
                                            class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Sau</a>
                                    </c:if>
                                </div>
                                <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                                    <div>
                                        <p class="text-sm text-gray-700">
                                            Trang <span class="font-medium">${currentPage}</span> trên <span
                                                class="font-medium">${totalPages}</span>
                                        </p>
                                    </div>
                                    <div>
                                        <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px"
                                            aria-label="Pagination">
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <a href="?page=${i}&keyword=${param.keyword}&type=${param.type}&category=${param.category}&status=${param.status}&sort=${param.sort}"
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