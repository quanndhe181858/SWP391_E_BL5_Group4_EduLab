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
        <title>Chỉnh sửa khoá học - Giảng viên</title>
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
                    <h1 class="text-3xl font-bold text-gray-900">Chỉnh sửa khoá học</h1>
                </div>
                <p class="text-lg text-gray-600 ml-9">Cập nhật thông tin khoá học</p>
            </div>

            <form id="editCourseForm" method="post" action="courses" enctype="multipart/form-data">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${course.id}">

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    <div class="lg:col-span-2 space-y-6">
                        <div class="bg-white rounded-lg shadow-sm p-6">
                            <h2 class="text-xl font-bold text-gray-900 mb-6">Thông tin cơ bản</h2>

                            <div class="space-y-5">
                                <div>
                                    <label for="title" class="block text-sm font-semibold text-gray-700 mb-2">
                                        Tên khoá học <span class="text-red-500">*</span>
                                    </label>
                                    <input 
                                        type="text" 
                                        id="title" 
                                        name="title" 
                                        value="${course.title}"
                                        maxlength="200"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                        placeholder="e.g., Complete Web Development Bootcamp"
                                        required>
                                    <p class="text-xs text-gray-500 mt-1">
                                        <span id="titleCount">0</span>/200 ký tự
                                    </p>
                                </div>

                                <div>
                                    <label for="description" class="block text-sm font-semibold text-gray-700 mb-2">
                                        Mô tả khoá học <span class="text-red-500">*</span>
                                    </label>
                                    <textarea 
                                        id="description" 
                                        name="description" 
                                        rows="10"
                                        maxlength="2000"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                        placeholder="Describe what students will learn in this course..."
                                        required>${course.description}</textarea>
                                    <p class="text-xs text-gray-500 mt-1">
                                        <span id="descCount">0</span>/2000 ký tự
                                    </p>
                                </div>

                                <div>
                                    <label for="categoryId" class="block text-sm font-semibold text-gray-700 mb-2">
                                        Đề mục <span class="text-red-500">*</span>
                                    </label>
                                    <select 
                                        id="categoryId" 
                                        name="categoryId"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white"
                                        required>
                                        <option value="">Chọn đề mục</option>
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
                            <div class="flex items-center justify-between mb-6">
                                <h2 class="text-xl font-bold text-gray-900">Danh sách bài học</h2>
                                <button 
                                    type="button"
                                    onclick="addSection()"
                                    class="inline-flex items-center px-4 py-2 bg-blue-600 text-white text-sm font-semibold rounded-lg hover:bg-blue-700 transition">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                    </svg>
                                    Thêm bài học
                                </button>
                            </div>

                            <div id="sectionsContainer" class="space-y-4">
                                <c:choose>
                                    <c:when test="${not empty sections}">
                                        <c:forEach items="${sections}" var="section" varStatus="status">
                                            <div class="border border-gray-200 rounded-lg p-4 hover:shadow-md transition">
                                                <div class="flex items-start justify-between gap-4">
                                                    <div class="flex-grow">
                                                        <div class="flex items-center gap-2 mb-2">
                                                            <span class="px-2 py-1 text-xs font-semibold bg-gray-100 text-gray-700 rounded">
                                                                Bài học ${status.index + 1}
                                                            </span>
                                                            <span class="px-2 py-1 text-xs font-semibold ${section.status == 'Active' ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-700'} rounded">
                                                                ${section.status == "Active" ? "Hoạt động" : "Không hoạt động"}
                                                            </span>
                                                            <span class="px-2 py-1 text-xs font-semibold ${section.status == 'Active' ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-700'} rounded">
                                                                Type: ${section.type}
                                                            </span>
                                                        </div>
                                                        <h3 class="text-lg font-bold text-gray-900 mb-1">${section.title}</h3>
                                                        <p class="text-sm text-gray-600 line-clamp-2">${section.description}</p>
                                                    </div>
                                                    <div class="flex items-center gap-2 flex-shrink-0">
                                                        <button 
                                                            type="button"
                                                            onclick="editSection(${section.id})"
                                                            class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition"
                                                            title="Edit section">
                                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                                                            </svg>
                                                        </button>
                                                        <button 
                                                            type="button"
                                                            onclick="removeSection(${section.id}, '${section.title}')"
                                                            class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition"
                                                            title="Remove section">
                                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                                            </svg>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-8 bg-gray-50 rounded-lg border-2 border-dashed border-gray-300">
                                            <svg class="mx-auto h-12 w-12 text-gray-400 mb-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                            </svg>
                                            <h3 class="text-sm font-medium text-gray-900">Chưa có bài học nào</h3>
                                            <p class="mt-1 text-sm text-gray-500">Bắt đầu bằng cách thêm bài học mới.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <div class="lg:col-span-1 space-y-6">
                        <div class="bg-white rounded-lg shadow-sm p-6">
                            <h2 class="text-xl font-bold text-gray-900 mb-4">Ảnh khoá học</h2>

                            <div class="space-y-4">
                                <div class="relative w-full h-48 bg-gray-100 rounded-lg overflow-hidden">
                                    <img 
                                        id="thumbnailPreview" 
                                        src="${pageContext.request.contextPath}/${course.thumbnail}" 
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
                                    Đổi ảnh
                                </button>

                                <p class="text-xs text-gray-500">Khuyến nghị: 1280x720px, JPG or PNG, cao nhất 5MB</p>
                            </div>
                        </div>

                        <!-- Trong phần radio buttons status -->
                        <div class="bg-white rounded-lg shadow-sm p-6">
                            <h2 class="text-xl font-bold text-gray-900 mb-4">Trạng thái khoá học</h2>

                            <div class="space-y-3">
                                <label class="flex items-center p-3 border-2 border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition ${empty sections ? 'opacity-50 cursor-not-allowed' : ''}">
                                    <input 
                                        type="radio" 
                                        name="status" 
                                        value="Active"
                                        ${course.status == 'Active' ? 'checked' : ''}
                                        ${empty sections ? 'disabled' : ''}
                                        class="w-4 h-4 text-blue-600 focus:ring-blue-500">
                                    <div class="ml-3">
                                        <span class="block font-semibold text-gray-900">Hoạt động</span>
                                        <span class="text-sm text-gray-600">Khoá học hiển thị và sẵn sàng cho học sinh tham gia</span>
                                    </div>
                                </label>

                                <label class="flex items-center p-3 border-2 border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition">
                                    <input 
                                        type="radio" 
                                        name="status" 
                                        value="Inactive"
                                        ${course.status == 'Inactive' || empty sections ? 'checked' : ''}
                                        class="w-4 h-4 text-blue-600 focus:ring-blue-500">
                                    <div class="ml-3">
                                        <span class="block font-semibold text-gray-900">Không hoạt động</span>
                                        <span class="text-sm text-gray-600">Khoá học bị ẩn, không tiếp nhận học sinh mới</span>
                                    </div>
                                </label>

                                <c:if test="${empty sections}">
                                    <div class="mt-3 p-3 bg-yellow-50 border border-yellow-200 rounded-lg">
                                        <div class="flex items-start gap-2">
                                            <svg class="w-5 h-5 text-yellow-600 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>
                                            </svg>
                                            <p class="text-sm text-yellow-800">Khoá học cần có ít nhất 1 bài học để có thể đặt trạng thái Hoạt động</p>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <div class="bg-white rounded-lg shadow-sm p-6">
                            <div class="space-y-3">
                                <button 
                                    type="submit"
                                    class="w-full px-4 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition shadow-sm">
                                    Cập nhật
                                </button>

                                <a 
                                    href="courses"
                                    class="block w-full px-4 py-3 bg-white border border-gray-300 text-gray-700 font-medium text-center rounded-lg hover:bg-gray-50 transition">
                                    Huỷ
                                </a>

                                <button 
                                    type="button"
                                    onclick="deleteCourse(${course.id}, '${course.title}')"
                                    class="w-full px-4 py-3 bg-white border border-red-300 text-red-600 font-medium rounded-lg hover:bg-red-50 transition">
                                    Xoá khoá học
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

        <jsp:include page="/View/Instructor/addCourseSectionPopup.jsp" />
        <jsp:include page="/View/Instructor/editCourseSectionPopup.jsp" />

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const titleInput = document.getElementById('title');
                const descInput = document.getElementById('description');

                document.getElementById('titleCount').textContent = titleInput.value.length;
                document.getElementById('descCount').textContent = descInput.value.length;

                titleInput.addEventListener('input', function () {
                    document.getElementById('titleCount').textContent = this.value.length;
                });

                descInput.addEventListener('input', function () {
                    document.getElementById('descCount').textContent = this.value.length;
                });
            });

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
                e.preventDefault();

                const cid = '${course.id}';
                const title = document.getElementById('title').value.trim();
                const description = document.getElementById('description').value.trim();
                const categoryId = document.getElementById('categoryId').value;
                const status = document.querySelector('input[name="status"]:checked').value;
                const thumbnailFile = document.getElementById('thumbnail').files[0];
                const hasSections = ${not empty sections};

                if (!title) {
                    showToast('Tên khoá học không được để trống', 'error', 2500);
                    document.getElementById('title').focus();
                    return false;
                }

                if (title.length > 200) {
                    showToast('Tên khoá học không được vượt quá 200 ký tự', 'error', 2500);
                    document.getElementById('title').focus();
                    return false;
                }

                if (!description) {
                    showToast('Mô tả khoá học không được để trống', 'error', 2500);
                    document.getElementById('description').focus();
                    return false;
                }

                if (description.length > 2000) {
                    showToast('Mô tả khoá học không được vượt quá 500 ký tự', 'error', 2500);
                    document.getElementById('description').focus();
                    return false;
                }

                if (!categoryId) {
                    showToast('Vui lòng chọn đề mục', 'error', 2500);
                    document.getElementById('categoryId').focus();
                    return false;
                }

                // Kiểm tra nếu không có bài học và muốn set Active
                if (!hasSections && status === 'Active') {
                    showToast('Khoá học cần có ít nhất 1 bài học để có thể đặt trạng thái Hoạt động', 'error', 3000);
                    return false;
                }

                const formData = new FormData();
                formData.append('action', 'update');
                formData.append('id', cid);
                formData.append('title', title);
                formData.append('description', description);
                formData.append('categoryId', categoryId);
                formData.append('status', status);

                if (thumbnailFile) {
                    formData.append('thumbnail', thumbnailFile);
                }

                $.ajax({
                    url: "${pageContext.request.contextPath}/instructor/courses",
                    type: "PUT",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (response) {
                        formModified = false;
                        showToast("Cập nhật khoá học thành công!", "success", 2500);
                        setTimeout(() => window.location.reload(), 1500);
                    },
                    error: function (xhr) {
                        const errorMsg = xhr.responseJSON?.message || "Có lỗi xảy ra trong quá trình cập nhật khoá học, vui lòng thử lại sau";
                        showToast(errorMsg, "error", 2500);
                    }
                });

                return false;
            });

            function deleteCourse(courseId, courseName) {
                Swal.fire({
                    title: "Xoá khoá học này?",
                    html: `Bạn có chắc chắn muốn xoá khoá học <b>"` + courseName + `"</b>?<br>Hành động này sẽ không thể hoàn tác.`,
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonText: "Có, xoá ngay",
                    cancelButtonText: "Huỷ",
                    confirmButtonColor: "#d33",
                    reverseButtons: true
                }).then(result => {
                    if (!result.isConfirmed)
                        return;

                    $.ajax({
                        url: "${pageContext.request.contextPath}/instructor/courses?cid=" + courseId,
                        type: "DELETE",
                        success: function (response) {
                            showToast("Xoá khoá học thành công!", "success", 2500);
                            setTimeout(() => window.location.href = "courses", 1500);
                        },
                        error: function (xhr) {
                            showToast("Hiện tại đã có học viên tham gia khoá học và làm bài, không thể xoá!", "error", 2500);
                        }
                    });
                });
            }

            function removeSection(sectionId, sectionTitle) {
                Swal.fire({
                    title: "Xoá bài học?",
                    html: `Bạn có chắc chắn muốn xoá bài học <b>"` + sectionTitle + `"</b>?<br>Hành động này sẽ không thể hoàn tác.`,
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonText: "Có, xoá ngay",
                    cancelButtonText: "Huỷ",
                    confirmButtonColor: "#d33",
                    reverseButtons: true
                }).then(result => {
                    if (!result.isConfirmed)
                        return;

                    $.ajax({
                        url: "${pageContext.request.contextPath}/instructor/courses/sections?csid=" + sectionId,
                        type: "DELETE",
                        success: function (response) {
                            showToast("Xoá bài học thành công!", "success", 2500);
                            setTimeout(() => location.reload(), 1500);
                        },
                        error: function (xhr) {
                            showToast("Có lỗi trong quá trình xoá bài học, vui lòng thử lại sau!", "error", 2500);
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
