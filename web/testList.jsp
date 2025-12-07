<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý Bài Test</title>
    <style>
        /* CSS cơ bản cho bảng */
        body { font-family: Arial, sans-serif; }
        .container { width: 80%; margin: 20px auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .message-box { padding: 10px; margin-bottom: 15px; border-radius: 4px; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Quản lý Bài Test </h2>

        <%-- Hiển thị thông báo (nếu có) --%>
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="message-box success">${sessionScope.successMessage}</div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="message-box error">${sessionScope.errorMessage}</div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <a href="test?action=createForm" style="float: right; margin-bottom: 15px;">
            <button>+ Create a test</button>
        </a>

        <%-- Form Tìm kiếm/Lọc --%>
        <form action="test" method="GET" style="margin-bottom: 20px;">
            <input type="hidden" name="action" value="list"/>
            <input type="text" name="searchTitle" placeholder="Tìm theo Tên Test..." 
                   value="${searchTitle != null ? searchTitle : ''}" />
            
            <%-- Cần CourseDAO và logic ở Controller để đổ dữ liệu cho Category --%>
            <input type="text" name="categoryName" placeholder="Tìm theo Chuyên ngành..." 
                   value="${categoryName != null ? categoryName : ''}" />
            
            <button type="submit">Lọc/Tìm kiếm</button>
        </form>

        <%-- Bảng Danh sách Bài Test --%>
        <table>
            <thead>
                <tr>
                    <th>No</th>
                    <th>Course</th>
                    <th>Test Name</th>
                    <th>Instructor</th>
                    <th>Category</th>
                    <th>Date Created</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="test" items="${requestScope.listTest}" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td>${test.courseName}</td>
                        <td>${test.title}</td>
                        <td>${test.instructorName}</td>
                        <td>${test.categoryName}</td>
                        <td>${test.dateCreated}</td>
                        <td>
                            <a href="test?action=updateForm&id=${test.id}"><button>Update</button></a>
                            <button onclick="confirmDelete(${test.id}, '${test.title}')">Delete</button>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty requestScope.listTest}">
                     <tr><td colspan="7" style="text-align: center;">Không tìm thấy bài Test nào.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
    
    <%-- JavaScript cho chức năng Xóa --%>
    <script>
        function confirmDelete(id, title) {
            if (confirm("Bạn có chắc chắn muốn xóa bài Test: '" + title + "' không?")) {
                window.location.href = "test?action=delete&id=" + id;
            }
        }
    </script>
</body>
</html>