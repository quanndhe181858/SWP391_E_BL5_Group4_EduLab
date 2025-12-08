<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bài Test của tôi - Giảng viên</title>
        <jsp:include page="/layout/import.jsp" />
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp" />

        <div class="container mx-auto px-4 py-8">
            <div class="mb-8">
                <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">Bài Test của tôi</h1>
                        <p class="text-lg text-gray-600 mt-1">Quản lí bài test</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/instructor/test?type=create" class="inline-flex items-center px-4 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition shadow-sm">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                        </svg>
                        Tạo Bài Test mới
                    </a>
                </div>
            </div>

            <form id="filterForm" method="get" action="${pageContext.request.contextPath}/instructor/test">
                <input type="hidden" name="page" id="pageInput" value="${param.page != null ? param.page : 1}">

                <div class="flex flex-col lg:flex-row gap-6">
                    <aside class="w-full lg:w-1/4">
                        <div class="bg-white p-6 rounded-lg shadow-sm sticky top-4">
                            <h2 class="text-xl font-bold text-gray-900 mb-6">Bộ lọc</h2>

                            <%-- Tìm kiếm --%>
                            <div class="mb-6">
                                <label for="search" class="block text-sm font-semibold text-gray-700 mb-2">Tìm kiếm</label>
                                <div class="relative">
                                    <input 
                                        class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                        type="text" 
                                        placeholder="Tìm kiếm bài test ..." 
                                        id="search"
                                        name="search"
                                        value="${param.search != null ? param.search : ''}"
                                        onchange="submitFilter()"
                                        />
                                    <svg class="absolute right-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                                    </svg>
                                </div>
                            </div>

                            <%-- Đề mục/Danh mục (Category) --%>
                            <div class="mb-6">
                                <label class="block text-sm font-semibold text-gray-700 mb-3">Đề mục</label>

                                <c:forEach var="parent" items="${parentCategories}">
                                    <div class="mb-2">
                                        <div class="flex items-center justify-between p-2 bg-gray-50 rounded cursor-pointer hover:bg-gray-100"
                                             onclick="toggleCategory(${parent.id})">
                                            <label class="flex items-center cursor-pointer w-full">
                                                <input type="radio" name="filterCategoryId" value="${parent.id}"
                                                       ${param.filterCategoryId != null && param.filterCategoryId == parent.id ? 'checked' : ''}
                                                       class="w-4 h-4 text-blue-600 border-gray-300 focus:ring-blue-500"
                                                       onchange="submitFilter()">
                                                <span class="ml-2 text-sm font-medium text-gray-700">${parent.name}</span>
                                            </label>

                                            <svg id="icon-${parent.id}" class="w-4 h-4 text-gray-500 transform transition-transform"
                                                 fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                  d="M19 9l-7 7-7-7"></path>
                                            </svg>
                                        </div>

                                        <div id="subcategories-${parent.id}" class="ml-4 mt-1 space-y-1 hidden">
                                            <c:forEach var="child" items="${childCategories}">
                                                <c:if test="${child.parent_id == parent.id}">
                                                    <label class="flex items-center p-2 hover:bg-gray-50 rounded cursor-pointer">
                                                        <input type="radio" name="filterCategoryId" value="${child.id}"
                                                               ${param.filterCategoryId != null && param.filterCategoryId == child.id ? 'checked' : ''}
                                                               class="w-4 h-4 text-blue-600 border-gray-300 focus:ring-blue-500"
                                                               onchange="submitFilter()">
                                                        <span class="ml-2 text-sm text-gray-600">${child.name}</span>
                                                    </label>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <%-- Trạng thái --%>
                            <div class="mb-6">
                                <label for="status" class="block text-sm font-semibold text-gray-700 mb-2">Trạng thái</label>
                                <select id="status" name="status" 
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white"
                                        onchange="submitFilter()">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="Active" ${param.status == 'Active' ? 'selected' : ''}>Hoạt động</option>
                                    <option value="Inactive" ${param.status == 'Inactive' ? 'selected' : ''}>Không hoạt động</option>
                                </select>
                            </div>

                            <button type="button" onclick="clearFilters()" class="w-full px-4 py-2 text-sm font-medium text-blue-600 border border-blue-600 rounded-lg hover:bg-blue-50 transition">
                                Xoá lọc
                            </button>
                        </div>
                    </aside>

                    <main class="w-full lg:w-3/4">
                        <div class="bg-white rounded-lg shadow-sm">
                            
                            <%-- Thông báo (Nếu có) --%>
                            <c:if test="${not empty sessionScope.successMessage}">
                                <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4" role="alert">
                                    <p class="font-bold">Thành công</p>
                                    <p>${sessionScope.successMessage}</p>
                                    <c:remove var="successMessage" scope="session"/>
                                </div>
                            </c:if>
                            <c:if test="${not empty sessionScope.errorMessage}">
                                <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4" role="alert">
                                    <p class="font-bold">Lỗi</p>
                                    <p>${sessionScope.errorMessage}</p>
                                    <c:remove var="errorMessage" scope="session"/>
                                </div>
                            </c:if>

                            <%-- Header with Stats --%>
                            <div class="p-6 border-b border-gray-200">
                                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                                    <div class="bg-blue-50 p-4 rounded-lg">
                                        <p class="text-sm text-blue-600 font-semibold">Số lượng Bài Test</p>
                                        <p class="text-2xl font-bold text-gray-900 mt-1">${totalTests}</p>
                                    </div>
                                    <div class="bg-green-50 p-4 rounded-lg">
                                        <p class="text-sm text-green-600 font-semibold">Hoạt động</p>
                                        <p class="text-2xl font-bold text-gray-900 mt-1">${totalActiveTests}</p>
                                    </div>
                                    <div class="bg-yellow-50 p-4 rounded-lg">
                                        <p class="text-sm text-yellow-600 font-semibold">Không hoạt động</p>
                                        <p class="text-2xl font-bold text-gray-900 mt-1">${totalInactiveTests}</p>
                                    </div>
                                </div>

                                <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                                    <div>
                                        <p class="text-sm text-gray-600">Hiển thị ${startItem}-${endItem} của ${totalTestsPaging} bài test</p>
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <label class="text-sm text-gray-700">Sắp xếp:</label>
                                        <select name="sortBy" 
                                                class="px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm bg-white"
                                                onchange="submitFilter()">
                                            <option value="updated_at desc" ${param.sortBy == 'updated_at desc' || param.sortBy == null ? 'selected' : ''}>Vừa cập nhật</option>
                                            <option value="title asc" ${param.sortBy == 'title asc' ? 'selected' : ''}>Tên Test (A-Z)</option>
                                            <option value="created_at desc" ${param.sortBy == 'created_at desc' ? 'selected' : ''}>Mới nhất</option>
                                            <option value="created_at asc" ${param.sortBy == 'created_at asc' ? 'selected' : ''}>Cũ nhất</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="p-6">
                                <%-- Pagination --%>
                                <c:if test="${totalPages > 1}">
                                    <div class="mb-6 flex justify-center">
                                        <nav class="inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                                            <c:choose>
                                                <c:when test="${page > 1}">
                                                    <a href="javascript:void(0)" onclick="goToPage(${page - 1})" 
                                                       class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                                        <span class="sr-only">Trước</span>
                                                        <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                                                        <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                                        </svg>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-gray-100 text-sm font-medium text-gray-400 cursor-not-allowed">
                                                        <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                                                        <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                                        </svg>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <c:choose>
                                                    <c:when test="${i == page}">
                                                        <span class="relative inline-flex items-center px-4 py-2 border border-blue-500 bg-blue-50 text-sm font-medium text-blue-600">
                                                            ${i}
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="javascript:void(0)" onclick="goToPage(${i})" 
                                                           class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
                                                            ${i}
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>

                                            <c:choose>
                                                <c:when test="${page < totalPages}">
                                                    <a href="javascript:void(0)" onclick="goToPage(${page + 1})" 
                                                       class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                                        <span class="sr-only">Sau</span>
                                                        <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                                                        <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"/>
                                                        </svg>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-gray-100 text-sm font-medium text-gray-400 cursor-not-allowed">
                                                        <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                                                        <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"/>
                                                        </svg>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </nav>
                                    </div>
                                </c:if>

                                <div class="space-y-4">
                                    <c:choose>
                                        <c:when test="${not empty testList}">
                                            <c:forEach items="${testList}" var="test">
                                                <div class="border border-gray-200 rounded-lg p-6 hover:shadow-md transition">
                                                    <div class="flex flex-col md:flex-row gap-6">
                                                        <div class="w-full md:w-48 h-32 bg-gray-200 rounded-lg flex-shrink-0 flex items-center justify-center">
                                                            <svg class="w-12 h-12 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                                            </svg>
                                                        </div>

                                                        <div class="flex-grow">
                                                            <div class="flex items-start justify-between mb-2">
                                                                <div>
                                                                    <div class="flex items-center gap-2 mb-2">
                                                                        <span class="px-2 py-1 text-xs font-semibold text-blue-600 bg-blue-100 rounded">${test.category.name}</span>
                                                                        <span class="px-2 py-1 text-xs font-semibold ${test.status == 'Active' ? 'text-green-600 bg-green-100' : 'text-yellow-600 bg-yellow-100'} rounded">${test.status == "Active" ? "Hoạt động" : "Không hoạt động"}</span>
                                                                    </div>
                                                                    <h3 class="text-xl font-bold text-gray-900 mb-2">${test.title}</h3>
                                                                    <p class="text-sm text-gray-600 mb-3">${test.description}</p>
                                                                </div>
                                                            </div>

                                                            <div class="flex flex-wrap items-center gap-4 text-sm text-gray-600 mb-4">
                                                                <div class="flex items-center" title="Số lượng câu hỏi">
                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 10h.01M12 10h.01M16 10h.01M9 16H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-5l-5 4v-4z"></path>
                                                                    </svg>
                                                                    <span>${test.numberOfQuestions} Câu hỏi</span>
                                                                </div>
                                                                <div class="flex items-center" title="Thời gian làm bài">
                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                                                    </svg>
                                                                    <span>${test.duration} phút</span>
                                                                </div>
                                                                <div class="flex items-center" title="Điểm tối thiểu để đạt">
                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.21a2 2 0 00-2.288-1.748L7.003 4.382a2 2 0 00-1.748 2.288l1.727 6.495-4.14 4.14a1 1 0 00.707 1.707l4.14-4.14 6.495 1.727a2 2 0 002.288-1.748l1.748-6.495z"></path>
                                                                    </svg>
                                                                    <span>Min Grade: ${test.minGrade}%</span>
                                                                </div>
                                                            </div>

                                                            <%-- Action Buttons --%>
                                                            <div class="flex flex-wrap gap-2">
                                                                <a href="${pageContext.request.contextPath}/instructor/test?tid=${test.id}&type=edit" class="inline-flex items-center px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 transition">
                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                                                                    </svg>
                                                                    Chỉnh sửa
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/instructor/test?tid=${test.id}&type=manage_questions" class="inline-flex items-center px-4 py-2 bg-white border border-gray-300 text-gray-700 text-sm font-medium rounded-lg hover:bg-gray-50 transition">
                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.21a2 2 0 00-2.288-1.748L7.003 4.382a2 2 0 00-1.748 2.288l1.727 6.495-4.14 4.14a1 1 0 00.707 1.707l4.14-4.14 6.495 1.727a2 2 0 002.288-1.748l1.748-6.495z"></path>
                                                                    </svg>
                                                                    Quản lý Câu hỏi
                                                                </a>
                                                                <button type="button" onclick="deleteTest(${test.id}, '${test.title}')" class="inline-flex items-center px-4 py-2 bg-white border border-red-300 text-red-600 text-sm font-medium rounded-lg hover:bg-red-50 transition">
                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                                                    </svg>
                                                                    Xóa
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center py-12">
                                                <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.21a2 2 0 00-2.288-1.748L7.003 4.382a2 2 0 00-1.748 2.288l1.727 6.495-4.14 4.14a1 1 0 00.707 1.707l4.14-4.14 6.495 1.727a2 2 0 002.288-1.748l1.748-6.495z"></path>
                                                </svg>
                                                <h3 class="mt-2 text-sm font-medium text-gray-900">Không tìm thấy bài test nào</h3>
                                                <p class="mt-1 text-sm text-gray-500">Hãy bắt đầu bằng cách tạo một bài test mới.</p>
                                                <div class="mt-6">
                                                    <a href="${pageContext.request.contextPath}/instructor/test?type=create" class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                                        </svg>
                                                        Tạo Bài Test Mới
                                                    </a>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </form>
        </div>

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />

        <script>
            function toggleCategory(id) {
                const subcategories = document.getElementById('subcategories-' + id);
                const icon = document.getElementById('icon-' + id);

                if (subcategories.classList.contains('hidden')) {
                    subcategories.classList.remove('hidden');
                    icon.style.transform = 'rotate(180deg)';
                } else {
                    subcategories.classList.add('hidden');
                    icon.style.transform = 'rotate(0deg)';
                }
            }

            function submitFilter() {
                document.getElementById('pageInput').value = '1';
                document.getElementById('filterForm').submit();
            }

            function goToPage(pageNum) {
                document.getElementById('pageInput').value = pageNum;
                document.getElementById('filterForm').submit();
            }

            function clearFilters() {
                window.location.href = '${pageContext.request.contextPath}/instructor/test';
            }

            function deleteTest(testId, testName) {

                Swal.fire({
                    title: "Xóa Bài Test?",
                    html: `Bạn có chắc chắn muốn xóa bài test <b>"` + testName + `"</b>"?<br>Hành động này không thể hoàn tác.`,
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonText: "Vâng, xóa nó",
                    cancelButtonText: "Hủy",
                    confirmButtonColor: "#d33",
                    reverseButtons: true
                }).then(result => {
                    if (!result.isConfirmed)
                        return;

                    // Sử dụng AJAX DELETE để xóa bài test
                    $.ajax({
                        url: "${pageContext.request.contextPath}/instructor/test?tid=" + testId,
                        type: "POST", // Sử dụng POST và gửi tham số _method=DELETE
                        data: {
                            _method: 'DELETE' // Giả định Controller của bạn hỗ trợ Method Override
                        },
                        success: function (response) {
                            showToast("Bài Test đã được xóa thành công!", "success", 2500);
                            setTimeout(() => location.reload(), 1500);
                        },
                        error: function (xhr) {
                            showToast("Lỗi khi xóa bài test. Vui lòng thử lại!", "error", 2500);
                        }
                    });
                });
            }

            // Mở rộng danh mục đã chọn khi tải trang
            document.addEventListener('DOMContentLoaded', function () {
                const selectedCategory = document.querySelector('input[name="filterCategoryId"]:checked');
                if (selectedCategory) {
                    // Lấy parentDiv bằng cách tìm tổ tiên có id bắt đầu bằng 'subcategories-'
                    let parentDiv = selectedCategory.parentElement.parentElement.parentElement;
                    while (parentDiv && !parentDiv.id.startsWith('subcategories-')) {
                        parentDiv = parentDiv.parentElement;
                    }
                    
                    if (parentDiv) {
                        const parentId = parentDiv.id.replace('subcategories-', '');
                        // Mở rộng parent category (nếu là child category được chọn)
                        const parentContainer = document.getElementById('subcategories-' + parentId);
                        const icon = document.getElementById('icon-' + parentId);
                        
                        if (parentContainer) {
                           parentContainer.classList.remove('hidden');
                           icon.style.transform = 'rotate(180deg)';
                        }
                        
                        // Nếu là parent category được chọn, thì parentDiv chính là div chứa các subcategories.
                        if(selectedCategory.value === parentId) {
                            toggleCategory(parentId); // Mở chính nó
                        }
                    } else {
                        // Nếu là parent category được chọn (không có parentDiv), thì phải tìm đúng id của nó
                        const checkedRadio = document.querySelector('input[name="filterCategoryId"]:checked');
                        if (checkedRadio) {
                             const checkedId = checkedRadio.value;
                             const subcategories = document.getElementById('subcategories-' + checkedId);
                             const icon = document.getElementById('icon-' + checkedId);
                             if (subcategories && subcategories.children.length > 0) {
                                subcategories.classList.remove('hidden');
                                icon.style.transform = 'rotate(180deg)';
                            }
                        }
                    }
                }
            });
        </script>
    </body>
</html>