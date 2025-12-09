<%-- 
    Document   : Certificate
    Created on : Dec 8, 2025, 9:22:19 PM
    Author     : vomin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/layout/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Certificate</title>
    <style>
        .certificate {
            width: 900px;
            margin: 40px auto;
            padding: 50px;
            border: 12px solid #2c3e50;
            background: white;
            text-align: center;
            font-family: "Times New Roman";
        }
        h1 {
            font-size: 40px;
        }
        .name {
            font-size: 30px;
            font-weight: bold;
            margin: 20px 0;
        }
        .course {
            font-size: 26px;
            color: #2980b9;
        }
        .date {
            margin-top: 30px;
            font-size: 18px;
        }
    </style>
</head>
<body>

<div class="certificate">
    <h1>CERTIFICATE OF COMPLETION</h1>

    <p>This is to certify that</p>

    <div class="name">${cert.userName}</div>

    <p>has successfully completed</p>

    <div class="course">${cert.courseTitle}</div>

    <p>${cert.accomplishmentTitle}</p>

    <div class="date">
        Issued at: ${cert.issuedAt}
    </div>
</div>

</body>
</html>

<%@include file="/layout/footer.jsp" %>
