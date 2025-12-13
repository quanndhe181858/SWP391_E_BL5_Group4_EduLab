<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login - EduLAB</title>
        <jsp:include page="/layout/import.jsp" />
    </head>
    <body class="bg-gradient-to-br from-red-500 via-blue-600 to-cyan-700 min-h-screen flex items-center justify-center p-4">

        <div class="w-full max-w-md">
            <div class="bg-white rounded-2xl shadow-2xl overflow-hidden transform transition-all duration-300">

                <div class="bg-gradient-to-r from-blue-500 to-cyan-600 p-8 text-center">
                    <div class="w-20 h-20 bg-white rounded-full mx-auto mb-4 flex items-center justify-center">
                        <svg class="w-10 h-10 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                        </svg>
                    </div>
                    <h1 class="text-3xl font-bold text-white mb-2">Chào mừng</h1>
                    <p class="text-blue-100">Đăng nhập để tiếp tục học</p>
                </div>

                <div class="p-8">

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

                    <form action="<%= request.getContextPath()%>/login" method="POST" id="loginForm">

                        <div class="mb-6">
                            <label for="email" class="block text-gray-700 text-sm font-semibold mb-2">
                                Email
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
                        </div>

                        <div class="mb-6">
                            <label for="password" class="block text-gray-700 text-sm font-semibold mb-2">
                                Mật khẩu
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
                        </div>

                        <div class="flex items-center justify-between mb-6">
                            <a href="#" class="text-sm text-blue-600 hover:text-blue-700 font-medium">
                                Quên mật khẩu?
                            </a>
                        </div>

                        <button type="submit" 
                                class="w-full bg-gradient-to-r from-blue-500 to-cyan-600 text-white py-3 rounded-lg font-semibold hover:from-blue-600 hover:to-cyan-700 transform transition-all duration-200 focus:outline-none focus:ring-4 focus:ring-blue-300 shadow-lg">
                            Đăng nhập
                        </button>

                        <p class="text-center text-gray-600 text-sm mt-6">
                            Không có tài khoản? 
                            <a href="<%= request.getContextPath()%>/register" class="text-blue-600 hover:text-blue-700 font-semibold">
                                Đăng kí
                            </a>
                        </p>
                        <p class="text-center text-gray-600 text-sm mt-6">
                            Hoặc
                            <a href="<%= request.getContextPath()%>/home" class="text-blue-600 hover:text-blue-700 font-semibold">
                                về trang chủ
                            </a>
                        </p>
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

                $('#loginForm').submit(function (e) {
                    const email = $('#email').val().trim();
                    const password = $('#password').val();

                    if (!email || !password) {
                        e.preventDefault();
                        alert('Please fill in all fields');
                        return false;
                    }

                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailRegex.test(email)) {
                        e.preventDefault();
                        alert('Please enter a valid email address');
                        return false;
                    }
                });
            });
        </script>

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />
    </body>
</html>