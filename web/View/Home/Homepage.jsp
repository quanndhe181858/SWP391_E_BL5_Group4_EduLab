<%-- 
    Document   : Homepage
    Created on : Dec 8, 2025, 2:46:44 AM
    Author     : hoanghao
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LabEdu - Học Mọi Lúc, Mọi Nơi</title>
        <jsp:include page="/layout/import.jsp" />
    </head>
    <body class="bg-gray-50">

        <jsp:include page="/layout/header.jsp" />

        <!-- Hero Section -->
        <section class="bg-gradient-to-br from-blue-500 via-blue-600 to-cyan-700 text-white py-20">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="grid md:grid-cols-2 gap-12 items-center">
                    <div class="space-y-6">
                        <h1 class="text-5xl font-bold leading-tight">
                            Học Không Giới Hạn
                        </h1>
                        <p class="text-xl text-blue-100">
                            Bắt đầu, chuyển đổi hoặc thăng tiến sự nghiệp với các khoá học ngay thôi.
                        </p>
                        <div class="flex space-x-4">
                            <c:if test="${empty sessionScope.user}">
                                <a href="${pageContext.request.contextPath}/register" class="px-8 py-4 bg-white text-blue-600 font-semibold rounded-lg hover:bg-gray-100 transform transition hover:scale-105 shadow-lg">
                                    Đăng Ký Miễn Phí
                                </a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/courses" class="px-8 py-4 bg-blue-700 text-white font-semibold rounded-lg hover:bg-blue-800 transform transition hover:scale-105">
                                Khám Phá Khóa Học
                            </a>
                        </div>
                        <!--                        <div class="flex items-center space-x-8 pt-4">
                                                    <div>
                                                        <p class="text-3xl font-bold">10.000+</p>
                                                        <p class="text-blue-100">Học Viên</p>
                                                    </div>
                                                    <div>
                                                        <p class="text-3xl font-bold">500+</p>
                                                        <p class="text-blue-100">Giảng Viên</p>
                                                    </div>
                                                    <div>
                                                        <p class="text-3xl font-bold">1.200+</p>
                                                        <p class="text-blue-100">Khóa Học</p>
                                                    </div>
                                                </div>-->
                    </div>
                    <div class="hidden md:block">
                        <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=600&h=400&fit=crop" alt="Học viên đang học" class="rounded-2xl shadow-2xl">
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="py-16 bg-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-12">
                    <h2 class="text-3xl font-bold text-gray-900 mb-4">Tại Sao Chọn LabEdu?</h2>
                    <p class="text-gray-600">Mọi thứ bạn cần để thăng tiến trong hành trình học tập</p>
                </div>
                <div class="grid md:grid-cols-4 gap-8">
                    <div class="text-center p-6 rounded-xl hover:shadow-lg transition-shadow">
                        <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold mb-2">Giảng Viên Chuyên Nghiệp</h3>
                        <p class="text-gray-600">Học từ các chuyên gia có kinh nghiệm thực tế trong ngành</p>
                    </div>
                    <div class="text-center p-6 rounded-xl hover:shadow-lg transition-shadow">
                        <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold mb-2">Học Theo Tốc Độ Riêng</h3>
                        <p class="text-gray-600">Truy cập khóa học mọi lúc, mọi nơi trên mọi thiết bị</p>
                    </div>
                    <div class="text-center p-6 rounded-xl hover:shadow-lg transition-shadow">
                        <div class="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <svg class="w-8 h-8 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"></path>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold mb-2">Nhận Chứng Chỉ</h3>
                        <p class="text-gray-600">Kiếm chứng chỉ để tăng cơ hội nghề nghiệp của bạn</p>
                    </div>
                    <div class="text-center p-6 rounded-xl hover:shadow-lg transition-shadow">
                        <div class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <svg class="w-8 h-8 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold mb-2">Tham Gia Cộng Đồng</h3>
                        <p class="text-gray-600">Kết nối với học viên toàn cầu và cùng phát triển</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Popular Categories -->
        <!--        <section class="py-16 bg-gray-50">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="text-center mb-12">
                            <h2 class="text-3xl font-bold text-gray-900 mb-4">Khám Phá Danh Mục Phổ Biến</h2>
                            <p class="text-gray-600">Tìm khóa học hoàn hảo để bắt đầu hành trình học tập của bạn</p>
                        </div>
                        <div class="grid md:grid-cols-3 lg:grid-cols-6 gap-6">
                            <a href="#" class="bg-white p-6 rounded-xl text-center hover:shadow-lg transition-all transform hover:-translate-y-1">
                                <div class="w-16 h-16 bg-blue-100 rounded-lg flex items-center justify-center mx-auto mb-3">
                                    <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"></path>
                                    </svg>
                                </div>
                                <h3 class="font-semibold text-gray-900">Lập Trình</h3>
                                <p class="text-sm text-gray-500 mt-1">325 khóa học</p>
                            </a>
                            <a href="#" class="bg-white p-6 rounded-xl text-center hover:shadow-lg transition-all transform hover:-translate-y-1">
                                <div class="w-16 h-16 bg-green-100 rounded-lg flex items-center justify-center mx-auto mb-3">
                                    <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                                    </svg>
                                </div>
                                <h3 class="font-semibold text-gray-900">Kinh Doanh</h3>
                                <p class="text-sm text-gray-500 mt-1">189 khóa học</p>
                            </a>
                            <a href="#" class="bg-white p-6 rounded-xl text-center hover:shadow-lg transition-all transform hover:-translate-y-1">
                                <div class="w-16 h-16 bg-purple-100 rounded-lg flex items-center justify-center mx-auto mb-3">
                                    <svg class="w-8 h-8 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01"></path>
                                    </svg>
                                </div>
                                <h3 class="font-semibold text-gray-900">Thiết Kế</h3>
                                <p class="text-sm text-gray-500 mt-1">267 khóa học</p>
                            </a>
                            <a href="#" class="bg-white p-6 rounded-xl text-center hover:shadow-lg transition-all transform hover:-translate-y-1">
                                <div class="w-16 h-16 bg-red-100 rounded-lg flex items-center justify-center mx-auto mb-3">
                                    <svg class="w-8 h-8 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 3.055A9.001 9.001 0 1020.945 13H11V3.055z"></path>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.488 9H15V3.512A9.025 9.025 0 0120.488 9z"></path>
                                    </svg>
                                </div>
                                <h3 class="font-semibold text-gray-900">Marketing</h3>
                                <p class="text-sm text-gray-500 mt-1">142 khóa học</p>
                            </a>
                            <a href="#" class="bg-white p-6 rounded-xl text-center hover:shadow-lg transition-all transform hover:-translate-y-1">
                                <div class="w-16 h-16 bg-yellow-100 rounded-lg flex items-center justify-center mx-auto mb-3">
                                    <svg class="w-8 h-8 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                                    </svg>
                                </div>
                                <h3 class="font-semibold text-gray-900">CNTT & Phần Mềm</h3>
                                <p class="text-sm text-gray-500 mt-1">298 khóa học</p>
                            </a>
                            <a href="#" class="bg-white p-6 rounded-xl text-center hover:shadow-lg transition-all transform hover:-translate-y-1">
                                <div class="w-16 h-16 bg-indigo-100 rounded-lg flex items-center justify-center mx-auto mb-3">
                                    <svg class="w-8 h-8 text-indigo-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"></path>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                    </svg>
                                </div>
                                <h3 class="font-semibold text-gray-900">Nhiếp Ảnh</h3>
                                <p class="text-sm text-gray-500 mt-1">156 khóa học</p>
                            </a>
                        </div>
                    </div>
                </section>-->

        <!-- Featured Courses -->
        <section class="py-16 bg-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center mb-12">
                    <div>
                        <h2 class="text-3xl font-bold text-gray-900 mb-2">Khóa Học Mới</h2>
                        <p class="text-gray-600">Bắt đầu học với các khóa học mới được phát triển</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/courses" class="text-blue-600 font-semibold hover:underline flex items-center">
                        Xem Tất Cả
                        <svg class="w-5 h-5 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                        </svg>
                    </a>
                </div>
                <div class="grid md:grid-cols-4 gap-8">
                    <!-- Course Card 1 -->
                    <c:forEach items="${cList}" var="c">
                        <div class="bg-white rounded-xl shadow-md overflow-hidden hover:shadow-xl transition-shadow">
                            <img src="${pageContext.request.contextPath}/${c.thumbnail}" alt="Khóa học" class="w-full h-48 object-cover">
                            <div class="p-6">
                                <div class="flex items-center justify-between mb-3">
                                    <span class="px-3 py-1 bg-blue-100 text-blue-600 text-xs font-semibold rounded-full">${c.category.name}</span>
                                </div>
                                <h3 class="text-xl font-semibold text-gray-900 mb-2">${c.title}</h3>
                                <p class="text-gray-600 text-sm mb-4">${c.description}</p>
                                <!--                                <div class="flex items-center text-sm text-gray-500 mb-4">
                                                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                                                    </svg>
                                                                    <span>52 giờ</span>
                                                                    <span class="mx-2">•</span>
                                                                    <span>156 bài học</span>
                                                                </div>-->
                                <div class="flex items-center justify-between">
                                    <a href="${pageContext.request.contextPath}/courses?id=${c.id}" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">Chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <c:if test="${empty sessionScope.user}">
            <section class="py-20 bg-gradient-to-r from-blue-600 to-cyan-600">
                <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <h2 class="text-4xl font-bold text-white mb-6">Sẵn Sàng Bắt Đầu Học?</h2>
                    <p class="text-xl text-blue-100 mb-8">Tham gia cùng hàng nghìn học viên đang học kỹ năng mới mỗi ngày</p>
                    <a href="${pageContext.request.contextPath}/register" class="inline-block px-8 py-4 bg-white text-blue-600 font-semibold rounded-lg hover:bg-gray-100 transform transition hover:scale-105 shadow-lg">
                        Bắt Đầu Ngay Hôm Nay
                    </a>
                </div>
            </section>
        </c:if>

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />
    </body>
</html>