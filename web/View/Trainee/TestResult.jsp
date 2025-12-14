<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Kết quả bài thi</title>
        <jsp:include page="/layout/import.jsp"/>
    </head>
    <body class="bg-gray-100 min-h-screen">
        <jsp:include page="/layout/header.jsp"/>

        <div class="max-w-4xl mx-auto p-6">
            <!-- Debug Info (optional - xóa khi production) -->
            <c:if test="${param.debug == 'true'}">
                <div class="bg-yellow-50 border border-yellow-200 p-4 rounded mb-4 text-sm">
                    <h4 class="font-bold mb-2">Debug Info:</h4>
                    <p>Test ID: ${test.id}</p>
                    <p>Total Questions: ${totalQuestions}</p>
                    <p>Correct Count: ${correctCount}</p>
                    <p>Grade: ${grade}</p>
                    <p>Passed: ${passed}</p>
                    <p>User ID: ${sessionScope.user.id}</p>
                    <p>Current Attempted: ${attempt.currentAttempted}</p>
                    <p>Status: ${attempt.status}</p>
                </div>
            </c:if>

            <!-- ===== TEST INFO ===== -->
            <div class="bg-white p-6 rounded shadow mb-6">
                <h2 class="text-2xl font-bold mb-2">${test.title}</h2>
                <p class="text-gray-600">${test.description}</p>
            </div>

            <!-- ===== KẾT QUẢ ===== -->
            <div class="bg-white p-8 rounded shadow text-center">
                <c:choose>
                    <c:when test="${passed}">
                        <!-- PASSED -->
                        <div class="mb-6">
                            <svg class="w-24 h-24 mx-auto text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <h3 class="text-3xl font-bold text-green-600 mb-2">ĐẠT</h3>
                        <p class="text-gray-600 mb-6">Chúc mừng! Bạn đã hoàn thành bài thi thành công!</p>
                    </c:when>
                    <c:otherwise>
                        <!-- FAILED -->
                        <div class="mb-6">
                            <svg class="w-24 h-24 mx-auto text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <h3 class="text-3xl font-bold text-red-600 mb-2">CHƯA ĐẠT</h3>
                        <p class="text-gray-600 mb-6">Đừng nản lòng! Hãy ôn tập và thử lại nhé!</p>
                    </c:otherwise>
                </c:choose>

                <!-- Chi tiết điểm -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mt-8 mb-8">
                    <div class="p-4 bg-blue-50 rounded-lg">
                        <p class="text-sm text-gray-600 mb-1">Điểm số</p>
                        <p class="text-3xl font-bold text-blue-600">
                            <fmt:formatNumber value="${grade}" maxFractionDigits="1"/>
                        </p>
                    </div>

                    <div class="p-4 bg-green-50 rounded-lg">
                        <p class="text-sm text-gray-600 mb-1">Số câu đúng</p>
                        <p class="text-3xl font-bold text-green-600">
                            ${correctCount}/${totalQuestions}
                        </p>
                    </div>

                    <div class="p-4 bg-purple-50 rounded-lg">
                        <p class="text-sm text-gray-600 mb-1">Điểm đạt</p>
                        <p class="text-3xl font-bold text-purple-600">
                            ${test.minGrade}
                        </p>
                    </div>

                    <div class="p-4 bg-orange-50 rounded-lg">
                        <p class="text-sm text-gray-600 mb-1">Số lần làm</p>
                        <p class="text-3xl font-bold text-orange-600">
                            ${attempt.currentAttempted}
                        </p>
                    </div>
                </div>

                <!-- Progress Bar -->
                <div class="mb-8">
                    <div class="w-full bg-gray-200 rounded-full h-4">
                        <div class="h-4 rounded-full transition-all duration-500 ${passed ? 'bg-green-500' : 'bg-red-500'}" 
                             style="width: ${grade}%"></div>
                    </div>
                    <p class="mt-2 text-sm text-gray-600">
                        Tỷ lệ đúng: <fmt:formatNumber value="${grade}" maxFractionDigits="1"/>%
                    </p>
                </div>

                <!-- Previous attempts info -->
                <c:if test="${previousAttempt != null && attempt.currentAttempted > 1}">
                    <div class="mb-6 p-4 bg-gray-50 rounded-lg text-left">
                        <h4 class="font-semibold mb-2">Lịch sử làm bài:</h4>
                        <p class="text-sm text-gray-600">
                            Lần trước: Điểm ${previousAttempt.grade} - ${previousAttempt.status}
                        </p>
                        <p class="text-sm text-gray-600">
                            Lần này: Điểm ${grade} - ${attempt.status}
                        </p>
                        <c:if test="${grade > previousAttempt.grade}">
                            <p class="text-sm text-green-600 font-semibold mt-2">
                                ✓ Bạn đã cải thiện được ${grade - previousAttempt.grade} điểm!
                            </p>
                        </c:if>
                    </div>
                </c:if>

                <!-- Actions -->
                <div class="flex gap-4 justify-center mt-6">
                    <c:if test="${!passed}">
                        <a href="${pageContext.request.contextPath}/trainee/test?id=${test.id}" 
                           class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition font-semibold">
                            Làm lại
                        </a>
                    </c:if>
                    <c:url var="backUrl" value="/learn">
                        <c:param name="courseId" value="${test.courseId}" />
                        <c:if test="${test.courseSectionId > 0}">
                            <c:param name="sectionId" value="${test.courseSectionId}" />
                        </c:if>
                    </c:url>
                    <a href="${backUrl}"
                       class="bg-gray-300 text-gray-700 px-6 py-3 rounded-lg hover:bg-gray-400 transition font-semibold">
                        Quay lại bài học
                    </a>

                </div>
            </div>
        </div>

        <jsp:include page="/layout/footer.jsp"/>
    </body>
</html>