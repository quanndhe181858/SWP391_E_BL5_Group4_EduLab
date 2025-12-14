<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - EduLab</title>
        <jsp:include page="/layout/import.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp"/>
        <jsp:include page="/layout/admin_sidebar.jsp"/>

        <main class="ml-64 pt-6 px-6 pb-8 min-h-screen">
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-gray-900">Dashboard Tổng Quan</h1>
                <p class="text-gray-600 mt-1">Theo dõi hoạt động hệ thống EduLab</p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6 mb-8">
                <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6 hover:shadow-md transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-blue-100 p-3 rounded-lg">
                            <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                            </svg>
                        </div>
                    </div>
                    <h3 class="text-gray-500 text-sm font-medium">Tổng Người Dùng</h3>
                    <p class="text-3xl font-bold text-gray-900 mt-2">${ds.totalUsers}</p>
                    <p class="text-xs text-gray-500 mt-2">
                        <span class="text-green-600 font-medium">+${ds.newUsersThisMonth}</span> trong tháng này
                    </p>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6 hover:shadow-md transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-green-100 p-3 rounded-lg">
                            <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                            </svg>
                        </div>
                    </div>
                    <h3 class="text-gray-500 text-sm font-medium">Tổng Khóa Học</h3>
                    <p class="text-3xl font-bold text-gray-900 mt-2">${ds.totalCourses}</p>
                    <p class="text-xs text-gray-500 mt-2">
                        <span class="text-blue-600 font-medium">${ds.activeCourses}</span> đang hoạt động
                    </p>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6 hover:shadow-md transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-purple-100 p-3 rounded-lg">
                            <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                    </div>
                    <h3 class="text-gray-500 text-sm font-medium">Lượt Đăng Ký</h3>
                    <p class="text-3xl font-bold text-gray-900 mt-2">${ds.totalEnrollments}</p>
                    <p class="text-xs text-gray-500 mt-2">
                        <span class="text-purple-600 font-medium">${ds.enrollmentsThisWeek}</span> trong tuần này
                    </p>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6 hover:shadow-md transition-shadow">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-orange-100 p-3 rounded-lg">
                            <svg class="w-6 h-6 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                            </svg>
                        </div>
                    </div>
                    <h3 class="text-gray-500 text-sm font-medium">Tỷ Lệ Hoàn Thành</h3>
                    <p class="text-3xl font-bold text-gray-900 mt-2">${ds.completionRate}%</p>
                    <p class="text-xs text-gray-500 mt-2">
                        <span class="text-orange-600 font-medium">${ds.completedCourse}</span> khóa hoàn thành
                    </p>
                </div>
            </div>

            <div class="grid grid-cols-1 xl:grid-cols-2 gap-6 mb-8">
                <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-lg font-semibold text-gray-900">Tăng Trưởng Người Dùng</h2>
                        <select id="userChartDayFilter" class="text-sm border-gray-300 rounded-lg focus:ring-blue-500 focus:border-blue-500">
                            <option value="7" ${currentFilter == 7 ? 'selected' : ''}>7 ngày qua</option>
                            <option value="30" ${currentFilter == 30 ? 'selected' : ''}>30 ngày qua</option>
                            <option value="90" ${currentFilter == 90 ? 'selected' : ''}>3 tháng qua</option>
                        </select>
                    </div>
                    <div style="height: 250px;">
                        <canvas id="userGrowthChart"></canvas>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-lg font-semibold text-gray-900">Phân Bố Danh Mục</h2>
                        <a href="${pageContext.request.contextPath}/manager_category?page=categories"><button class="text-sm text-blue-600 hover:text-blue-700 font-medium">Xem tất cả</button></a>
                    </div>
                    <div style="height: 250px;">
                        <canvas id="categoryChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 xl:grid-cols-2 gap-6 mb-8">
                <div class="bg-white rounded-xl shadow-sm border border-gray-100">
                    <div class="p-6 border-b border-gray-100">
                        <div class="flex items-center justify-between">
                            <h2 class="text-lg font-semibold text-gray-900">Người Dùng Mới</h2>
                            <a href="user-management.jsp" class="text-sm text-blue-600 hover:text-blue-700 font-medium">Xem tất cả →</a>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="space-y-4 max-h-[450px] overflow-auto">
                            <c:forEach items="${uList}" var="user">
                                <div class="flex items-center gap-4 p-3 hover:bg-gray-50 rounded-lg transition-colors">
                                    <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-600 rounded-full flex items-center justify-center text-white font-semibold">
                                        ${user.first_name.substring(0,1)}
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <p class="text-sm font-medium text-gray-900 truncate">${user.first_name} ${user.last_name}</p>
                                        <p class="text-xs text-gray-500 truncate">${user.email}</p>
                                    </div>
                                    <div class="text-right">
                                        <span class="text-xs px-2 py-1 rounded-full ${user.status == 'Active' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}">
                                            ${user.status}
                                        </span>
                                        <p class="text-xs text-gray-400 mt-1">
                                            <fmt:formatDate value="${user.created_at}" pattern="dd/MM/yyyy"/>
                                        </p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-100">
                    <div class="p-6 border-b border-gray-100">
                        <div class="flex items-center justify-between">
                            <h2 class="text-lg font-semibold text-gray-900">Khóa Học Phổ Biến</h2>
                            <a href="course-management.jsp" class="text-sm text-blue-600 hover:text-blue-700 font-medium">Xem tất cả →</a>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="space-y-4 max-h-[450px] overflow-auto">
                            <c:forEach items="${cList}" var="course">
                                <div class="flex items-center gap-4 p-3 hover:bg-gray-50 rounded-lg transition-colors">
                                    <img src="${course.thumbnail}" alt="${course.title}" class="w-16 h-16 object-cover rounded-lg">
                                    <div class="flex-1 min-w-0">
                                        <p class="text-sm font-medium text-gray-900 truncate">${course.title}</p>
                                        <p class="text-xs text-gray-500 mt-1">${course.categoryName}</p>
                                    </div>
                                    <div class="text-right">
                                        <p class="text-sm font-semibold text-blue-600">${course.enrollmentCount}</p>
                                        <p class="text-xs text-gray-500">học viên</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 xl:grid-cols-3 gap-6">
                <div class="xl:col-span-2 bg-white rounded-xl shadow-sm border border-gray-100">
                    <div class="p-6 border-b border-gray-100">
                        <h2 class="text-lg font-semibold text-gray-900">Hoạt Động Gần Đây</h2>
                    </div>
                    <div class="p-6 max-h-[250px] overflow-auto">
                        <div class="space-y-4">
                            <c:forEach items="${raList}" var="activity">
                                <div class="flex gap-4">
                                    <div class="w-8 h-8 rounded-full ${activity.type == 'enrollment' ? 'bg-blue-100' : activity.type == 'completion' ? 'bg-green-100' : 'bg-purple-100'} flex items-center justify-center flex-shrink-0">
                                        <svg class="w-4 h-4 ${activity.type == 'enrollment' ? 'text-blue-600' : activity.type == 'completion' ? 'text-green-600' : 'text-purple-600'}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                        </svg>
                                    </div>
                                    <div class="flex-1">
                                        <p class="text-sm text-gray-900">${activity.description}</p>
                                        <p class="text-xs text-gray-500 mt-1">${activity.timeAgo}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-100">
                    <div class="p-6 border-b border-gray-100">
                        <h2 class="text-lg font-semibold text-gray-900">Thống Kê Hệ Thống</h2>
                    </div>
                    <div class="p-6 space-y-4">
                        <div class="flex items-center justify-between">
                            <div class="flex items-center gap-3">
                                <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                                    <svg class="w-4 h-4 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"/>
                                    </svg>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-600">Danh mục</p>
                                    <p class="text-lg font-semibold text-gray-900">${ds.totalCategories}</p>
                                </div>
                            </div>
                        </div>

                        <div class="flex items-center justify-between">
                            <div class="flex items-center gap-3">
                                <div class="w-8 h-8 bg-purple-100 rounded-lg flex items-center justify-center">
                                    <svg class="w-4 h-4 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                                    </svg>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-600">Bài kiểm tra</p>
                                    <p class="text-lg font-semibold text-gray-900">${ds.totalTests}</p>
                                </div>
                            </div>
                        </div>

                        <div class="flex items-center justify-between">
                            <div class="flex items-center gap-3">
                                <div class="w-8 h-8 bg-green-100 rounded-lg flex items-center justify-center">
                                    <svg class="w-4 h-4 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                    </svg>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-600">Câu hỏi</p>
                                    <p class="text-lg font-semibold text-gray-900">${ds.totalQuizzes}</p>
                                </div>
                            </div>
                        </div>

                        <div class="flex items-center justify-between">
                            <div class="flex items-center gap-3">
                                <div class="w-8 h-8 bg-orange-100 rounded-lg flex items-center justify-center">
                                    <svg class="w-4 h-4 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                    </svg>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-600">Media files</p>
                                    <p class="text-lg font-semibold text-gray-900">${ds.totalMedia}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script>
            const usersStatisticData = [
            <c:forEach items="${usList}" var="stat" varStatus="status">
            {
            dayName: '${stat.dayName}',
                    userCount: ${stat.userCount}
            }${!status.last ? ',' : ''}
            </c:forEach>
            ];
            const categoriesStatisticData = [
            <c:forEach items="${csList}" var="cateStat" varStatus="cateStatus">
            {
            categoryName: '${cateStat.categoryName}',
                    percentage: '${cateStat.percentage}',
                    courseCount: ${cateStat.courseCount}
            }${!cateStatus.last ? ',' : ''}
            </c:forEach>
            ];
            const userCtx = document.getElementById('userGrowthChart').getContext('2d');
            // Tách labels và data từ usersStatisticData
            const userLabels = usersStatisticData.map(item => item.dayName);
            const userData = usersStatisticData.map(item => item.userCount);
            new Chart(userCtx, {
            type: 'line',
                    data: {
                    labels: userLabels,
                            datasets: [{
                            label: 'Người dùng mới',
                                    data: userData,
                                    borderColor: 'rgb(59, 130, 246)',
                                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                                    tension: 0.4,
                                    fill: true
                            }]
                    },
                    options: {
                    responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                            legend: {
                            display: false
                            }
                            },
                            scales: {
                            y: {
                            beginAtZero: true,
                                    grid: {
                                    display: true,
                                            drawBorder: false
                                    }
                            },
                                    x: {
                                    grid: {
                                    display: false
                                    }
                                    }
                            }
                    }
            });
            const cateLabels = categoriesStatisticData.map(item => item.categoryName);
            const cateData = categoriesStatisticData.map(item => item.courseCount);
            const catCtx = document.getElementById('categoryChart').getContext('2d');
            new Chart(catCtx, {
            type: 'doughnut',
                    data: {
                    labels: cateLabels,
                            datasets: [{
                            data: cateData,
                                    backgroundColor: [
                                            'rgb(59, 130, 246)',
                                            'rgb(34, 197, 94)',
                                            'rgb(168, 85, 247)',
                                            'rgb(249, 115, 22)'
                                    ]
                            }]
                    },
                    options: {
                    responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                            legend: {
                            position: 'bottom'
                            }
                            }
                    }
            });
            $('#userChartDayFilter').on('change', () => {
            const selectedBox = $('#userChartDayFilter').val();
            window.location.href = "${pageContext.request.contextPath}/admin_dashboard?chartDayFilter=" + selectedBox;
            });
        </script>
    </body>
</html>