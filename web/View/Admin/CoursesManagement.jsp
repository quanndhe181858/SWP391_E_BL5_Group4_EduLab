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
                                        <span class="text-sm text-gray-600">${course.category.name}</span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="text-sm text-gray-600">${course.userCreated.first_name} ${course.userCreated.last_name}</span>
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
                                            <button onclick="showCourse(${course.id})" 
                                                    class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors" title="Xem chi tiết">
                                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                                </svg>
                                            </button>
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

        <jsp:include page="/layout/importBottom.jsp" />

        <script>
            function resetFilter() {
                window.location.href = '${pageContext.request.contextPath}/admin/courses?page=courses';
            }

            function toggleHideCourse(courseId, currentHideStatus) {
                const action = currentHideStatus ? 'hiển thị' : 'ẩn';
                if (confirm('Bạn có chắc muốn ' + action + ' khóa học này?')) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/admin/courses',
                        type: 'POST',
                        data: {
                            courseId: courseId
                        },
                        success: function (data) {
                            if (data.success) {
                                showToast('Đã ' + action + ' khóa học thành công!', 'success');
                                setTimeout(() => {
                                    window.location.reload();
                                }, 1500);
                            } else {
                                showToast(data.message);
                            }
                        },
                        error: function (xhr, status, error) {
                            alert('Có lỗi xảy ra: ' + error);
                        }
                    });
                }
            }

            function showCourse(courseId) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/courses/detail',
                    type: 'GET',
                    data: {
                        cid: courseId
                    },
                    success: function (data) {
                        if (data.success) {
                            displayCourseModal(data.course, data.sections);
                        } else {
                            showToast(data.message || 'Không thể tải thông tin khóa học', 'error');
                        }
                    },
                    error: function (xhr, status, error) {
                        showToast('Có lỗi xảy ra khi tải thông tin khóa học', 'error');
                    }
                });
            }

            function displayCourseModal(course, sections) {
                const contextPath = '${pageContext.request.contextPath}';

                // Tạo HTML cho sections
                let sectionsHtml = '';
                if (sections && sections.length > 0) {
                    sections.forEach((section, index) => {
                        const statusClass = section.status === 'Active' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700';
                        const statusText = section.status === 'Active' ? 'Hoạt động' : 'Không hoạt động';

                        // Xác định icon và label dựa trên type
                        let typeIcon = '';
                        let typeLabel = '';
                        let mediaHtml = '';

                        switch (section.type) {
                            case 'text':
                                typeIcon = '<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/></svg>';
                                typeLabel = 'Văn bản';
                                // Chỉ hiển thị content
                                if (section.content) {
                                    mediaHtml = '<div class="ml-11 mt-3 p-4 bg-gray-50 rounded-lg border border-gray-200">' +
                                            '<p class="text-sm text-gray-700 leading-relaxed">' + section.content + '</p>' +
                                            '</div>';
                                }
                                break;
                            case 'video':
                                typeIcon = '<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>';
                                typeLabel = 'Video';
                                mediaHtml = '<div class="ml-11 mt-3 space-y-3">';
                                // Hiển thị content trước
                                if (section.content) {
                                    mediaHtml += '<div class="p-4 bg-gray-50 rounded-lg border border-gray-200">' +
                                            '<p class="text-sm text-gray-700 leading-relaxed">' + section.content + '</p>' +
                                            '</div>';
                                }
                                // Sau đó hiển thị video
                                if (section.media && section.media.path) {
                                    mediaHtml += '<video controls class="w-full max-w-2xl rounded-lg shadow-md border border-gray-200">' +
                                            '<source src="' + contextPath + '/' + section.media.path + '" type="' + (section.media.mime_type || 'video/mp4') + '">' +
                                            'Trình duyệt của bạn không hỗ trợ video.' +
                                            '</video>';
                                }
                                mediaHtml += '</div>';
                                break;
                            case 'image':
                                typeIcon = '<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>';
                                typeLabel = 'Hình ảnh';
                                mediaHtml = '<div class="ml-11 mt-3 space-y-3">';
                                // Hiển thị content trước
                                if (section.content) {
                                    mediaHtml += '<div class="p-4 bg-gray-50 rounded-lg border border-gray-200">' +
                                            '<p class="text-sm text-gray-700 leading-relaxed">' + section.content + '</p>' +
                                            '</div>';
                                }
                                // Sau đó hiển thị image
                                if (section.media && section.media.path) {
                                    mediaHtml += '<img src="' + contextPath + '/' + section.media.path + '" ' +
                                            'alt="' + section.title + '" ' +
                                            'class="max-w-2xl rounded-lg shadow-md border border-gray-200">';
                                }
                                mediaHtml += '</div>';
                                break;
                            default:
                                typeIcon = '<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01"/></svg>';
                                typeLabel = section.type;
                                // Chỉ hiển thị content cho type không xác định
                                if (section.content) {
                                    mediaHtml = '<div class="ml-11 mt-3 p-4 bg-gray-50 rounded-lg border border-gray-200">' +
                                            '<p class="text-sm text-gray-700 leading-relaxed">' + section.content + '</p>' +
                                            '</div>';
                                }
                        }

                        sectionsHtml += '<div class="border border-gray-200 rounded-lg p-4 hover:bg-gray-50 transition-colors">' +
                                '<div class="flex items-start justify-between">' +
                                '<div class="flex-1">' +
                                '<div class="flex items-center gap-3 mb-2">' +
                                '<span class="flex items-center justify-center w-8 h-8 bg-blue-100 text-blue-700 rounded-full text-sm font-semibold">' +
                                section.position +
                                '</span>' +
                                '<h4 class="text-base font-semibold text-gray-900">' + section.title + '</h4>' +
                                '</div>' +
                                '<p class="text-sm text-gray-600 ml-11 mb-2">' + (section.description || 'Không có mô tả') + '</p>' +
                                '<div class="flex items-center gap-3 ml-11 mb-2">' +
                                '<span class="px-2 py-1 text-xs font-medium rounded ' + statusClass + '">' +
                                statusText +
                                '</span>' +
                                '<span class="inline-flex items-center gap-1 text-xs text-gray-600">' +
                                typeIcon +
                                '<span class="font-medium">' + typeLabel + '</span>' +
                                '</span>' +
                                '</div>' +
                                mediaHtml +
                                '</div>' +
                                '</div>' +
                                '</div>';
                    });
                } else {
                    sectionsHtml = '<p class="text-center text-gray-500 py-8">Chưa có phần học nào</p>';
                }

                const courseStatusClass = course.status === 'Active' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700';
                const courseStatusText = course.status === 'Active' ? 'Hoạt động' : 'Không hoạt động';
                const hideStatusHtml = course.hide_by_admin ? '<span class="px-3 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-700 ml-2">Đã ẩn</span>' : '';
                const categoryNameDisplay = course.categoryName || 'Chưa phân loại';
                const createdDate = new Date(course.created_at).toLocaleDateString('vi-VN');

                const modalHtml = '<div id="courseDetailModal" class="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4" onclick="closeCourseModal(event)">' +
                        '<div class="bg-white rounded-2xl shadow-2xl max-w-5xl w-full max-h-[90vh] overflow-hidden" onclick="event.stopPropagation()">' +
                        '<!-- Header -->' +
                        '<div class="bg-gradient-to-r from-blue-600 to-blue-700 px-6 py-5 flex items-center justify-between">' +
                        '<h2 class="text-2xl font-bold text-white">Chi tiết khóa học</h2>' +
                        '<button onclick="closeCourseModal()" class="text-white hover:bg-white/20 rounded-lg p-2 transition-colors">' +
                        '<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">' +
                        '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>' +
                        '</svg>' +
                        '</button>' +
                        '</div>' +
                        '<!-- Content -->' +
                        '<div class="overflow-y-auto max-h-[calc(90vh-120px)]">' +
                        '<!-- Course Info -->' +
                        '<div class="p-6 border-b border-gray-200">' +
                        '<div class="flex gap-6">' +
                        '<img src="' + contextPath + '/' + course.thumbnail + '" ' +
                        'alt="' + course.title + '" ' +
                        'class="w-48 h-32 rounded-lg object-cover shadow-md flex-shrink-0">' +
                        '<div class="flex-1">' +
                        '<div class="flex items-start justify-between mb-3">' +
                        '<div>' +
                        '<h3 class="text-xl font-bold text-gray-900 mb-2">' + course.title + '</h3>' +
                        '<p class="text-sm text-gray-600 mb-3">' + course.description + '</p>' +
                        '</div>' +
                        '</div>' +
                        '<div class="grid grid-cols-2 gap-4">' +
                        '<div>' +
                        '<p class="text-xs text-gray-500 mb-1">Trạng thái</p>' +
                        '<span class="px-3 py-1 text-xs font-semibold rounded-full ' + courseStatusClass + '">' +
                        courseStatusText +
                        '</span>' +
                        hideStatusHtml +
                        '</div>' +
                        '<div>' +
                        '<p class="text-xs text-gray-500 mb-1">Danh mục</p>' +
                        '<p class="text-sm font-medium text-gray-900">' + categoryNameDisplay + '</p>' +
                        '</div>' +
                        '<div>' +
                        '<p class="text-xs text-gray-500 mb-1">Ngày tạo</p>' +
                        '<p class="text-sm font-medium text-gray-900">' + createdDate + '</p>' +
                        '</div>' +
                        '<div>' +
                        '<p class="text-xs text-gray-500 mb-1">ID khóa học</p>' +
                        '<p class="text-sm font-medium text-gray-900">#' + course.id + '</p>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '<!-- Sections -->' +
                        '<div class="p-6">' +
                        '<div class="flex items-center justify-between mb-4">' +
                        '<h3 class="text-lg font-bold text-gray-900">' +
                        'Danh sách phần học ' +
                        '<span class="text-sm font-normal text-gray-500">(' + sections.length + ' phần)</span>' +
                        '</h3>' +
                        '</div>' +
                        '<div class="space-y-3">' +
                        sectionsHtml +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '<!-- Footer -->' +
                        '<div class="bg-gray-50 px-6 py-4 flex items-center justify-end gap-3 border-t border-gray-200">' +
                        '<button onclick="closeCourseModal()" ' +
                        'class="px-5 py-2.5 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-100 transition-colors font-medium">' +
                        'Đóng' +
                        '</button>' +
                        '</div>' +
                        '</div>' +
                        '</div>';

                $('body').append(modalHtml);

                $('body').css('overflow', 'hidden');
            }

            function closeCourseModal(event) {
                if (!event || event.target.id === 'courseDetailModal') {
                    $('#courseDetailModal').remove();
                    $('body').css('overflow', 'auto');
                }
            }

            $(document).on('keydown', function (e) {
                if (e.key === 'Escape' && $('#courseDetailModal').length) {
                    closeCourseModal();
                }
            });
        </script>
    </body>
</html>