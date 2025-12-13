<%@page import="model.Quiz"%>
<%@page import="model.QuizAnswer"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Take Test</title>
        <jsp:include page="/layout/import.jsp" />
    </head>

    <body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">

        <%
            List<Quiz> quizList = (List<Quiz>) request.getAttribute("quizList");
            int total = quizList != null ? quizList.size() : 0;
        %>

        <jsp:include page="/layout/header.jsp"/>

        <div class="flex gap-6 p-6 max-w-7xl mx-auto">

            <!-- ===== LEFT PANEL ===== -->
            <div class="w-80">
                <div class="bg-white p-6 rounded-xl shadow sticky top-6">

                    <div class="bg-red-600 text-white p-5 rounded-xl mb-4 text-center">
                        <div id="timer" class="text-3xl font-bold">00:10:00</div>
                        <p class="text-sm">Thời gian còn lại</p>
                    </div>

                    <div class="grid grid-cols-5 gap-2 mb-4">
                        <% for (int i = 1; i <= total; i++) { %>
                        <div onclick="showQuestion(<%= i %>)"
                             class="w-10 h-10 border border-blue-600 text-blue-600 rounded flex items-center justify-center cursor-pointer">
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
                      action="<%= request.getContextPath() %>/trainee/submit-test"
                      method="post">

                    <!-- HIDDEN INPUTS QUAN TRỌNG -->
                    <input type="hidden" name="testId" value="${testId}">


                    <input type="hidden" name="courseId" value="${param.courseId}">
                    <input type="hidden" name="sectionId" value="${param.sectionId}">

                    <%
                        int index = 1;
                        for (Quiz quiz : quizList) {
                    %>

                    <div id="q<%= index %>" class="question-block hidden">

                        <h3 class="text-xl font-bold mb-4">
                            Câu <%= index %> / <%= total %>
                        </h3>

                        <p class="mb-4"><%= quiz.getQuestion() %></p>

                        <%
                            char c = 'A';
                            for (QuizAnswer a : quiz.getAnswers()) {
                        %>

                        <label class="block border p-3 rounded mb-2">
                            <input type="radio"
                                   name="q<%= quiz.getId() %>"
                                   value="<%= a.getId() %>" />
                            <strong><%= c %>.</strong> <%= a.getContent() %>
                        </label>

                        <%
                                c++;
                            }
                        %>
                    </div>

                    <%
                            index++;
                        }
                    %>

                </form>
            </div>
        </div>

        <!-- ===== MODAL ===== -->
        <div id="submitModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
            <div class="bg-white p-6 rounded">
                <p>Bạn chắc chắn nộp bài?</p>
                <div class="flex gap-3 mt-4">
                    <button onclick="closeModal()">Hủy</button>
                    <button onclick="document.getElementById('testForm').submit()">Nộp</button>
                </div>
            </div>
        </div>

        <jsp:include page="/layout/footer.jsp"/>

        <script>
            function showQuestion(i) {
                document.querySelectorAll(".question-block")
                        .forEach(q => q.classList.add("hidden"));
                document.getElementById("q" + i).classList.remove("hidden");
            }
            showQuestion(1);

            function openModal() {
                document.getElementById("submitModal").classList.remove("hidden");
            }
            function closeModal() {
                document.getElementById("submitModal").classList.add("hidden");
            }
        </script>

    </body>
</html>