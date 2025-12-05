<%-- 
    Document   : quizList
    Created on : Dec 5, 2024
    Author     : Le Minh Duc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Quiz"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz List - EduLab</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/quizList.css">
        <style>
.toast {
    visibility: hidden;
    min-width: 250px;
    background-color: #333;
    color: #fff;
    text-align: center;
    border-radius: 4px;
    padding: 16px;
    position: fixed;
    z-index: 1;
    left: 50%;
    bottom: 30px;
    transform: translateX(-50%);
}
.toast.show {
    visibility: visible;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}
.toast.error { background-color: #d9534f; }
.toast.success { background-color: #5cb85c; }

@keyframes fadein { from {bottom: 0; opacity: 0;} to {bottom: 30px; opacity: 1;} }
@keyframes fadeout { from {bottom: 30px; opacity: 1;} to {bottom: 0; opacity: 0;} }
</style>

    </head>
    <body>       
        <div class="container">
            <h1>Quiz Management</h1>

            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/instructor/quizes?action=add" class="btn">+ Add New Quiz</a>
                <div>
                    <span>Total Quizzes: <strong><%= request.getAttribute("totalQuizzes") != null ? request.getAttribute("totalQuizzes") : 0 %></strong></span>
                </div>
            </div>

            <%
                List<Quiz> quizList = (List<Quiz>) request.getAttribute("quizList");
                
                if (quizList != null && !quizList.isEmpty()) {
            %>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Question</th>
                        <th>Type</th>
                        <th>Category ID</th>
                        <th>Created At</th>
                        <th>Updated At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Quiz quiz : quizList) {
                    %>
                    <tr>
                        <td><%= quiz.getId() %></td>
                        <td>
                            <div class="quiz-question" title="<%= quiz.getQuestion() %>">
                                <%= quiz.getQuestion() %>
                            </div>
                        </td>
                        <td>
                            <span class="quiz-type"><%= quiz.getType() %></span>
                        </td>
                        <td><%= quiz.getCategory_id() %></td>
                        <td class="timestamp">
                            <%= quiz.getCreated_at() != null ? quiz.getCreated_at() : "N/A" %>
                        </td>
                        <td class="timestamp">
                            <%= quiz.getUpdated_at() != null ? quiz.getUpdated_at() : "N/A" %>
                        </td>
                        <td>
                            <div class="actions">
                                <a href="${pageContext.request.contextPath}/instructor/quizes?action=edit&id=<%= quiz.getId() %>" class="btn btn-edit">Edit</a>
                                <a href="${pageContext.request.contextPath}/instructor/quizes?action=delete&id=<%= quiz.getId() %>" 
                                   class="btn btn-delete" 
                                   onclick="return confirm('Are you sure you want to delete this quiz?')">
                                    Delete
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <%
                } else {
            %>

            <div class="no-data">
                <p>No quizzes found. Click "Add New Quiz" to create one.</p>
            </div>

            <%
                }
            %>
        </div>
        <% 
            String notification = (String) session.getAttribute("notification");
            String nType = (String) session.getAttribute("notificationType");
            if (notification != null) { 
        %>
        <div id="snackbar" class="toast <%= nType %>"><%= notification %></div>
        <script>
            var x = document.getElementById("snackbar");
            x.className += " show";
            setTimeout(function () {
                x.className = x.className.replace(" show", "");
            }, 3000);
        </script>
        <% 
            session.removeAttribute("notification");
            session.removeAttribute("notificationType");
            } 
        %>  
    </body>
</html>