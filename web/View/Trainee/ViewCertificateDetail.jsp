<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chứng Chỉ - ${certificate.courseTitle}</title>
        <jsp:include page="/layout/import.jsp" />
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;600;700&display=swap');

            body {
                font-family: 'Poppins', sans-serif;
            }

            .certificate-container {
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 50%, #7e22ce 100%);
                padding: 3rem;
                border-radius: 20px;
                box-shadow: 0 25px 80px rgba(0,0,0,0.4);
                position: relative;
            }

            .certificate-border {
                border: 12px solid;
                border-image: linear-gradient(45deg, #fbbf24, #f59e0b, #d97706) 1;
                background: white;
                border-radius: 12px;
                position: relative;
                overflow: hidden;
            }

            .certificate-inner {
                padding: 3rem;
                background:
                    linear-gradient(to right, rgba(251, 191, 36, 0.05) 1px, transparent 1px),
                    linear-gradient(to bottom, rgba(251, 191, 36, 0.05) 1px, transparent 1px);
                background-size: 50px 50px;
                position: relative;
            }

            .corner-decoration {
                position: absolute;
                width: 100px;
                height: 100px;
                opacity: 0.1;
            }

            .corner-decoration.top-left {
                top: 0;
                left: 0;
                border-top: 3px solid #fbbf24;
                border-left: 3px solid #fbbf24;
            }

            .corner-decoration.top-right {
                top: 0;
                right: 0;
                border-top: 3px solid #fbbf24;
                border-right: 3px solid #fbbf24;
            }

            .corner-decoration.bottom-left {
                bottom: 0;
                left: 0;
                border-bottom: 3px solid #fbbf24;
                border-left: 3px solid #fbbf24;
            }

            .corner-decoration.bottom-right {
                bottom: 0;
                right: 0;
                border-bottom: 3px solid #fbbf24;
                border-right: 3px solid #fbbf24;
            }

            .certificate-title {
                font-family: 'Playfair Display', serif;
                font-size: 3.5rem;
                font-weight: 700;
                background: linear-gradient(135deg, #1e3c72, #2a5298, #7e22ce);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                text-transform: uppercase;
                letter-spacing: 4px;
            }

            .recipient-name {
                font-family: 'Playfair Display', serif;
                font-size: 3rem;
                font-weight: 700;
                color: #1e40af;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            }

            .course-title {
                font-family: 'Playfair Display', serif;
                font-size: 2rem;
                font-weight: 600;
                color: #7e22ce;
                border-bottom: 3px solid #fbbf24;
                display: inline-block;
                padding-bottom: 0.5rem;
            }

            .decorative-line {
                height: 3px;
                background: linear-gradient(to right, transparent, #fbbf24, #f59e0b, #fbbf24, transparent);
                margin: 2rem 0;
            }

            .seal {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                background: linear-gradient(135deg, #fbbf24, #f59e0b);
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 0 8px 20px rgba(251, 191, 36, 0.4);
                position: relative;
            }

            .seal::before {
                content: '';
                position: absolute;
                width: 90%;
                height: 90%;
                border-radius: 50%;
                border: 2px dashed white;
            }

            .seal-text {
                font-size: 0.75rem;
                font-weight: 700;
                color: white;
                text-align: center;
                z-index: 1;
            }

            .grade-badge {
                background: linear-gradient(135deg, #10b981, #059669);
                color: white;
                padding: 1rem 2rem;
                border-radius: 50px;
                font-size: 1.5rem;
                font-weight: 700;
                display: inline-block;
                box-shadow: 0 8px 20px rgba(16, 185, 129, 0.3);
            }

            .info-card {
                background: linear-gradient(135deg, #f8fafc, #f1f5f9);
                border-left: 4px solid #fbbf24;
                padding: 1.5rem;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            }

            @media print {
                .no-print {
                    display: none;
                }
                body {
                    background: white;
                }
                .certificate-container {
                    box-shadow: none;
                    page-break-inside: avoid;
                }
            }

            @media (max-width: 768px) {
                .certificate-title {
                    font-size: 2rem;
                }
                .recipient-name {
                    font-size: 2rem;
                }
                .course-title {
                    font-size: 1.5rem;
                }
                .certificate-inner {
                    padding: 1.5rem;
                }
            }
        </style>
    </head>
    <body class="bg-gradient-to-br from-slate-100 to-slate-200">
        <%@include file="/layout/header.jsp" %>

        <div class="max-w-6xl mx-auto px-4 py-12">
            <!-- Back Button -->
            <div class="mb-8 no-print">
                <a href="${pageContext.request.contextPath}/trainee/certificates" 
                   class="inline-flex items-center px-6 py-3 bg-white text-slate-700 font-semibold rounded-lg hover:bg-slate-50 transition shadow-md">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                    </svg>
                    Quay lại danh sách
                </a>
            </div>

            <!-- Certificate -->
            <div class="certificate-container mb-8">
                <div class="certificate-border">
                    <div class="certificate-inner">
                        <!-- Corner Decorations -->
                        <div class="corner-decoration top-left"></div>
                        <div class="corner-decoration top-right"></div>
                        <div class="corner-decoration bottom-left"></div>
                        <div class="corner-decoration bottom-right"></div>

                        <!-- Header -->
                        <div class="text-center mb-8">
                            <div class="flex items-center justify-center gap-4 mb-6">
                                <svg class="w-16 h-16 text-amber-500" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                                </svg>
                                <h1 class="certificate-title">
                                    Chứng Chỉ
                                </h1>
                                <svg class="w-16 h-16 text-amber-500" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                                </svg>
                            </div>
                            <p class="text-2xl text-slate-600 italic font-light">
                                Certificate of Completion
                            </p>
                        </div>

                        <div class="decorative-line"></div>

                        <!-- Body -->
                        <div class="text-center mb-8">
                            <p class="text-xl text-slate-700 mb-6 font-light">
                                Chứng nhận rằng
                            </p>
                            <h2 class="recipient-name mb-8">
                                ${certificate.firstName} ${certificate.lastName}
                            </h2>
                            <p class="text-lg text-slate-700 mb-6 font-light">
                                Đã hoàn thành xuất sắc khóa học
                            </p>
                            <h3 class="course-title mb-8">
                                ${certificate.courseTitle}
                            </h3>
                        </div>

                        <!-- Course Description -->
                        <c:if test="${not empty certificate.courseDescription}">
                            <div class="max-w-3xl mx-auto mb-8">
                                <div class="info-card">
                                    <h4 class="text-lg font-semibold text-slate-800 mb-3 flex items-center">
                                        <svg class="w-5 h-5 mr-2 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                        </svg>
                                        Về khóa học
                                    </h4>
                                    <p class="text-slate-600 leading-relaxed">
                                        ${certificate.courseDescription}
                                    </p>
                                </div>
                            </div>
                        </c:if>

                        <div class="decorative-line"></div>

                        <!-- Certificate Details & Grade -->
                        <div class="max-w-4xl mx-auto mb-8">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <!-- Left: Certificate Info -->
                                <div class="info-card">
                                    <h4 class="text-sm font-semibold text-slate-500 uppercase tracking-wider mb-4">
                                        Thông tin chứng chỉ
                                    </h4>
                                    <div class="space-y-3">
                                        <div class="flex justify-between items-center pb-2 border-b border-slate-200">
                                            <span class="text-slate-600 font-medium">Mã chứng chỉ:</span>
                                            <span class="text-slate-800 font-bold font-mono text-lg">
                                                ${certificate.certificateCode}
                                            </span>
                                        </div>
                                        <div class="flex justify-between items-center pb-2 border-b border-slate-200">
                                            <span class="text-slate-600 font-medium">Ngày cấp:</span>
                                            <span class="text-slate-800 font-semibold">
                                                <fmt:formatDate value="${certificate.issuedAt}" pattern="dd/MM/yyyy" />
                                            </span>
                                        </div>
                                        <div class="flex justify-between items-center">
                                            <span class="text-slate-600 font-medium">Email:</span>
                                            <span class="text-slate-800 font-semibold">
                                                ${certificate.email}
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Right: Grade -->
                                <div class="info-card flex flex-col items-center justify-center">
                                    <h4 class="text-sm font-semibold text-slate-500 uppercase tracking-wider mb-4">
                                        Điểm đạt được
                                    </h4>
                                    <div class="grade-badge mb-3">
                                        <c:choose>
                                            <c:when test="${not empty certificate.passedGrade}">
                                                <fmt:formatNumber value="${certificate.passedGrade}" maxFractionDigits="1" minFractionDigits="0"/>
                                            </c:when>
                                            <c:otherwise>
                                                100
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="text-xl">/100</span>
                                    </div>
                                    <div class="flex items-center text-green-700">
                                        <svg class="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                                        </svg>
                                        <span class="font-semibold">Đạt yêu cầu</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Signature Section -->
                        <div class="flex justify-between items-end max-w-4xl mx-auto mt-12 pt-8">
                            <!-- Seal -->
                            <div class="flex flex-col items-center">
                                <div class="seal mb-3">
                                    <div class="seal-text">
                                        <div class="font-bold">VERIFIED</div>
                                        <div class="text-xs mt-1">
                                            <fmt:formatDate value="${certificate.issuedAt}" pattern="yyyy" />
                                        </div>
                                    </div>
                                </div>
                                <p class="text-sm text-slate-500 font-medium">Xác thực</p>
                            </div>

                            <!-- Signature -->
                            <div class="text-center">
                                <div class="mb-12 h-16"></div>
                                <div class="border-t-2 border-slate-800 pt-2 px-12">
                                    <p class="font-bold text-lg text-slate-800">Giám đốc điều hành</p>
                                    <p class="text-sm text-slate-600 mt-1">Learning Management System</p>
                                </div>
                            </div>
                        </div>

                        <!-- Footer -->
                        <div class="text-center mt-12 pt-8 border-t border-slate-200">
                            <p class="text-sm text-slate-500 italic">
                                Chứng chỉ này xác nhận người được cấp đã hoàn thành đầy đủ và xuất sắc chương trình đào tạo
                            </p>
                            <p class="text-xs text-slate-400 mt-2">
                                Xác thực chứng chỉ tại: ${pageContext.request.contextPath}/verify?code=${certificate.certificateCode}
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex flex-wrap gap-4 justify-center no-print">
                <a href="${pageContext.request.contextPath}/trainee/certificate/download?id=${certificate.id}"
                   class="inline-flex items-center px-8 py-4 bg-gradient-to-r from-blue-600 to-purple-600 text-white font-semibold rounded-lg hover:from-blue-700 hover:to-purple-700 transition shadow-lg hover:shadow-xl transform hover:-translate-y-1">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path>
                    </svg>
                    Tải xuống PDF
                </a>
                <a href="${pageContext.request.contextPath}/learn?courseId=${certificate.courseId}"
                   class="inline-flex items-center px-8 py-4 bg-gradient-to-r from-green-600 to-emerald-600 text-white font-semibold rounded-lg hover:from-green-700 hover:to-emerald-700 transition shadow-lg hover:shadow-xl transform hover:-translate-y-1">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                    </svg>
                    Xem lại khóa học
                </a>
            </div>
        </div>

        <%@include file="/layout/footer.jsp" %>
    </body>
</html>