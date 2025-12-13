<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/layout/header.jsp" />
<jsp:include page="/layout/import.jsp" />

<%
    Double rawScore = (Double) request.getAttribute("score");
    double score = (rawScore == null || Double.isNaN(rawScore)) ? 0.0 : rawScore;

    Boolean allowRetakeObj = (Boolean) request.getAttribute("allowRetake");
    boolean allowRetake = allowRetakeObj != null && allowRetakeObj;

    int testId = Integer.parseInt(request.getAttribute("testId").toString());
    boolean passed = Boolean.TRUE.equals(request.getAttribute("passed"));
%>

<style>
    .result-card {
        background: white;
        padding: 35px;
        border-radius: 16px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        width: 100%;
        max-width: 500px;
        text-align: center;
    }
    .score-circle {
        width: 130px;
        height: 130px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: auto;
        font-size: 32px;
        font-weight: bold;
        margin-bottom: 20px;
    }
    .score-pass {
        border: 6px solid #28a745;
        color: #28a745;
    }
    .score-fail {
        border: 6px solid #dc3545;
        color: #dc3545;
    }
    .main-btn {
        width: 100%;
        padding: 12px;
        font-size: 18px;
        border-radius: 10px;
        font-weight: 600;
        margin-top: 15px;
        cursor: pointer;
        border: none;
    }
    .btn-retake {
        background: #007bff;
        color: white;
    }
    .btn-back {
        background: #6c757d;
        color: white;
        display: block;
        text-decoration: none;
        line-height: 45px;
    }
</style>

<div class="min-h-screen flex justify-center items-center bg-gray-100">
    <!-- score, passed, allowRetake, testId đã có từ controller -->

    <div class="result-card">

        <div class="score-circle <%= passed ? "score-pass" : "score-fail" %>">
            <%= String.format("%.1f", score) %> / 10
        </div>

        <h2 class="<%= passed ? "text-green-600" : "text-red-600" %>">
            <%= passed ? "You passed!" : "You did not pass" %>
        </h2>

        <p>
            <%= passed ? "Congratulations!" : "You can retake the test if attempts remain." %>
        </p>

        <% if (!passed && allowRetake) { %>
        <form action="<%= request.getContextPath() %>/trainee/taketest" method="get">
            <input type="hidden" name="testId" value="<%= testId %>">
            <button class="main-btn btn-retake">Retake Test</button>
        </form>
        <% } %>

        <% if (passed) { %>
        <a href="<%= request.getContextPath() %>/trainee/view-certificate?testId=<%= testId %>"
           class="main-btn btn-retake" style="background: #28a745">
            View Certificate
        </a>

        <% } %>

        <a href="<%= request.getContextPath() %>/trainee/lesson-detail?testId=<%= testId %>"
           class="main-btn btn-back">
            Back to Lesson
        </a>

    </div>

</div>

<jsp:include page="/layout/footer.jsp" />
