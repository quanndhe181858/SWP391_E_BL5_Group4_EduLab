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
    </head>
    <body>
        <div class="container">
            <h1>Quiz Management</h1>
            
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/quiz?action=create" class="btn">+ Add New Quiz</a>
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
                                <a href="${pageContext.request.contextPath}/quiz?action=edit&id=<%= quiz.getId() %>" class="btn btn-edit">Edit</a>
                                <a href="${pageContext.request.contextPath}/quiz?action=delete&id=<%= quiz.getId() %>" 
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
    </body>
</html>