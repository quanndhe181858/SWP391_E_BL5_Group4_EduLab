<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><c:if test="${mode eq 'UPDATE'}">Chỉnh sửa</c:if><c:if test="${mode eq 'CREATE'}">Tạo mới</c:if> Bài Test</title>
    <style>
        /* CSS cơ bản */
        .container { width: 60%; margin: 20px auto; padding: 20px; border: 1px solid #ccc; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], textarea, select { width: 100%; padding: 8px; border: 1px solid #ddd; box-sizing: border-box; }
        .quiz-section { border: 1px solid #e0e0e0; padding: 15px; margin-top: 15px; }
    </style>
</head>
<body>
    <div class="container">
        <h1><c:if test="${mode eq 'UPDATE'}">Chỉnh sửa</c:if><c:if test="${mode eq 'CREATE'}">Tạo mới</c:if> Bài Test</h1>

        <form action="${pageContext.request.contextPath}/instructor/test" method="POST">
            <input type="hidden" name="action" value="save"/>
            <c:if test="${mode eq 'UPDATE'}">
                <input type="hidden" name="id" value="${test.id}"/>
            </c:if>

            <div class="form-group">
                <label for="testName">Test Name:</label>
                <input type="text" id="testName" name="testName" value="${test.title}" required/>
            </div>

            <div class="form-group">
                <label for="courseId">Course:</label>
                <select id="courseId" name="courseId" required>
                    <option value="">-- Chọn Khóa học --</option>
                    <%-- Đây là nơi list Course (từ CourseDAO) sẽ được đưa vào --%>
                    <option value="1">Software Engineer (Demo)</option>
                    <option value="2">DevOps (Demo)</option>
                </select>
            </div>

            <div class="form-group">
                <label for="numberOfQuizzes">Number of quizzes:</label>
                <input type="text" id="numberOfQuizzes" name="numberOfQuizzes" value="${test.numberOfQuizzes}" required/>
            </div>

            <div class="form-group">
                <label for="timeLimit">Time limit (minute):</label>
                <input type="text" id="timeLimit" name="timeLimit" value="${test.timeInterval}" required/>
            </div>
            
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="3">${test.description}</textarea>
            </div>

            <div class="quiz-section">
                <p>Chọn Quiz:</p>
                <button type="button" id="chooseQuizBtn">Choose Quizzes</button>
                <button type="button" id="randomQuizBtn">Random Quizzes</button>

                <div id="selectedQuizList" style="margin-top: 10px; border-top: 1px solid #eee; padding-top: 10px;">
                    <%-- Danh sách quiz được chọn sẽ hiển thị tại đây --%>
                    <p>Danh sách Quiz đã chọn sẽ hiển thị ở đây.</p>
                </div>
                
                <%-- Trường ẩn để gửi ID quiz về Servlet (dạng chuỗi "1,5,8") --%>
                <input type="hidden" id="chosenQuizzes" name="chosenQuizzes" value="1,2,3"/> 
            </div>
            
            <div class="form-group" style="margin-top: 20px;">
                <label>
                    <input type="checkbox" name="active" value="true" ${test.status eq 'Active' ? 'checked' : ''}> Active
                </label>
            </div>

            <button type="submit">Save</button>
        </form>
    </div>
    
    <%-- Sẽ cần JavaScript/AJAX để hiện thực chức năng chọn/random quiz --%>
</body>
</html>