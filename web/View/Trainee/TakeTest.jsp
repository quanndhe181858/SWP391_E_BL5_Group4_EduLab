<%@page import="model.QuizAnswer"%>
<%@ page import="java.util.*, model.Question, model.Answer" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Khoá học của tôi - Giảng viên</title>
        <jsp:include page="/layout/import.jsp" />
    </head>
    <body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
        <%
            List<Question> qs = (List<Question>) request.getAttribute("questions");
            int total = (qs != null) ? qs.size() : 0;
        %>

        <jsp:include page="/layout/header.jsp" />

        <div class="flex gap-6 p-6 max-w-7xl mx-auto">

            <div class="w-80 flex-shrink-0">
                <div class="bg-white rounded-xl shadow-xl border border-gray-200 p-6 sticky top-6">

                    <div class="bg-gradient-to-r from-red-500 to-red-600 rounded-xl p-6 mb-6 shadow-lg">
                        <div class="text-center">
                            <svg class="w-8 h-8 mx-auto mb-2 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            <div id="timer" class="text-4xl font-bold text-white tracking-wider">00:10:00</div>
                            <p class="text-red-100 text-sm mt-2">Thời gian còn lại</p>
                        </div>
                    </div>

                    <div class="mb-6">
                        <h3 class="text-sm font-bold text-gray-700 mb-4 flex items-center">
                            <svg class="w-5 h-5 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                            </svg>
                            Danh sách câu hỏi
                        </h3>
                        <div class="grid grid-cols-5 gap-2">
                            <% for (int i = 1; i <= total; i++) {%>
                            <div class="w-11 h-11 border-2 border-blue-500 text-blue-600 rounded-lg flex items-center justify-center font-bold cursor-pointer hover:bg-blue-50 transition-all hover:scale-105 active:scale-95" 
                                 onclick="showQuestion(<%= i%>)">
                                <%= i%>
                            </div>
                            <% }%>
                        </div>
                    </div>

                    <button class="w-full py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white font-bold rounded-lg hover:from-blue-700 hover:to-blue-800 transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 flex items-center justify-center" 
                            onclick="openModal()">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        Nộp bài
                    </button>

                    <div class="mt-6 p-4 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-lg border border-blue-200">
                        <div class="text-center">
                            <p class="text-sm text-gray-600 mb-1">Tổng số câu hỏi</p>
                            <p class="text-3xl font-bold text-blue-600"><%= total%></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="flex-1 bg-white rounded-xl shadow-xl border border-gray-200 p-8 min-h-screen">
                <form id="testForm"
                      action="${pageContext.request.contextPath}/trainee/submit-test"
                      method="POST">

                    <input type="hidden" name="testId" value="${testId}">

                    <%
                        int index = 1;
                        for (Question q : qs) {
                    %>

                    <div id="q<%= index%>" class="question-block hidden">
                        <div class="flex items-center justify-between mb-6 pb-4 border-b-2 border-gray-200">
                            <div class="flex items-center">
                                <div class="w-10 h-10 bg-gradient-to-r from-blue-600 to-blue-700 text-white rounded-lg flex items-center justify-center font-bold mr-4">
                                    <%= index%>
                                </div>
                                <h3 class="text-xl font-bold text-gray-800">Câu hỏi <%= index%></h3>
                            </div>
                            <span class="text-sm text-gray-500 bg-gray-100 px-3 py-1 rounded-full"><%= index%> / <%= total%></span>
                        </div>

                        <div class="mb-8">
                            <p class="text-lg text-gray-700 leading-relaxed"><%= q.getContent()%></p>
                        </div>

                        <div class="space-y-3">
                            <%
                                char letter = 'A';
                                for (QuizAnswer a : q.getAnswers()) {
                            %>
                            <label class="flex items-start p-4 border-2 border-gray-300 rounded-lg cursor-pointer hover:border-blue-500 hover:bg-blue-50 transition-all group">
                                <input type="radio" name="q<%= index%>" value="<%= a.getId()%>" 
                                       class="mt-1 w-5 h-5 text-blue-600 focus:ring-2 focus:ring-blue-500">
                                <div class="ml-4 flex-1">
                                    <div class="flex items-center">
                                        <span class="w-7 h-7 bg-gray-200 text-gray-700 rounded-full flex items-center justify-center font-bold text-sm mr-3 group-hover:bg-blue-600 group-hover:text-white transition-all">
                                            <%= letter%>
                                        </span>
                                        <span class="text-gray-700 group-hover:text-gray-900"><%= a.getContent()%></span>
                                    </div>
                                </div>
                            </label>
                            <%
                                    letter++;
                                }
                            %>
                        </div>

                        <div class="flex justify-between mt-8 pt-6 border-t-2 border-gray-200">
                            <% if (index > 1) {%>
                            <button type="button" onclick="showQuestion(<%= index - 1%>)" 
                                    class="px-6 py-3 bg-gray-200 text-gray-700 font-semibold rounded-lg hover:bg-gray-300 transition-all flex items-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                                </svg>
                                Câu trước
                            </button>
                            <% } else { %>
                            <div></div>
                            <% } %>

                            <% if (index < total) {%>
                            <button type="button" onclick="showQuestion(<%= index + 1%>)" 
                                    class="px-6 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white font-semibold rounded-lg hover:from-blue-700 hover:to-blue-800 transition-all flex items-center shadow-md hover:shadow-lg">
                                Câu sau
                                <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                            </button>
                            <% } %>
                        </div>
                    </div>

                    <%
                            index++;
                        }
                    %>

                </form>
            </div>
        </div>
        <div id="submitModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 backdrop-blur-sm">
            <div class="bg-white rounded-2xl shadow-2xl p-8 max-w-md w-full mx-4 transform transition-all">
                <div class="text-center mb-6">
                    <div class="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                        </svg>
                    </div>
                    <h3 class="text-2xl font-bold text-gray-800 mb-2">Xác nhận nộp bài</h3>
                    <p class="text-gray-600">Bạn có chắc chắn muốn nộp bài kiểm tra? Hành động này không thể hoàn tác.</p>
                </div>

                <div class="flex gap-4">
                    <button onclick="closeModal()" 
                            class="flex-1 px-6 py-3 bg-gray-200 text-gray-700 font-semibold rounded-lg hover:bg-gray-300 transition-all">
                        Hủy
                    </button>
                    <button onclick="document.getElementById('testForm').submit()" 
                            class="flex-1 px-6 py-3 bg-gradient-to-r from-green-600 to-green-700 text-white font-semibold rounded-lg hover:from-green-700 hover:to-green-800 transition-all shadow-lg hover:shadow-xl">
                        Nộp bài
                    </button>
                </div>
            </div>
        </div>
        <jsp:include page="/layout/footer.jsp" />

        <script>
            function showQuestion(i) {
                document.querySelectorAll(".question-block")
                        .forEach(q => q.classList.remove("block"));
                document.querySelectorAll(".question-block")
                        .forEach(q => q.classList.add("hidden"));
                const targetQuestion = document.getElementById("q" + i);
                targetQuestion.classList.remove("hidden");
                targetQuestion.classList.add("block");
                window.scrollTo({top: 0, behavior: 'smooth'});
            }

            function openModal() {
                document.getElementById("submitModal").classList.remove("hidden");
            }

            function closeModal() {
                document.getElementById("submitModal").classList.add("hidden");
            }

            let totalSeconds = 10 * 60;
            setInterval(() => {
                let h = String(Math.floor(totalSeconds / 3600)).padStart(2, "0");
                let m = String(Math.floor((totalSeconds % 3600) / 60)).padStart(2, "0");
                let s = String(totalSeconds % 60).padStart(2, "0");
                document.getElementById("timer").innerText = h + ":" + m + ":" + s;
                const timerEl = document.getElementById("timer");
                if (totalSeconds < 60) {
                    timerEl.parentElement.parentElement.classList.add("animate-pulse");
                }

                totalSeconds--;
                if (totalSeconds < 0) {
                    document.getElementById("testForm").submit();
                }
            }, 1000);
            showQuestion(1);
        </script>
    </body>
</html>