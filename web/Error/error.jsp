<%-- 
    Document   : error
    Created on : Dec 5, 2025, 2:05:39 AM
    Author     : quan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Error Pages</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }

            .container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                padding: 60px 40px;
                text-align: center;
                max-width: 600px;
                width: 100%;
                animation: fadeIn 0.5s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .error-code {
                font-size: 120px;
                font-weight: 700;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 20px;
                line-height: 1;
            }

            .error-title {
                font-size: 28px;
                color: #333;
                margin-bottom: 15px;
                font-weight: 600;
            }

            .error-message {
                font-size: 16px;
                color: #666;
                margin-bottom: 40px;
                line-height: 1.6;
            }

            .button-group {
                display: flex;
                gap: 15px;
                justify-content: center;
                flex-wrap: wrap;
                margin-bottom: 30px;
            }

            .btn {
                padding: 12px 30px;
                border: none;
                border-radius: 25px;
                font-size: 16px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 600;
                text-decoration: none;
                display: inline-block;
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
            }

            .btn-secondary {
                background: transparent;
                color: #667eea;
                border: 2px solid #667eea;
            }

            .btn-secondary:hover {
                background: #667eea;
                color: white;
            }

            .error-selector {
                display: flex;
                gap: 10px;
                justify-content: center;
                flex-wrap: wrap;
            }

            .error-btn {
                padding: 8px 20px;
                background: #f0f0f0;
                border: none;
                border-radius: 20px;
                cursor: pointer;
                font-size: 14px;
                font-weight: 600;
                color: #666;
                transition: all 0.3s ease;
            }

            .error-btn:hover {
                background: #e0e0e0;
            }

            .error-btn.active {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .icon {
                font-size: 80px;
                margin-bottom: 20px;
            }

            @media (max-width: 600px) {
                .error-code {
                    font-size: 80px;
                }

                .error-title {
                    font-size: 22px;
                }

                .container {
                    padding: 40px 25px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div id="errorContent"></div>

            <div class="button-group">
                <a href="/" class="btn btn-primary">Về Trang Chủ</a>
                <button onclick="history.back()" class="btn btn-secondary">Quay Lại</button>
            </div>

            <div class="error-selector">
                <button class="error-btn active" onclick="showError(400)">400</button>
                <button class="error-btn" onclick="showError(401)">401</button>
                <button class="error-btn" onclick="showError(403)">403</button>
                <button class="error-btn" onclick="showError(500)">500</button>
            </div>
        </div>

        <script>
            const errorData = {
                400: {
                    icon: '⚠️',
                    title: 'Yêu Cầu Không Hợp Lệ',
                    message: 'Yêu cầu của bạn không thể được xử lý. Vui lòng kiểm tra lại thông tin và thử lại.'
                },
                401: {
                    icon: '🔒',
                    title: 'Chưa Xác Thực',
                    message: 'Bạn cần đăng nhập để truy cập trang này. Vui lòng đăng nhập và thử lại.'
                },
                403: {
                    icon: '🚫',
                    title: 'Truy Cập Bị Từ Chối',
                    message: 'Bạn không có quyền truy cập vào trang này. Vui lòng liên hệ quản trị viên nếu bạn cho rằng đây là lỗi.'
                },
                500: {
                    icon: '💥',
                    title: 'Lỗi Máy Chủ',
                    message: 'Đã xảy ra lỗi không mong muốn trên máy chủ. Chúng tôi đang khắc phục sự cố. Vui lòng thử lại sau.'
                }
            };

            function showError(code) {
                const error = errorData[code];
                const content = `
                    <div class="icon">` + error.icon + `</div>
                    <div class="error-code">` + code + `</div>
                    <h1 class="error-title">` + error.title + `</h1>
                    <p class="error-message">` + error.message + `</p>
                `;

                document.getElementById('errorContent').innerHTML = content;

                // Update active button
                document.querySelectorAll('.error-btn').forEach(btn => {
                    btn.classList.remove('active');
                });
                event.target.classList.add('active');
            }

            showError(400);
        </script>
    </body>
</html>