<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi Tiết Chứng Chỉ</title>
        <jsp:include page="/layout/import.jsp" />
        <style>
            .certificate-container {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: 8px solid #4a5568;
                box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            }
            .certificate-inner {
                background: white;
                border: 3px solid #2563eb;
            }
            .decorative-line {
                height: 2px;
                background: linear-gradient(to right, transparent, #2563eb, transparent);
            }
            @media print {
                .no-print { display: none; }
                body { background: white; }
                .certificate-container { box-shadow: none; }
            }
        </style>
    </head>
    <body class="bg-slate-100">
        <%@include file="/layout/header.jsp" %>
        
        <div class="max-w-5xl mx-auto px-6 py-12">
            <!-- Back Button -->
            <div class="mb-6 no-print">
                <a href="${pageContext.request.contextPath}/trainee/certificates" 
                   class="inline-flex items-center text-blue-600 hover:text-blue-700 font-medium">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                    </svg>
                    Quay lại danh sách
                </a>
            </div>

            <!-- Certificate -->
            <div class="certificate-container rounded-xl p-8 mb-6">
                <div class="certificate-inner rounded-lg p-12">
                    <!-- Header -->
                    <div class="text-center mb-8">
                        <h1 class="text-4xl font-bold text-slate-800 mb-2">
                            CHỨNG CHỈ HOÀN THÀNH
                        </h1>
                        <p class="text-xl text-slate-600 italic">
                            Certificate of Completion
                        </p>
                    </div>

                    <div class="decorative-line mb-8"></div>

                    <!-- Body -->
                    <div class="text-center mb-8">
                        <p class="text-lg text-slate-700 mb-6">
                            Chứng nhận rằng
                        </p>
                        <h2 class="text-3xl font-bold text-blue-600 mb-6">
                            ${sessionScope.user.first_name} ${sessionScope.user.last_name}
                        </h2>
                        <p class="text-lg text-slate-700 leading-relaxed max-w-2xl mx-auto">
                            Đã hoàn thành xuất sắc chương trình đào tạo và được cấp chứng chỉ này
                            để ghi nhận sự nỗ lực và thành tích xuất sắc.
                        </p>
                    </div>

                    <div class="decorative-line mb-8"></div>

                    <!-- Details -->
                    <div class="max-w-md mx-auto mb-8">
                        <div class="bg-slate-50 rounded-lg p-6 space-y-4">
                            <div class="flex justify-between items-center">
                                <span class="text-slate-600 font-medium">Mã chứng chỉ:</span>
                                <span class="text-slate-800 font-bold font-mono">
                                    ${certificate.certificateCode}
                                </span>
                            </div>
                            <div class="h-px bg-slate-200"></div>
                            <div class="flex justify-between items-center">
                                <span class="text-slate-600 font-medium">Ngày cấp:</span>
                                <span class="text-slate-800 font-semibold">
                                    <fmt:formatDate value="${certificate.issuedAt}" pattern="dd/MM/yyyy" />
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Signature -->
                    <div class="flex justify-end max-w-2xl mx-auto mt-12">
                        <div class="text-center">
                            <div class="mb-16"></div>
                            <div class="border-t-2 border-slate-300 pt-2 px-8">
                                <p class="font-semibold text-slate-700">Giám đốc</p>
                            </div>
                        </div>
                    </div>

                    <!-- Footer -->
                    <div class="text-center mt-8">
                        <p class="text-sm text-slate-500 italic">
                            Chứng chỉ này xác nhận sự hoàn thành xuất sắc chương trình đào tạo
                        </p>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex gap-4 justify-center no-print">
                <button onclick="window.print()" 
                        class="inline-flex items-center px-6 py-3 bg-slate-700 text-white font-semibold rounded-lg hover:bg-slate-800 transition">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"></path>
                    </svg>
                    In chứng chỉ
                </button>
                <a href="${pageContext.request.contextPath}/trainee/certificate/download?id=${certificate.id}"
                   class="inline-flex items-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path>
                    </svg>
                    Tải xuống PDF
                </a>
            </div>
        </div>
        
        <%@include file="/layout/footer.jsp" %>
    </body>
</html>