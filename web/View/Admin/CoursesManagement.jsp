<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý khóa học - Quản trị viên</title>
        <jsp:include page="/layout/import.jsp"/>
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp"/>
        <jsp:include page="/layout/admin_sidebar.jsp"/>

        <main class="ml-64 pt-6 px-6 pb-8 min-h-screen">
            <div class="mb-8">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">Quản lý khóa học</h1>
                        <p class="text-gray-600 mt-1">Quản lý tất cả các khóa học trong hệ thống</p>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                <div class="bg-white rounded-xl shadow-md p-6 border-l-4 border-blue-500">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-gray-600 text-sm font-medium">Tổng khóa học</p>
                            <p class="text-3xl font-bold text-gray-900 mt-2">${totalCourses}</p>
                        </div>
                        <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-md p-6 border-l-4 border-green-500">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-gray-600 text-sm font-medium">Đang hoạt động</p>
                            <p class="text-3xl font-bold text-gray-900 mt-2">${activeCourses}</p>
                        </div>
                        <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-md p-6 border-l-4 border-red-500">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-gray-600 text-sm font-medium">Đã ẩn</p>
                            <p class="text-3xl font-bold text-gray-900 mt-2">${hiddenCourses}</p>
                        </div>
                        <div class="w-12 h-12 bg-red-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"/>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-md p-6 mb-6">
                <form action="${pageContext.request.contextPath}/admin/courses" method="GET" id="filterForm">
                    <input type="hidden" name="page" value="courses">

                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-4">
                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Tìm kiếm</label>
                            <div class="relative">
                                <input type="text" name="search" value="${param.search}" 
                                       placeholder="Tìm theo tên hoặc mô tả khóa học..."
                                       class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                <svg class="w-5 h-5 text-gray-400 absolute left-3 top-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                                </svg>
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Danh mục</label>
                            <select name="categoryId" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                <option value="">Tất cả danh mục</option>
                                <c:forEach items="${categories}" var="cat">
                                    <option value="${cat.id}" ${param.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Trạng thái</label>
                            <select name="status" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                <option value="">Tất cả</option>
                                <option value="Active" ${param.status == 'Active' ? 'selected' : ''}>Hoạt động</option>
                                <option value="Inactive" ${param.status == 'Inactive' ? 'selected' : ''}>Không hoạt động</option>
                                <option value="Hidden" ${param.status == 'Hidden' ? 'selected' : ''}>Đã ẩn</option>
                            </select>
                        </div>
                    </div>

                    <div class="flex items-center justify-between">
                        <div class="flex items-center gap-2">
                            <label class="text-sm font-medium text-gray-700">Sắp xếp:</label>
                            <select name="sortBy" class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                <option value="id DESC" ${param.sortBy == 'id DESC' ? 'selected' : ''}>Mới nhất</option>
                                <option value="id ASC" ${param.sortBy == 'id ASC' ? 'selected' : ''}>Cũ nhất</option>
                                <option value="title ASC" ${param.sortBy == 'title ASC' ? 'selected' : ''}>Tên A-Z</option>
                                <option value="title DESC" ${param.sortBy == 'title DESC' ? 'selected' : ''}>Tên Z-A</option>
                            </select>
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

            <div class="bg-white rounded-xl shadow-md overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead class="bg-gray-50 border-b border-gray-200">
                            <tr>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">ID</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Khóa học</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Danh mục</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Người tạo</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Trạng thái</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Ngày tạo</th>
                                <th class="px-6 py-4 text-center text-xs font-semibold text-gray-600 uppercase tracking-wider">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <c:forEach items="${cList}" var="course">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="text-sm font-medium text-gray-900">#${course.id}</span>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex items-center gap-4">
                                            <img src="${pageContext.request.contextPath}/${course.thumbnail}" 
                                                 alt="${course.title}"
                                                 class="w-16 h-16 rounded-lg object-cover shadow-sm">
                                            <div class="max-w-xs">
                                                <p class="text-sm font-semibold text-gray-900 line-clamp-1">${course.title}</p>
                                                <p class="text-xs text-gray-500 line-clamp-2 mt-1">${course.description}</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="text-sm text-gray-600"></span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="text-sm text-gray-600"></span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <c:choose>
                                            <c:when test="${course.status == 'Active'}">
                                                <span class="px-3 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-700">Hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-3 py-1 text-xs font-semibold rounded-full bg-yellow-100 text-yellow-700">Không hoạt động</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${course.hide_by_admin}">
                                            <span class="px-3 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-700">Đã ẩn</span>
                                        </c:if>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="text-sm text-gray-600">
                                            <fmt:formatDate value="${course.created_at}" pattern="dd/MM/yyyy"/>
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-center">
                                        <div class="flex items-center justify-center gap-2">
                                            <a href="${pageContext.request.contextPath}/admin/courses/view?id=${course.id}" 
                                               class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors" title="Xem chi tiết">
                                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                                </svg>
                                            </a>
                                            <button onclick="toggleHideCourse(${course.id}, ${course.hide_by_admin})" 
                                                    class="p-2 ${course.hide_by_admin ? 'text-green-600 hover:bg-green-50' : 'text-yellow-600 hover:bg-yellow-50'} rounded-lg transition-colors" 
                                                    title="${course.hide_by_admin ? 'Hiển thị' : 'Ẩn'}">
                                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <c:choose>
                                                    <c:when test="${course.hide_by_admin}">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"/>
                                                    </c:otherwise>
                                                </c:choose>
                                                </svg>
                                            </button>
                                            <button onclick="deleteCourse(${course.id})" 
                                                    class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors" title="Xóa">
                                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                                </svg>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="bg-gray-50 px-6 py-4 border-t border-gray-200">
                    <div class="flex items-center justify-center">
                        <div class="flex gap-2">
                            <c:if test="${curPage > 1}">
                                <a href="?page=courses&pageNum=${curPage - 1}&search=${param.search}&categoryId=${param.categoryId}&status=${param.status}&sortBy=${param.sortBy}" 
                                   class="px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors">
                                    Trước
                                </a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a href="?page=courses&pageNum=${i}&search=${param.search}&categoryId=${param.categoryId}&status=${param.status}&sortBy=${param.sortBy}" 
                                   class="px-4 py-2 ${curPage == i ? 'bg-blue-600 text-white' : 'border border-gray-300 text-gray-700 hover:bg-gray-50'} rounded-lg transition-colors">
                                    ${i}
                                </a>
                            </c:forEach>

                            <c:if test="${curPage < totalPages}">
                                <a href="?page=courses&pageNum=${curPage + 1}&search=${param.search}&categoryId=${param.categoryId}&status=${param.status}&sortBy=${param.sortBy}" 
                                   class="px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors">
                                    Sau
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script>
            function resetFilter() {
                window.location.href = '${pageContext.request.contextPath}/admin/courses?page=courses';
            }

            function toggleHideCourse(courseId, currentHideStatus) {
                const action = currentHideStatus ? 'hiển thị' : 'ẩn';
                if (confirm(`Bạn có chắc muốn ${action} khóa học này?`)) {
                    fetch('${pageContext.request.contextPath}/admin/courses/toggle-hide', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: 'courseId=' + courseId
                    })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    alert(`Đã ${action} khóa học thành công!`);
                                    location.reload();
                                } else {
                                    alert('Có lỗi xảy ra. Vui lòng thử lại!');
                                }
                            });
                }
            }

            function deleteCourse(courseId) {
                if (confirm('Bạn có chắc muốn xóa khóa học này? Hành động này không thể hoàn tác!')) {
                    fetch('${pageContext.request.contextPath}/admin/courses/delete', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: 'courseId=' + courseId
                    })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    alert('Đã xóa khóa học thành công!');
                                    location.reload();
                                } else {
                                    alert('Có lỗi xảy ra. Vui lòng thử lại!');
                                }
                            });
                }
            }
        </script>
    </body>
</html>