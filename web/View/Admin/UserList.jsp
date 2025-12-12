<%-- 
    Document   : UserList
    Created on : Dec 12, 2025, 1:27:23 PM
    Author     : Le Minh Duc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User List</title>
    </head>
    <body>
        <!-- Search & Filter Bar -->
        <div class="bg-white rounded-xl shadow-md p-4 mb-6">
            <div class="flex flex-col sm:flex-row gap-4">
                
                <!-- Search Input -->
                <div class="flex-1 relative">
                    <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                    </svg>
                    <input type="text" 
                           id="searchInput"
                           placeholder="Tìm kiếm test..." 
                           class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>

                <!-- Filter Dropdown -->
                <select id="filterType" 
                        class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    <option value="all">Tất cả vai trò</option>
                    <option value="course">Admin</option>
                    <option value="section">Instructor</option>
                    <option value="section">Trainee</option>
                </select>

            </div>
        </div>

        <!-- Table Card -->
        <div class="bg-white rounded-xl shadow-md overflow-hidden">
            
            <!-- Table -->
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">ID</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Họ</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Tên</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Email</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Ngày Sinh</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Vai trò</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Ngày tạo</th>
                            <th class="px-6 py-4 text-center text-xs font-semibold text-gray-600 uppercase tracking-wider">Thao tác</th>
                        </tr>
                    </thead>

                    <tbody class="bg-white divide-y divide-gray-200" id="testTableBody">
                        <c:forEach var="t" items="${testList}">
                            <tr class="hover:bg-gray-50 transition-colors test-row" 
                                data-title="${t.title}" 
                                data-code="${t.code}"
                                data-type="${t.courseSectionId == 0 ? 'course' : 'section'}">
                                
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${t.id}</td>
                                
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="font-mono text-sm font-semibold text-gray-700 bg-gray-100 px-2 py-1 rounded">${t.code}</span>
                                </td>
                                
                                <td class="px-6 py-4 text-sm text-gray-900 font-medium">${t.title}</td>

                                <!-- Type Badge -->
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${t.courseSectionId == 0}">
                                            <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                                <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                                    <path d="M10.394 2.08a1 1 0 00-.788 0l-7 3a1 1 0 000 1.84L5.25 8.051a.999.999 0 01.356-.257l4-1.714a1 1 0 11.788 1.838L7.667 9.088l1.94.831a1 1 0 00.787 0l7-3a1 1 0 000-1.838l-7-3zM3.31 9.397L5 10.12v4.102a8.969 8.969 0 00-1.05-.174 1 1 0 01-.89-.89 11.115 11.115 0 01.25-3.762zM9.3 16.573A9.026 9.026 0 007 14.935v-3.957l1.818.78a3 3 0 002.364 0l5.508-2.361a11.026 11.026 0 01.25 3.762 1 1 0 01-.89.89 8.968 8.968 0 00-5.35 2.524 1 1 0 01-1.4 0zM6 18a1 1 0 001-1v-2.065a8.935 8.935 0 00-2-.712V17a1 1 0 001 1z"/>
                                                </svg>
                                                Khóa học
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4z" clip-rule="evenodd"/>
                                                </svg>
                                                Bài học
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${t.courseId}</td>
                                
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <c:choose>
                                        <c:when test="${t.courseSectionId != 0}">
                                            ${t.courseSectionId}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-gray-400">—</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <!-- Action Buttons -->
                                <td class="px-6 py-4 whitespace-nowrap text-center">
                                    <div class="flex items-center justify-center gap-2">
                                        
                                        <!-- View Button -->
                                        <a href="${pageContext.request.contextPath}/instructor/test?action=view&id=${t.id}"
                                           class="inline-flex items-center px-3 py-1.5 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition-colors text-sm font-medium"
                                           title="Xem chi tiết">
                                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                            </svg>
                                            Xem
                                        </a>

                                        <!-- Edit Button -->
                                        <a href="${pageContext.request.contextPath}/instructor/test?action=edit&id=${t.id}"
                                           class="inline-flex items-center px-3 py-1.5 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors text-sm font-medium"
                                           title="Chỉnh sửa">
                                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                                            </svg>
                                            Sửa
                                        </a>

                                        <!-- Delete Button -->
                                        <a href="${pageContext.request.contextPath}/instructor/deleteTest?id=${t.id}"
                                           onclick="return confirm('Bạn có chắc muốn xóa test này không?');"
                                           class="inline-flex items-center px-3 py-1.5 bg-red-500 text-white rounded-lg hover:bg-red-600 transition-colors text-sm font-medium"
                                           title="Xóa">
                                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                            </svg>
                                            Xóa
                                        </a>

                                    </div>
                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Empty State -->
            <c:if test="${empty testList}">
                <div class="text-center py-12">
                    <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                    <h3 class="mt-2 text-sm font-medium text-gray-900">Chưa có người dùng nào</h3>
                    <p class="mt-1 text-sm text-gray-500">Giờ còn cách đợi người đăng ký.</p>
                </div>
            </c:if>

        </div>

</body>
</html>
