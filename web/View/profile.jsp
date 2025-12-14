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

            .error-message {
                display: none;
                color: #dc2626;
                font-size: 0.875rem;
                margin-top: 0.25rem;
            }
            .error-message.show {
                display: block;
            }
            .input-error {
                border-color: #dc2626 !important;
            }
            .password-strength {
                height: 4px;
                background: #e5e7eb;
                border-radius: 2px;
                margin-top: 0.5rem;
                overflow: hidden;
            }
            .password-strength-bar {
                height: 100%;
                transition: all 0.3s ease;
                width: 0%;
            }
            .strength-weak {
                background: #ef4444;
                width: 33%;
            }
            .strength-medium {
                background: #f59e0b;
                width: 66%;
            }
            .strength-strong {
                background: #10b981;
                width: 100%;
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
                        <form action="${pageContext.request.contextPath}/change-password" method="POST" id="passwordForm" onsubmit="return validatePasswordForm()">
                            <input type="hidden" name="action" value="changePassword">

                            <div class="max-w-md">
                                <h3 class="text-lg font-semibold text-gray-800 mb-4">Đổi mật khẩu</h3>

                                <div class="space-y-4">
                                    <div>
                                        <label for="curPassword" class="block text-gray-700 text-sm font-semibold mb-2">
                                            Mật khẩu hiện tại <span class="text-red-500">*</span>
                                        </label>
                                        <div class="relative">
                                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                                </svg>
                                            </div>
                                            <input type="password" 
                                                   id="curPassword" 
                                                   name="curPassword" 
                                                   class="w-full pl-10 pr-12 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200"
                                                   placeholder="••••••••"
                                                   required>
                                            <button type="button" 
                                                    id="toggleCurPassword"
                                                    class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                                <svg class="w-5 h-5 text-gray-400 hover:text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                                </svg>
                                            </button>
                                        </div>
                                        <p class="error-message" id="curPasswordError"></p>
                                    </div>

                                    <div>
                                        <label for="newPassword" class="block text-gray-700 text-sm font-semibold mb-2">
                                            Mật khẩu mới <span class="text-red-500">*</span>
                                        </label>
                                        <div class="relative">
                                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                                </svg>
                                            </div>
                                            <input type="password" 
                                                   id="newPassword" 
                                                   name="newPassword" 
                                                   class="w-full pl-10 pr-12 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200"
                                                   placeholder="••••••••"
                                                   required>
                                            <button type="button" 
                                                    id="toggleNewPassword"
                                                    class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                                <svg class="w-5 h-5 text-gray-400 hover:text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                                </svg>
                                            </button>
                                        </div>
                                        <div class="password-strength">
                                            <div class="password-strength-bar" id="newPasswordStrengthBar"></div>
                                        </div>
                                        <p class="error-message" id="newPasswordError"></p>
                                        <p class="text-xs text-gray-500 mt-1">Ít nhất 8 ký tự, 1 chữ hoa, 1 chữ thường, 1 số, 1 ký tự đặc biệt</p>
                                    </div>

                                    <div>
                                        <label for="rePassword" class="block text-gray-700 text-sm font-semibold mb-2">
                                            Xác nhận mật khẩu mới <span class="text-red-500">*</span>
                                        </label>
                                        <div class="relative">
                                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                                </svg>
                                            </div>
                                            <input type="password" 
                                                   id="rePassword" 
                                                   name="rePassword" 
                                                   class="w-full pl-10 pr-12 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200"
                                                   placeholder="••••••••"
                                                   required>
                                            <button type="button" 
                                                    id="toggleRePassword"
                                                    class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                                <svg class="w-5 h-5 text-gray-400 hover:text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                                </svg>
                                            </button>
                                        </div>
                                        <p class="error-message" id="rePasswordError"></p>
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
            function setupPasswordToggle(buttonId, inputId) {
                const button = document.getElementById(buttonId);
                const input = document.getElementById(inputId);

                if (!button || !input)
                    return;

                button.addEventListener('click', function () {
                    const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
                    input.setAttribute('type', type);

                    const svg = this.querySelector('svg');
                    if (type === 'text') {
                        svg.innerHTML = `
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
            `;
                    } else {
                        svg.innerHTML = `
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
            `;
                    }
                });
            }

            function checkPasswordStrength(password) {
                let strength = 0;

                if (password.length >= 8)
                    strength++;
                if (password.length >= 12)
                    strength++;
                if (/[a-z]/.test(password))
                    strength++;
                if (/[A-Z]/.test(password))
                    strength++;
                if (/[0-9]/.test(password))
                    strength++;
                if (/[^a-zA-Z0-9]/.test(password))
                    strength++;

                return strength;
            }

            function updatePasswordStrength(password, barId) {
                const strengthBar = document.getElementById(barId);
                if (!strengthBar)
                    return;

                const strength = checkPasswordStrength(password);

                strengthBar.className = 'password-strength-bar';

                if (password.length === 0) {
                    strengthBar.style.width = '0%';
                } else if (strength <= 2) {
                    strengthBar.classList.add('strength-weak');
                } else if (strength <= 4) {
                    strengthBar.classList.add('strength-medium');
                } else {
                    strengthBar.classList.add('strength-strong');
                }
            }

            function validatePassword(password) {
                const minLength = 8;
                const hasUpperCase = /[A-Z]/.test(password);
                const hasLowerCase = /[a-z]/.test(password);
                const hasNumber = /[0-9]/.test(password);
                const hasSpecialChar = /[^a-zA-Z0-9]/.test(password);

                if (password.length < minLength) {
                    return 'Mật khẩu phải có ít nhất 8 ký tự';
                }
                if (!hasUpperCase) {
                    return 'Mật khẩu phải có ít nhất 1 chữ hoa';
                }
                if (!hasLowerCase) {
                    return 'Mật khẩu phải có ít nhất 1 chữ thường';
                }
                if (!hasNumber) {
                    return 'Mật khẩu phải có ít nhất 1 số';
                }
                if (!hasSpecialChar) {
                    return 'Mật khẩu phải có ít nhất 1 ký tự đặc biệt';
                }

                return '';
            }

            function showError(elementId, message) {
                const errorElement = document.getElementById(elementId);
                if (errorElement) {
                    errorElement.textContent = message;
                    errorElement.classList.add('show');
                }
            }

            function clearError(elementId) {
                const errorElement = document.getElementById(elementId);
                if (errorElement) {
                    errorElement.textContent = '';
                    errorElement.classList.remove('show');
                }
            }

            function clearAllPasswordErrors() {
                clearError('curPasswordError');
                clearError('newPasswordError');
                clearError('rePasswordError');
            }

            function validatePasswordForm() {
                let isValid = true;

                const curPassword = document.getElementById('curPassword').value.trim();
                const newPassword = document.getElementById('newPassword').value.trim();
                const rePassword = document.getElementById('rePassword').value.trim();

                clearAllPasswordErrors();

                if (!curPassword) {
                    showError('curPasswordError', 'Vui lòng nhập mật khẩu hiện tại');
                    isValid = false;
                }

                if (!newPassword) {
                    showError('newPasswordError', 'Vui lòng nhập mật khẩu mới');
                    isValid = false;
                } else {
                    const passwordError = validatePassword(newPassword);
                    if (passwordError) {
                        showError('newPasswordError', passwordError);
                        isValid = false;
                    } else if (curPassword && newPassword === curPassword) {
                        showError('newPasswordError', 'Mật khẩu mới phải khác mật khẩu hiện tại');
                        isValid = false;
                    }
                }

                if (!rePassword) {
                    showError('rePasswordError', 'Vui lòng xác nhận mật khẩu mới');
                    isValid = false;
                } else if (newPassword !== rePassword) {
                    showError('rePasswordError', 'Mật khẩu xác nhận không khớp');
                    isValid = false;
                }

                return isValid;
            }

            function resetPasswordForm() {
                const passwordForm = document.getElementById('passwordForm');
                if (passwordForm) {
                    passwordForm.reset();
                }

                clearAllPasswordErrors();

                const strengthBar = document.getElementById('newPasswordStrengthBar');
                if (strengthBar) {
                    strengthBar.style.width = '0%';
                    strengthBar.className = 'password-strength-bar';
                }
            }

            function validateProfileForm() {
                const firstName = document.getElementById('firstName');
                const lastName = document.getElementById('lastName');
                const bodInput = document.getElementById('bod');

                if (!firstName || !lastName)
                    return true;

                const firstNameValue = firstName.value.trim();
                const lastNameValue = lastName.value.trim();

                if (!firstNameValue || !lastNameValue) {
                    showToast('Vui lòng điền đầy đủ họ và tên!', 'error');
                    return false;
                }

                if (bodInput && bodInput.value) {
                    const selectedDate = new Date(bodInput.value);
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);

                    if (selectedDate > today) {
                        showToast('Ngày sinh không được nằm trong tương lai!', 'error');
                        return false;
                    }
                }

                return true;
            }

            function resetForm() {
                location.reload();
            }

            function switchTab(tabName) {
                document.querySelectorAll('[id^="tab-"]').forEach(tab => {
                    tab.classList.remove('tab-active', 'text-blue-600');
                    tab.classList.add('text-gray-500');
                });

                document.querySelectorAll('[id^="content-"]').forEach(content => {
                    content.classList.add('hidden');
                });

                const selectedTab = document.getElementById('tab-' + tabName);
                const selectedContent = document.getElementById('content-' + tabName);

                if (selectedTab) {
                    selectedTab.classList.add('tab-active', 'text-blue-600');
                    selectedTab.classList.remove('text-gray-500');
                }

                if (selectedContent) {
                    selectedContent.classList.remove('hidden');
                }
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
                        const avatarPreview = document.getElementById('avatarPreview');
                        if (avatarPreview) {
                            avatarPreview.src = e.target.result;
                        }
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
                const originalSrc = avatarPreview ? avatarPreview.src : '';

                if (avatarPreview) {
                    avatarPreview.style.opacity = '0.5';
                }

                fetch('${pageContext.request.contextPath}' + '/profile', {
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
                            if (avatarPreview) {
                                avatarPreview.style.opacity = '1';
                            }

                            if (data.success) {
                                showToast('Cập nhật avatar thành công!', 'success');

                                if (data.path && avatarPreview) {
                                    avatarPreview.src = '${pageContext.request.contextPath}' + '/' + data.path + '?t=' + new Date().getTime();
                                }

                                setTimeout(() => {
                                    location.reload();
                                }, 1000);
                            } else {
                                showToast(data.message || 'Không thể cập nhật avatar!', 'error');
                                if (avatarPreview && originalSrc) {
                                    avatarPreview.src = originalSrc;
                                }
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            if (avatarPreview) {
                                avatarPreview.style.opacity = '1';
                                if (originalSrc) {
                                    avatarPreview.src = originalSrc;
                                }
                            }
                            showToast('Có lỗi xảy ra khi upload avatar!', 'error');
                        });
            }

            document.addEventListener('DOMContentLoaded', function () {
                const tab = '${tab}';
                const error = '${error}';
                const ok = '${ok}';

                if (tab) {
                    switchTab(tab);
                }

                if (error) {
                    showToast(error, 'error');
                }

                if (ok) {
                    showToast(ok, 'success');
                }

                setupPasswordToggle('toggleCurPassword', 'curPassword');
                setupPasswordToggle('toggleNewPassword', 'newPassword');
                setupPasswordToggle('toggleRePassword', 'rePassword');

                const newPasswordInput = document.getElementById('newPassword');
                if (newPasswordInput) {
                    newPasswordInput.addEventListener('input', function () {
                        updatePasswordStrength(this.value, 'newPasswordStrengthBar');
                    });
                }

                const curPasswordInput = document.getElementById('curPassword');
                if (curPasswordInput) {
                    curPasswordInput.addEventListener('blur', function () {
                        if (!this.value.trim()) {
                            showError('curPasswordError', 'Vui lòng nhập mật khẩu hiện tại');
                        } else {
                            clearError('curPasswordError');
                        }
                    });
                }

                if (newPasswordInput) {
                    newPasswordInput.addEventListener('blur', function () {
                        const error = validatePassword(this.value.trim());
                        if (error) {
                            showError('newPasswordError', error);
                        } else {
                            clearError('newPasswordError');
                        }
                    });
                }

                const rePasswordInput = document.getElementById('rePassword');
                if (rePasswordInput) {
                    rePasswordInput.addEventListener('blur', function () {
                        const newPassword = document.getElementById('newPassword')?.value.trim() || '';
                        if (!this.value.trim()) {
                            showError('rePasswordError', 'Vui lòng xác nhận mật khẩu mới');
                        } else if (this.value.trim() !== newPassword) {
                            showError('rePasswordError', 'Mật khẩu xác nhận không khớp');
                        } else {
                            clearError('rePasswordError');
                        }
                    });
                }
            });
        </script>
    </body>
</html>