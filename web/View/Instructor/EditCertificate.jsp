<%-- 
    Document   : EditCertificate
    Created on : Dec 18, 2025, 7:35:30 PM
    Author     : hao
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chỉnh sửa chứng chỉ</title>
        <jsp:include page="/layout/import.jsp"/>
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp"/>

        <div class="container mx-auto px-4 py-8">
            <div class="max-w-3xl mx-auto">
                <div class="mb-6">
                    <div class="text-lg mb-3">
                        <a href="${pageContext.request.contextPath}/instructor/manager/certificate" 
                           class="text-blue-500 hover:underline">
                            ← Quay lại
                        </a>
                    </div>
                    <h1 class="text-3xl font-bold text-gray-900">Chỉnh sửa chứng chỉ</h1>
                    <p class="mt-2 text-gray-600">Cập nhật thông tin chứng chỉ</p>
                </div>

                <div class="bg-white rounded-lg shadow-md p-6">
                    <form action="${pageContext.request.contextPath}/instructor/certificate/edit" method="POST">
                        <input type="hidden" name="id" value="${cert.id}" />

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
                                value="${cert.title}"
                                />
                        </div>

                        <div class="mb-6">
                            <label for="course" class="block text-sm font-medium text-gray-700 mb-2">
                                Khóa học <span class="text-red-500">*</span>
                            </label>
                            <input 
                                type="text" 
                                id="course" 
                                name="course" 
                                disabled
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg bg-gray-100 cursor-not-allowed"
                                value="${courseName != null ? courseName : 'Không xác định'}"
                                />
                            <p class="mt-1 text-sm text-gray-500">Không thể thay đổi khóa học sau khi tạo</p>
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
                                >${cert.description}</textarea>
                        </div>

                        <div class="mb-6">
                            <label for="code_prefix" class="block text-sm font-medium text-gray-700 mb-2">
                                Mã tiền tố <span class="text-red-500">*</span>
                            </label>
                            <input 
                                type="text" 
                                id="code_prefix" 
                                name="code_prefix" 
                                required
                                disabled=""
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                placeholder="VD: COURSE-17"
                                value="${cert.codePrefix}"
                                />
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
                                <option value="Active" ${cert.status == 'Active' ? 'selected' : ''}>
                                    Hoạt động
                                </option>
                                <option value="Inactive" ${cert.status == 'Inactive' ? 'selected' : ''}>
                                    Không hoạt động
                                </option>
                            </select>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg">
                                <p class="text-red-600 font-medium">${error}</p>
                            </div>
                        </c:if>

                        <c:if test="${not empty success}">
                            <div class="mb-6 p-4 bg-green-50 border border-green-200 rounded-lg">
                                <p class="text-green-600 font-medium">${success}</p>
                            </div>
                        </c:if>

                        <div class="flex gap-4">
                            <button 
                                type="submit" 
                                class="flex-1 bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors font-medium"
                                >
                                Cập nhật chứng chỉ
                            </button>
                            <a 
                                href="${pageContext.request.contextPath}/instructor/manager/certificate" 
                                class="flex-1 bg-gray-200 text-gray-700 px-6 py-3 rounded-lg hover:bg-gray-300 transition-colors font-medium text-center"
                                >
                                Hủy bỏ
                            </a>
                        </div>
                    </form>
                </div>

                <div class="mt-6 p-4 bg-blue-50 border border-blue-200 rounded-lg">
                    <h3 class="font-semibold text-blue-900 mb-2">Lưu ý quan trọng:</h3>
                    <ul class="text-sm text-blue-800 space-y-1">
                        <li>• Các trường đánh dấu <span class="text-red-500">*</span> là bắt buộc</li>
                        <li>• Không thể thay đổi khóa học sau khi chứng chỉ đã được tạo</li>
                        <li>• Thay đổi tiền tố mã chỉ ảnh hưởng đến các chứng chỉ mới, không ảnh hưởng chứng chỉ đã cấp</li>
                        <li>• Chứng chỉ ở trạng thái "Không hoạt động" sẽ không được cấp tự động</li>
                    </ul>
                </div>

                <div class="mt-4 p-4 bg-white border border-gray-200 rounded-lg">
                    <h3 class="font-semibold text-gray-900 mb-2">Thông tin chứng chỉ:</h3>
                    <div class="grid grid-cols-2 gap-3 text-sm">
                        <div>
                            <span class="text-gray-600">ID:</span>
                            <span class="font-medium ml-2">#${cert.id}</span>
                        </div>
                        <div>
                            <span class="text-gray-600">Khóa học ID:</span>
                            <span class="font-medium ml-2">#${cert.courseId} - ${courseName}</span>
                        </div>
                        <div>
                            <span class="text-gray-600">Ngày tạo:</span>
                            <span class="font-medium ml-2">${cert.createdAt}</span>
                        </div>
                        <div>
                            <span class="text-gray-600">Trạng thái hiện tại:</span>
                            <span class="ml-2 px-2 py-1 rounded text-xs ${cert.status == 'Active' ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'}">
                                ${cert.status}
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/layout/footer.jsp"/>
        <jsp:include page="/layout/importBottom.jsp"/>
    </body>
</html>