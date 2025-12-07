<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <title>${course.title} - Learning</title>

        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background: #f9f9f9;
            }

            .wrapper {
                display: flex;
                height: 100vh;
            }

            /* Sidebar */
            .sidebar {
                width: 300px;
                background: #ffffff;
                border-right: 1px solid #ddd;
                padding: 20px;
                overflow-y: auto;
            }

            .sidebar h3 {
                margin-top: 0;
            }

            .lesson-item {
                padding: 10px 12px;
                margin-bottom: 8px;
                border-radius: 6px;
                display: block;
                text-decoration: none;
                color: #333;
            }

            .lesson-item:hover {
                background: #eee;
            }

            .active {
                background: #d1f5e0 !important;
                border-left: 5px solid #2ecc71;
            }

            .done-icon {
                float: right;
                font-weight: bold;
                color: #27ae60;
            }

            /* Content */
            .content {
                flex: 1;
                padding: 30px;
                overflow-y: auto;
            }

            .complete-btn {
                margin-top: 20px;
                padding: 10px 20px;
                background: #2ecc71;
                border: none;
                color: white;
                border-radius: 6px;
                cursor: pointer;
                font-size: 15px;
            }

            .complete-btn:hover {
                background: #25b863;
            }

            .video-frame {
                width: 80%;
                border-radius: 6px;
            }

            .lesson-title {
                font-size: 24px;
                margin-bottom: 10px;
                font-weight: bold;
            }

        </style>
    </head>

    <body>

        <div class="wrapper">

            <!-- Sidebar: Danh sách bài học -->
            <div class="sidebar">

                <h3>${course.title}</h3>
                <p style="color: gray;">Tiến độ khóa học</p>

                <!-- thanh progress -->
                <c:set var="total" value="${sections.size()}" />
                <c:set var="completed" value="0" />

                <c:forEach var="s" items="${sections}">
                    <c:if test="${progressMap[s.id] != null && progressMap[s.id].status == 'Completed'}">
                        <c:set var="completed" value="${completed + 1}" />
                    </c:if>
                </c:forEach>

                <c:set var="percent" value="${total == 0 ? 0 : (completed * 100 / total)}" />


                <div>
                    <b>${percent}% hoàn thành</b>
                    <div style="background:#ddd; height:8px; border-radius:4px;">
                        <div style="background:#2ecc71; height:8px; width:${percent}%"></div>
                    </div>
                </div>


                <hr>

                <!-- List lessons -->
                <c:forEach var="s" items="${sections}">
                    <c:set var="p" value="${progressMap[s.id]}" />

                    <a class="lesson-item ${s.id == current.id ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/learn?courseId=${course.id}&sectionId=${s.id}"
>

                        ${s.position}. ${s.title}

                        <c:if test="${p != null && p.status == 'Completed'}">
                            <span class="done-icon">✔</span>
                        </c:if>

                    </a>
                </c:forEach>

            </div>

            <!-- Main Content -->
            <div class="content">

                <h1 class="lesson-title">${current.title}</h1>
                <p style="color: gray;">${current.description}</p>

                <hr>

                <!-- Render nội dung theo loại -->
                <c:choose>

                    <c:when test="${current.type == 'text'}">
                        <div style="font-size: 17px; line-height: 1.6;">
                            ${current.content}
                        </div>
                    </c:when>

                    <c:when test="${current.type == 'image'}">
                        <img src="${current.content}" style="width: 70%; border-radius: 6px;">
                    </c:when>

                    <c:when test="${current.type == 'video'}">
                        <video controls class="video-frame">
                            <source src="${current.content}">
                        </video>
                    </c:when>

                </c:choose>

                <!-- Nút đánh dấu hoàn thành -->
                <br><br>
               <form method="POST" action="${pageContext.request.contextPath}/learn">
                    <input type="hidden" name="courseId" value="${course.id}">
                    <input type="hidden" name="sectionId" value="${current.id}">
                    <button class="complete-btn">✔ Đánh dấu hoàn thành</button>
                </form>

            </div>

        </div>

    </body>
</html>
