<%-- 
    Document   : addQuiz
    Created on : Dec 5, 2024
    Author     : Le Minh Duc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Quiz - EduLab</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/quizList.css">
    </head>
    <body>
        <div class="container">
            <div class="navigation-top">
                <a href="${pageContext.request.contextPath}/instructor/quizes?action=list" class="back-link">
                    &larr; Back to Quiz List
                </a>
            </div>
                    
            <h1>Add New Quiz</h1>            
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <div class="form-container">
                <form action="${pageContext.request.contextPath}/instructor/quizes  " method="POST">
                    <input type="hidden" name="action" value="create">
                    
                    <!-- Question Field -->
                    <div class="form-group">
                        <label for="question">
                            Question <span class="required">*</span>
                        </label>
                        <textarea 
                            id="question" 
                            name="question" 
                            required 
                            placeholder="Enter your quiz question here..."
                        ><%= request.getParameter("question") != null ? request.getParameter("question") : "" %></textarea>
                        <div class="help-text">Enter the complete question text</div>
                    </div>
                    
                    <!-- Type Field -->
                    <div class="form-group">
                        <label for="type">
                            Question Type <span class="required">*</span>
                        </label>
                        <select id="type" name="type" required>
                            <option value="">-- Select Question Type --</option>
                            <option value="Multiple Choice" 
                                <%= "Multiple Choice".equals(request.getParameter("type")) ? "selected" : "" %>>
                                Multiple Choice
                            </option>
                            <option value="True/False" 
                                <%= "True/False".equals(request.getParameter("type")) ? "selected" : "" %>>
                                True/False
                            </option>
                            <option value="Short Answer" 
                                <%= "Short Answer".equals(request.getParameter("type")) ? "selected" : "" %>>
                                Short Answer
                            </option>
                            <option value="Essay" 
                                <%= "Essay".equals(request.getParameter("type")) ? "selected" : "" %>>
                                Essay
                            </option>
                            <option value="Fill in the Blank" 
                                <%= "Fill in the Blank".equals(request.getParameter("type")) ? "selected" : "" %>>
                                Fill in the Blank
                            </option>
                            <option value="Matching" 
                                <%= "Matching".equals(request.getParameter("type")) ? "selected" : "" %>>
                                Matching
                            </option>
                        </select>
                        <div class="help-text">Select the type of question</div>
                    </div>
                    
                    <!-- Category Field -->
                    <div class="form-group">
                        <label for="categoryId">
                            Category <span class="required">*</span>
                        </label>
                        <select id="categoryId" name="categoryId" required>
                            <option value="">-- Select Category --</option>
                            <option value="1" 
                                <%= "1".equals(request.getParameter("categoryId")) ? "selected" : "" %>>
                                Programming
                            </option>
                            <option value="2" 
                                <%= "2".equals(request.getParameter("categoryId")) ? "selected" : "" %>>
                                Mathematics
                            </option>
                            <option value="3" 
                                <%= "3".equals(request.getParameter("categoryId")) ? "selected" : "" %>>
                                Science
                            </option>
                            <option value="4" 
                                <%= "4".equals(request.getParameter("categoryId")) ? "selected" : "" %>>
                                History
                            </option>
                            <option value="5" 
                                <%= "5".equals(request.getParameter("categoryId")) ? "selected" : "" %>>
                                Language Arts
                            </option>
                            <option value="6" 
                                <%= "6".equals(request.getParameter("categoryId")) ? "selected" : "" %>>
                                Business
                            </option>
                        </select>
                        <div class="help-text">Choose the category this quiz belongs to</div>
                    </div>
                    
                    <!-- Form Actions -->
                    <div class="form-actions">
                        <button type="submit" class="btn btn-submit">
                            Create Quiz
                        </button>
                        <a href="${pageContext.request.contextPath}/instructor/quizes?action=list" 
                           class="btn btn-cancel">
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>