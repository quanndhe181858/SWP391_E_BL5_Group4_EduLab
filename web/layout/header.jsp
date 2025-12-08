<%-- 
    Document   : header
    Created on : Dec 6, 2025, 2:55:22 PM
    Author     : quan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
    <nav class="bg-white border-b border-gray-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center space-x-8">
                    <div class="flex items-center">
                        <a href="${pageContext.request.contextPath}/home">
                            <span class="text-2xl font-bold text-blue-600">LabEdu</span>
                        </a>
                    </div>
                    <div class="">
                        <div class="relative w-[500px]">
                            <form action="courses">
                                <input 
                                    type="text" 
                                    placeholder="Bạn muốn học gì?" 
                                    name="search"
                                    class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                                    />
                                <button class="absolute right-2 top-1/2 transform -translate-y-1/2 bg-blue-600 text-white p-2 rounded-md">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                                    </svg>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="flex items-center space-x-4">
<!--                            <a href="${pageContext.request.contextPath}/my-courses" class="text-gray-700 hover:text-blue-600 text-sm font-medium">
                                My Courses
                            </a>-->

                            <div class="relative" id="userDropdown">
                                <button class="flex items-center space-x-2 text-gray-700 hover:text-blue-600 focus:outline-none" id="userMenuButton">
                                    <div class="w-9 h-9 bg-blue-600 rounded-full flex items-center justify-center text-white font-semibold">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.user.first_name}">
                                                ${sessionScope.user.first_name.substring(0, 1).toUpperCase()}
                                            </c:when>
                                            <c:otherwise>U</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <span class="text-sm font-medium">
                                        <c:out value="${not empty sessionScope.user.first_name ? sessionScope.user.first_name : 'User'}" />
                                    </span>
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                    </svg>
                                </button>

                                <div id="dropdownMenu" class="hidden absolute right-0 mt-2 w-56 bg-white rounded-lg shadow-lg border border-gray-200 py-2 z-50">
                                    <div class="px-4 py-3 border-b border-gray-200">
                                        <p class="text-sm font-semibold text-gray-900">
                                            <c:out value="${sessionScope.user.first_name}" /> <c:out value="${sessionScope.user.last_name}" />
                                        </p>
                                        <p class="text-xs text-gray-500 truncate">
                                            <c:out value="${sessionScope.user.email}" />
                                        </p>
                                    </div>
<!--                                    <a href="${pageContext.request.contextPath}/profile" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                        <div class="flex items-center">
                                            <svg class="w-4 h-4 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                            </svg>
                                            My Profile
                                        </div>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/my-courses" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                        <div class="flex items-center">
                                            <svg class="w-4 h-4 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                                            </svg>
                                            My Learning
                                        </div>
                                    </a>-->
                                    <div class="border-t border-gray-200 mt-2 pt-2">
                                        <form action="${pageContext.request.contextPath}/logout" method="POST">
                                            <button type="submit" class="w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-red-50">
                                                <div class="flex items-center">
                                                    <svg class="w-4 h-4 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                                                    </svg>
                                                    Log Out
                                                </div>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="flex items-center space-x-4">
                            <a href="${pageContext.request.contextPath}/login" class="text-blue-600 text-sm font-medium hover:underline">
                                Log In
                            </a>
                            <a href="${pageContext.request.contextPath}/register" class="px-4 py-2 text-sm font-medium text-blue-600 border border-blue-600 rounded hover:bg-blue-50">
                                Join for Free
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>
</header>

<script>
    $(document).ready(function () {
        $('#userMenuButton').click(function (e) {
            e.stopPropagation();
            $('#dropdownMenu').toggleClass('hidden');
        });

        $(document).click(function (e) {
            if (!$(e.target).closest('#userDropdown').length) {
                $('#dropdownMenu').addClass('hidden');
            }
        });

        $('#dropdownMenu').click(function (e) {
            e.stopPropagation();
        });
    });
</script>