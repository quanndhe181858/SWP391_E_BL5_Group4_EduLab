<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quên mật khẩu - EduLAB</title>
        <jsp:include page="/layout/import.jsp" />
    </head>
    <body class="bg-gradient-to-br from-red-500 via-blue-600 to-cyan-700 min-h-screen flex items-center justify-center p-4">

        <div class="w-full max-w-md">
            <div class="bg-white rounded-2xl shadow-2xl overflow-hidden transform transition-all duration-300">

                <!-- Header -->
                <div class="bg-gradient-to-r from-blue-500 to-cyan-600 p-8 text-center">
                    <div class="w-20 h-20 bg-white rounded-full mx-auto mb-4 flex items-center justify-center">
                        <svg class="w-10 h-10 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 7a2 2 0 012 2m4 0a6 6 0 01-7.743 5.743L11 17H9v2H7v2H4a1 1 0 01-1-1v-2.586a1 1 0 01.293-.707l5.964-5.964A6 6 0 1121 9z" />
                        </svg>
                    </div>
                    <h1 class="text-3xl font-bold text-white mb-2">Quên mật khẩu</h1>
                    <p class="text-blue-100" id="headerText">Nhập email để nhận mã OTP</p>
                </div>

                <div class="p-8">

                    <!-- Thông báo -->
                    <div id="messageBox" class="mb-6 hidden"></div>

                    <!-- Form nhập email -->
                    <div id="emailForm">
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
                                       class="w-full pl-10 pr-4 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200"
                                       placeholder="you@example.com"
                                       required>
                            </div>
                        </div>

                        <button type="button" 
                                id="sendOTPBtn"
                                class="w-full bg-gradient-to-r from-blue-500 to-cyan-600 text-white py-3 rounded-lg font-semibold hover:from-blue-600 hover:to-cyan-700 transform transition-all duration-200 focus:outline-none focus:ring-4 focus:ring-blue-300 shadow-lg">
                            Gửi mã OTP
                        </button>
                    </div>

                    <!-- Form nhập OTP -->
                    <div id="otpForm" class="hidden">
                        <div class="mb-6">
                            <label class="block text-gray-700 text-sm font-semibold mb-4 text-center">
                                Nhập mã OTP (6 chữ số)
                            </label>

                            <!-- OTP Input boxes -->
                            <div class="flex justify-center gap-2 mb-4">
                                <input type="text" maxlength="1" class="otp-input w-12 h-14 text-center text-2xl font-bold border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200" data-index="0">
                                <input type="text" maxlength="1" class="otp-input w-12 h-14 text-center text-2xl font-bold border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200" data-index="1">
                                <input type="text" maxlength="1" class="otp-input w-12 h-14 text-center text-2xl font-bold border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200" data-index="2">
                                <input type="text" maxlength="1" class="otp-input w-12 h-14 text-center text-2xl font-bold border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200" data-index="3">
                                <input type="text" maxlength="1" class="otp-input w-12 h-14 text-center text-2xl font-bold border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200" data-index="4">
                                <input type="text" maxlength="1" class="otp-input w-12 h-14 text-center text-2xl font-bold border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200" data-index="5">
                            </div>

                            <!-- Timer -->
                            <div class="text-center mb-4">
                                <span class="text-sm text-gray-600">
                                    Mã OTP có hiệu lực trong: <span id="timer" class="font-bold text-blue-600">05:00</span>
                                </span>
                            </div>

                            <!-- Resend OTP -->
                            <div class="text-center">
                                <button type="button" 
                                        id="resendOTPBtn"
                                        class="text-sm text-blue-600 hover:text-blue-700 font-medium disabled:text-gray-400 disabled:cursor-not-allowed"
                                        disabled>
                                    Gửi lại mã OTP
                                </button>
                            </div>
                        </div>

                        <button type="button" 
                                id="verifyOTPBtn"
                                class="w-full bg-gradient-to-r from-blue-500 to-cyan-600 text-white py-3 rounded-lg font-semibold hover:from-blue-600 hover:to-cyan-700 transform transition-all duration-200 focus:outline-none focus:ring-4 focus:ring-blue-300 shadow-lg disabled:opacity-50 disabled:cursor-not-allowed"
                                disabled>
                            Xác nhận OTP
                        </button>

                        <button type="button" 
                                id="backBtn"
                                class="w-full mt-3 bg-gray-200 text-gray-700 py-3 rounded-lg font-semibold hover:bg-gray-300 transition-all duration-200">
                            Quay lại
                        </button>
                    </div>

                    <!-- Links -->
                    <div class="text-center mt-6">
                        <p class="text-gray-600 text-sm">
                            Nhớ mật khẩu? 
                            <a href="<%= request.getContextPath()%>/login" class="text-blue-600 hover:text-blue-700 font-semibold">
                                Đăng nhập
                            </a>
                        </p>
                        <p class="text-center text-gray-600 text-sm mt-3">
                            Hoặc
                            <a href="<%= request.getContextPath()%>/home" class="text-blue-600 hover:text-blue-700 font-semibold">
                                về trang chủ
                            </a>
                        </p>
                    </div>

                </div>
            </div>
        </div>

        <script>
            $(document).ready(function () {
                let timerInterval;
                let remainingTime = 300;
                let isTimerRunning = false;

                function resetTimer() {
                    if (timerInterval) {
                        clearInterval(timerInterval);
                        timerInterval = null;
                    }
                    remainingTime = 300;
                    $('#timer').text('05:00');
                }


                // Hàm hiển thị thông báo
                function showMessage(message, type) {
                    const box = $('#messageBox');

                    box.removeClass('hidden')
                            .removeClass('bg-red-50 bg-green-50 bg-blue-50 border-red-500 border-green-500 border-blue-500 text-red-700 text-green-700 text-blue-700')
                            .addClass('p-4 rounded-lg border-l-4 text-sm font-medium');

                    if (type === 'error') {
                        box.addClass('bg-red-50 border-red-500 text-red-700');
                    } else if (type === 'success') {
                        box.addClass('bg-green-50 border-green-500 text-green-700');
                    } else {
                        box.addClass('bg-blue-50 border-blue-500 text-blue-700');
                    }

                    box.text(message);
                }

                // Hàm bắt đầu đếm ngược
                function startTimer() {
                    resetTimer();

                    timerInterval = setInterval(function () {
                        remainingTime--;

                        const minutes = Math.floor(remainingTime / 60);
                        const seconds = remainingTime % 60;

                        $('#timer').text(
                                minutes.toString().padStart(2, '0') + ':' +
                                seconds.toString().padStart(2, '0')
                                );

                        if (remainingTime <= 0) {
                            clearInterval(timerInterval);
                            timerInterval = null;
                            $('#resendOTPBtn').prop('disabled', false);
                            showMessage('Mã OTP đã hết hạn', 'error');
                        }
                    }, 1000);
                }

                // Xử lý gửi OTP
                $('#sendOTPBtn').click(function () {
                    const email = $('#email').val().trim();

                    if (!email) {
                        showMessage('Vui lòng nhập email', 'error');
                        return;
                    }

                    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                    if (!emailRegex.test(email)) {
                        showMessage('Email không đúng định dạng', 'error');
                        return;
                    }

                    const btn = $(this);
                    btn.prop('disabled', true);
                    btn.html('<svg class="animate-spin h-5 w-5 mx-auto" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" fill="none"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>');

                    $.ajax({
                        url: '<%= request.getContextPath()%>/forgot-password',
                        type: 'POST',
                        dataType: 'json',
                        data: {
                            action: 'sendOTP',
                            email: email
                        },
                        success: function (response) {
                            if (response.success) {
                                showMessage(response.message, 'success');
                                $('#emailForm').addClass('hidden');
                                $('#otpForm').removeClass('hidden');
                                $('#headerText').text('Nhập mã OTP từ email');
                                $('.otp-input').first().focus();
                                startTimer();
                            } else {
                                showMessage(response.message, 'error');
                            }
                        },
                        error: function () {
                            showMessage('Có lỗi xảy ra. Vui lòng thử lại', 'error');
                        },
                        complete: function () {
                            btn.prop('disabled', false);
                            btn.html('Gửi mã OTP');
                        }
                    });
                });

                // Xử lý input OTP với khả năng tương thích bàn phím Việt
                $('.otp-input').on('input', function (e) {
                    const input = $(this);
                    let value = input.val();

                    // Chỉ cho phép số và loại bỏ tất cả ký tự khác
                    value = value.replace(/[^0-9]/g, '');

                    // Nếu có nhiều hơn 1 ký tự (do bàn phím Việt), chỉ lấy ký tự đầu
                    if (value.length > 1) {
                        value = value.charAt(0);
                    }

                    input.val(value);

                    // Tự động chuyển sang ô tiếp theo khi nhập số
                    if (value.length === 1) {
                        const nextInput = $('.otp-input[data-index="' + (parseInt(input.data('index')) + 1) + '"]');
                        if (nextInput.length) {
                            nextInput.focus();
                        }
                    }

                    // Kiểm tra nếu đã nhập đủ 6 số
                    checkOTPComplete();
                });

                // Xử lý keydown để xóa và di chuyển
                $('.otp-input').on('keydown', function (e) {
                    const input = $(this);
                    const index = parseInt(input.data('index'));

                    // Backspace
                    if (e.keyCode === 8) {
                        if (input.val() === '') {
                            const prevInput = $('.otp-input[data-index="' + (index - 1) + '"]');
                            if (prevInput.length) {
                                prevInput.focus();
                            }
                        } else {
                            input.val('');
                        }
                        e.preventDefault();
                        checkOTPComplete();
                    }

                    // Arrow left
                    if (e.keyCode === 37) {
                        const prevInput = $('.otp-input[data-index="' + (index - 1) + '"]');
                        if (prevInput.length) {
                            prevInput.focus();
                        }
                    }

                    // Arrow right
                    if (e.keyCode === 39) {
                        const nextInput = $('.otp-input[data-index="' + (index + 1) + '"]');
                        if (nextInput.length) {
                            nextInput.focus();
                        }
                    }
                });

                // Xử lý paste
                $('.otp-input').on('paste', function (e) {
                    e.preventDefault();
                    const pastedData = e.originalEvent.clipboardData.getData('text');
                    const digits = pastedData.replace(/[^0-9]/g, '').split('');

                    $('.otp-input').each(function (index) {
                        if (digits[index]) {
                            $(this).val(digits[index]);
                        }
                    });

                    checkOTPComplete();
                });

                // Kiểm tra OTP đã nhập đủ chưa
                function checkOTPComplete() {
                    let otp = '';
                    $('.otp-input').each(function () {
                        otp += $(this).val();
                    });

                    if (otp.length === 6) {
                        $('#verifyOTPBtn').prop('disabled', false);
                    } else {
                        $('#verifyOTPBtn').prop('disabled', true);
                    }
                }

                // Xử lý xác nhận OTP
                $('#verifyOTPBtn').click(function () {
                    let otp = '';
                    $('.otp-input').each(function () {
                        otp += $(this).val();
                    });

                    if (otp.length !== 6) {
                        showMessage('Vui lòng nhập đủ 6 chữ số', 'error');
                        return;
                    }

                    const btn = $(this);
                    btn.prop('disabled', true);
                    btn.html('<svg class="animate-spin h-5 w-5 mx-auto" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" fill="none"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>');

                    $.ajax({
                        url: '<%= request.getContextPath()%>/forgot-password',
                        type: 'POST',
                        data: {
                            action: 'verifyOTP',
                            otp: otp
                        },
                        success: function (response) {
                            if (response.success) {
                                clearInterval(timerInterval);
                                showMessage(response.message, 'success');

                                setTimeout(function () {
                                    window.location.href = '<%= request.getContextPath()%>/login';
                                }, 2000);
                            } else {
                                showMessage(response.message, 'error');
                                btn.prop('disabled', false);
                                btn.html('Xác nhận OTP');
                            }
                        },
                        error: function () {
                            showMessage('Có lỗi xảy ra. Vui lòng thử lại', 'error');
                            btn.prop('disabled', false);
                            btn.html('Xác nhận OTP');
                        }
                    });
                });

                // Xử lý gửi lại OTP
                $('#resendOTPBtn').click(function () {
                    $('#sendOTPBtn').click();
                });

                // Xử lý quay lại
                $('#backBtn').click(function () {
                    clearInterval(timerInterval);
                    isTimerRunning = false;
                    $('#otpForm').addClass('hidden');
                    $('#emailForm').removeClass('hidden');
                    $('#headerText').text('Nhập email để nhận mã OTP');
                    $('.otp-input').val('');
                    $('#messageBox').addClass('hidden');
                });
            });
        </script>
    </body>
</html>