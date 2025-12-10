<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${course.title} - Learning</title>
        <jsp:include page="/layout/import.jsp" />
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="bg-gray-50">
        <jsp:include page="/layout/header.jsp" />

        <div class="flex h-screen">
            <aside class="w-80 bg-white border-r border-gray-200 overflow-y-auto">
                <div class="p-6">
                    <h3 class="text-xl font-bold text-gray-900 mb-4 line-clamp-2">
                        ${course.title}
                    </h3>
                    <c:if test="${not empty error}">
                        <div class="mb-6 p-4 rounded-lg bg-red-100 border border-red-300 text-red-800 font-semibold">
                            ${error}
                        </div>
                    </c:if>

                    <c:set var="total" value="${fn:length(sections)}"/>
                    <c:set var="completed" value="0"/>
                    <c:forEach var="sec" items="${sections}">
                        <c:if test="${not empty progressMap[sec.id] && progressMap[sec.id].status == 'Completed'}">
                            <c:set var="completed" value="${completed + 1}"/>
                        </c:if>
                    </c:forEach>
                    <fmt:formatNumber var="percent" value="${total > 0 ? (completed * 100.0 / total) : 0}" maxFractionDigits="0"/>

                    <div class="mb-6">
                        <div class="flex items-center justify-between mb-2">
                            <span class="text-sm font-semibold text-gray-700">
                                ${completed}/${total} bài học
                            </span>
                            <span class="text-sm font-bold text-green-600">
                                ${percent}%
                            </span>
                        </div>
                        <div class="w-full bg-gray-200 rounded-full h-2.5">
                            <div class="bg-green-500 h-2.5 rounded-full transition-all duration-300" 
                                 style="width: ${percent}%"></div>
                        </div>
                    </div>

                    <hr class="border-gray-200 mb-4">

                    <nav class="space-y-1">
                        <c:forEach var="s" items="${sections}" varStatus="status">
                            <c:set var="isActive" value="${s.id == current.id}"/>
                            <c:set var="isCompleted" value="${not empty progressMap[s.id] && progressMap[s.id].status == 'Completed'}"/>

                            <a href="${pageContext.request.contextPath}/learn?courseId=${course.id}&sectionId=${s.id}"
                               class="flex items-start gap-3 p-3 rounded-lg transition-all duration-200 group
                               ${isActive ? 'bg-green-50 border-l-4 border-green-500' : 'hover:bg-gray-50'}">

                                <div class="flex-shrink-0 w-8 h-8 flex items-center justify-center rounded-full
                                     ${isCompleted ? 'bg-green-500 text-white' : 
                                       isActive ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-600'}">
                                     <c:choose>
                                         <c:when test="${isCompleted}">
                                             <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                             <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                             </svg>
                                         </c:when>
                                         <c:otherwise>
                                             <span class="text-sm font-semibold">${s.position}</span>
                                         </c:otherwise>
                                     </c:choose>
                                </div>

                                <div class="flex-1 min-w-0">
                                    <p class="text-sm font-medium ${isActive ? 'text-green-700' : 'text-gray-900'}
                                       line-clamp-2 group-hover:text-green-600 transition-colors">
                                        ${s.title}
                                    </p>
                                    <c:if test="${not empty s.description}">
                                        <p class="text-xs text-gray-500 mt-1 line-clamp-1">
                                            ${s.description}
                                        </p>
                                    </c:if>
                                </div>
                            </a>
                        </c:forEach>
                    </nav>
                </div>
            </aside>

            <main class="flex-1 overflow-y-auto">
                <div class="max-w-4xl mx-auto px-8 py-10">
                    <div class="mb-6">
                        <a href="${pageContext.request.contextPath}/courses"
                           class="inline-flex items-center gap-2 text-sm font-semibold
                           text-gray-600 hover:text-green-700 transition">

                            <svg class="w-5 h-5" fill="none" stroke="currentColor"
                                 viewBox="0 0 24 24">
                            <path stroke-linecap="round"
                                  stroke-linejoin="round"
                                  stroke-width="2"
                                  d="M15 19l-7-7 7-7"/>
                            </svg>

                            Quay về khóa học
                        </a>
                    </div>

                    <div class="mb-8">
                        <div class="flex items-center gap-2 text-sm text-gray-500 mb-3">
                            <span>Bài ${current.position}</span>
                            <span>•</span>
                            <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-md font-medium">
                                ${current.type}
                            </span>
                        </div>

                        <h1 class="text-3xl font-bold text-gray-900 mb-3">
                            ${current.title}
                        </h1>

                        <c:if test="${not empty current.description}">
                            <p class="text-lg text-gray-600 leading-relaxed">
                                ${current.description}
                            </p>
                        </c:if>
                    </div>

                    <hr class="border-gray-200 mb-8">

                    <c:if test="${not empty current.content}">
                        <div class="prose prose-lg max-w-none mb-10">
                            <div class="text-gray-700 leading-relaxed">
                                ${current.content}
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty test}">
                        <div class="p-6 bg-blue-50 border border-blue-300 rounded-lg mb-10">
                            <h3 class="text-xl font-semibold text-blue-700 mb-3">📝 Bài kiểm tra</h3>
                            <p class="text-gray-700 mb-4">${test.description}</p>

                            <c:choose>
                                <c:when test="${not testDone}">
                                    <a href="${pageContext.request.contextPath}/trainee/taketest?testId=${test.id}"
                                       class="px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700">
                                        Làm bài test
                                    </a>
                                    <p class="mt-3 text-red-600 font-semibold">
                                        ❗ Bạn cần hoàn thành bài test để hoàn thành bài học.
                                    </p>
                                </c:when>

                                <c:otherwise>
                                    <div class="inline-flex items-center gap-2 px-4 py-2 bg-green-100 text-green-700 rounded-lg font-semibold">
                                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd"
                                              d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                              clip-rule="evenodd"/>
                                        </svg>
                                        Đã hoàn thành bài test
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>


                    <c:if test="${not empty mediaList}">
                        <div class="mb-10">
                            <h3 class="text-2xl font-bold text-gray-900 mb-6">
                                📎 Tài nguyên đính kèm
                            </h3>

                            <div class="space-y-6">
                                <c:forEach var="m" items="${mediaList}">

                                    <!-- Image -->
                                    <c:if test="${fn:endsWith(fn:toLowerCase(m.path), '.jpg') || 
                                                  fn:endsWith(fn:toLowerCase(m.path), '.jpeg') || 
                                                  fn:endsWith(fn:toLowerCase(m.path), '.png') ||
                                                  fn:endsWith(fn:toLowerCase(m.path), '.gif')}">
                                          <div class="rounded-lg overflow-hidden shadow-md border border-gray-200">
                                              <img src="${pageContext.request.contextPath}/${m.path}"
                                                   class="w-full h-auto">
                                          </div>
                                    </c:if>

                                    <c:if test="${fn:endsWith(fn:toLowerCase(m.path), '.mp4')}">
                                        <div class="rounded-lg overflow-hidden shadow-md border border-gray-200">
                                            <video controls class="w-full h-auto bg-black">
                                                <source src="${pageContext.request.contextPath}/${m.path}" type="video/mp4">
                                                Trình duyệt của bạn không hỗ trợ video.
                                            </video>
                                        </div>
                                    </c:if>

                                    <c:if test="${not fn:endsWith(fn:toLowerCase(m.path), '.jpg') && 
                                                  not fn:endsWith(fn:toLowerCase(m.path), '.jpeg') && 
                                                  not fn:endsWith(fn:toLowerCase(m.path), '.png') &&
                                                  not fn:endsWith(fn:toLowerCase(m.path), '.gif') &&
                                                  not fn:endsWith(fn:toLowerCase(m.path), '.mp4') &&
                                                  not fn:endsWith(fn:toLowerCase(m.path), '.pdf') &&
                                                  not fn:contains(m.path, 'youtube')}">
                                          <a href="${pageContext.request.contextPath}/${m.path}" 
                                             target="_blank"
                                             class="flex items-center gap-3 p-4 bg-gray-50 border border-gray-200 rounded-lg hover:bg-gray-100 transition-colors">
                                              <svg class="w-8 h-8 text-gray-600 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                              <path fill-rule="evenodd" d="M8 4a3 3 0 00-3 3v4a5 5 0 0010 0V7a1 1 0 112 0v4a7 7 0 11-14 0V7a5 5 0 0110 0v4a3 3 0 11-6 0V7a1 1 0 012 0v4a1 1 0 102 0V7a3 3 0 00-3-3z" clip-rule="evenodd"/>
                                              </svg>
                                              <div class="flex-1">
                                                  <p class="font-semibold text-gray-900">
                                                      ${not empty m.name ? m.name : 'Tài liệu đính kèm'}
                                                  </p>
                                                  <p class="text-sm text-gray-600">
                                                      Click để tải xuống
                                                  </p>
                                              </div>
                                              <svg class="w-5 h-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/>
                                              </svg>
                                          </a>
                                    </c:if>

                                </c:forEach>
                            </div>
                        </div>
                    </c:if>

                    <c:set var="isCurrentCompleted" value="${not empty progressMap[current.id] && progressMap[current.id].status == 'Completed'}"/>

                    <form method="POST" action="${pageContext.request.contextPath}/learn">
                        <input type="hidden" name="courseId" value="${course.id}">
                        <input type="hidden" name="sectionId" value="${current.id}">

                        <button type="submit"
                                class="w-full md:w-auto px-8 py-4 rounded-lg font-semibold text-lg shadow-lg
                                ${(empty test || testDone) ? 'bg-green-500 hover:bg-green-600 text-white' : 
                                  'bg-gray-300 text-gray-500 cursor-not-allowed'}"
                                  ${(not empty test && !testDone) ? 'disabled' : ''}>
                                    <span class="flex items-center justify-center gap-2">
                                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                        </svg>
                                        Đánh dấu hoàn thành
                                    </span>
                                </button>

                        </form>

                        <div class="flex justify-between items-center mt-8 pt-8 border-t border-gray-200">
                            <c:if test="${current.position > 1}">
                                <c:set var="prevSection" value="${null}"/>
                                <c:forEach var="s" items="${sections}">
                                    <c:if test="${s.position == current.position - 1}">
                                        <c:set var="prevSection" value="${s}"/>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${not empty prevSection}">
                                    <a href="${pageContext.request.contextPath}/learn?courseId=${course.id}&sectionId=${prevSection.id}"
                                       class="flex items-center gap-2 px-6 py-3 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                                        </svg>
                                        <span class="font-medium">Bài trước</span>
                                    </a>
                                </c:if>
                            </c:if>

                            <div class="flex-1"></div>

                            <c:if test="${current.position < fn:length(sections)}">
                                <c:set var="nextSection" value="${null}"/>
                                <c:forEach var="s" items="${sections}">
                                    <c:if test="${s.position == current.position + 1}">
                                        <c:set var="nextSection" value="${s}"/>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${not empty nextSection}">
                                    <a href="${pageContext.request.contextPath}/learn?courseId=${course.id}&sectionId=${nextSection.id}"
                                       class="flex items-center gap-2 px-6 py-3 bg-green-500 text-white rounded-lg hover:bg-green-600 transition-colors">
                                        <span class="font-medium">Bài tiếp theo</span>
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                        </svg>
                                    </a>
                                </c:if>
                            </c:if>
                        </div>

                    </div>
                </main>
            </div>
            <c:if test="${allCompleted && not empty courseTest}">
                <hr class="my-12 border-gray-300">

                <div class="p-8 bg-purple-50 border border-purple-300 rounded-xl">
                    <h2 class="text-2xl font-bold text-purple-700 mb-3">
                        🎓 Bài kiểm tra cuối khóa
                    </h2>

                    <p class="text-gray-700 mb-6">
                        ${courseTest.description}
                    </p>

                    <a href="${pageContext.request.contextPath}/trainee/taketest?testId=${courseTest.id}"
                       class="inline-block px-8 py-4 bg-purple-600 text-white rounded-lg
                       text-lg hover:bg-purple-700 transition">
                        Bắt đầu bài test cuối khóa
                    </a>
                </div>
            </c:if>

            <jsp:include page="/layout/footer.jsp" />
            <jsp:include page="/layout/importBottom.jsp" />
        </body>
    </html>