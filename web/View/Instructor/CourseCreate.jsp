<%-- 
    Document   : CourseCreate
    Created on : Dec 7, 2025, 2:02:27 PM
    Author     : quan
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tạo khoá học - Giảng viên</title>
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
                    <h1 class="text-3xl font-bold text-gray-900">Tạo khoá học mới</h1>
                </div>
                <p class="text-lg text-gray-600 ml-9">Điền thông tin để tạo khoá học mới của bạn</p>
            </div>

            <form id="createCourseForm" method="post" action="courses" enctype="multipart/form-data">
                <input type="hidden" name="action" value="create">

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
                                        maxlength="200"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                        placeholder="Ví dụ: Lập trình Web từ A đến Z"
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
                                        placeholder="Mô tả chi tiết về nội dung khoá học, những gì học sinh sẽ học được..."
                                        required></textarea>
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
                                                        <option value="${child.id}">
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

                        <div class="bg-blue-50 border border-blue-200 rounded-lg p-6">
                            <div class="flex items-start gap-3">
                                <svg class="w-6 h-6 text-blue-600 mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                                <div class="text-sm">
                                    <p class="font-semibold text-blue-900 mb-2">Lưu ý khi tạo khoá học</p>
                                    <ul class="space-y-1 text-blue-800 list-disc list-inside">
                                        <li>Tên khoá học nên ngắn gọn, dễ hiểu và hấp dẫn</li>
                                        <li>Mô tả chi tiết giúp học sinh hiểu rõ nội dung</li>
                                        <li>Sau khi tạo, bạn có thể thêm bài học vào khoá học</li>
                                        <li>Khoá học có thể được chỉnh sửa bất kỳ lúc nào</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="lg:col-span-1 space-y-6">
                        <div class="bg-white rounded-lg shadow-sm p-6">
                            <h2 class="text-xl font-bold text-gray-900 mb-4">Ảnh khoá học</h2>

                            <div class="space-y-4">
                                <div class="relative w-full h-48 bg-gray-100 rounded-lg overflow-hidden border-gray-300">
                                    <img 
                                        id="thumbnailPreview" 
                                        src="${pageContext.request.contextPath}/media/image/default-course-image.webp" 
                                        alt="Course thumbnail"
                                        class="w-full h-full object-cover">
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
                                    Chọn ảnh
                                </button>

                                <p class="text-xs text-gray-500">
                                    <span class="text-red-500">*</span> Nếu không add ảnh, ảnh mặc định sẽ là trên<br>
                                    Khuyến nghị: 1280x720px, JPG hoặc PNG, tối đa 5MB
                                </p>
                            </div>
                        </div>

                        <div class="bg-white rounded-lg shadow-sm p-6">
                            <h2 class="text-xl font-bold text-gray-900 mb-4">Trạng thái khoá học</h2>

                            <div class="space-y-3">
                                <label class="flex items-center p-3 border-2 border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition">
                                    <input 
                                        type="radio" 
                                        name="status" 
                                        value="Inactive"
                                        class="w-4 h-4 text-blue-600 focus:ring-blue-500" checked="">
                                    <div class="ml-3">
                                        <span class="block font-semibold text-gray-900">Không hoạt động</span>
                                        <span class="text-sm text-gray-600">Khoá học bị ẩn, không tiếp nhận học sinh, khi mới tạo khoá học, trạng thái sẽ luôn là không hoạt động, vui lòng cập nhật khoá học (Thêm bài học, trạng thái)</span>
                                    </div>
                                </label>
                            </div>
                        </div>

                        <div class="bg-white rounded-lg shadow-sm p-6">
                            <div class="space-y-3">
                                <button 
                                    type="submit"
                                    class="w-full px-4 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition shadow-sm">
                                    Tạo khoá học
                                </button>

                                <a 
                                    href="courses"
                                    class="block w-full px-4 py-3 bg-white border border-gray-300 text-gray-700 font-medium text-center rounded-lg hover:bg-gray-50 transition">
                                    Huỷ
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />

        <script>
            $(document).ready(function () {
                $('#thumbnail').on('change', function (e) {
                    const file = e.target.files[0];
                    if (file) {
                        if (file.size > 5 * 1024 * 1024) {
                            showToast('Kích thước file phải nhỏ hơn 5MB', 'error', 2500);
                            $(this).val('');
                            return;
                        }

                        if (!file.type.startsWith('image/')) {
                            showToast('Vui lòng chọn file hình ảnh', 'error', 2500);
                            $(this).val('');
                            return;
                        }

                        const reader = new FileReader();
                        reader.onload = function (e) {
                            $('#thumbnailPreview').attr('src', e.target.result);
                        };
                        reader.readAsDataURL(file);
                    }
                });

                $('#createCourseForm').on('submit', function (e) {
                    e.preventDefault();

                    const title = $('#title').val().trim();
                    const description = $('#description').val().trim();
                    const categoryId = $('#categoryId').val();
                    const thumbnail = $('#thumbnail')[0].files[0];

                    if (!title) {
                        showToast('Tên khoá học không được để trống', 'error', 2500);
                        $('#title').focus();
                        return false;
                    }

                    if (title.length > 200) {
                        showToast('Tên khoá học không được vượt quá 200 ký tự', 'error', 2500);
                        $('#title').focus();
                        return false;
                    }

                    if (!description) {
                        showToast('Mô tả khoá học không được để trống', 'error', 2500);
                        $('#description').focus();
                        return false;
                    }

                    if (description.length > 2000) {
                        showToast('Mô tả khoá học không được vượt quá 500 ký tự', 'error', 2500);
                        $('#description').focus();
                        return false;
                    }

                    if (!categoryId) {
                        showToast('Vui lòng chọn đề mục', 'error', 2500);
                        $('#categoryId').focus();
                        return false;
                    }

                    const formData = new FormData();
                    formData.append('title', title);
                    formData.append('description', description);
                    formData.append('categoryId', categoryId);
                    formData.append('status', $('input[name="status"]:checked').val());

                    if (thumbnail) {
                        formData.append('thumbnail', thumbnail);
                    }

                    const $submitBtn = $(this).find('button[type="submit"]');
                    const originalBtnText = $submitBtn.html();
                    $submitBtn.prop('disabled', true);
                    $submitBtn.html('<svg class="animate-spin h-5 w-5 mx-auto" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>');

                    $.ajax({
                        url: '${pageContext.request.contextPath}/instructor/courses',
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (response) {
                            if (response.success) {
                                showToast('Tạo khoá học thành công!', 'success', 2500);
                                formModified = false;

                                setTimeout(function () {
                                    window.location.href = '${pageContext.request.contextPath}/instructor/courses';
                                }, 1000);
                            } else {
                                showToast(response.message || 'Có lỗi xảy ra khi tạo khoá học', 'error', 2500);
                                $submitBtn.prop('disabled', false);
                                $submitBtn.html(originalBtnText);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error:', error);
                            console.error('Status:', status);
                            console.error('Response:', xhr.responseText);

                            let errorMessage = 'Không thể kết nối đến server';
                            if (xhr.status === 500) {
                                errorMessage = 'Lỗi server: ' + xhr.status;
                            } else if (xhr.status === 404) {
                                errorMessage = 'Không tìm thấy URL';
                            } else if (xhr.responseJSON && xhr.responseJSON.message) {
                                errorMessage = xhr.responseJSON.message;
                            }

                            showToast(errorMessage, 'error', 2500);
                            $submitBtn.prop('disabled', false);
                            $submitBtn.html(originalBtnText);
                        }
                    });

                    return false;
                });

                let formModified = false;
                $('#createCourseForm input, #createCourseForm textarea, #createCourseForm select').on('change', function () {
                    formModified = true;
                });

                $(window).on('beforeunload', function (e) {
                    if (formModified) {
                        const message = 'Bạn có thay đổi chưa được lưu. Bạn có chắc muốn rời khỏi trang?';
                        e.returnValue = message;
                        return message;
                    }
                });
            });

            $('#title').on('input', function () {
                const length = $(this).val().length;
                $('#titleCount').text(length);
            });

            $('#description').on('input', function () {
                const length = $(this).val().length;
                $('#descCount').text(length);
            });
        </script>
    </body>
</html>