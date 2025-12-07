<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
    <title>${course.title} - Learning</title>

    <style>
        body { margin: 0; font-family: Arial; background: #f3f4f7; }
        .wrapper { display: flex; height: 100vh; }

        .sidebar {
            width: 300px; background: #fff; border-right: 1px solid #ddd;
            padding: 20px; overflow-y: auto;
        }
        .lesson-item { display: block; padding: 10px; border-radius: 6px; 
                       margin-bottom: 8px; color:#333; text-decoration:none; }
        .lesson-item:hover { background: #eee; }
        .active { background:#d1f5e0; border-left:5px solid #2ecc71; }
        .done-icon { float:right; color:#28a745; }

        .content { flex:1; padding:30px; overflow-y:auto; }
        .lesson-title { font-size:26px; font-weight:bold; }

        .image-frame { width:70%; margin-top:10px; border-radius:6px; }
        .video-frame { width:80%; margin-top:10px; border-radius:6px; }

        .complete-btn {
            margin-top:20px; padding:10px 20px;
            background:#2ecc71; color:white;
            border-radius:6px; border:none; cursor:pointer;
        }
        .complete-btn:hover { background:#27b864; }
    </style>
</head>

<body>

<div class="wrapper">

    <!-- SIDEBAR -->
    <div class="sidebar">

        <h3>${course.title}</h3>
        <c:set var="total" value="${fn:length(sections)}"/>
        <c:set var="completed" value="0"/>

        <c:forEach var="sec" items="${sections}">
            <c:if test="${progressMap[sec.id] != null && progressMap[sec.id].status == 'Completed'}">
                <c:set var="completed" value="${completed + 1}"/>
            </c:if>
        </c:forEach>

        <c:set var="percent" value="${total == 0 ? 0 : (completed * 100 / total)}"/>

        <div>
            <b>${percent}% hoàn thành</b>
            <div style="background:#ddd; height:8px; border-radius:4px;">
                <div style="background:#2ecc71; width:${percent}%; height:8px;"></div>
            </div>
        </div>

        <hr>

        <!-- DANH SÁCH BÀI HỌC -->
        <c:forEach var="s" items="${sections}">
            <a class="lesson-item ${s.id == current.id ? 'active' : ''}"
               href="${pageContext.request.contextPath}/learn?courseId=${course.id}&sectionId=${s.id}">
                ${s.position}. ${s.title}

                <c:if test="${progressMap[s.id] != null && progressMap[s.id].status == 'Completed'}">
                    <span class="done-icon">✔</span>
                </c:if>
            </a>
        </c:forEach>

    </div>

    <!-- MAIN CONTENT -->
    <div class="content">

        <h1 class="lesson-title">${current.title}</h1>
        <p style="color:gray;">${current.description}</p>
        <p>Loại bài học: <b>${current.type}</b></p>
        <hr>

        <!-- NỘI DUNG TEXT LUÔN HIỂN THỊ -->
        <div style="font-size:17px; line-height:1.6; margin-bottom:20px;">
            ${current.content}
        </div>

        <!-- MEDIA TABLE CONTROL -->
        <c:if test="${not empty mediaList}">
            <h3 style="margin-top:20px;">Tài nguyên đính kèm</h3>

            <c:forEach var="m" items="${mediaList}">

                <!-- IMAGE -->
                <c:if test="${fn:endsWith(m.path,'.jpg') 
                             || fn:endsWith(m.path,'.jpeg')
                             || fn:endsWith(m.path,'.png')}">
                    <img class="image-frame" 
                         src="${pageContext.request.contextPath}/${m.path}">
                </c:if>

                <!-- MP4 VIDEO -->
                <c:if test="${fn:endsWith(m.path,'.mp4')}">
                    <video controls class="video-frame">
                        <source src="${pageContext.request.contextPath}/${m.path}">
                    </video>
                </c:if>

                <!-- YOUTUBE LINK -->
                <c:if test="${fn:contains(m.path,'youtube.com')}">
                    <iframe width="80%" height="420"
                            src="https://www.youtube.com/embed/${fn:substringAfter(m.path,'v=')}"
                            frameborder="0" allowfullscreen></iframe>
                </c:if>

                <!-- PDF -->
                <c:if test="${fn:endsWith(m.path,'.pdf')}">
                    <a href="${pageContext.request.contextPath}/${m.path}" target="_blank">
                        📄 Tải file PDF
                    </a>
                </c:if>

            </c:forEach>

        </c:if>

        <!-- BUTTON COMPLETE -->
        <form method="POST" action="${pageContext.request.contextPath}/learn">
            <input type="hidden" name="courseId" value="${course.id}">
            <input type="hidden" name="sectionId" value="${current.id}">
            <button class="complete-btn">✔ Đánh dấu hoàn thành</button>
        </form>

    </div>

</div>

</body>
</html>
