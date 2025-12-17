<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String currentPage = request.getParameter("page");
    if (currentPage == null)
        currentPage = "dashboard";
%>

<aside class="fixed top-0 left-0 w-64 h-screen bg-gradient-to-b from-blue-600 to-blue-700 text-white shadow-xl">
    <!-- BRAND -->
    <div class="px-6 py-5 border-b border-blue-500/30">
        <div class="flex items-center gap-3">
            <div class="w-10 h-10 bg-white rounded-lg flex items-center justify-center">
                <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5z"/>
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z"/>
                </svg>
            </div>
            <div>
                <h1 class="text-lg font-bold">EduLAB</h1>
                <p class="text-xs text-blue-200">Learning Platform</p>
            </div>
        </div>
    </div>

    <!-- MENU -->
    <nav class="px-3 py-4 overflow-y-auto h-[calc(100vh-88px)] custom-scrollbar">
        <!-- TỔNG QUAN -->
        <div class="mb-6">
            <p class="px-3 py-2 text-xs font-semibold text-blue-200 uppercase tracking-wide">
                Tổng quan
            </p>
            <a href="${pageContext.request.contextPath}/admin_dashboard?page=dashboard" 
               class="flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("dashboard") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30"%>">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                </svg>
                <span>Dashboard</span>
            </a>
        </div>

        <!-- HỌC TẬP -->
        <div class="mb-6">
            <p class="px-3 py-2 text-xs font-semibold text-blue-200 uppercase tracking-wide">
                Học tập
            </p>
            <div class="space-y-1">
                <!--                <a href="?page=courses" 
                                   class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("courses") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30"%>">
                                    <div class="flex items-center gap-3">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                                        </svg>
                                        <span>Khóa học</span>
                                    </div>
                                    <span class="px-2 py-0.5 text-xs font-semibold bg-blue-500 rounded-full">12</span>
                                </a>
                
                                <a href="?page=lessons" 
                                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("lessons") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30"%>">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"/>
                                    </svg>
                                    <span>Bài giảng</span>
                                </a>
                
                                <a href="?page=quizzes" 
                                   class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("quizzes") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30"%>">
                                    <div class="flex items-center gap-3">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"/>
                                        </svg>
                                        <span>Bài kiểm tra</span>
                                    </div>
                                    <span class="px-2 py-0.5 text-xs font-semibold bg-red-500 rounded-full">5</span>
                                </a>-->

                <a href="${pageContext.request.contextPath}/manager_category?page=categories" 
                   class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("categories") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30"%>">
                    <div class="flex items-center gap-3">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                        <span>Danh mục</span>
                    </div>
                </a>
            </div>
        </div>

        <!-- QUẢN LÝ -->
        <div class="mb-6">
            <p class="px-3 py-2 text-xs font-semibold text-blue-200 uppercase tracking-wide">
                Quản lý
            </p>
            <div class="space-y-1">

                <a href="${pageContext.request.contextPath}/admin/users?page=users" 
                   class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("users") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30"%>">
                    <div class="flex items-center gap-3">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                        </svg>
                        <span>Người dùng</span>
                    </div>
                </a>
                    
                <a href="${pageContext.request.contextPath}/admin/quizzes?page=quizzes"
                            class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("quizzes") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30" %>">
                            <div class="flex items-center gap-3">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                                <span>Câu hỏi</span>
                            </div>
                </a>
            </div>
        </div>
    </nav>
</aside>

<style>
    /* Custom Scrollbar */
    .custom-scrollbar::-webkit-scrollbar {
        width: 6px;
    }

    .custom-scrollbar::-webkit-scrollbar-track {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 10px;
    }

    .custom-scrollbar::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.3);
        border-radius: 10px;
    }

    .custom-scrollbar::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.5);
    }
</style>