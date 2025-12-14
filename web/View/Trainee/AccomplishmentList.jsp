<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>My Accomplishments</title>
        <jsp:include page="/layout/import.jsp"/>
    </head>

    <body class="bg-slate-100">
        <%@include file="/layout/header.jsp"%>

        <div class="max-w-6xl mx-auto px-6 py-10">

            <!-- TITLE -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-slate-800">
                    Thành tích học tập
                </h1>
                <p class="text-slate-600 mt-1">
                    Danh sách các khóa học bạn đã hoàn thành và đạt yêu cầu
                </p>
            </div>

            <!-- EMPTY STATE -->
            <c:if test="${empty completedCourses}">
                <div class="bg-white rounded-xl shadow p-10 text-center text-slate-600">
                    Bạn chưa hoàn thành khóa học nào.
                </div>
            </c:if>

            <!-- TABLE -->
            <c:if test="${not empty completedCourses}">
                <div class="bg-white rounded-xl shadow overflow-hidden">

                    <table class="w-full">
                        <thead class="bg-slate-50 border-b">
                            <tr>
                                <th class="px-6 py-4 text-left text-sm font-semibold text-slate-600">
                                    Khóa học
                                </th>
                                <th class="px-6 py-4 text-left text-sm font-semibold text-slate-600">
                                    Ngày hoàn thành
                                </th>
                                <th class="px-6 py-4 text-center text-sm font-semibold text-slate-600">
                                    Điểm đạt
                                </th>
                                <th class="px-6 py-4 text-center text-sm font-semibold text-slate-600">
                                    Trạng thái
                                </th>
                                <th class="px-6 py-4 text-center text-sm font-semibold text-slate-600">
                                    Chứng chỉ
                                </th>
                            </tr>
                        </thead>

                        <tbody class="divide-y">
                            <c:forEach var="c" items="${completedCourses}">
                                <tr class="hover:bg-slate-50 transition">

                                    <!-- COURSE TITLE -->
                                    <td class="px-6 py-4 font-medium text-slate-800">
                                        ${c.title}
                                    </td>

                                    <!-- COMPLETED DATE -->
                                    <td class="px-6 py-4 text-slate-600">
                                        <fmt:formatDate value="${c.completedAt}" pattern="dd/MM/yyyy"/>
                                    </td>

                                    <!-- PASSED GRADE -->
                                    <td class="px-6 py-4 text-center font-semibold text-green-600">
                                        ${c.passedGrade}
                                    </td>

                                    <!-- STATUS -->
                                    <td class="px-6 py-4 text-center">
                                        <span class="px-3 py-1 rounded-full text-sm font-semibold
                                              bg-green-100 text-green-700">
                                            Completed
                                        </span>
                                    </td>

                                    <!-- CERTIFICATE -->
                                    <td class="px-6 py-4 text-center">
                                        <a href="${pageContext.request.contextPath}/trainee/certificates"
                                           class="text-blue-600 font-semibold hover:underline">
                                            Xem
                                        </a>
                                    </td>

                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

        </div>

        <%@include file="/layout/footer.jsp"%>
    </body>
</html>
