<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Yêu cầu thi lại</title>
        <jsp:include page="/layout/import.jsp"/>
    </head>

    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp"/>

        <div class="container mx-auto px-4 py-8">

            <!-- HEADER -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-gray-900">
                    Yêu cầu thi lại
                </h1>
                <p class="text-lg text-gray-600 mt-1">
                    Danh sách học viên đang chờ phê duyệt thi lại bài kiểm tra cuối khóa
                </p>
            </div>

            <!-- FILTER BAR -->
            <form method="get" action="${pageContext.request.contextPath}/instructor/retake-request">
                <div class="bg-white p-6 rounded-lg shadow-sm mb-6">
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">

                        <!-- SEARCH -->
                        <input type="text"
                               name="search"
                               value="${search}"
                               placeholder="Tìm theo tên học viên / email..."
                               class="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500"
                               onchange="this.form.submit()"/>

                        <!-- COURSE -->
                        <select name="courseId"
                                class="px-4 py-2 border rounded-lg bg-white"
                                onchange="this.form.submit()">
                            <option value="">Tất cả khóa học</option>
                            <c:forEach var="c" items="${courses}">
                                <option value="${c.id}" ${c.id == selectedCourseId ? 'selected' : ''}>
                                    ${c.title}
                                </option>
                            </c:forEach>
                        </select>

                        <!-- SORT -->
                        <select name="sort"
                                class="px-4 py-2 border rounded-lg bg-white"
                                onchange="this.form.submit()">
                            <option value="created" ${sortBy == 'created' ? 'selected' : ''}>
                                Ngày gửi yêu cầu
                            </option>
                            <option value="name" ${sortBy == 'name' ? 'selected' : ''}>
                                Tên học viên
                            </option>
                        </select>

                        <!-- ORDER -->
                        <select name="order"
                                class="px-4 py-2 border rounded-lg bg-white"
                                onchange="this.form.submit()">
                            <option value="desc" ${sortOrder == 'desc' ? 'selected' : ''}>Mới nhất</option>
                            <option value="asc" ${sortOrder == 'asc' ? 'selected' : ''}>Cũ nhất</option>
                        </select>
                    </div>

                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/instructor/retake-request"
                           class="text-sm text-purple-600 hover:underline">
                            Xóa bộ lọc
                        </a>
                    </div>
                </div>
            </form>

            <!-- SUMMARY -->
            <div class="mb-4 text-sm text-gray-600">
                Hiển thị ${requests.size()} yêu cầu
            </div>

            <!-- LIST -->
            <c:choose>
                <c:when test="${empty requests}">
                    <div class="bg-white p-10 rounded-lg shadow-sm text-center text-gray-500">
                        Không có yêu cầu thi lại nào đang chờ
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="space-y-4">

                        <c:forEach var="r" items="${requests}">
                            <div class="bg-white border border-gray-200 rounded-lg p-6 hover:shadow-md transition">

                                <!-- TOP -->
                                <div class="flex justify-between items-start mb-2">
                                    <div>
                                        <h3 class="text-xl font-bold text-gray-900">
                                            ${r.userName}
                                        </h3>
                                        <p class="text-sm text-gray-500">
                                            ${r.userEmail}
                                        </p>
                                    </div>

                                    <span class="px-3 py-1 text-xs font-semibold rounded-full
                                          bg-yellow-100 text-yellow-800">
                                        Pending
                                    </span>
                                </div>

                                <!-- INFO -->
                                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 text-sm text-gray-700 mt-4">
                                    <div>
                                        <span class="font-semibold">Khóa học:</span><br/>
                                        ${r.courseTitle}
                                    </div>
                                    <div>
                                        <span class="font-semibold">Bài test:</span><br/>
                                        ${r.testTitle}
                                    </div>
                                    <div>
                                        <span class="font-semibold">Điểm gần nhất:</span><br/>
                                        ${r.grade}/100 (Lần ${r.currentAttempted}/2)
                                    </div>
                                </div>

                                <!-- DATE -->
                                <div class="text-sm text-gray-500 mt-3">
                                    Yêu cầu lúc:
                                    <fmt:formatDate value="${r.updatedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </div>

                                <!-- ACTIONS -->
                                <!-- ACTIONS -->
                                <div class="mt-5 flex gap-3">

                                    <!-- APPROVE -->
                                    <form method="post"
                                          action="${pageContext.request.contextPath}/instructor/retake-request">
                                        <input type="hidden" name="action" value="approve">
                                        <input type="hidden" name="userId" value="${r.userId}">
                                        <input type="hidden" name="testId" value="${r.testId}">
                                        <button type="submit"
                                                class="px-4 py-2 bg-green-600 text-white text-sm font-semibold rounded-lg hover:bg-green-700">
                                            Chấp nhận
                                        </button>
                                    </form>

                                    <!-- REJECT -->
                                    <form method="post"
                                          action="${pageContext.request.contextPath}/instructor/retake-request">
                                        <input type="hidden" name="action" value="reject">
                                        <input type="hidden" name="userId" value="${r.userId}">
                                        <input type="hidden" name="testId" value="${r.testId}">
                                        <button type="submit"
                                                class="px-4 py-2 border border-red-300 text-red-600 text-sm font-semibold rounded-lg hover:bg-red-50">
                                            Từ chối
                                        </button>
                                    </form>

                                </div>


                            </div>
                        </c:forEach>

                    </div>
                </c:otherwise>
            </c:choose>

        </div>

        <jsp:include page="/layout/footer.jsp"/>
        <jsp:include page="/layout/importBottom.jsp"/>
    </body>
</html>
