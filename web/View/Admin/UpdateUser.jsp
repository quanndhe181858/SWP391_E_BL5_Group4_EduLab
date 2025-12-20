<%-- Document : UpdateUser Created on : Dec 12, 2025, 1:45:00 PM Author : Le Minh Duc --%>

    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@page contentType="text/html;charset=UTF-8" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Cập nhật Người dùng - Admin</title>
                    <jsp:include page="/layout/import.jsp" />
                </head>

                <body class="bg-gradient-to-br from-gray-50 to-gray-100">

                    <!-- HEADER -->
                    <jsp:include page="/layout/header.jsp" />
                    <jsp:include page="/layout/admin_sidebar.jsp" />

                    <!-- Main Container -->
                    <div class="ml-64 pt-6 px-6 pb-8">

                        <!-- Breadcrumb -->
                        <div class="mb-6">
                            <nav class="flex" aria-label="Breadcrumb">
                                <ol class="inline-flex items-center space-x-1 md:space-x-3">
                                    <li class="inline-flex items-center">
                                        <a href="${pageContext.request.contextPath}/admin/users?page=users"
                                            class="inline-flex items-center text-sm font-medium text-gray-700 hover:text-blue-600">
                                            <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                                <path
                                                    d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z" />
                                            </svg>
                                            Quản lý Người dùng
                                        </a>
                                    </li>
                                    <li aria-current="page">
                                        <div class="flex items-center">
                                            <svg class="w-6 h-6 text-gray-400" fill="currentColor" viewBox="0 0 20 20">
                                                <path fill-rule="evenodd"
                                                    d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                                                    clip-rule="evenodd" />
                                            </svg>
                                            <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Cập nhật thông
                                                tin</span>
                                        </div>
                                    </li>
                                </ol>
                            </nav>
                        </div>

                        <!-- Page Title -->
                        <div class="mb-8">
                            <h1 class="text-3xl font-bold text-gray-800 mb-2">✏️ Cập nhật Thông tin Người dùng</h1>
                            <p class="text-gray-600">Chỉnh sửa thông tin cá nhân và vai trò của người dùng</p>
                        </div>

                        <!-- Form Card -->
                        <div class="bg-white rounded-xl shadow-md p-8">
                            <form method="POST" action="${pageContext.request.contextPath}/admin/users"
                                id="updateUserForm">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${user.id}">

                                <!-- Role Section -->
                                <div class="mb-8 pb-8 border-b border-gray-200">
                                    <h2 class="text-xl font-semibold text-gray-800 mb-4 flex items-center">
                                        <svg class="w-5 h-5 mr-2 text-purple-600" fill="currentColor"
                                            viewBox="0 0 20 20">
                                            <path fill-rule="evenodd"
                                                d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                                                clip-rule="evenodd" />
                                        </svg>
                                        Vai trò & Quyền hạn
                                    </h2>

                                    <div class="space-y-4">
                                        <label class="block text-sm font-medium text-gray-700 mb-2">
                                            Chọn vai trò <span class="text-red-500">*</span>
                                        </label>

                                        <c:forEach var="role" items="${roles}">
                                            <div
                                                class="flex items-start p-4 border-2 rounded-lg cursor-pointer transition-all ${user.role_id == role.id ? 'border-blue-500 bg-blue-50' : 'border-gray-200 hover:border-gray-300'}">
                                                <input type="radio" id="role${role.id}" name="roleId" value="${role.id}"
                                                    ${user.role_id==role.id ? 'checked' : '' } required
                                                    class="mt-1 h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300">
                                                <label for="role${role.id}" class="ml-3 flex-1 cursor-pointer">
                                                    <div class="flex items-center justify-between">
                                                        <div>
                                                            <span
                                                                class="block text-sm font-semibold text-gray-900">${role.name}</span>
                                                            <c:if test="${not empty role.description}">
                                                                <span
                                                                    class="block text-sm text-gray-600 mt-1">${role.description}</span>
                                                            </c:if>
                                                        </div>
                                                        <c:choose>
                                                            <c:when test="${role.id == 1}">
                                                                <span
                                                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-purple-100 text-purple-800">
                                                                    <svg class="w-3 h-3 mr-1" fill="currentColor"
                                                                        viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Admin
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${role.id == 2}">
                                                                <span
                                                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                                    <svg class="w-3 h-3 mr-1" fill="currentColor"
                                                                        viewBox="0 0 20 20">
                                                                        <path
                                                                            d="M10.394 2.08a1 1 0 00-.788 0l-7 3a1 1 0 000 1.84L5.25 8.051a.999.999 0 01.356-.257l4-1.714a1 1 0 11.788 1.838L7.667 9.088l1.94.831a1 1 0 00.787 0l7-3a1 1 0 000-1.838l-7-3zM3.31 9.397L5 10.12v4.102a8.969 8.969 0 00-1.05-.174 1 1 0 01-.89-.89 11.115 11.115 0 01.25-3.762zM9.3 16.573A9.026 9.026 0 007 14.935v-3.957l1.818.78a3 3 0 002.364 0l5.508-2.361a11.026 11.026 0 01.25 3.762 1 1 0 01-.89.89 8.968 8.968 0 00-5.35 2.524 1 1 0 01-1.4 0zM6 18a1 1 0 001-1v-2.065a8.935 8.935 0 00-2-.712V17a1 1 0 001 1z" />
                                                                    </svg>
                                                                    Instructor
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span
                                                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                                                    <svg class="w-3 h-3 mr-1" fill="currentColor"
                                                                        viewBox="0 0 20 20">
                                                                        <path
                                                                            d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" />
                                                                    </svg>
                                                                    Trainee
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Additional Info Section -->
                                <div class="mb-8">
                                    <h2 class="text-xl font-semibold text-gray-800 mb-4 flex items-center">
                                        <svg class="w-5 h-5 mr-2 text-gray-600" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd"
                                                d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z"
                                                clip-rule="evenodd" />
                                        </svg>
                                        Thông tin bổ sung
                                    </h2>

                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 bg-gray-50 p-4 rounded-lg">
                                        <div>
                                            <p class="text-sm text-gray-600">User ID:</p>
                                            <p class="text-sm font-medium text-gray-900">${user.id}</p>
                                        </div>
                                        <div>
                                            <p class="text-sm text-gray-600">UUID:</p>
                                            <p class="text-sm font-mono font-medium text-gray-900 break-all">
                                                ${user.uuid}</p>
                                        </div>
                                        <div>
                                            <p class="text-sm text-gray-600">Trạng thái hiện tại:</p>
                                            <p class="text-sm font-medium">
                                                <c:choose>
                                                    <c:when test="${user.status == 'Active'}">
                                                        <span
                                                            class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                            <span class="w-2 h-2 mr-1 bg-green-500 rounded-full"></span>
                                                            Hoạt động
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                                                            <span class="w-2 h-2 mr-1 bg-gray-500 rounded-full"></span>
                                                            Không hoạt động
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                        <div>
                                            <p class="text-sm text-gray-600">Ngày tạo:</p>
                                            <p class="text-sm font-medium text-gray-900">
                                                <fmt:formatDate value="${user.created_at}" pattern="dd/MM/yyyy HH:mm" />
                                            </p>
                                        </div>
                                        <c:if test="${not empty user.updated_at}">
                                            <div>
                                                <p class="text-sm text-gray-600">Cập nhật lần cuối:</p>
                                                <p class="text-sm font-medium text-gray-900">
                                                    <fmt:formatDate value="${user.updated_at}"
                                                        pattern="dd/MM/yyyy HH:mm" />
                                                </p>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="flex items-center justify-end gap-4 pt-6 border-t border-gray-200">
                                    <a href="${pageContext.request.contextPath}/admin/users"
                                        class="px-6 py-2.5 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition-colors font-medium">
                                        Hủy
                                    </a>
                                    <button type="submit"
                                        class="px-6 py-2.5 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors font-medium flex items-center">
                                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M5 13l4 4L19 7" />
                                        </svg>
                                        Cập nhật
                                    </button>
                                </div>
                            </form>
                        </div>

                    </div>

                    <!-- FOOTER -->
                    <jsp:include page="/layout/importBottom.jsp" />

                    <!-- Toast Notification Logic -->
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            <c:if test="${not empty sessionScope.success}">
                                showToast("${sessionScope.success}", "success");
                            </c:if>
                            <c:if test="${not empty sessionScope.error}">
                                showToast("${sessionScope.error}", "error");
                            </c:if>
                            <c:if test="${not empty sessionScope.notification}">
                                showToast("${sessionScope.notification}", "${sessionScope.notificationType != null ? sessionScope.notificationType : 'info'}");
                            </c:if>
                        });
                    </script>
                    <c:if test="${not empty sessionScope.success}">
                        <c:remove var="success" scope="session" />
                    </c:if>
                    <c:if test="${not empty sessionScope.error}">
                        <c:remove var="error" scope="session" />
                    </c:if>
                    <c:if test="${not empty sessionScope.notification}">
                        <c:remove var="notification" scope="session" />
                        <c:remove var="notificationType" scope="session" />
                    </c:if>

                    <!-- Form Validation Script -->
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const form = document.getElementById('updateUserForm');

                            form.addEventListener('submit', function (e) {
                                const firstName = document.getElementById('firstName').value.trim();
                                const lastName = document.getElementById('lastName').value.trim();
                                const email = document.getElementById('email').value.trim();
                                const roleChecked = document.querySelector('input[name="roleId"]:checked');

                                if (!firstName || !lastName || !email || !roleChecked) {
                                    e.preventDefault();
                                    showToast('Vui lòng điền đầy đủ thông tin bắt buộc!', "error");
                                    return false;
                                }

                                // Email validation
                                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                                if (!emailPattern.test(email)) {
                                    e.preventDefault();
                                    showToast('Email không hợp lệ!', "error");
                                    return false;
                                }

                                return true;
                            });

                            // Radio button styling
                            const radioInputs = document.querySelectorAll('input[name="roleId"]');
                            radioInputs.forEach(radio => {
                                radio.addEventListener('change', function () {
                                    document.querySelectorAll('input[name="roleId"]').forEach(r => {
                                        const container = r.closest('.flex');
                                        if (r.checked) {
                                            container.classList.add('border-blue-500', 'bg-blue-50');
                                            container.classList.remove('border-gray-200');
                                        } else {
                                            container.classList.remove('border-blue-500', 'bg-blue-50');
                                            container.classList.add('border-gray-200');
                                        }
                                    });
                                });
                            });
                        });
                    </script>

                </body>

                </html>