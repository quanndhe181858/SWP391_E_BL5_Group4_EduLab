<%-- 
    Document   : AddCertificate
    Created on : Dec 18, 2025, 6:29:36 PM
    Author     : hao
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm chứng chỉ</title>
        <jsp:include page="/layout/import.jsp"/>
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp"/>

        <div class="container mx-auto px-4 py-8">
            <div class="max-w-3xl mx-auto">
                <div class="mb-6">
                    <div class="text-lg mb-3 text-blue-500 hover:underline"><a href="${pageContext.request.contextPath}/instructor/manager/certificate">Quay lại</a></div>
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">Thêm chứng chỉ mới</h1>
                        <p class="mt-2 text-gray-600">Điền thông tin để tạo chứng chỉ mới</p>
                    </div>
                </div>

                <div class="bg-white rounded-lg shadow-md p-6">
                    <form action="${pageContext.request.contextPath}/instructor/certificate" method="POST">

                        <div class="mb-6">
                            <label for="title" class="block text-sm font-medium text-gray-700 mb-2">
                                Tiêu đề <span class="text-red-500">*</span>
                            </label>
                            <input 
                                type="text" 
                                id="title" 
                                name="title" 
                                required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                placeholder="Nhập tiêu đề chứng chỉ"
                                />
                        </div>

                        <div class="mb-6">
                            <label for="course_id" class="block text-sm font-medium text-gray-700 mb-2">
                                Khóa học <span class="text-red-500">*</span>
                            </label>
                            <select 
                                id="course_id" 
                                name="course_id" 
                                required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                >
                                <option value="">Chọn khóa học</option>
                                <c:forEach items="${courseList}" var="course">
                                    <option value="${course.id}">
                                        ${course.title}
                                    </option>
                                </c:forEach>
                            </select>
                            <p class="mt-1 text-sm text-gray-500">Chỉ bao gồm những khoá học chưa có chứng chỉ</p>
                        </div>

                        <div class="mb-6">
                            <label for="description" class="block text-sm font-medium text-gray-700 mb-2">
                                Mô tả
                            </label>
                            <textarea 
                                id="description" 
                                name="description" 
                                rows="4"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                placeholder="Nhập mô tả cho chứng chỉ"
                                ></textarea>
                        </div>

                        <div class="mb-6">
                            <label for="code_prefix" class="block text-sm font-medium text-gray-700 mb-2">
                                Tiền tố mã <span class="text-red-500">*</span>
                            </label>
                            <input 
                                type="text" 
                                id="code_prefix" 
                                name="code_prefix" 
                                required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                placeholder="VD: COURSE-xxx"
                                />
                            <p class="mt-1 text-sm text-gray-500">Mã sẽ được tạo tự động theo định dạng này, lưu ý sau khi tạo sẽ không thể chỉnh sửa!</p>
                        </div>

                        <div class="mb-6">
                            <label for="status" class="block text-sm font-medium text-gray-700 mb-2">
                                Trạng thái <span class="text-red-500">*</span>
                            </label>
                            <select 
                                id="status" 
                                name="status" 
                                required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                >
                                <option value="Active">Hoạt động</option>
                                <option value="Inactive">Không hoạt động</option>
                            </select>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg">
                                <p class="text-red-600">${error}</p>
                            </div>
                        </c:if>

                        <c:if test="${not empty success}">
                            <div class="mb-6 p-4 bg-green-50 border border-green-200 rounded-lg">
                                <p class="text-green-600">${success}</p>
                            </div>
                        </c:if>

                        <div class="flex gap-4">
                            <button 
                                type="submit" 
                                class="flex-1 bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors font-medium"
                                >
                                Tạo chứng chỉ
                            </button>
                            <a 
                                href="${pageContext.request.contextPath}/certificate/list" 
                                class="flex-1 bg-gray-200 text-gray-700 px-6 py-3 rounded-lg hover:bg-gray-300 transition-colors font-medium text-center"
                                >
                                Hủy bỏ
                            </a>
                        </div>
                    </form>
                </div>

                <div class="mt-6 p-4 bg-blue-50 border border-blue-200 rounded-lg">
                    <h3 class="font-semibold text-blue-900 mb-2">Lưu ý:</h3>
                    <ul class="text-sm text-blue-800 space-y-1">
                        <li>• Các trường đánh dấu <span class="text-red-500">*</span> là bắt buộc</li>
                        <li>• Tiền tố mã sẽ được sử dụng để tự động tạo mã chứng chỉ</li>
                        <li>• Chứng chỉ sẽ được tạo tự động khi học viên hoàn thành khóa học</li>
                    </ul>
                </div>
            </div>
        </div>

        <jsp:include page="/layout/footer.jsp"/>
        <jsp:include page="/layout/importBottom.jsp"/>
    </body>
</html>