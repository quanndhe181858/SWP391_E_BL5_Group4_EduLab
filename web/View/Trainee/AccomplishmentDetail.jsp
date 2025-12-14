<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Course Accomplishment Detail</title>
        <jsp:include page="/layout/import.jsp"/>
    </head>

    <body class="bg-slate-100">
        <%@include file="/layout/header.jsp"%>

        <div class="max-w-6xl mx-auto px-6 py-10">

            <!-- COURSE HEADER -->
            <div class="bg-white rounded-xl shadow p-6 mb-8">
                <h1 class="text-2xl font-bold text-slate-800">
                    ${course.title}
                </h1>
                <p class="text-slate-600 mt-1">
                    Chi tiết kết quả học tập của bạn
                </p>

            </div>
            <a href="${pageContext.request.contextPath}/trainee/accomplishments"
               class="inline-flex items-center gap-2 text-sm font-semibold
               text-slate-600 hover:text-blue-600
               transition">

                <!-- Icon -->
                <svg xmlns="http://www.w3.org/2000/svg"
                     class="w-5 h-5"
                     fill="none"
                     viewBox="0 0 24 24"
                     stroke="currentColor">
                <path stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M15 19l-7-7 7-7" />
                </svg>

                Quay về danh sách thành tích
            </a>

            <!-- SECTION LIST -->
            <div class="bg-white rounded-xl shadow overflow-hidden">
                <table class="w-full">
                    <thead class="bg-slate-100 border-b text-sm">
                        <tr>
                            <th class="px-6 py-4 text-left">Bài học</th>
                            <th class="px-6 py-4 text-center">Có test</th>
                            <th class="px-6 py-4 text-center">Điểm cao nhất</th>
                            <th class="px-6 py-4 text-center">Số lần làm</th>
                            <th class="px-6 py-4 text-center">Trạng thái</th>
                        </tr>
                    </thead>

                    <tbody class="divide-y text-sm">
                        <c:forEach var="s" items="${sections}">
                            <c:set var="test" value="${testMap[s.id]}"/>
                            <c:set var="attempts" value="${attemptMap[s.id]}"/>

                            <tr>
                                <td class="px-6 py-4 font-medium">
                                    ${s.title}
                                </td>

                                <!-- HAS TEST -->
                                <td class="px-6 py-4 text-center">
                                    <c:choose>
                                        <c:when test="${test != null}">
                                            ✅
                                        </c:when>
                                        <c:otherwise>
                                            —
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <!-- BEST GRADE -->
                                <td class="px-6 py-4 text-center">
                                    <c:choose>
                                        <c:when test="${not empty attempts}">
                                            ${attempts[0].grade}
                                        </c:when>
                                        <c:otherwise>
                                            —
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <!-- ATTEMPT COUNT -->
                                <td class="px-6 py-4 text-center">
                                    ${empty attempts ? 0 : fn:length(attempts)}
                                </td>

                                <!-- STATUS -->
                                <td class="px-6 py-4 text-center">
                                    <c:choose>
                                        <c:when test="${not empty attempts and attempts[0].status == 'Passed'}">
                                            <span class="text-green-600 font-semibold">Passed</span>
                                        </c:when>
                                        <c:when test="${test != null}">
                                            <span class="text-red-500 font-semibold">Not Passed</span>
                                        </c:when>
                                        <c:otherwise>
                                            —
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>

        <%@include file="/layout/footer.jsp"%>
    </body>
</html>
