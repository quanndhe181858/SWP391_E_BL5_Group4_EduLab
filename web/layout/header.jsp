<%-- 
    Document   : header
    Created on : Dec 6, 2025, 2:55:22 PM
    Author     : quan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="sticky z-20 top-0">
    <nav class="bg-white border-b border-gray-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center space-x-8">
                    <div class="flex items-center">
                        <a href="${pageContext.request.contextPath}/home">
                            <span class="text-2xl font-bold text-blue-600">EduLAB</span>
                        </a>
                    </div>
                    <div class="">
                        <div class="relative w-[500px]">
                            <form action="${pageContext.request.contextPath}/courses">
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
                            <!-- <c:if test="${sessionScope.user.role_id == 2}">
                                <a href="${pageContext.request.contextPath}/instructor/courses" class="text-gray-700 hover:text-blue-600 text-sm font-medium">
                                    My Courses
                                </a>
                            </c:if> -->

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
                                    </a> -->
                                    
                                    <!-- Admin Menu -->
                                    <c:if test="${sessionScope.user.role_id == 1}">
                                        <a href="${pageContext.request.contextPath}/admin/users" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                            <div class="flex items-center">
                                                <svg class="w-4 h-4 mr-3" fill="currentColor" viewBox="0 0 20 20">
                                                    <path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/>
                                                </svg>
                                                User Management
                                            </div>
                                        </a>
                                    </c:if>
                                    
                                    <!-- Instructor Menu -->                                   
                                    <c:if test="${sessionScope.user.role_id == 2}">
                                        <a href="${pageContext.request.contextPath}/instructor/courses" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                            <div class="flex items-center">
                                                <svg class="w-4 h-4 mr-3" fill="currentColor" viewBox="0 0 20 20">
                                                    <path d="M10.394 2.08a1 1 0 00-.788 0l-7 3a1 1 0 000 1.84L5.25 8.051a.999.999 0 01.356-.257l4-1.714a1 1 0 11.788 1.838L7.667 9.088l1.94.831a1 1 0 00.787 0l7-3a1 1 0 000-1.838l-7-3zM3.31 9.397L5 10.12v4.102a8.969 8.969 0 00-1.05-.174 1 1 0 01-.89-.89 11.115 11.115 0 01.25-3.762zM9.3 16.573A9.026 9.026 0 007 14.935v-3.957l1.818.78a3 3 0 002.364 0l5.508-2.361a11.026 11.026 0 01.25 3.762 1 1 0 01-.89.89 8.968 8.968 0 00-5.35 2.524 1 1 0 01-1.4 0zM6 18a1 1 0 001-1v-2.065a8.935 8.935 0 00-2-.712V17a1 1 0 001 1z"/>
                                                </svg>
                                                My Course
                                            </div>
                                        </a>
                                    </c:if>
                                    <c:if test="${sessionScope.user.role_id == 2}">
                                        <a href="${pageContext.request.contextPath}/instructor/quizes" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                            <div class="flex items-center">
                                                <svg class="w-4 h-4 mr-3" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd"/>
                                                </svg>
                                                My Quiz
                                            </div>
                                        </a>
                                    </c:if>
                                    <c:if test="${sessionScope.user.role_id == 2}">
                                        <a href="${pageContext.request.contextPath}/managerTest" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                            <div class="flex items-center">
                                                <svg class="w-4 h-4 mr-3" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M6 2a2 2 0 00-2 2v12a2 2 0 002 2h8a2 2 0 002-2V7.414A2 2 0 0015.414 6L12 2.586A2 2 0 0010.586 2H6zm5 6a1 1 0 10-2 0v2H7a1 1 0 100 2h2v2a1 1 0 102 0v-2h2a1 1 0 100-2h-2V8z" clip-rule="evenodd"/>
                                                </svg>
                                                My Test
                                            </div>
                                        </a>
                                    </c:if>
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