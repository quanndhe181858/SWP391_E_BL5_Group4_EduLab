<%-- 
    Document   : profile
    Created on : Dec 13, 2025, 2:23:51 PM
    Author     : hao
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang cá nhân - ${sessionScope.user.first_name} ${sessionScope.user.last_name}</title>
        <jsp:include page="/layout/import.jsp" />
        <style>
            .profile-avatar {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
            }
            .tab-active {
                border-bottom: 2px solid #3b82f6;
                color: #3b82f6;
            }
        </style>
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp" />

        <div class="container mx-auto px-4 py-8">
            <c:if test="${not empty sessionScope.message}">
                <div class="mb-6 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
                    <span class="block sm:inline">${sessionScope.message}</span>
                    <c:remove var="message" scope="session"/>
                </div>
            </c:if>

            <c:if test="${not empty sessionScope.error}">
                <div class="mb-6 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                    <span class="block sm:inline">${sessionScope.error}</span>
                    <c:remove var="error" scope="session"/>
                </div>
            </c:if>

            <div class="max-w-6xl mx-auto min-h-[696px]">
                <div class="bg-white rounded-lg shadow-md overflow-hidden mb-6">
                    <div class="bg-white h-24"></div>
                    <div class="px-6 pb-6">
                        <div class="flex flex-col md:flex-row items-center md:items-end -mt-16 md:-mt-12">
                            <div class="relative">
                                <c:if test="${not empty sessionScope.avatar}">
                                    <img id="avatarPreview" 
                                         src="${pageContext.request.contextPath}/${media.path}" 
                                         alt="Avatar" 
                                         class="profile-avatar border-4 border-white shadow-lg">
                                </c:if>
                                <c:if test="${empty sessionScope.avatar}">
                                    <img id="avatarPreview" 
                                         src="${pageContext.request.contextPath}/media/avatar/default-avatar.avif"
                                         alt="Avatar" 
                                         class="profile-avatar border-4 border-white shadow-lg">
                                </c:if>
                                <button onclick="document.getElementById('avatarInput').click()" 
                                        class="absolute bottom-0 right-0 bg-blue-500 text-white p-2 rounded-full hover:bg-blue-600 transition">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"></path>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                    </svg>
                                </button>
                                <input type="file" id="avatarInput" class="hidden" accept="image/*" onchange="previewAvatar(this)">
                            </div>
                            <div class="mt-4 md:mt-0 md:ml-6 text-center md:text-left flex-1">
                                <h1 class="text-2xl md:text-3xl font-bold text-gray-800">
                                    ${sessionScope.user.first_name} ${sessionScope.user.last_name}
                                </h1>
                                <p class="text-gray-600 mt-1">${sessionScope.user.email}</p>
                                <div class="flex items-center justify-center md:justify-start gap-4 mt-2">
                                    <span class="px-3 py-1 ${sessionScope.user.status == 'Active' ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'} rounded-full text-sm font-medium">
                                        ${sessionScope.user.status == 'Active' ? 'Đang hoạt động' : 'Không hoạt động'}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-lg shadow-md">
                    <div class="border-b border-gray-200">
                        <nav class="flex -mb-px">
                            <button onclick="switchTab('info')" 
                                    id="tab-info" 
                                    class="tab-active py-4 px-6 font-medium text-sm transition-colors hover:text-blue-600">
                                Thông tin cá nhân
                            </button>
                            <button onclick="switchTab('security')" 
                                    id="tab-security" 
                                    class="py-4 px-6 text-gray-500 font-medium text-sm transition-colors hover:text-blue-600">
                                Bảo mật
                            </button>
                        </nav>
                    </div>

                    <div id="content-info" class="p-6">
                        <form action="${pageContext.request.contextPath}/profile" method="POST" onsubmit="return validateProfileForm()">
                            <input type="hidden" name="userId" value="${sessionScope.user.id}">

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">
                                        Họ <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" 
                                           name="firstName" 
                                           id="firstName"
                                           value="${sessionScope.user.first_name}" 
                                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                           required>
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">
                                        Tên <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" 
                                           name="lastName" 
                                           id="lastName"
                                           value="${sessionScope.user.last_name}" 
                                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                           required>
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">
                                        Email <span class="text-red-500">*</span>
                                    </label>
                                    <input type="email" 
                                           name="email" 
                                           id="email"
                                           value="${sessionScope.user.email}" 
                                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-gray-50"
                                           readonly>
                                    <p class="text-xs text-gray-500 mt-1">Email không thể thay đổi</p>
                                </div>

                                <fmt:formatDate value="<%= new java.util.Date()%>" pattern="yyyy-MM-dd" var="today"/>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">
                                        Ngày sinh
                                    </label>
                                    <input type="date" 
                                           name="bod" 
                                           id="bod"
                                           value="${sessionScope.user.bod}" 
                                           max="${today}"
                                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                </div>
                            </div>

                            <div class="mt-6 flex justify-end gap-3">
                                <button type="button" 
                                        onclick="resetForm()" 
                                        class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition">
                                    Hủy
                                </button>
                                <button type="submit" 
                                        class="px-6 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition">
                                    Lưu thay đổi
                                </button>
                            </div>
                        </form>
                    </div>

                    <div id="content-security" class="p-6 hidden">
                        <form action="${pageContext.request.contextPath}/profile" method="POST" onsubmit="return validatePasswordForm()">
                            <input type="hidden" name="action" value="changePassword">

                            <div class="max-w-md">
                                <h3 class="text-lg font-semibold text-gray-800 mb-4">Đổi mật khẩu</h3>

                                <div class="space-y-4">
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-2">
                                            Mật khẩu hiện tại <span class="text-red-500">*</span>
                                        </label>
                                        <input type="password" 
                                               name="currentPassword" 
                                               id="currentPassword"
                                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                               required>
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-2">
                                            Mật khẩu mới <span class="text-red-500">*</span>
                                        </label>
                                        <input type="password" 
                                               name="newPassword" 
                                               id="newPassword"
                                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                               required>
                                        <p class="text-xs text-gray-500 mt-1">Mật khẩu phải có ít nhất 8 ký tự</p>
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-2">
                                            Xác nhận mật khẩu mới <span class="text-red-500">*</span>
                                        </label>
                                        <input type="password" 
                                               name="confirmPassword" 
                                               id="confirmPassword"
                                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                               required>
                                    </div>
                                </div>

                                <div class="mt-6 flex gap-3">
                                    <button type="button" 
                                            onclick="resetPasswordForm()" 
                                            class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition">
                                        Hủy
                                    </button>
                                    <button type="submit" 
                                            class="px-6 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition">
                                        Đổi mật khẩu
                                    </button>
                                </div>
                            </div>
                        </form>

                        <div class="mt-8 pt-8 border-t border-gray-200">
                            <h3 class="text-lg font-semibold text-gray-800 mb-2">Thông tin tài khoản</h3>
                            <div class="space-y-2 text-sm text-gray-600">
                                <p><strong>UUID:</strong> ${sessionScope.user.uuid}</p>
                                <p><strong>Ngày tạo:</strong> <fmt:formatDate value="${sessionScope.user.created_at}" pattern="dd/MM/yyyy HH:mm"/></p>
                                <p><strong>Cập nhật lần cuối:</strong> <fmt:formatDate value="${sessionScope.user.updated_at}" pattern="dd/MM/yyyy HH:mm"/></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />
        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const error = '${error}';
                const ok = '${ok}';

                if (error) {
                    showToast(error, 'error');
                }

                if (ok) {
                    showToast(ok, 'success');
                }
            });

            function switchTab(tabName) {
                document.querySelectorAll('[id^="tab-"]').forEach(tab => {
                    tab.classList.remove('tab-active', 'text-blue-600');
                    tab.classList.add('text-gray-500');
                });

                document.querySelectorAll('[id^="content-"]').forEach(content => {
                    content.classList.add('hidden');
                });

                document.getElementById('tab-' + tabName).classList.add('tab-active', 'text-blue-600');
                document.getElementById('tab-' + tabName).classList.remove('text-gray-500');
                document.getElementById('content-' + tabName).classList.remove('hidden');
            }

            function previewAvatar(input) {
                if (input.files && input.files[0]) {
                    const file = input.files[0];

                    const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/webp'];
                    if (!validTypes.includes(file.type)) {
                        showToast('Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WEBP)!', 'error');
                        input.value = '';
                        return;
                    }

                    const maxSize = 5 * 1024 * 1024;
                    if (file.size > maxSize) {
                        showToast('Kích thước file không được vượt quá 5MB!', 'error');
                        input.value = '';
                        return;
                    }

                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('avatarPreview').src = e.target.result;
                    };
                    reader.readAsDataURL(file);

                    uploadAvatar(file);
                }
            }

            function uploadAvatar(file) {
                const formData = new FormData();
                formData.append('avatar', file);
                formData.append('action', 'uploadAvatar');

                const avatarPreview = document.getElementById('avatarPreview');
                const originalSrc = avatarPreview.src;
                avatarPreview.style.opacity = '0.5';

                fetch('${pageContext.request.contextPath}/profile', {
                    method: 'POST',
                    body: formData
                })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            avatarPreview.style.opacity = '1';

                            if (data.success) {
                                showToast('Cập nhật avatar thành công!', 'success');

                                if (data.path) {
                                    avatarPreview.src = '${pageContext.request.contextPath}/' + data.path + '?t=' + new Date().getTime();
                                }

                                setTimeout(() => {
                                    location.reload();
                                }, 1000);
                            } else {
                                showToast(data.message || 'Không thể cập nhật avatar!', 'error');
                                avatarPreview.src = originalSrc;
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            avatarPreview.style.opacity = '1';
                            avatarPreview.src = originalSrc;
                            showToast('Có lỗi xảy ra khi upload avatar!', 'error');
                        });
            }

            function validateProfileForm() {
                const firstName = document.getElementById('firstName').value.trim();
                const lastName = document.getElementById('lastName').value.trim();
                const bodInput = document.getElementById("bod");
                const bodValue = bodInput.value;

                if (!firstName || !lastName) {
                    showToast("Vui lòng điền đầy đủ họ và tên!", 'error');
                    return false;
                }

                if (bodValue) {
                    const selectedDate = new Date(bodValue);
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);

                    if (selectedDate > today) {
                        showToast("Ngày sinh không được nằm trong tương lai!", "error");
                        return false;
                    }
                }

                return true;
            }

            function validatePasswordForm() {
                const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$/;

                const currentPassword = document.getElementById('currentPassword').value;
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

                if (!currentPassword || !newPassword || !confirmPassword) {
                    showToast("Vui lòng điền đầy đủ thông tin!", 'error');
                    return false;
                }

                if (newPassword.length < 8) {
                    showToast("Mật khẩu mới phải có ít nhất 8 ký tự!", 'error');
                    return false;
                }

                if (!passwordRegex.test(newPassword)) {
                    showToast("Mật khẩu phải có ít nhất 8 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt!", 'error');
                    return false;
                }

                if (newPassword !== confirmPassword) {
                    showToast("Mật khẩu mới và xác nhận mật khẩu không khớp!", 'error');
                    return false;
                }

                if (currentPassword === newPassword) {
                    showToast("Vui lòng điền đầy đủ họ và tên!", 'error');
                    return false;
                }

                return true;
            }

            function resetForm() {
                location.reload();
            }

            function resetPasswordForm() {
                document.getElementById('currentPassword').value = '';
                document.getElementById('newPassword').value = '';
                document.getElementById('confirmPassword').value = '';
            }

            function showNotification(message, type) {
                const bgColor = type === 'success' ? 'bg-green-100 border-green-400 text-green-700' : 'bg-red-100 border-red-400 text-red-700';
                const notification = document.createElement('div');
                notification.className = `fixed top-4 right-4 ${bgColor} px-4 py-3 rounded shadow-lg z-50`;
                notification.innerHTML = message;
                document.body.appendChild(notification);

                setTimeout(() => {
                    notification.remove();
                }, 3000);
            }
        </script>
    </body>
</html>