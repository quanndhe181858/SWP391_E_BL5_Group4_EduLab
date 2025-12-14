<%@page import="model.Question"%>
<%@page import="model.QuizAnswer"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Take Test</title>
        <jsp:include page="/layout/import.jsp" />
        <style>
            .question-nav-btn {
                transition: all 0.2s;
            }
            .question-nav-btn:hover {
                background-color: #3b82f6;
                color: white;
                transform: scale(1.05);
            }
            .question-nav-btn.answered {
                background-color: #10b981;
                color: white;
                border-color: #10b981;
            }
            .question-nav-btn.current {
                background-color: #3b82f6;
                color: white;
                border-color: #3b82f6;
            }
            .answer-option {
                cursor: pointer;
                transition: all 0.2s;
            }
            .answer-option:hover {
                background-color: #f3f4f6;
            }
            @keyframes pulse {
                0%, 100% {
                    opacity: 1;
                }
                50% {
                    opacity: 0.5;
                }
            }
            .timer-warning {
                animation: pulse 1s infinite;
            }
        </style>
    </head>

    <body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">

        <%
            List<Question> questions = (List<Question>) request.getAttribute("questions");
            int total = questions != null ? questions.size() : 0;
            model.Test test = (model.Test) request.getAttribute("test");
            int timeInterval = test != null ? test.getTimeInterval() : 10;
        %>

        <jsp:include page="/layout/header.jsp"/>

        <div class="flex gap-6 p-6 max-w-7xl mx-auto">

            <!-- ===== LEFT PANEL ===== -->
            <div class="w-80">
                <div class="bg-white p-6 rounded-xl shadow sticky top-6">

                    <div class="bg-red-600 text-white p-5 rounded-xl mb-4 text-center">
                        <div id="timer" class="text-3xl font-bold"><%= timeInterval %>:00</div>
                        <p class="text-sm">Thời gian còn lại</p>
                    </div>

                    <div class="grid grid-cols-5 gap-2 mb-4">
                        <% for (int i = 1; i <= total; i++) { %>
                        <div onclick="showQuestion(<%= i %>)"
                             id="navBtn<%= i %>"
                             class="question-nav-btn w-10 h-10 border border-blue-600 text-blue-600 rounded flex items-center justify-center cursor-pointer">
                            <%= i %>
                        </div>
                        <% } %>
                    </div>


                    <button onclick="openModal()"
                            class="w-full bg-blue-600 text-white py-2 rounded">
                        Nộp bài
                    </button>
                </div>
            </div>

            <!-- ===== QUESTIONS ===== -->
            <div class="flex-1 bg-white p-8 rounded-xl shadow">
                <form id="testForm"
                      action="<%= request.getContextPath() %>/trainee/test"
                      method="post">

                    <!-- HIDDEN INPUTS QUAN TRỌNG -->
                    <input type="hidden" name="testId" value="${test.id}">
                    <input type="hidden" name="courseId" value="${test.courseId}">
                    <input type="hidden" name="sectionId" value="${test.courseSectionId}">

                    <%
                        int index = 1;
                        if (questions != null) {
                            for (Question question : questions) {
                    %>

                    <div id="q<%= index %>" class="question-block hidden" data-question="<%= index %>">

                        <h3 class="text-xl font-bold mb-4">
                            Câu <%= index %> / <%= total %>
                        </h3>

                        <p class="mb-4"><%= question.getContent() %></p>

                        <%
                            char c = 'A';
                            List<QuizAnswer> answers = question.getAnswers();
                            if (answers != null) {
                                for (QuizAnswer answer : answers) {
                        %>

                        <label class="answer-option block border p-3 rounded mb-2 cursor-pointer hover:bg-gray-50">
                            <input type="radio"
                                   name="answer_<%= question.getId() %>"
                                   value="<%= answer.getId() %>"
                                   onchange="markAnswered(<%= index %>)" />
                            <strong><%= c %>.</strong> <%= answer.getContent() %>
                        </label>

                        <%
                                    c++;
                                }
                            }
                        %>

                        <div class="flex justify-between mt-6">
                            <% if (index > 1) { %>
                            <button type="button"
                                    onclick="showQuestion(<%= index - 1 %>)"
                                    class="px-4 py-2 bg-gray-300 text-gray-700 rounded hover:bg-gray-400">
                                ← Câu trước
                            </button>
                            <% } else { %>
                            <div></div>
                            <% } %>

                            <% if (index < total) { %>
                            <button type="button"
                                    onclick="showQuestion(<%= index + 1 %>)"
                                    class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
                                Câu tiếp →
                            </button>
                            <% } %>
                        </div>
                    </div>

                    <%
                                index++;
                            }
                        }
                    %>

                </form>
            </div>
        </div>

        <!-- ===== MODAL ===== -->
        <div id="submitModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
            <div class="bg-white p-6 rounded-xl shadow-lg">
                <p class="text-lg font-semibold mb-4">Bạn chắc chắn nộp bài?</p>
                <div class="flex gap-3 mt-4">
                    <button onclick="closeModal()"
                            class="px-6 py-2 bg-gray-300 text-gray-700 rounded hover:bg-gray-400">
                        Hủy
                    </button>
                    <button onclick="submitTest()"
                            class="px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
                        Nộp
                    </button>
                </div>
            </div>
        </div>

        <jsp:include page="/layout/footer.jsp"/>

        <script>
            let currentQuestion = 1;
            let isSubmitting = false;
            const totalQuestions = <%= total %>;
            const timeLimit = <%= timeInterval %> * 60;
            let timeLeft = timeLimit;

            function updateTimer() {
                const minutes = Math.floor(timeLeft / 60);
                const seconds = timeLeft % 60;
                const timerElement = document.getElementById('timer');

                timerElement.textContent =
                        (minutes < 10 ? '0' : '') + minutes + ':' +
                        (seconds < 10 ? '0' : '') + seconds;

                if (timeLeft <= 60 && !timerElement.classList.contains('timer-warning')) {
                    timerElement.classList.add('timer-warning');
                }

                if (timeLeft <= 0) {
                    clearInterval(timerInterval);
                    alert('Hết thời gian! Bài thi sẽ được tự động nộp.');
                    isSubmitting = true;
                    document.getElementById('testForm').submit();
                }

                timeLeft--;
            }

            const timerInterval = setInterval(updateTimer, 1000);

            function showQuestion(i) {
                document.querySelectorAll('.question-nav-btn').forEach(btn => {
                    btn.classList.remove('current');
                });

                document.querySelectorAll(".question-block")
                        .forEach(q => q.classList.add("hidden"));

                document.getElementById("q" + i).classList.remove("hidden");
                document.getElementById('navBtn' + i).classList.add('current');

                currentQuestion = i;
            }

            function markAnswered(questionNum) {
                const navBtn = document.getElementById('navBtn' + questionNum);
                if (!navBtn.classList.contains('answered')) {
                    navBtn.classList.add('answered');
                }
            }

            function checkAnsweredQuestions() {
                for (let i = 1; i <= totalQuestions; i++) {
                    const questionBlock = document.getElementById('q' + i);
                    if (questionBlock) {
                        const radios = questionBlock.querySelectorAll('input[type="radio"]:checked');
                        if (radios.length > 0) {
                            markAnswered(i);
                        }
                    }
                }
            }

            showQuestion(1);
            checkAnsweredQuestions();

            function openModal() {
                document.getElementById("submitModal").classList.remove("hidden");
            }

            function closeModal() {
                document.getElementById("submitModal").classList.add("hidden");
            }

            function submitTest() {
                isSubmitting = true;
                clearInterval(timerInterval);
                document.getElementById('testForm').submit();
            }

            window.addEventListener('beforeunload', function (e) {
                if (!isSubmitting) {
                    e.preventDefault();
                    e.returnValue = 'Bạn có chắc muốn rời khỏi trang? Bài thi của bạn sẽ không được lưu.';
                }
            });
        </script>

    </body>
</html>