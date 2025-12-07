<%-- 
    Document   : CourseList.jsp
    Created on : Dec 4, 2025, 10:39:47 PM
    Author     : quan
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Khoá học của tôi - Giảng viên</title>
        <jsp:include page="/layout/import.jsp" />
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp" />

        <div class="container mx-auto px-4 py-8">
            <div class="mb-8">
                <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">Khoá học của tôi</h1>
                        <p class="text-lg text-gray-600 mt-1">Quản lí khoá học</p>
                    </div>
                    <a href="courses?type=create" class="inline-flex items-center px-4 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition shadow-sm">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                        </svg>
                        Tạo khoá học mới
                    </a>
                </div>
            </div>

            <form id="filterForm" method="get" action="courses">
                <input type="hidden" name="page" id="pageInput" value="${param.page != null ? param.page : 1}">

                <div class="flex flex-col lg:flex-row gap-6">
                    <aside class="w-full lg:w-1/4">
                        <div class="bg-white p-6 rounded-lg shadow-sm sticky top-4">
                            <h2 class="text-xl font-bold text-gray-900 mb-6">Bộ lọc</h2>

                            <div class="mb-6">
                                <label for="search" class="block text-sm font-semibold text-gray-700 mb-2">Tìm kiếm</label>
                                <div class="relative">
                                    <input 
                                        class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                        type="text" 
                                        placeholder="Tìm kiếm khoá học ..." 
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

                            <div class="mb-6">
                                <label class="block text-sm font-semibold text-gray-700 mb-3">Đề mục</label>

                                <c:forEach var="parent" items="${parents}">
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
                                            <c:forEach var="child" items="${children}">
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
                            <!-- Header with Stats -->
                            <div class="p-6 border-b border-gray-200">
                                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                                    <div class="bg-blue-50 p-4 rounded-lg">
                                        <p class="text-sm text-blue-600 font-semibold">Số lượng khoá học</p>
                                        <p class="text-2xl font-bold text-gray-900 mt-1">${totalCourses}</p>
                                    </div>
                                    <div class="bg-green-50 p-4 rounded-lg">
                                        <p class="text-sm text-green-600 font-semibold">Hoạt động</p>
                                        <p class="text-2xl font-bold text-gray-900 mt-1">${totalActiveCourses}</p>
                                    </div>
                                    <div class="bg-yellow-50 p-4 rounded-lg">
                                        <p class="text-sm text-yellow-600 font-semibold">Không hoạt động</p>
                                        <p class="text-2xl font-bold text-gray-900 mt-1">${totalInactiveCourses}</p>
                                    </div>
                                    <!--                                    <div class="bg-purple-50 p-4 rounded-lg">
                                                                            <p class="text-sm text-purple-600 font-semibold">Total Students</p>
                                                                            <p class="text-2xl font-bold text-gray-900 mt-1">1,247</p>
                                                                        </div>-->
                                </div>

                                <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                                    <div>
                                        <p class="text-sm text-gray-600">Hiển thị ${startItem}-${endItem} của ${totalCoursesPaging} khoá học</p>
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <label class="text-sm text-gray-700">Sắp xếp (asc):</label>
                                        <select name="sortBy" 
                                                class="px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm bg-white"
                                                onchange="submitFilter()">
                                            <option value="updated_at desc" ${param.sortBy == 'updated_at desc' || param.sortBy == null ? 'selected' : ''}>Vừa cập nhật</option>
                                            <option value="title asc" ${param.sortBy == 'title asc' ? 'selected' : ''}>Tên khoá học (A-Z)</option>
                                            <option value="created_at desc" ${param.sortBy == 'created_at desc' ? 'selected' : ''}>Mới nhất</option>
                                            <option value="created_at asc" ${param.sortBy == 'created_at asc' ? 'selected' : ''}>Cũ nhất</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="p-6">
                                <!-- Pagination -->
                                <c:if test="${totalPages > 1}">
                                    <div class="mb-6 flex justify-center">
                                        <nav class="inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                                            <!-- Previous Button -->
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

                                            <!-- Page Numbers -->
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

                                            <!-- Next Button -->
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
                                        <c:when test="${not empty courseList}">
                                            <c:forEach items="${courseList}" var="course">
                                                <div class="border border-gray-200 rounded-lg p-6 hover:shadow-md transition">
                                                    <div class="flex flex-col md:flex-row gap-6">
                                                        <img class="w-full md:w-48 h-32 bg-gradient-to-br from-blue-400 to-blue-600 rounded-lg flex-shrink-0" src="${pageContext.request.contextPath}/${course.thumbnail}" />

                                                        <div class="flex-grow">
                                                            <div class="flex items-start justify-between mb-2">
                                                                <div>
                                                                    <div class="flex items-center gap-2 mb-2">
                                                                        <span class="px-2 py-1 text-xs font-semibold text-blue-600 bg-blue-100 rounded">${course.category.name}</span>
                                                                        <span class="px-2 py-1 text-xs font-semibold ${course.status == 'Active' ? 'text-green-600 bg-green-100' : 'text-yellow-600 bg-yellow-100'} rounded">${course.status == "Active" ? "Hoạt động" : "Không hoạt động"}</span>
                                                                    </div>
                                                                    <h3 class="text-xl font-bold text-gray-900 mb-2">${course.title}</h3>
                                                                    <p class="text-sm text-gray-600 mb-3">${course.description}</p>
                                                                </div>
                                                            </div>

                                                            <div class="flex flex-wrap items-center gap-4 text-sm text-gray-600 mb-4">
                                                                <!--                                                                <div class="flex items-center">
                                                                                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
                                                                                                                                    </svg>
                                                                                                                                    <span>256 students</span>
                                                                                                                                </div>-->
                                                                <div class="flex items-center">
                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z"></path>
                                                                    </svg>
                                                                    <span>24 Bài học</span>
                                                                </div>
                                                                <div class="flex items-center">
                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                                                    </svg>
                                                                    <span>${course.getUpdatedAgo()}</span>
                                                                </div>
                                                            </div>

                                                            <!-- Action Buttons -->
                                                            <div class="flex flex-wrap gap-2">
                                                                <a href="courses?cid=${course.id}&type=edit" class="inline-flex items-center px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 transition">
                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                                                                    </svg>
                                                                    Edit
                                                                </a>
<!--                                                                <a href="course?action=content&id=${course.id}" class="inline-flex items-center px-4 py-2 bg-white border border-gray-300 text-gray-700 text-sm font-medium rounded-lg hover:bg-gray-50 transition">
                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                                                    </svg>
                                                                    Content
                                                                </a>-->
<!--                                                                <a href="course?action=students&id=${course.id}" class="inline-flex items-center px-4 py-2 bg-white border border-gray-300 text-gray-700 text-sm font-medium rounded-lg hover:bg-gray-50 transition">
                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                                                                    </svg>
                                                                    Students
                                                                </a>-->
                                                                <button type="button" onclick="deleteCourse(${course.id}, '${course.title}')" class="inline-flex items-center px-4 py-2 bg-white border border-red-300 text-red-600 text-sm font-medium rounded-lg hover:bg-red-50 transition">
                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                                                    </svg>
                                                                    Delete
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
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                                                </svg>
                                                <h3 class="mt-2 text-sm font-medium text-gray-900">No courses found</h3>
                                                <p class="mt-1 text-sm text-gray-500">Get started by creating a new course.</p>
                                                <div class="mt-6">
                                                    <a href="course?action=create" class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                                        </svg>
                                                        Create New Course
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
                window.location.href = 'courses';
            }

            function deleteCourse(courseId, courseName) {

                Swal.fire({
                    title: "Delete Course?",
                    html: `Are you sure you want to delete <b>"` + courseName + `"</b>"?<br>This action cannot be undone.`,
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonText: "Yes, delete it",
                    cancelButtonText: "Cancel",
                    confirmButtonColor: "#d33",
                    reverseButtons: true
                }).then(result => {
                    if (!result.isConfirmed)
                        return;

                    $.ajax({
                        url: "${pageContext.request.contextPath}/instructor/courses?cid=" + courseId,
                        type: "DELETE",
                        success: function (response) {
                            showToast("Course deleted successfully!", "success", 2500);
                            setTimeout(() => location.reload(), 1500);
                        },
                        error: function (xhr) {
                            showToast("Error deleting course. Please try again!", "error", 2500);
                        }
                    });
                });
            }

            document.addEventListener('DOMContentLoaded', function () {
                const selectedCategory = document.querySelector('input[name="filterCategoryId"]:checked');
                if (selectedCategory) {
                    const parentDiv = selectedCategory.closest('[id^="subcategories-"]');
                    if (parentDiv) {
                        const parentId = parentDiv.id.replace('subcategories-', '');
                        const subcategories = document.getElementById('subcategories-' + parentId);
                        const icon = document.getElementById('icon-' + parentId);
                        if (subcategories) {
                            subcategories.classList.remove('hidden');
                            icon.style.transform = 'rotate(180deg)';
                        }
                    }
                }
            });
        </script>
    </body>
</html>