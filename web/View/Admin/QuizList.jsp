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

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                        <div class="bg-white rounded-xl shadow-md p-6 border-l-4 border-blue-500">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-gray-600 text-sm font-medium">Tổng câu hỏi</p>
                                    <p class="text-3xl font-bold text-gray-900 mt-2">${totalQuizzes}</p>
                                </div>
                                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                                    <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                                    </svg>
                                </div>
                            </div>
                        </div>

                        <div class="bg-white rounded-xl shadow-md p-6 border-l-4 border-green-500">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-gray-600 text-sm font-medium">Đang hoạt động</p>
                                    <p class="text-3xl font-bold text-gray-900 mt-2">${activeQuizzes}</p>
                                </div>
                                <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
                                    <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                </div>
                            </div>
                        </div>

                        <div class="bg-white rounded-xl shadow-md p-6 border-l-4 border-red-500">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-gray-600 text-sm font-medium">Đã ẩn</p>
                                    <p class="text-3xl font-bold text-gray-900 mt-2">${hiddenQuizzes}</p>
                                </div>
                                <div class="w-12 h-12 bg-red-100 rounded-lg flex items-center justify-center">
                                    <svg class="w-6 h-6 text-red-600" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
                                    </svg>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-xl shadow-md p-6 mb-6">
                        <form action="${pageContext.request.contextPath}/admin/quizzes" method="get" id="filterForm">
                            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-4">
                                <!-- SEARCH INPUT -->
                                <div class="md:col-span-2">
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Tìm kiếm</label>
                                    <div class="relative">
                                        <input type="text" name="keyword" value="${param.keyword}"
                                            placeholder="Tìm theo nội dung câu hỏi..." class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg
                                            focus:ring-2 focus:ring-blue-500 focus:border-transparent" />
                                        <svg class="absolute left-3 top-3 w-5 h-5 text-gray-400" fill="none"
                                            stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                        </svg>
                                    </div>
                                </div>

                                <!-- FILTER: TYPE -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Loại câu hỏi</label>
                                    <select name="type"
                                        class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                        <option value="">Tất cả loại</option>
                                        <option value="Single Choice" ${param.type=='Single Choice' ? 'selected' : '' }>
                                            Single Choice</option>
                                        <option value="Multiple Choice" ${param.type=='Multiple Choice' ? 'selected'
                                            : '' }>
                                            Multiple Choice</option>
                                    </select>
                                </div>

                                <!-- FILTER: CATEGORY -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Danh mục</label>
                                    <select name="category"
                                        class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                        <option value="">Tất cả danh mục</option>
                                        <c:forEach items="${categories}" var="cat">
                                            <option value="${cat.id}" ${param.category==cat.id ? 'selected' : '' }>
                                                ${cat.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="flex flex-wrap items-center justify-between gap-4">
                                <div class="flex flex-wrap items-center gap-4">
                                    <!-- FILTER: STATUS -->
                                    <div class="flex items-center gap-2">
                                        <label class="text-sm font-medium text-gray-700 whitespace-nowrap">Trạng
                                            thái:</label>
                                        <select name="status"
                                            class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                            <option value="">Tất cả</option>
                                            <option value="Active" ${param.status=='Active' ? 'selected' : '' }>Hoạt
                                                động</option>
                                            <option value="Hidden" ${param.status=='Hidden' ? 'selected' : '' }>Đã ẩn
                                            </option>
                                        </select>
                                    </div>

                                    <!-- FILTER: SORT -->
                                    <div class="flex items-center gap-2">
                                        <label class="text-sm font-medium text-gray-700 whitespace-nowrap">Sắp
                                            xếp:</label>
                                        <select name="sort"
                                            class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                            <option value="">Mới nhất</option>
                                            <option value="oldest" ${param.sort=='oldest' ? 'selected' : '' }>Cũ nhất
                                            </option>
                                            <option value="name_asc" ${param.sort=='name_asc' ? 'selected' : '' }>Tên
                                                A-Z</option>
                                            <option value="name_desc" ${param.sort=='name_desc' ? 'selected' : '' }>Tên
                                                Z-A</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="flex gap-3">
                                    <button type="button" onclick="resetFilter()"
                                        class="px-5 py-2.5 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors font-medium">
                                        Đặt lại
                                    </button>
                                    <button type="submit"
                                        class="px-6 py-2.5 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors font-medium shadow-md">
                                        Áp dụng
                                    </button>
                                </div>
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

                    <div class="flex justify-between items-center mb-4">
                        <h2 class="text-lg font-semibold text-gray-700">Kết quả tìm kiếm: <span
                                class="text-blue-600">${totalFilteredQuizzes}</span> câu hỏi được tìm thấy</h2>
                    </div>

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
                                class="flex items-center justify-between border-t border-gray-200 bg-white px-4 py-3 sm:px-6 mt-4 rounded-lg shadow-sm">
                                <div class="flex flex-1 justify-between sm:hidden">
                                    <c:if test="${currentPage > 1}">
                                        <a href="${pageContext.request.contextPath}/admin/quizzes?page=${currentPage - 1}&keyword=${keyword}&type=${selectedType}&category=${selectedCategory}&status=${selectedStatus}&sort=${selectedSort}"
                                            class="relative inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">Previous</a>
                                    </c:if>
                                    <c:if test="${currentPage < totalPages}">
                                        <a href="${pageContext.request.contextPath}/admin/quizzes?page=${currentPage + 1}&keyword=${keyword}&type=${selectedType}&category=${selectedCategory}&status=${selectedStatus}&sort=${selectedSort}"
                                            class="relative ml-3 inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">Next</a>
                                    </c:if>
                                </div>
                                <div class="hidden sm:flex sm:flex-1 sm:items-center sm:justify-between">
                                    <div>
                                        <p class="text-sm text-gray-700">
                                            Hiển thị trang
                                            <span class="font-medium">${currentPage}</span>
                                            trong tổng số
                                            <span class="font-medium">${totalPages}</span>
                                            trang
                                        </p>
                                    </div>
                                    <div>
                                        <nav class="isolate inline-flex -space-x-px rounded-md shadow-sm"
                                            aria-label="Pagination">
                                            <!-- Previous Button -->
                                            <c:choose>
                                                <c:when test="${currentPage > 1}">
                                                    <a href="${pageContext.request.contextPath}/admin/quizzes?page=${currentPage - 1}&keyword=${keyword}&type=${selectedType}&category=${selectedCategory}&status=${selectedStatus}&sort=${selectedSort}"
                                                        class="relative inline-flex items-center rounded-l-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">
                                                        <span class="sr-only">Previous</span>
                                                        <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"
                                                            aria-hidden="true">
                                                            <path fill-rule="evenodd"
                                                                d="M12.79 5.23a.75.75 0 01-.02 1.06L8.832 10l3.938 3.71a.75.75 0 11-1.04 1.08l-4.5-4.25a.75.75 0 010-1.08l4.5-4.25a.75.75 0 011.06.02z"
                                                                clip-rule="evenodd" />
                                                        </svg>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span
                                                        class="relative inline-flex items-center rounded-l-md px-2 py-2 text-gray-300 ring-1 ring-inset ring-gray-300 cursor-not-allowed">
                                                        <span class="sr-only">Previous</span>
                                                        <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"
                                                            aria-hidden="true">
                                                            <path fill-rule="evenodd"
                                                                d="M12.79 5.23a.75.75 0 01-.02 1.06L8.832 10l3.938 3.71a.75.75 0 11-1.04 1.08l-4.5-4.25a.75.75 0 010-1.08l4.5-4.25a.75.75 0 011.06.02z"
                                                                clip-rule="evenodd" />
                                                        </svg>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>

                                            <!-- Page Numbers -->
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <c:choose>
                                                    <c:when test="${currentPage == i}">
                                                        <a href="#" aria-current="page"
                                                            class="relative z-10 inline-flex items-center bg-blue-600 px-4 py-2 text-sm font-semibold text-white focus:z-20 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600">${i}</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/admin/quizzes?page=${i}&keyword=${keyword}&type=${selectedType}&category=${selectedCategory}&status=${selectedStatus}&sort=${selectedSort}"
                                                            class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">${i}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>

                                            <!-- Next Button -->
                                            <c:choose>
                                                <c:when test="${currentPage < totalPages}">
                                                    <a href="${pageContext.request.contextPath}/admin/quizzes?page=${currentPage + 1}&keyword=${keyword}&type=${selectedType}&category=${selectedCategory}&status=${selectedStatus}&sort=${selectedSort}"
                                                        class="relative inline-flex items-center rounded-r-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">
                                                        <span class="sr-only">Next</span>
                                                        <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"
                                                            aria-hidden="true">
                                                            <path fill-rule="evenodd"
                                                                d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z"
                                                                clip-rule="evenodd" />
                                                        </svg>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span
                                                        class="relative inline-flex items-center rounded-r-md px-2 py-2 text-gray-300 ring-1 ring-inset ring-gray-300 cursor-not-allowed">
                                                        <span class="sr-only">Next</span>
                                                        <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"
                                                            aria-hidden="true">
                                                            <path fill-rule="evenodd"
                                                                d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z"
                                                                clip-rule="evenodd" />
                                                        </svg>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>

                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>

                <script>
                    function resetFilter() {
                        window.location.href = '${pageContext.request.contextPath}/admin/quizzes';
                    }
                </script>
            </body>


            </html>