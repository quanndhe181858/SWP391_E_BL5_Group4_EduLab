<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Làm bài thi</title>
        <jsp:include page="/layout/import.jsp"/>
        <style>
            .timer {
                position: fixed;
                top: 80px;
                right: 20px;
                background: white;
                padding: 15px 20px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                font-size: 20px;
                font-weight: bold;
                color: #dc2626;
                z-index: 100;
            }
            .answer-option {
                cursor: pointer;
                transition: all 0.2s;
            }
            .answer-option:hover {
                background-color: #f3f4f6;
            }
            .answer-option input[type="radio"]:checked + label {
                background-color: #dbeafe;
                border-color: #3b82f6;
            }
        </style>
    </head>
    <body class="bg-gray-100 min-h-screen">
        <jsp:include page="/layout/header.jsp"/>

        <!-- Timer -->
        <div class="timer" id="timer">
            <span id="timeDisplay">${test.timeInterval}:00</span>
        </div>

        <div class="max-w-4xl mx-auto p-6">
            <!-- ===== TEST INFO ===== -->
            <div class="bg-white p-6 rounded shadow mb-6">
                <h2 class="text-2xl font-bold mb-2">${test.title}</h2>
                <p class="text-gray-600">${test.description}</p>
                <p class="mt-2 text-sm text-gray-500">
                    Thời gian: ${test.timeInterval} phút | 
                    Điểm đạt: ${test.minGrade}/100 |
                    Số câu hỏi: ${questions.size()}
                </p>

                <!-- Previous attempt info -->
                <c:if test="${previousAttempt != null}">
                    <div class="mt-4 p-4 bg-blue-50 rounded border border-blue-200">
                        <p class="text-sm font-semibold text-blue-800">Kết quả lần trước:</p>
                        <p class="text-sm text-blue-700">
                            Điểm: ${previousAttempt.grade} | 
                            Trạng thái: 
                            <span class="font-semibold
                                  <c:choose>
                                      <c:when test="${previousAttempt.status == 'Passed'}">text-green-600</c:when>
                                      <c:otherwise>text-red-600</c:otherwise>
                                  </c:choose>">
                                ${previousAttempt.status}
                            </span> | 
                            Số lần làm: ${previousAttempt.currentAttempted}
                        </p>
                    </div>
                </c:if>

                <c:if test="${test.courseSectionId == 0}">
                    <span class="inline-block mt-2 px-3 py-1 text-sm bg-blue-100 text-blue-600 rounded">
                        Bài thi cuối khóa
                    </span>
                </c:if>
            </div>

            <!-- ===== FORM BÀI THI ===== -->
            <form action="${pageContext.request.contextPath}/trainee/test" 
                  method="POST" 
                  id="testForm" 
                  onsubmit="return confirmSubmit()">
                <input type="hidden" name="testId" value="${test.id}">

                <div class="bg-white p-6 rounded shadow">
                    <c:if test="${empty questions}">
                        <p class="text-red-500">Bài test chưa có câu hỏi.</p>
                    </c:if>

                    <c:forEach var="q" items="${questions}" varStatus="i">
                        <div class="mb-8 pb-6 border-b last:border-b-0">
                            <p class="font-semibold text-lg mb-3">
                                Câu ${i.index + 1}: ${q.content}
                            </p>

                            <!-- Hiển thị loại câu hỏi -->
                            <span class="text-xs px-2 py-1 bg-gray-100 text-gray-600 rounded mb-3 inline-block">
                                ${q.type}
                            </span>

                            <!-- Đáp án -->
                            <div class="mt-4 space-y-2">
                                <c:forEach var="answer" items="${q.answers}" varStatus="j">
                                    <div class="answer-option border rounded-lg p-3 hover:bg-gray-50">
                                        <label class="flex items-start cursor-pointer w-full">
                                            <input 
                                                type="radio" 
                                                name="answer_${q.id}" 
                                                value="${answer.id}"
                                                class="mt-1 mr-3"
                                                required>
                                            <span class="flex-1">
                                                <c:choose>
                                                    <c:when test="${j.index == 0}"><span class="font-medium mr-2">A.</span></c:when>
                                                    <c:when test="${j.index == 1}"><span class="font-medium mr-2">B.</span></c:when>
                                                    <c:when test="${j.index == 2}"><span class="font-medium mr-2">C.</span></c:when>
                                                    <c:when test="${j.index == 3}"><span class="font-medium mr-2">D.</span></c:when>
                                                    <c:when test="${j.index == 4}"><span class="font-medium mr-2">E.</span></c:when>
                                                    <c:when test="${j.index == 5}"><span class="font-medium mr-2">F.</span></c:when>
                                                    <c:otherwise><span class="font-medium mr-2">${j.index + 1}.</span></c:otherwise>
                                                </c:choose>
                                                ${answer.content}
                                            </span>
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Submit Button -->
                    <c:if test="${not empty questions}">
                        <div class="mt-6 flex gap-4">
                            <button 
                                type="submit" 
                                class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition font-semibold">
                                Nộp bài
                            </button>
                            <a 
                                href="${pageContext.request.contextPath}/trainee/courses" 
                                class="bg-gray-300 text-gray-700 px-6 py-3 rounded-lg hover:bg-gray-400 transition font-semibold inline-block">
                                Hủy
                            </a>
                        </div>
                    </c:if>
                </div>
            </form>
        </div>

        <jsp:include page="/layout/footer.jsp"/>

        <script>
            // Timer functionality
            const timeLimit = ${test.timeInterval} * 60; // Convert to seconds
            let timeLeft = timeLimit;
            let isSubmitting = false;

            function updateTimer() {
                const minutes = Math.floor(timeLeft / 60);
                const seconds = timeLeft % 60;
                document.getElementById('timeDisplay').textContent =
                        minutes + ':' + (seconds < 10 ? '0' : '') + seconds;

                if (timeLeft <= 0) {
                    alert('Hết thời gian! Bài thi sẽ được tự động nộp.');
                    isSubmitting = true;
                    document.getElementById('testForm').submit();
                } else if (timeLeft <= 60) {
                    document.getElementById('timer').style.color = '#dc2626';
                    document.getElementById('timer').style.animation = 'pulse 1s infinite';
                }

                timeLeft--;
            }

            // Update every second
            updateTimer();
            const timerInterval = setInterval(updateTimer, 1000);

            // Confirm submission
            function confirmSubmit() {
                if (isSubmitting)
                    return true;

                const totalQuestions = ${questions.size()};
                let answeredCount = 0;

                // Count answered questions
                const radios = document.querySelectorAll('input[name^="answer_"]:checked');
                answeredCount = radios.length;

                if (answeredCount < totalQuestions) {
                    const unanswered = totalQuestions - answeredCount;
                    if (!confirm('Bạn còn ' + unanswered + ' câu chưa trả lời. Bạn có chắc muốn nộp bài?')) {
                        return false;
                    }
                }

                isSubmitting = true;
                clearInterval(timerInterval);
                return true;
            }

            // Confirm before leaving page
            window.addEventListener('beforeunload', function (e) {
                if (!isSubmitting) {
                    e.preventDefault();
                    e.returnValue = 'Bạn có chắc muốn rời khỏi trang? Bài thi của bạn sẽ không được lưu.';
                }
            });
        </script>

        <style>
            @keyframes pulse {
                0%, 100% {
                    opacity: 1;
                }
                50% {
                    opacity: 0.5;
                }
            }
        </style>
    </body>
</html>