<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String currentPage = request.getParameter("page");
    if (currentPage == null) currentPage = "dashboard";
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
            <a href="?page=dashboard" 
               class="flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("dashboard") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30" %>">
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
                <a href="?page=courses" 
                   class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("courses") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30" %>">
                    <div class="flex items-center gap-3">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                        </svg>
                        <span>Khóa học</span>
                    </div>
                    <span class="px-2 py-0.5 text-xs font-semibold bg-blue-500 rounded-full">12</span>
                </a>

                <a href="?page=lessons" 
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("lessons") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30" %>">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"/>
                    </svg>
                    <span>Bài giảng</span>
                </a>

                <a href="?page=quizzes" 
                   class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("quizzes") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30" %>">
                    <div class="flex items-center gap-3">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"/>
                        </svg>
                        <span>Bài kiểm tra</span>
                    </div>
                    <span class="px-2 py-0.5 text-xs font-semibold bg-red-500 rounded-full">5</span>
                </a>

                <a href="manager_category" 
                   class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("assignments") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30" %>">
                    <div class="flex items-center gap-3">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                        <span>Danh mục</span>
                    </div>
                    <span class="px-2 py-0.5 text-xs font-semibold bg-orange-500 rounded-full">8</span>
                </a>
            </div>
        </div>

        <!-- QUẢN LÝ -->
        <div class="mb-6">
            <p class="px-3 py-2 text-xs font-semibold text-blue-200 uppercase tracking-wide">
                Quản lý
            </p>
            <div class="space-y-1">
                <a href="?page=students" 
                   class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("students") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30" %>">
                    <div class="flex items-center gap-3">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                        </svg>
                        <span>Học viên</span>
                    </div>
                    <span class="px-2 py-0.5 text-xs font-semibold bg-green-500 rounded-full">248</span>
                </a>

                <a href="?page=instructors" 
                   class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("instructors") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30" %>">
                    <div class="flex items-center gap-3">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"/>
                        </svg>
                        <span>Giảng viên</span>
                    </div>
                    <span class="px-2 py-0.5 text-xs font-semibold bg-purple-500 rounded-full">15</span>
                </a>

                <a href="?page=reports" 
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("reports") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30" %>">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                    </svg>
                    <span>Báo cáo</span>
                </a>

                <a href="?page=schedule" 
                   class="flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("schedule") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30" %>">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                    </svg>
                    <span>Lịch học</span>
                </a>
            </div>
        </div>

        <!-- GIAO TIẾP -->
        <div class="mb-6">
            <p class="px-3 py-2 text-xs font-semibold text-blue-200 uppercase tracking-wide">
                Giao tiếp
            </p>
            <a href="?page=messages" 
               class="flex items-center justify-between px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("messages") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30" %>">
                <div class="flex items-center gap-3">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 10h.01M12 10h.01M16 10h.01M9 16H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-5l-5 5v-5z"/>
                    </svg>
                    <span>Tin nhắn</span>
                </div>
                <span class="px-2 py-0.5 text-xs font-semibold bg-red-500 rounded-full animate-pulse">3</span>
            </a>
        </div>

        <!-- HỆ THỐNG -->
        <div class="mb-6">
            <p class="px-3 py-2 text-xs font-semibold text-blue-200 uppercase tracking-wide">
                Hệ thống
            </p>
            <a href="?page=settings" 
               class="flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all <%= currentPage.equals("settings") ? "bg-white text-blue-600 font-semibold shadow-lg" : "text-white hover:bg-blue-500/30" %>">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                </svg>
                <span>Cài đặt</span>
            </a>
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