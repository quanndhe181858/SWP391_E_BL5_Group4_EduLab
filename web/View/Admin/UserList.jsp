<%-- Document : UserList Created on : Dec 12, 2025, 1:27:23 PM Author : Le Minh Duc --%>

    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@page contentType="text/html;charset=UTF-8" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Quản lý Người dùng - Admin</title>
                    <jsp:include page="/layout/import.jsp" />
                </head>

                <body class="bg-gradient-to-br from-gray-50 to-gray-100">

                    <!-- HEADER -->
                    <jsp:include page="/layout/header.jsp" />
                    <jsp:include page="/layout/admin_sidebar.jsp" />

                    <!-- Main Container -->
                    <div class="ml-64 pt-6 px-6 pb-8">

                        <!-- Page Title -->
                        <div class="mb-8">
                            <h1 class="text-3xl font-bold text-gray-800 mb-2">👥 Quản lý Người dùng</h1>
                            <p class="text-gray-600">Quản lý thông tin và trạng thái của tất cả người dùng trong hệ
                                thống</p>
                        </div>

                        <!-- Statistics Cards -->
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                            <div class="bg-white rounded-xl shadow-md p-6">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <p class="text-sm text-gray-600">Tổng người dùng</p>
                                        <p class="text-2xl font-bold text-gray-800">${userList.size()}</p>
                                    </div>
                                    <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
                                        <svg class="w-6 h-6 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                                            <path
                                                d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z" />
                                        </svg>
                                    </div>
                                </div>
                            </div>

                            <c:set var="adminCount" value="0" />
                            <c:set var="instructorCount" value="0" />
                            <c:set var="traineeCount" value="0" />
                            <c:forEach var="u" items="${userList}">
                                <c:if test="${u.role_id == 1}">
                                    <c:set var="adminCount" value="${adminCount + 1}" />
                                </c:if>
                                <c:if test="${u.role_id == 2}">
                                    <c:set var="instructorCount" value="${instructorCount + 1}" />
                                </c:if>
                                <c:if test="${u.role_id == 3}">
                                    <c:set var="traineeCount" value="${traineeCount + 1}" />
                                </c:if>
                            </c:forEach>

                            <div class="bg-white rounded-xl shadow-md p-6">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <p class="text-sm text-gray-600">Admin</p>
                                        <p class="text-2xl font-bold text-purple-600">${adminCount}</p>
                                    </div>
                                    <div class="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center">
                                        <svg class="w-6 h-6 text-purple-600" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd"
                                                d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                                                clip-rule="evenodd" />
                                        </svg>
                                    </div>
                                </div>
                            </div>

                            <div class="bg-white rounded-xl shadow-md p-6">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <p class="text-sm text-gray-600">Instructor</p>
                                        <p class="text-2xl font-bold text-green-600">${instructorCount}</p>
                                    </div>
                                    <div class="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center">
                                        <svg class="w-6 h-6 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                                            <path
                                                d="M10.394 2.08a1 1 0 00-.788 0l-7 3a1 1 0 000 1.84L5.25 8.051a.999.999 0 01.356-.257l4-1.714a1 1 0 11.788 1.838L7.667 9.088l1.94.831a1 1 0 00.787 0l7-3a1 1 0 000-1.838l-7-3zM3.31 9.397L5 10.12v4.102a8.969 8.969 0 00-1.05-.174 1 1 0 01-.89-.89 11.115 11.115 0 01.25-3.762zM9.3 16.573A9.026 9.026 0 007 14.935v-3.957l1.818.78a3 3 0 002.364 0l5.508-2.361a11.026 11.026 0 01.25 3.762 1 1 0 01-.89.89 8.968 8.968 0 00-5.35 2.524 1 1 0 01-1.4 0zM6 18a1 1 0 001-1v-2.065a8.935 8.935 0 00-2-.712V17a1 1 0 001 1z" />
                                        </svg>
                                    </div>
                                </div>
                            </div>

                            <div class="bg-white rounded-xl shadow-md p-6">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <p class="text-sm text-gray-600">Trainee</p>
                                        <p class="text-2xl font-bold text-orange-600">${traineeCount}</p>
                                    </div>
                                    <div class="w-12 h-12 bg-orange-100 rounded-full flex items-center justify-center">
                                        <svg class="w-6 h-6 text-orange-600" fill="currentColor" viewBox="0 0 20 20">
                                            <path d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" />
                                        </svg>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Search & Filter Bar -->
                        <div class="bg-white rounded-xl shadow-md p-6 mb-6">
                            <form method="GET" action="${pageContext.request.contextPath}/admin/users" id="filterForm">
                                <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-4">
                                    <!-- Search Input -->
                                    <div class="md:col-span-2">
                                        <label class="block text-sm font-medium text-gray-700 mb-2">Tìm kiếm</label>
                                        <div class="relative">
                                            <svg class="absolute left-3 top-3 w-5 h-5 text-gray-400" fill="none"
                                                stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                            </svg>
                                            <input type="text" id="searchInput" name="keyword" value="${keyword}"
                                                placeholder="Tìm theo tên, email..."
                                                class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                        </div>
                                    </div>

                                    <!-- Filter Dropdown: Role -->
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-2">Vai trò</label>
                                        <select name="role" id="filterRole"
                                            class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                            <option value="all" ${selectedRole==null || selectedRole=='all' ? 'selected'
                                                : '' }>Tất cả vai trò</option>
                                            <option value="1" ${selectedRole=='1' ? 'selected' : '' }>Admin</option>
                                            <option value="2" ${selectedRole=='2' ? 'selected' : '' }>Instructor
                                            </option>
                                            <option value="3" ${selectedRole=='3' ? 'selected' : '' }>Trainee</option>
                                        </select>
                                    </div>

                                    <!-- Filter Dropdown: Status -->
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-2">Trạng thái</label>
                                        <select name="status" id="filterStatus"
                                            class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                            <option value="all" ${selectedStatus==null || selectedStatus=='all'
                                                ? 'selected' : '' }>Tất cả</option>
                                            <option value="Active" ${selectedStatus=='Active' ? 'selected' : '' }>Hoạt
                                                động</option>
                                            <option value="Inactive" ${selectedStatus=='Inactive' ? 'selected' : '' }>Vô
                                                hiệu hóa</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="flex flex-wrap items-center justify-between gap-4">
                                    <div class="flex items-center gap-2">
                                        <label class="text-sm font-medium text-gray-700 whitespace-nowrap">Sắp
                                            xếp:</label>
                                        <select name="sort" id="sortFilter"
                                            class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                            <option value="newest" ${selectedSort=='newest' ? 'selected' : '' }>Mới nhất
                                            </option>
                                            <option value="oldest" ${selectedSort=='oldest' ? 'selected' : '' }>Cũ nhất
                                            </option>
                                            <option value="name_asc" ${selectedSort=='name_asc' ? 'selected' : '' }>Tên
                                                A-Z</option>
                                            <option value="name_desc" ${selectedSort=='name_desc' ? 'selected' : '' }>
                                                Tên Z-A</option>
                                        </select>
                                    </div>

                                    <div class="flex gap-3">
                                        <button type="button" onclick="resetFilter()"
                                            class="px-5 py-2.5 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors font-medium">
                                            Đặt lại
                                        </button>
                                        <button type="submit"
                                            class="px-6 py-2.5 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors font-medium shadow-md flex items-center gap-2">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                            </svg>
                                            Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>




                        <!-- Add User Button -->
                        <div class="flex justify-end mb-4">
                            <a href="${pageContext.request.contextPath}/admin/users?action=create"
                                class="inline-flex items-center px-4 py-2 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 whitespace-nowrap">
                                <svg class="-ml-1 mr-2 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                                </svg>
                                Thêm người dùng
                            </a>
                        </div>

                        <div class="flex justify-between items-center mb-4">
                            <h2 class="text-lg font-semibold text-gray-700">Kết quả tìm kiếm: <span
                                    class="text-blue-600">${userList.size()}</span> người dùng được tìm thấy</h2>
                        </div>

                        <!-- Table Card -->
                        <div class="bg-white rounded-xl shadow-md overflow-hidden">


                            <!-- Table -->
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50">
                                        <tr>
                                            <th
                                                class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                                ID</th>
                                            <th
                                                class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                                Họ</th>
                                            <th
                                                class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                                Tên</th>
                                            <th
                                                class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                                Email</th>
                                            <th
                                                class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                                Ngày Sinh</th>
                                            <th
                                                class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                                Vai trò</th>
                                            <th
                                                class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                                Trạng thái</th>
                                            <th
                                                class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                                Ngày tạo</th>
                                            <th
                                                class="px-6 py-4 text-center text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                                Thao tác</th>
                                        </tr>
                                    </thead>

                                    <tbody class="bg-white divide-y divide-gray-200" id="userTableBody">
                                        <c:forEach var="u" items="${userList}">
                                            <tr class="hover:bg-gray-50 transition-colors user-row"
                                                data-firstname="${u.first_name}" data-lastname="${u.last_name}"
                                                data-email="${u.email}" data-role="${u.role_id}">

                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${u.id}
                                                </td>

                                                <td
                                                    class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                    ${u.first_name}</td>

                                                <td
                                                    class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                    ${u.last_name}</td>

                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${u.email}
                                                </td>

                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                                    <c:choose>
                                                        <c:when test="${not empty u.bod}">
                                                            <fmt:formatDate value="${u.bod}" pattern="dd/MM/yyyy" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-gray-400">—</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <!-- Role Badge -->
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <c:choose>
                                                        <c:when test="${u.role_id == 1}">
                                                            <span
                                                                class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-purple-100 text-purple-800">
                                                                <svg class="w-4 h-4 mr-1" fill="currentColor"
                                                                    viewBox="0 0 20 20">
                                                                    <path fill-rule="evenodd"
                                                                        d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                                                                        clip-rule="evenodd" />
                                                                </svg>
                                                                Admin
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${u.role_id == 2}">
                                                            <span
                                                                class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                                <svg class="w-4 h-4 mr-1" fill="currentColor"
                                                                    viewBox="0 0 20 20">
                                                                    <path
                                                                        d="M10.394 2.08a1 1 0 00-.788 0l-7 3a1 1 0 000 1.84L5.25 8.051a.999.999 0 01.356-.257l4-1.714a1 1 0 11.788 1.838L7.667 9.088l1.94.831a1 1 0 00.787 0l7-3a1 1 0 000-1.838l-7-3zM3.31 9.397L5 10.12v4.102a8.969 8.969 0 00-1.05-.174 1 1 0 01-.89-.89 11.115 11.115 0 01.25-3.762zM9.3 16.573A9.026 9.026 0 007 14.935v-3.957l1.818.78a3 3 0 002.364 0l5.508-2.361a11.026 11.026 0 01.25 3.762 1 1 0 01-.89.89 8.968 8.968 0 00-5.35 2.524 1 1 0 01-1.4 0zM6 18a1 1 0 001-1v-2.065a8.935 8.935 0 00-2-.712V17a1 1 0 001 1z" />
                                                                </svg>
                                                                Instructor
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                                                <svg class="w-4 h-4 mr-1" fill="currentColor"
                                                                    viewBox="0 0 20 20">
                                                                    <path
                                                                        d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" />
                                                                </svg>
                                                                Trainee
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <!-- Status Badge -->
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <c:choose>
                                                        <c:when test="${u.status == 'Active'}">
                                                            <span
                                                                class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                                <span
                                                                    class="w-2 h-2 mr-1 bg-green-500 rounded-full"></span>
                                                                Hoạt động
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                                                                <span
                                                                    class="w-2 h-2 mr-1 bg-gray-500 rounded-full"></span>
                                                                Không hoạt động
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                    <fmt:formatDate value="${u.created_at}" pattern="dd/MM/yyyy" />
                                                </td>

                                                <!-- Action Buttons -->
                                                <td class="px-6 py-4 whitespace-nowrap text-center">
                                                    <div class="flex items-center justify-center gap-2">

                                                        <!-- Edit Button -->
                                                        <c:if test="${u.role_id != 1}">
                                                            <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${u.id}"
                                                                class="inline-flex items-center px-3 py-1.5 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors text-sm font-medium"
                                                                title="Chỉnh sửa">
                                                                <svg class="w-4 h-4 mr-1" fill="none"
                                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                                                                </svg>
                                                                Sửa
                                                            </a>

                                                            <!-- Change Status Button -->
                                                            <a href="${pageContext.request.contextPath}/admin/users?action=changeStatus&id=${u.id}"
                                                                onclick="return confirm('Bạn có chắc muốn thay đổi trạng thái của người dùng này?');"
                                                                class="inline-flex items-center px-3 py-1.5 ${u.status == 'Active' ? 'bg-orange-500 hover:bg-orange-600' : 'bg-green-500 hover:bg-green-600'} text-white rounded-lg transition-colors text-sm font-medium"
                                                                title="Thay đổi trạng thái">
                                                                <svg class="w-4 h-4 mr-1" fill="none"
                                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
                                                                </svg>
                                                                ${u.status == 'Active' ? 'Vô hiệu hóa' : 'Kích hoạt'}
                                                            </a>
                                                        </c:if>

                                                    </div>
                                                </td>

                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Empty State -->
                            <c:if test="${empty userList}">
                                <div class="text-center py-12">
                                    <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
                                    </svg>
                                    <h3 class="mt-2 text-sm font-medium text-gray-900">Chưa có người dùng nào</h3>
                                    <p class="mt-1 text-sm text-gray-500">Hệ thống chưa có người dùng nào được đăng ký.
                                    </p>
                                </div>
                            </c:if>

                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div
                                class="flex items-center justify-between border-t border-gray-200 bg-white px-4 py-3 sm:px-6 mt-4 rounded-lg shadow-sm">
                                <div class="flex flex-1 justify-between sm:hidden">
                                    <c:if test="${currentPage > 1}">
                                        <a href="${pageContext.request.contextPath}/admin/users?page=${currentPage - 1}&role=${selectedRole}&status=${selectedStatus}&sort=${selectedSort}&keyword=${keyword}"
                                            class="relative inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50">Previous</a>
                                    </c:if>
                                    <c:if test="${currentPage < totalPages}">
                                        <a href="${pageContext.request.contextPath}/admin/users?page=${currentPage + 1}&role=${selectedRole}&status=${selectedStatus}&sort=${selectedSort}&keyword=${keyword}"
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
                                                    <a href="${pageContext.request.contextPath}/admin/users?page=${currentPage - 1}&role=${selectedRole}&status=${selectedStatus}&sort=${selectedSort}&keyword=${keyword}"
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
                                                        <a href="${pageContext.request.contextPath}/admin/users?page=${i}&role=${selectedRole}&status=${selectedStatus}&sort=${selectedSort}&keyword=${keyword}"
                                                            class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">${i}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>

                                            <!-- Next Button -->
                                            <c:choose>
                                                <c:when test="${currentPage < totalPages}">
                                                    <a href="${pageContext.request.contextPath}/admin/users?page=${currentPage + 1}&role=${selectedRole}&status=${selectedStatus}&sort=${selectedSort}&keyword=${keyword}"
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

                    <!-- FOOTER -->
                    <jsp:include page="/layout/importBottom.jsp" />

                    <!-- Toast Notification Logic -->
                    <script>
                        function resetFilter() {
                            window.location.href = '${pageContext.request.contextPath}/admin/users';
                        }

                        document.addEventListener('DOMContentLoaded', function () {

                            <c:if test="${not empty sessionScope.success}">
                                showToast("${sessionScope.success}", "success");
                            </c:if>
                            <c:if test="${not empty sessionScope.error}">
                                showToast("${sessionScope.error}", "error");
                            </c:if>
                        });
                    </script>
                    <c:if test="${not empty sessionScope.success}">
                        <c:remove var="success" scope="session" />
                    </c:if>
                    <c:if test="${not empty sessionScope.error}">
                        <c:remove var="error" scope="session" />
                    </c:if>

                    <!-- Client-side Search Script Removed -->

                </body>

                </html>