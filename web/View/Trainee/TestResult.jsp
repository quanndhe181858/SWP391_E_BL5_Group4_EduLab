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
                    <p>Is Course Test: ${test.courseSectionId == 0}</p>
                </div>
            </c:if>

            <div class="bg-white p-6 rounded shadow mb-6">
                <h2 class="text-2xl font-bold mb-2">${test.title}</h2>
                <p class="text-gray-600">${test.description}</p>
            </div>

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

                        <!-- Thông báo đặc biệt cho course test -->
                        <c:if test="${test.courseSectionId == 0}">
                            <div class="p-4 bg-green-50 border-2 border-green-300 rounded-lg mb-6">
                                <p class="text-green-800 font-semibold text-lg">
                                    🎉 Bạn đã hoàn thành khóa học! Hãy nhận chứng chỉ của bạn!
                                </p>
                            </div>
                        </c:if>
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

                        <!-- Thông báo đặc biệt cho course test khi fail -->
                        <c:if test="${test.courseSectionId == 0 && attempt.currentAttempted >= 2}">
                            <div class="p-4 bg-red-50 border-2 border-red-300 rounded-lg mb-6">
                                <p class="text-red-800 font-semibold text-lg">
                                    ⚠️ Bạn đã hết số lần làm bài. Khóa học chưa hoàn thành.
                                </p>
                                <p class="text-red-700 text-sm mt-2">
                                    Vui lòng liên hệ giảng viên để được hỗ trợ thêm.
                                </p>
                            </div>
                        </c:if>
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
                    <c:choose>
                        <c:when test="${test.courseSectionId == 0 && passed}">
                            <a href="${pageContext.request.contextPath}/trainee/certificate/view?courseId=${test.courseId}" 
                               class="bg-gradient-to-r from-yellow-500 to-orange-500 text-white px-8 py-3 rounded-lg hover:from-yellow-600 hover:to-orange-600 transition font-semibold shadow-lg flex items-center gap-2">
                                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                                </svg>
                                Nhận chứng chỉ
                            </a>
                        </c:when>

                        <c:when test="${test.courseSectionId == 0 && !passed}">
                            <a href="${pageContext.request.contextPath}/learn?courseId=${test.courseId}&failed=true" 
                               class="bg-gray-500 text-white px-6 py-3 rounded-lg hover:bg-gray-600 transition font-semibold">
                                Quay lại khóa học
                            </a>
                        </c:when>

                        <c:when test="${!passed}">
                            <a href="${pageContext.request.contextPath}/trainee/test?id=${test.id}" 
                               class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition font-semibold">
                                Làm lại
                            </a>
                            <c:url var="backUrl" value="/learn">
                                <c:param name="courseId" value="${test.courseId}" />
                                <c:param name="sectionId" value="${test.courseSectionId}" />
                            </c:url>
                            <a href="${backUrl}"
                               class="bg-gray-300 text-gray-700 px-6 py-3 rounded-lg hover:bg-gray-400 transition font-semibold">
                                Quay lại bài học
                            </a>
                        </c:when>

                        <c:otherwise>
                            <c:url var="backUrl" value="/learn">
                                <c:param name="courseId" value="${test.courseId}" />
                                <c:param name="sectionId" value="${test.courseSectionId}" />
                            </c:url>
                            <a href="${backUrl}"
                               class="bg-green-600 text-white px-6 py-3 rounded-lg hover:bg-green-700 transition font-semibold">
                                Tiếp tục học
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <jsp:include page="/layout/footer.jsp"/>
    </body>
</html>