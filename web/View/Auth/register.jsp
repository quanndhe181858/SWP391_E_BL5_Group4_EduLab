<%-- 
    Document   : register
    Created on : Dec 13, 2025, 4:05:48 PM
    Author     : hao
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng kí - EduLAB</title>
        <jsp:include page="/layout/import.jsp" />
        <style>
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
    <body class="bg-gradient-to-br from-red-500 via-blue-600 to-cyan-700 min-h-screen flex items-center justify-center p-4">

        <div class="w-[500px]">
            <div class="bg-white rounded-2xl shadow-2xl overflow-hidden transform transition-all duration-300">

                <div class="bg-gradient-to-r from-blue-500 to-cyan-600 p-6 text-center">
                    <div class="w-20 h-20 bg-white rounded-full mx-auto mb-3 flex items-center justify-center">
                        <svg class="w-10 h-10 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                        </svg>
                    </div>
                    <h1 class="text-3xl font-bold text-white mb-1">Chào mừng</h1>
                    <p class="text-blue-100">Đăng kí để tham gia khoá học</p>
                </div>

                <div class="p-6">

                    <% if (request.getAttribute("error") != null) {%>
                    <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded-r">
                        <div class="flex items-center">
                            <svg class="w-5 h-5 text-red-500 mr-2" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                            </svg>
                            <p class="text-red-700 text-sm font-medium"><%= request.getAttribute("error")%></p>
                        </div>
                    </div>
                    <% }%>

                    <form action="<%= request.getContextPath()%>/register" method="POST" id="registerForm">
                        <div class="grid grid-cols-2 gap-4 mb-5">
                            <div>
                                <label for="firstName" class="block text-gray-700 text-sm font-semibold mb-2">
                                    Họ <span class="text-red-500">*</span>
                                </label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                        </svg>
                                    </div>
                                    <input type="text" 
                                           id="firstName" 
                                           name="firstName" 
                                           value="<%= request.getParameter("firstName") != null ? request.getParameter("firstName") : ""%>"
                                           class="w-full pl-10 pr-4 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200"
                                           placeholder="Nguyễn"
                                           maxlength="50"
                                           required>
                                </div>
                                <p class="error-message" id="firstNameError"></p>
                            </div>

                            <div>
                                <label for="lastName" class="block text-gray-700 text-sm font-semibold mb-2">
                                    Tên <span class="text-red-500">*</span>
                                </label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                        </svg>
                                    </div>
                                    <input type="text" 
                                           id="lastName" 
                                           name="lastName" 
                                           value="<%= request.getParameter("lastName") != null ? request.getParameter("lastName") : ""%>"
                                           class="w-full pl-10 pr-4 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200"
                                           placeholder="Văn A"
                                           maxlength="50"
                                           required>
                                </div>
                                <p class="error-message" id="lastNameError"></p>
                            </div>
                        </div>

                        <div class="mb-5">
                            <label for="email" class="block text-gray-700 text-sm font-semibold mb-2">
                                Email <span class="text-red-500">*</span>
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207" />
                                    </svg>
                                </div>
                                <input type="email" 
                                       id="email" 
                                       name="email" 
                                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : ""%>"
                                       class="w-full pl-10 pr-4 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200"
                                       placeholder="you@example.com"
                                       required>
                            </div>
                            <p class="error-message" id="emailError"></p>
                        </div>

                        <div class="grid grid-cols-2 gap-4 mb-6">
                            <div>
                                <label for="password" class="block text-gray-700 text-sm font-semibold mb-2">
                                    Mật khẩu <span class="text-red-500">*</span>
                                </label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                        </svg>
                                    </div>
                                    <input type="password" 
                                           id="password" 
                                           name="password" 
                                           class="w-full pl-10 pr-12 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200"
                                           placeholder="••••••••"
                                           required>
                                    <button type="button" 
                                            id="togglePassword"
                                            class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                        <svg class="w-5 h-5 text-gray-400 hover:text-gray-600" id="eyeIcon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                        </svg>
                                    </button>
                                </div>
                                <div class="password-strength">
                                    <div class="password-strength-bar" id="strengthBar"></div>
                                </div>
                                <p class="error-message" id="passwordError"></p>
                                <p class="text-xs text-gray-500 mt-1">Ít nhất 8 ký tự, 1 chữ hoa, 1 chữ thường, 1 số, 1 ký tự đặc biệt</p>
                            </div>

                            <div>
                                <label for="rePassword" class="block text-gray-700 text-sm font-semibold mb-2">
                                    Xác nhận mật khẩu <span class="text-red-500">*</span>
                                </label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
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
                                        <svg class="w-5 h-5 text-gray-400 hover:text-gray-600" id="eyeIcon2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                        </svg>
                                    </button>
                                </div>
                                <p class="error-message" id="rePasswordError"></p>
                            </div>
                        </div>

                        <button type="submit" 
                                class="w-full bg-gradient-to-r from-blue-500 to-cyan-600 text-white py-3 rounded-lg font-semibold hover:from-blue-600 hover:to-cyan-700 transform transition-all duration-200 focus:outline-none focus:ring-4 focus:ring-blue-300 shadow-lg hover:shadow-xl">
                            Đăng kí
                        </button>

                        <div class="relative my-6">
                            <div class="absolute inset-0 flex items-center">
                                <div class="w-full border-t border-gray-300"></div>
                            </div>
                            <div class="relative flex justify-center text-sm">
                                <span class="px-2 bg-white text-gray-500">Hoặc đăng kí với</span>
                            </div>
                        </div>

                        <div class="text-center">
                            <a href="https://accounts.google.com/o/oauth2/auth?scope=profile%20email%20openid%20https://www.googleapis.com/auth/userinfo.profile%20https://www.googleapis.com/auth/userinfo.email%20https://www.googleapis.com/auth/user.phonenumbers.read%20https://www.googleapis.com/auth/user.gender.read&redirect_uri=http://localhost:8080/SWP391_E_BL5_Group4_LabEdu/auth/google&response_type=code&client_id=301095774546-t0dvfvp0v7lhqhkumtmlemeomkt1j514.apps.googleusercontent.com&approval_prompt=force"
                               class="inline-flex items-center justify-center w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:bg-gray-50 transition-all duration-200 font-medium text-gray-700">
                                <svg class="w-5 h-5 mr-2" viewBox="0 0 24 24">
                                <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                                <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                                <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
                                <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
                                </svg>
                                Đăng kí với Google
                            </a>
                        </div>

                        <div class="mt-6 text-center space-y-2">
                            <p class="text-gray-600 text-sm">
                                Đã có tài khoản? 
                                <a href="<%= request.getContextPath()%>/login" class="text-blue-600 hover:text-blue-700 font-semibold">
                                    Đăng nhập
                                </a>
                            </p>
                            <p class="text-gray-600 text-sm">
                                <a href="<%= request.getContextPath()%>/home" class="text-blue-600 hover:text-blue-700 font-semibold">
                                    ← Về trang chủ
                                </a>
                            </p>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            $(document).ready(function () {
                $('#togglePassword').click(function () {
                    const passwordInput = $('#password');
                    const type = passwordInput.attr('type') === 'password' ? 'text' : 'password';
                    passwordInput.attr('type', type);

                    if (type === 'text') {
                        $('#eyeIcon').html(`
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
            `);
                    } else {
                        $('#eyeIcon').html(`
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
            `);
                    }
                });

                $('#toggleRePassword').click(function () {
                    const passwordInput = $('#rePassword');
                    const type = passwordInput.attr('type') === 'password' ? 'text' : 'password';
                    passwordInput.attr('type', type);

                    if (type === 'text') {
                        $('#eyeIcon2').html(`
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
            `);
                    } else {
                        $('#eyeIcon2').html(`
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
            `);
                    }
                });

                function validateName(value, fieldName) {
                    const trimmed = value.trim();
                    if (trimmed.length === 0) {
                        return fieldName + ' không được để trống';
                    }
                    if (trimmed !== value) {
                        return fieldName + ' không được chỉ chứa khoảng trắng';
                    }
                    if (trimmed.length > 50) {
                        return fieldName + ' không được vượt quá 50 ký tự';
                    }
                    return '';
                }

                function validateEmail(email) {
                    const trimmed = email.trim();
                    if (trimmed.length === 0) {
                        return 'Email không được để trống';
                    }
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailRegex.test(trimmed)) {
                        return 'Email không hợp lệ';
                    }
                    return '';
                }

                function validatePassword(password) {
                    if (password.length < 8) {
                        return 'Mật khẩu phải có ít nhất 8 ký tự';
                    }
                    if (!/[A-Z]/.test(password)) {
                        return 'Mật khẩu phải có ít nhất 1 chữ hoa';
                    }
                    if (!/[a-z]/.test(password)) {
                        return 'Mật khẩu phải có ít nhất 1 chữ thường';
                    }
                    if (!/[0-9]/.test(password)) {
                        return 'Mật khẩu phải có ít nhất 1 chữ số';
                    }
                    if (!/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
                        return 'Mật khẩu phải có ít nhất 1 ký tự đặc biệt';
                    }
                    return '';
                }

                function checkPasswordStrength(password) {
                    let strength = 0;
                    if (password.length >= 8)
                        strength++;
                    if (/[a-z]/.test(password))
                        strength++;
                    if (/[A-Z]/.test(password))
                        strength++;
                    if (/[0-9]/.test(password))
                        strength++;
                    if (/[!@#$%^&*(),.?":{}|<>]/.test(password))
                        strength++;

                    const strengthBar = $('#strengthBar');
                    strengthBar.removeClass('strength-weak strength-medium strength-strong');

                    if (strength <= 2) {
                        strengthBar.addClass('strength-weak');
                    } else if (strength <= 4) {
                        strengthBar.addClass('strength-medium');
                    } else {
                        strengthBar.addClass('strength-strong');
                    }
                }

                function showError(inputId, errorId, message) {
                    $('#' + inputId).addClass('input-error');
                    $('#' + errorId).text(message).addClass('show');
                }

                function clearError(inputId, errorId) {
                    $('#' + inputId).removeClass('input-error');
                    $('#' + errorId).removeClass('show');
                }

                $('#firstName').on('blur', function () {
                    const error = validateName($(this).val(), 'Họ');
                    if (error) {
                        showError('firstName', 'firstNameError', error);
                    } else {
                        clearError('firstName', 'firstNameError');
                    }
                });

                $('#lastName').on('blur', function () {
                    const error = validateName($(this).val(), 'Tên');
                    if (error) {
                        showError('lastName', 'lastNameError', error);
                    } else {
                        clearError('lastName', 'lastNameError');
                    }
                });

                $('#email').on('blur', function () {
                    const error = validateEmail($(this).val());
                    if (error) {
                        showError('email', 'emailError', error);
                    } else {
                        clearError('email', 'emailError');
                    }
                });

                $('#password').on('input', function () {
                    checkPasswordStrength($(this).val());
                });

                $('#password').on('blur', function () {
                    const error = validatePassword($(this).val());
                    if (error) {
                        showError('password', 'passwordError', error);
                    } else {
                        clearError('password', 'passwordError');
                    }
                });

                $('#rePassword').on('blur', function () {
                    const password = $('#password').val();
                    const rePassword = $(this).val();
                    if (rePassword !== password) {
                        showError('rePassword', 'rePasswordError', 'Mật khẩu xác nhận không khớp');
                    } else {
                        clearError('rePassword', 'rePasswordError');
                    }
                });

                $('#registerForm').submit(function (e) {
                    let hasError = false;

                    const firstNameError = validateName($('#firstName').val(), 'Họ');
                    if (firstNameError) {
                        showError('firstName', 'firstNameError', firstNameError);
                        hasError = true;
                    } else {
                        clearError('firstName', 'firstNameError');
                    }

                    const lastNameError = validateName($('#lastName').val(), 'Tên');
                    if (lastNameError) {
                        showError('lastName', 'lastNameError', lastNameError);
                        hasError = true;
                    } else {
                        clearError('lastName', 'lastNameError');
                    }

                    const emailError = validateEmail($('#email').val());
                    if (emailError) {
                        showError('email', 'emailError', emailError);
                        hasError = true;
                    } else {
                        clearError('email', 'emailError');
                    }

                    const passwordError = validatePassword($('#password').val());
                    if (passwordError) {
                        showError('password', 'passwordError', passwordError);
                        hasError = true;
                    } else {
                        clearError('password', 'passwordError');
                    }

                    const password = $('#password').val();
                    const rePassword = $('#rePassword').val();
                    if (rePassword !== password) {
                        showError('rePassword', 'rePasswordError', 'Mật khẩu xác nhận không khớp');
                        hasError = true;
                    } else if (rePassword.length === 0) {
                        showError('rePassword', 'rePasswordError', 'Vui lòng xác nhận mật khẩu');
                        hasError = true;
                    } else {
                        clearError('rePassword', 'rePasswordError');
                    }

                    if (hasError) {
                        e.preventDefault();
                        return false;
                    }
                });
            });
        </script>
    </body>
</html>