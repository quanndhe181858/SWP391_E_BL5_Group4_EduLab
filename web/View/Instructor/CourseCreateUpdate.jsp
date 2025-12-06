<%-- 
    Document   : CourseCreateUpdate
    Created on : Dec 6, 2025, 2:51:07 PM
    Author     : quan
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Course - Instructor</title>
        <jsp:include page="/layout/import.jsp" />
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp" />

        <div class="container mx-auto px-4 py-8">
            <div class="mb-8">
                <div class="flex items-center gap-3 mb-2">
                    <a href="courses" class="text-gray-600 hover:text-gray-900 transition">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                        </svg>
                    </a>
                    <h1 class="text-3xl font-bold text-gray-900">Edit Course</h1>
                </div>
                <p class="text-lg text-gray-600 ml-9">Update your course information and settings</p>
            </div>

            <form id="editCourseForm" method="post" action="course" enctype="multipart/form-data">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${course.id}">

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    <div class="lg:col-span-2 space-y-6">
                        <div class="bg-white rounded-lg shadow-sm p-6">
                            <h2 class="text-xl font-bold text-gray-900 mb-6">Basic Information</h2>

                            <div class="space-y-5">
                                <div>
                                    <label for="title" class="block text-sm font-semibold text-gray-700 mb-2">
                                        Course Title <span class="text-red-500">*</span>
                                    </label>
                                    <input 
                                        type="text" 
                                        id="title" 
                                        name="title" 
                                        value="${course.title}"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                        placeholder="e.g., Complete Web Development Bootcamp"
                                        required>
                                    <p class="text-sm text-gray-500 mt-1">Choose a clear, descriptive title for your course</p>
                                </div>

                                <div>
                                    <label for="description" class="block text-sm font-semibold text-gray-700 mb-2">
                                        Course Description <span class="text-red-500">*</span>
                                    </label>
                                    <textarea 
                                        id="description" 
                                        name="description" 
                                        rows="5"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                        placeholder="Describe what students will learn in this course..."
                                        required>${course.description}</textarea>
                                    <p class="text-sm text-gray-500 mt-1">Provide a comprehensive overview of your course content</p>
                                </div>

                                <div>
                                    <label for="categoryId" class="block text-sm font-semibold text-gray-700 mb-2">
                                        Category <span class="text-red-500">*</span>
                                    </label>
                                    <select 
                                        id="categoryId" 
                                        name="categoryId"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white"
                                        required>
                                        <option value="">Select a category</option>
                                        <c:forEach var="parent" items="${parents}">
                                            <optgroup label="${parent.name}">
                                                <c:forEach var="child" items="${children}">
                                                    <c:if test="${child.parent_id == parent.id}">
                                                        <option value="${child.id}" ${course.category_id == child.id ? 'selected' : ''}>
                                                            ${child.name}
                                                        </option>
                                                    </c:if>
                                                </c:forEach>
                                            </optgroup>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="bg-white rounded-lg shadow-sm p-6">
                            <h2 class="text-xl font-bold text-gray-900 mb-6">Course Sections</h2>

                            ${courseSections}
                        </div>
                    </div>

                    <div class="lg:col-span-1 space-y-6">
                        <div class="bg-white rounded-lg shadow-sm p-6">
                            <h2 class="text-xl font-bold text-gray-900 mb-4">Course Thumbnail</h2>

                            <div class="space-y-4">
                                <div class="relative w-full h-48 bg-gray-100 rounded-lg overflow-hidden">
                                    <img 
                                        id="thumbnailPreview" 
                                        src="${course.thumbnail}" 
                                        alt="Course thumbnail"
                                        class="w-full h-full object-cover">
                                    <div id="uploadOverlay" class="absolute inset-0 bg-black bg-opacity-50 flex items-center justify-center opacity-0 hover:opacity-100 transition cursor-pointer">
                                        <svg class="w-12 h-12 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                        </svg>
                                    </div>
                                </div>

                                <input 
                                    type="file" 
                                    id="thumbnail" 
                                    name="thumbnail" 
                                    accept="image/*"
                                    class="hidden">

                                <button 
                                    type="button"
                                    onclick="document.getElementById('thumbnail').click()"
                                    class="w-full px-4 py-2 border border-gray-300 text-gray-700 font-medium rounded-lg hover:bg-gray-50 transition">
                                    Change Thumbnail
                                </button>

                                <p class="text-xs text-gray-500">Recommended: 1280x720px, JPG or PNG, max 5MB</p>
                            </div>
                        </div>

                        <div class="bg-white rounded-lg shadow-sm p-6">
                            <h2 class="text-xl font-bold text-gray-900 mb-4">Course Status</h2>

                            <div class="space-y-3">
                                <label class="flex items-center p-3 border-2 border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition">
                                    <input 
                                        type="radio" 
                                        name="status" 
                                        value="Active"
                                        ${course.status == 'Active' ? 'checked' : ''}
                                        class="w-4 h-4 text-blue-600 focus:ring-blue-500">
                                    <div class="ml-3">
                                        <span class="block font-semibold text-gray-900">Active</span>
                                        <span class="text-sm text-gray-600">Course is visible and available for enrollment</span>
                                    </div>
                                </label>

                                <label class="flex items-center p-3 border-2 border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition">
                                    <input 
                                        type="radio" 
                                        name="status" 
                                        value="Inactive"
                                        ${course.status == 'Inactive' ? 'checked' : ''}
                                        class="w-4 h-4 text-blue-600 focus:ring-blue-500">
                                    <div class="ml-3">
                                        <span class="block font-semibold text-gray-900">Inactive</span>
                                        <span class="text-sm text-gray-600">Course is hidden and not available for enrollment</span>
                                    </div>
                                </label>
                            </div>
                        </div>

                        <div class="bg-white rounded-lg shadow-sm p-6">
                            <div class="space-y-3">
                                <button 
                                    type="submit"
                                    class="w-full px-4 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition shadow-sm">
                                    Update Course
                                </button>

                                <a 
                                    href="courses"
                                    class="block w-full px-4 py-3 bg-white border border-gray-300 text-gray-700 font-medium text-center rounded-lg hover:bg-gray-50 transition">
                                    Cancel
                                </a>

                                <button 
                                    type="button"
                                    onclick="deleteCourse(${course.id}, '${course.title}')"
                                    class="w-full px-4 py-3 bg-white border border-red-300 text-red-600 font-medium rounded-lg hover:bg-red-50 transition">
                                    Delete Course
                                </button>
                            </div>
                        </div>

                        <div class="bg-blue-50 rounded-lg p-4">
                            <div class="flex items-start gap-3">
                                <svg class="w-5 h-5 text-blue-600 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                                <div class="text-sm">
                                    <p class="text-blue-900 font-medium">Last updated</p>
                                    <p class="text-blue-700">${course.getUpdatedAgo()}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />

        <script>
            document.getElementById('thumbnail').addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file) {
                    if (file.size > 5 * 1024 * 1024) {
                        showToast('File size must be less than 5MB', 'error', 2500);
                        e.target.value = '';
                        return;
                    }

                    if (!file.type.startsWith('image/')) {
                        showToast('Please select an image file', 'error', 2500);
                        e.target.value = '';
                        return;
                    }

                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('thumbnailPreview').src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });

            document.getElementById('editCourseForm').addEventListener('submit', function (e) {
                const title = document.getElementById('title').value.trim();
                const description = document.getElementById('description').value.trim();
                const categoryId = document.getElementById('categoryId').value;
                const price = document.getElementById('price').value;

                if (!title || !description || !categoryId || price === '') {
                    e.preventDefault();
                    showToast('Please fill in all required fields', 'error', 2500);
                    return false;
                }

                if (parseFloat(price) < 0) {
                    e.preventDefault();
                    showToast('Price cannot be negative', 'error', 2500);
                    return false;
                }

                return true;
            });

            function deleteCourse(courseId, courseName) {
                Swal.fire({
                    title: "Delete Course?",
                    html: `Are you sure you want to delete <b>"` + courseName + `"</b>?<br>This action cannot be undone.`,
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
                            setTimeout(() => window.location.href = "courses", 1500);
                        },
                        error: function (xhr) {
                            showToast("Error deleting course. Please try again!", "error", 2500);
                        }
                    });
                });
            }

            let formModified = false;
            const formElements = document.querySelectorAll('#editCourseForm input, #editCourseForm textarea, #editCourseForm select');

            formElements.forEach(element => {
                element.addEventListener('change', () => {
                    formModified = true;
                });
            });

            window.addEventListener('beforeunload', (e) => {
                if (formModified) {
                    e.preventDefault();
                    e.returnValue = '';
                }
            });

            document.getElementById('editCourseForm').addEventListener('submit', () => {
                formModified = false;
            });
        </script>
    </body>
</html>
