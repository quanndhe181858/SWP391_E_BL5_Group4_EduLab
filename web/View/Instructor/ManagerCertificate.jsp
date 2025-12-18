<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý chứng chỉ</title>
        <jsp:include page="/layout/import.jsp"/>
    </head>

    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp"/>

        <div class="container mx-auto px-4 py-8">

            <!-- HEADER -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-gray-900">Chứng chỉ</h1>
                <p class="text-lg text-gray-600 mt-1">
                    Quản lý các chứng chỉ bạn đã tạo
                </p>
            </div>

            <!-- FILTER BAR -->
            <form method="get" action="${pageContext.request.contextPath}/instructor/manager/certificate">
                <input type="hidden" name="page" value="${currentPage}"/>

                <div class="bg-white p-6 rounded-lg shadow-sm mb-6">
                    <div class="grid grid-cols-1 md:grid-cols-5 gap-4">

                        <!-- SEARCH -->
                        <input type="text"
                               name="search"
                               value="${search}"
                               placeholder="Tìm kiếm chứng chỉ..."
                               class="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                               onchange="this.form.submit()"/>

                        <!-- CATEGORY -->
                        <select name="category"
                                class="px-4 py-2 border rounded-lg bg-white"
                                onchange="this.form.submit()">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}"
                                        ${selectedCategory == cat.id ? 'selected' : ''}>
                                    ${cat.name} (${cat.count})
                                </option>
                            </c:forEach>
                        </select>

                        <!-- STATUS -->
                        <select name="status"
                                class="px-4 py-2 border rounded-lg bg-white"
                                onchange="this.form.submit()">
                            <option value="">Tất cả trạng thái</option>
                            <option value="Active" ${selectedStatus == 'Active' ? 'selected' : ''}>Hoạt động</option>
                            <option value="Inactive" ${selectedStatus == 'Inactive' ? 'selected' : ''}>Không hoạt động</option>
                        </select>

                        <!-- SORT -->
                        <select name="sort"
                                class="px-4 py-2 border rounded-lg bg-white"
                                onchange="this.form.submit()">
                            <option value="created" ${sortBy == 'created' ? 'selected' : ''}>Ngày tạo</option>
                            <option value="title" ${sortBy == 'title' ? 'selected' : ''}>Tên chứng chỉ</option>
                            <option value="course" ${sortBy == 'course' ? 'selected' : ''}>Khóa học</option>
                            <option value="issued" ${sortBy == 'issued' ? 'selected' : ''}>Số lượng phát hành</option>
                        </select>

                        <!-- ORDER -->
                        <select name="order"
                                class="px-4 py-2 border rounded-lg bg-white"
                                onchange="this.form.submit()">
                            <option value="desc" ${sortOrder == 'desc' ? 'selected' : ''}>Giảm dần</option>
                            <option value="asc" ${sortOrder == 'asc' ? 'selected' : ''}>Tăng dần</option>
                        </select>

                    </div>

                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/instructor/manager/certificate"
                           class="text-sm text-blue-600 hover:underline">
                            Xoá bộ lọc
                        </a>
                    </div>
                </div>
            </form>

            <!-- SUMMARY -->
            <div class="mb-4 text-sm text-gray-600">
                Hiển thị ${certificates.size()} / ${totalRecords} chứng chỉ
            </div>

            <!-- LIST -->
            <c:choose>
                <c:when test="${empty certificates}">
                    <div class="bg-white p-10 rounded-lg shadow-sm text-center text-gray-500 min-h-[405px]">
                        Không có chứng chỉ nào
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="space-y-4 min-h-[405px]">
                        <c:forEach var="cert" items="${certificates}">
                            <div class="border border-gray-200 rounded-lg p-6 hover:shadow-md transition">

                                <div class="flex justify-between items-start mb-2">
                                    <h3 class="text-xl font-bold text-gray-900 line-clamp-2">
                                        ${cert.title}
                                    </h3>
                                    <span class="px-2 py-1 text-xs font-semibold rounded
                                          ${cert.status == 'Active'
                                            ? 'bg-green-100 text-green-700'
                                            : 'bg-gray-100 text-gray-600'}">
                                              ${cert.status}
                                          </span>
                                    </div>

                                    <p class="text-sm text-blue-600 mb-1">
                                        <i class="fas fa-book mr-1"></i> ${cert.courseTitle}
                                    </p>

                                    <c:if test="${cert.categoryName != null}">
                                        <p class="text-sm text-gray-500 mb-2">
                                            <i class="fas fa-tag mr-1"></i> ${cert.categoryName}
                                        </p>
                                    </c:if>

                                    <p class="text-sm text-gray-600 mb-4 line-clamp-2">
                                        ${cert.description != null ? cert.description : 'Chưa có mô tả'}
                                    </p>

                                    <div class="flex justify-between items-center text-sm text-gray-500">
                                        <span>
                                            <i class="fas fa-check-circle text-green-600"></i>
                                            ${cert.issuedCount} đã phát hành
                                        </span>
                                        <span>
                                            <fmt:formatDate value="${cert.createdAt}" pattern="dd/MM/yyyy"/>
                                        </span>
                                    </div>

                                    <!-- ACTIONS -->
                                    <div class="mt-4 flex gap-2">
                                        <a href="${pageContext.request.contextPath}/instructor/certificate/edit?id=${cert.id}"
                                           class="inline-flex px-4 py-2 bg-yellow-500 text-white text-sm font-medium rounded-lg hover:bg-yellow-600">
                                            Edit
                                        </a>
                                    </div>

                                </div>
                            </c:forEach>
                        </div>

                        <!-- PAGINATION -->
                        <c:if test="${totalPages > 1}">
                            <div class="mt-8 flex justify-center">
                                <nav class="inline-flex rounded-md shadow-sm -space-x-px">
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <a href="?page=${i}&search=${search}&category=${selectedCategory}&status=${selectedStatus}&sort=${sortBy}&order=${sortOrder}"
                                           class="px-4 py-2 border text-sm
                                           ${i == currentPage
                                             ? 'bg-blue-50 border-blue-500 text-blue-600'
                                             : 'bg-white border-gray-300 text-gray-700 hover:bg-gray-50'}">
                                               ${i}
                                           </a>
                                        </c:forEach>
                                    </nav>
                                </div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>

                </div>

                <jsp:include page="/layout/footer.jsp"/>
                <jsp:include page="/layout/importBottom.jsp"/>

                <script>
                    function confirmDelete(id, title) {
                        if (confirm('Xóa chứng chỉ "' + title + '" ?')) {
                            window.location.href =
                                    '${pageContext.request.contextPath}/instructor/certificate/delete?id=' + id;
                        }
                    }
                </script>

            </body>
        </html>
