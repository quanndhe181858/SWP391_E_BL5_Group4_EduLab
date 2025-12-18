<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instructor Dashboard - EduLab</title>
        <jsp:include page="/layout/import.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            .course-card {
                transition: all 0.3s ease;
            }
            .course-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 12px 24px -10px rgba(0, 0, 0, 0.15);
            }
            .stat-card {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }
            .stat-card-green {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            }
            .stat-card-blue {
                background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            }
            .stat-card-orange {
                background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            }
        </style>
    </head>
    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp"/>

        <main class="container mx-auto pt-6 px-6 pb-8 min-h-screen">
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-gray-900">Chào mừng trở lại, ${sessionScope.user.first_name}! 👋</h1>
                <p class="text-gray-600 mt-1">Đây là tổng quan về các khóa học và hoạt động giảng dạy của bạn</p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6 mb-8">
                <div class="stat-card rounded-xl shadow-lg p-6 text-white">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-white/80 text-sm font-medium mb-1">Khóa học của tôi</p>
                            <h3 class="text-4xl font-bold">${ds.myCourses}</h3>
                            <p class="text-white/90 text-xs mt-2">
                                <span class="font-semibold">${ds.activeCourses}</span> đang hoạt động
                            </p>
                        </div>
                        <div class="bg-white/20 rounded-full p-4">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="stat-card-green rounded-xl shadow-lg p-6 text-white">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-white/80 text-sm font-medium mb-1">Học viên của tôi</p>
                            <h3 class="text-4xl font-bold">${ds.totalStudents}</h3>
                            <p class="text-white/90 text-xs mt-2">
                                <span class="font-semibold">+${ds.newStudentsThisWeek}</span> tuần này
                            </p>
                        </div>
                        <div class="bg-white/20 rounded-full p-4">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="stat-card-blue rounded-xl shadow-lg p-6 text-white">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-white/80 text-sm font-medium mb-1">Tỷ lệ hoàn thành</p>
                            <h3 class="text-4xl font-bold">${ds.avgCompletionRate}%</h3>
                            <p class="text-white/90 text-xs mt-2">
                                <span class="font-semibold">${ds.completedEnrollments}</span> hoàn thành
                            </p>
                        </div>
                        <div class="bg-white/20 rounded-full p-4">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="stat-card-orange rounded-xl shadow-lg p-6 text-white">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-white/80 text-sm font-medium mb-1">Bài kiểm tra chờ</p>
                            <h3 class="text-4xl font-bold">${ds.pendingTests}</h3>
                        </div>
                        <div class="bg-white/20 rounded-full p-4">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"/>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 xl:grid-cols-2 gap-6 mb-8">
                <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-lg font-semibold text-gray-900">Hoạt động học viên</h2>
                        <select id="engagementFilter" class="text-sm border-gray-300 rounded-lg focus:ring-purple-500 focus:border-purple-500">
                            <option value="7" ${currentFilter == 7 ? 'selected' : ''}>7 ngày qua</option>
                            <option value="30" ${currentFilter == 30 ? 'selected' : ''}>30 ngày qua</option>
                            <option value="90" ${currentFilter == 90 ? 'selected' : ''}>3 tháng qua</option>
                        </select>
                    </div>
                    <div style="height: 280px;">
                        <canvas id="engagementChart"></canvas>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-lg font-semibold text-gray-900">Tỉ lệ hoàn thành</h2>
                        <span class="text-sm text-gray-500">${ds.myCourses} khóa học</span>
                    </div>
                    <div style="height: 280px;">
                        <canvas id="performanceChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 xl:grid-cols-2 gap-6 mb-8">
                <div class="bg-white rounded-xl shadow-sm border border-gray-100">
                    <div class="p-6 border-b border-gray-100">
                        <div class="flex items-center justify-between">
                            <h2 class="text-lg font-semibold text-gray-900">Khóa học của tôi</h2>
                            <a href="${pageContext.request.contextPath}/instructor/courses" class="text-sm text-purple-600 hover:text-purple-700 font-medium">Quản lý khóa học →</a>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="space-y-4 space-x-1 max-h-[400px] overflow-auto">
                            <c:forEach items="${myCourses}" var="course">
                                <a href="${pageContext.request.contextPath}/instructor/courses?cid=${course.id}&type=edit">
                                    <div class="course-card border border-gray-200 rounded-lg p-4 hover:border-purple-300 cursor-pointer">
                                        <div class="flex items-start gap-4">
                                            <img src="${pageContext.request.contextPath}/${course.thumbnail}" alt="${course.title}" class="w-20 h-20 object-cover rounded-lg flex-shrink-0">
                                            <div class="flex-1 min-w-0">
                                                <h3 class="font-semibold text-gray-900 mb-1 truncate">${course.title}</h3>
                                                <p class="text-xs text-gray-500 mb-2">${course.categoryName}</p>
                                                <div class="flex items-center gap-4 text-xs">
                                                    <span class="flex items-center gap-1 text-gray-600">
                                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                                                        </svg>
                                                        ${course.studentCount} học viên
                                                    </span>
                                                    <span class="flex items-center gap-1 text-gray-600">
                                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                        </svg>
                                                        ${course.completionRate}% hoàn thành
                                                    </span>
                                                </div>
                                            </div>
                                            <span class="px-3 py-1 rounded-full text-xs font-medium ${course.status == 'Active' ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-700'}">
                                                ${course.status == 'Active' ? 'Hoạt động' : 'Không hoạt động'}
                                            </span>
                                            <c:if test="${course.hide_by_admin}">
                                                <span class="px-3 py-1 rounded-full text-xs font-medium bg-red-100 text-red-700">
                                                    Bị khoá bởi quản trị viên
                                                </span>
                                            </c:if>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-100">
                    <div class="p-6 border-b border-gray-100">
                        <div class="flex items-center justify-between">
                            <h2 class="text-lg font-semibold text-gray-900">Học viên xuất sắc</h2>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="space-y-4 max-h-[400px] overflow-auto">
                            <c:forEach items="${topStudents}" var="student" varStatus="status">
                                <div class="flex items-center gap-4 p-3 hover:bg-gray-50 rounded-lg transition-colors">
                                    <div class="flex items-center justify-center w-8 h-8 rounded-full font-bold text-sm ${status.index == 0 ? 'bg-yellow-100 text-yellow-700' : status.index == 1 ? 'bg-gray-100 text-gray-700' : status.index == 2 ? 'bg-orange-100 text-orange-700' : 'bg-blue-100 text-blue-700'}">
                                        ${status.index + 1}
                                    </div>
                                    <div class="w-10 h-10 bg-gradient-to-br from-purple-500 to-blue-600 rounded-full flex items-center justify-center text-white font-semibold">
                                        ${student.firstName.substring(0,1)}${student.lastName.substring(0,1)}
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <p class="text-sm font-medium text-gray-900 truncate">${student.firstName} ${student.lastName}</p>
                                        <p class="text-xs text-gray-500">${student.coursesCompleted} khóa hoàn thành</p>
                                    </div>
                                    <div class="text-right">
                                        <div class="flex items-center gap-1">
                                            <svg class="w-4 h-4 text-yellow-500" fill="currentColor" viewBox="0 0 20 20">
                                            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                                            </svg>
                                            <span class="text-sm font-semibold text-gray-900">${student.avgScore}</span>
                                        </div>
                                        <p class="text-xs text-gray-500">điểm TB</p>
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
                        <h2 class="text-lg font-semibold text-gray-900">Hoạt động học viên gần đây</h2>
                    </div>
                    <div class="p-6 max-h-[350px] overflow-auto">
                        <div class="space-y-4">
                            <c:forEach items="${recentActivities}" var="activity">
                                <div class="flex gap-4 items-start">
                                    <div class="w-10 h-10 rounded-full ${activity.type == 'completed_section' ? 'bg-green-100' : activity.type == 'completion' ? 'bg-green-100' : activity.type == 'started_course' ? 'bg-blue-100' : activity.type == 'passed_test' ? 'bg-purple-100' : 'bg-orange-100'} flex items-center justify-center flex-shrink-0">
                                        <c:choose>
                                            <c:when test="${activity.type == 'completed_section'}">
                                                <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                </svg>
                                            </c:when>
                                            <c:when test="${activity.type == 'started_course'}">
                                                <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                                                </svg>
                                            </c:when>
                                            <c:when test="${activity.type == 'completion'}">
                                                <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                </svg>
                                            </c:when>
                                            <c:otherwise>
                                                <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                                                </svg>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="flex-1">
                                        <p class="text-sm text-gray-900">${activity.description}</p>
                                        <div class="flex items-center gap-2 mt-1">
                                            <p class="text-xs text-gray-500">${activity.timeAgo}</p>
                                            <span class="text-gray-300">•</span>
                                            <p class="text-xs text-gray-600 font-medium">${activity.courseName}</p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-100">
                    <div class="p-6 border-b border-gray-100">
                        <h2 class="text-lg font-semibold text-gray-900">Thao tác nhanh</h2>
                    </div>
                    <div class="p-6 space-y-3">
                        <a href="${pageContext.request.contextPath}/instructor/courses?type=create" class="flex items-center gap-3 p-3 bg-gradient-to-r from-purple-500 to-purple-600 hover:from-purple-600 hover:to-purple-700 rounded-lg text-white transition-all">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                            </svg>
                            <span class="text-sm font-medium">Tạo khóa học mới</span>
                        </a>

                        <a href="${pageContext.request.contextPath}/managerTest" class="flex items-center gap-3 p-3 bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 rounded-lg text-white transition-all">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                            </svg>
                            <span class="text-sm font-medium">Tạo bài kiểm tra</span>
                        </a>
                    </div>
                </div>
        </main>

        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />

        <script>
            const engagementData = [
            <c:forEach items="${engagementStats}" var="stat" varStatus="status">
            {
            dayName: '${stat.dayName}',
                    activeStudents: ${stat.activeStudents}
            }${!status.last ? ',' : ''}
            </c:forEach>
            ];
            // Performance Chart Data
            const performanceData = [
            <c:forEach items="${coursePerformance}" var="perf" varStatus="perfStatus">
            {
            courseName: '${perf.courseName}',
                    completionRate: ${perf.completionRate}
            }${!perfStatus.last ? ',' : ''}
            </c:forEach>
            ];
            const engCtx = document.getElementById('engagementChart').getContext('2d');
            const engLabels = engagementData.map(item => item.dayName);
            const engValues = engagementData.map(item => item.activeStudents);
            new Chart(engCtx, {
            type: 'line',
                    data: {
                    labels: engLabels,
                            datasets: [{
                            label: 'Học viên hoạt động',
                                    data: engValues,
                                    borderColor: 'rgb(139, 92, 246)',
                                    backgroundColor: 'rgba(139, 92, 246, 0.1)',
                                    tension: 0.4,
                                    fill: true,
                                    pointBackgroundColor: 'rgb(139, 92, 246)',
                                    pointBorderColor: '#fff',
                                    pointBorderWidth: 2,
                                    pointRadius: 5,
                                    pointHoverRadius: 7
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
                                    ticks: {
                                    stepSize: 5
                                    },
                                    grid: {
                                    borderDash: [5, 5]
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
            const perfCtx = document.getElementById('performanceChart').getContext('2d');
            const perfLabels = performanceData.map(item => item.courseName);
            const perfValues = performanceData.map(item => item.completionRate);
            new Chart(perfCtx, {
            type: 'bar',
                    data: {
                    labels: perfLabels,
                            datasets: [{
                            label: 'Tỷ lệ hoàn thành (%)',
                                    data: perfValues,
                                    backgroundColor: [
                                            'rgba(99, 102, 241, 0.8)',
                                            'rgba(16, 185, 129, 0.8)',
                                            'rgba(245, 158, 11, 0.8)',
                                            'rgba(139, 92, 246, 0.8)',
                                            'rgba(59, 130, 246, 0.8)'
                                    ],
                                    borderRadius: 8,
                                    barThickness: 40
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
                                    max: 100,
                                    ticks: {
                                    callback: function(value) {
                                    return value + '%';
                                    }
                                    },
                                    grid: {
                                    borderDash: [5, 5]
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
            $('#engagementFilter').on('change', function() {
            const selectedValue = $(this).val();
            window.location.href = "${pageContext.request.contextPath}/instructor/dashboard?filter=" + selectedValue;
            });
        </script>
    </body>
</html>