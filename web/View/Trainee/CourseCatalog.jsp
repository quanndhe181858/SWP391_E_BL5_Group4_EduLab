<%-- 
    Document   : CourseCatalog
    Created on : Dec 7, 2025, 7:39:24 PM
    Author     : quan
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách tổng hợp khoá học</title>
        <jsp:include page="/layout/import.jsp" />
    </head>
    <body>
        <jsp:include page="/layout/header.jsp" />
        <div class="container mx-auto px-4 py-8">
            <div class="p-3 w-full rounded-lg">
                <form action="courses" method="GET" id="filterForm">
                    <input type="hidden" name="page" id="pageInput" value="${page != null ? page : 1}">

                    <div class="flex gap-5">
                        <input 
                            class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            type="text" 
                            placeholder="Tìm kiếm khoá học ..." 
                            id="search"
                            name="search"
                            value="${param.search != null ? param.search : ''}"
                            />
                        <select 
                            id="categoryId" 
                            name="categoryId"
                            class="w-full max-w-[20%] px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white"
                            onchange="resetPageAndSubmit()">
                            <option value="">Tất cả các đề mục</option>
                            <c:forEach var="parent" items="${parents}">
                                <optgroup label="${parent.name}">
                                    <c:forEach var="child" items="${children}">
                                        <c:if test="${child.parent_id == parent.id}">
                                            <option value="${child.id}" ${param.categoryId == child.id ? 'selected' : ''}>
                                                ${child.name}
                                            </option>
                                        </c:if>
                                    </c:forEach>
                                </optgroup>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>

            <div class="p-3 w-full rounded-lg flex gap-4 min-h-screen">
                <div class="w-full">
                    <h2 class="text-2xl font-bold mb-4">Danh sách khoá học</h2>

                    <c:choose>
                        <c:when test="${empty courseCatalog}">
                            <div class="text-center py-12 min-h-[525px]">
                                <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                                <h3 class="mt-2 text-sm font-medium text-gray-900">Không tìm thấy khoá học</h3>
                                <p class="mt-1 text-sm text-gray-500">Không có khoá học nào phù hợp với tiêu chí tìm kiếm.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="grid grid-cols-1 lg:grid-cols-4 gap-6">
                                <c:forEach items="${courseCatalog}" var="c">
                                    <a href="courses?id=${c.id}" class="block">
                                        <div class="bg-white rounded-lg overflow-hidden shadow-md hover:shadow-xl transition-shadow duration-300 border border-gray-200 h-full">
                                            <div class="relative h-48 overflow-hidden bg-white p-3">
                                                <c:choose>
                                                    <c:when test="${not empty c.thumbnail}">
                                                        <img src="${pageContext.request.contextPath}/${c.thumbnail}" alt="${c.title}" class="w-full h-full object-cover rounded-lg">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="w-full h-full flex items-center justify-center bg-gradient-to-br from-blue-400 to-blue-600 rounded-lg">
                                                            <svg class="w-20 h-20 text-white opacity-50" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                                                            </svg>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${c.status == 'Active'}">
                                                    <span class="absolute top-5 right-5 bg-white text-black text-xs font-medium px-3 py-1.5 rounded-lg border border-gray-300 shadow-sm">
                                                        Có thể tham gia
                                                    </span>
                                                </c:if>
                                            </div>

                                            <div class="px-4 pt-2 pb-3">
                                                <div class="flex items-center gap-2 mb-3">
                                                    <div class="w-6 h-6 bg-gray-200 rounded flex items-center justify-center flex-shrink-0">
                                                        <svg class="w-4 h-4 text-gray-600" fill="currentColor" viewBox="0 0 20 20">
                                                        <path d="M10.394 2.08a1 1 0 00-.788 0l-7 3a1 1 0 000 1.84L5.25 8.051a.999.999 0 01.356-.257l4-1.714a1 1 0 11.788 1.838L7.667 9.088l1.94.831a1 1 0 00.787 0l7-3a1 1 0 000-1.838l-7-3zM3.31 9.397L5 10.12v4.102a8.969 8.969 0 00-1.05-.174 1 1 0 01-.89-.89 11.115 11.115 0 01.25-3.762zM9.3 16.573A9.026 9.026 0 007 14.935v-3.957l1.818.78a3 3 0 002.364 0l5.508-2.361a11.026 11.026 0 01.25 3.762 1 1 0 01-.89.89 8.968 8.968 0 00-5.35 2.524 1 1 0 01-1.4 0zM6 18a1 1 0 001-1v-2.065a8.935 8.935 0 00-2-.712V17a1 1 0 001 1z"/>
                                                        </svg>
                                                    </div>
                                                    <span class="text-xs text-gray-600 font-medium">
                                                        ${c.category.name}
                                                    </span>
                                                </div>

                                                <h3 class="text-base font-bold mb-2 line-clamp-2 text-gray-900">
                                                    ${c.title}
                                                </h3>

                                                <p class="text-gray-600 text-xs mb-3 line-clamp-2 leading-relaxed">
                                                    ${c.description}
                                                </p>
                                            </div>

                                            <div class="px-4 py-3 border-t border-gray-100 flex items-center justify-between">
                                                <div class="flex items-center gap-1 text-xs text-gray-500">
                                                    <svg class="w-3.5 h-3.5" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd"/>
                                                    </svg>
                                                    <span>
                                                        <fmt:formatDate value="${c.created_at}" pattern="dd/MM/yyyy" />
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>

                            <c:if test="${totalPages > 1}">
                                <div class="mt-8 flex justify-center">
                                    <nav class="inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                                        <c:choose>
                                            <c:when test="${page > 1}">
                                                <a href="javascript:void(0)" onclick="goToPage(${page - 1})" 
                                                   class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                                    <span class="sr-only">Trước</span>
                                                    <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                                    </svg>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-gray-100 text-sm font-medium text-gray-400 cursor-not-allowed">
                                                    <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                                    </svg>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>

                                        <c:set var="startPage" value="${page - 2 > 0 ? page - 2 : 1}" />
                                        <c:set var="endPage" value="${page + 2 <= totalPages ? page + 2 : totalPages}" />

                                        <c:if test="${startPage > 1}">
                                            <a href="javascript:void(0)" onclick="goToPage(1)" 
                                               class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
                                                1
                                            </a>
                                            <c:if test="${startPage > 2}">
                                                <span class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700">
                                                    ...
                                                </span>
                                            </c:if>
                                        </c:if>

                                        <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                            <c:choose>
                                                <c:when test="${i == page}">
                                                    <span class="relative inline-flex items-center px-4 py-2 border border-blue-500 bg-blue-50 text-sm font-medium text-blue-600">
                                                        ${i}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="javascript:void(0)" onclick="goToPage(${i})" 
                                                       class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
                                                        ${i}
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>

                                        <c:if test="${endPage < totalPages}">
                                            <c:if test="${endPage < totalPages - 1}">
                                                <span class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700">
                                                    ...
                                                </span>
                                            </c:if>
                                            <a href="javascript:void(0)" onclick="goToPage(${totalPages})" 
                                               class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
                                                ${totalPages}
                                            </a>
                                        </c:if>

                                        <c:choose>
                                            <c:when test="${page < totalPages}">
                                                <a href="javascript:void(0)" onclick="goToPage(${page + 1})" 
                                                   class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                                    <span class="sr-only">Sau</span>
                                                    <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"/>
                                                    </svg>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-gray-100 text-sm font-medium text-gray-400 cursor-not-allowed">
                                                    <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"/>
                                                    </svg>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </nav>
                                </div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />
        <script>
            let searchTimeout;
            document.getElementById('search').addEventListener('input', function () {
                clearTimeout(searchTimeout);
                searchTimeout = setTimeout(function () {
                    resetPageAndSubmit();
                }, 500);
            });

            function goToPage(pageNum) {
                document.getElementById('pageInput').value = pageNum;
                document.getElementById('filterForm').submit();
            }

            function resetPageAndSubmit() {
                document.getElementById('pageInput').value = 1;
                document.getElementById('filterForm').submit();
            }
        </script>
    </body>
</html>