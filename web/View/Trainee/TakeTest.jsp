<%-- 
    Document   : TakeTest
    Created on : Dec 5, 2025
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Question, model.Answer" %>

<jsp:include page="/layout/header.jsp" />
<jsp:include page="/layout/import.jsp" />

<style>
    body {
        font-family: sans-serif;
        background: #f5f7fa;
    }
    .container-test {
        display: flex;
        width: 100%;
        min-height: 100vh;
        padding: 30px 40px;
        gap: 30px;
    }
    .test-sidebar {
        width: 300px;
        background: white;
        border: 1px solid #e3e3e3;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }
    .back-btn {
        font-size: 22px;
        text-decoration: none;
        color: #444;
        display: inline-block;
        margin-bottom: 15px;
    }
    .timer {
        font-size: 26px;
        text-align: center;
        font-weight: bold;
        margin-bottom: 20px;
        color: #d9534f;
    }
    .progress-wrapper {
        background: #eee;
        height: 10px;
        border-radius: 5px;
        margin-bottom: 20px;
    }
    #progress {
        height: 100%;
        width: 0%;
        background: #007bff;
        border-radius: 5px;
        transition: width .3s;
    }
    .question-grid {
        display: grid;
        grid-template-columns: repeat(5, 1fr);
        grid-gap: 10px;
    }
    .question-box {
        width: 42px;
        height: 42px;
        border: 1px solid #007bff;
        color: #007bff;
        border-radius: 8px;
        text-align: center;
        line-height: 42px;
        cursor: pointer;
        transition: .2s;
        font-weight: 600;
    }
    .question-box:hover {
        background: #e6f0ff;
    }
    .submit-btn {
        margin-top: 25px;
        width: 100%;
        padding: 12px;
        background: #007bff;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        transition: .2s;
    }
    .submit-btn:hover {
        background: #0056c2;
    }
    .test-content {
        flex: 1;
        background: white;
        border-radius: 12px;
        padding: 35px;
        border: 1px solid #e3e3e3;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }
    .question-block {
        display: none;
    }
    .question-block.active {
        display: block;
        animation: fadeIn .3s ease;
    }
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .answer-option {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
        gap: 8px;
        cursor: pointer;
    }
    /* MODAL */
    .modal {
        position: fixed;
        inset: 0;
        background: rgba(0,0,0,0.4);
        display: none;
        justify-content: center;
        align-items: center;
    }
    .modal-box {
        background: white;
        padding: 20px;
        width: 300px;
        text-align: center;
        border-radius: 12px;
    }
    .modal button {
        width: 45%;
        padding: 10px;
        border-radius: 8px;
        border: none;
        cursor: pointer;
        font-size: 15px;
        margin: 5px;
    }
    .modal .yes-btn { background: #28a745; color: white; }
    .modal .no-btn { background: #ccc; }
</style>

<%
    List<Question> qs = (List<Question>) request.getAttribute("questions");
    int total = qs.size();   // ❗ bỏ courseId
%>

<div class="container-test">

    <!-- LEFT SIDEBAR -->
    <div class="test-sidebar">
        <a href="javascript:history.back()" class="back-btn">⬅ Back</a>

        <div class="timer" id="timer">00:10:00</div>

        <div class="progress-wrapper">
            <div id="progress"></div>
        </div>

        <div class="question-grid">
            <% for (int k = 1; k <= total; k++) { %>
            <div class="question-box" onclick="showQuestion(<%=k%>)">
                <%= k %>
            </div>
            <% } %>
        </div>

        <button class="submit-btn" onclick="openModal()">Submit</button>
    </div>

    <!-- MAIN CONTENT -->
    <div class="test-content">
        <form id="testForm"
              action="${pageContext.request.contextPath}/trainee/submit-test"
              method="POST">

            <input type="hidden" name="testId" value="${testId}">
            <input type="hidden" name="total" value="<%= total %>">

            <%
                int index = 1;
                for (Question q : qs) {

                    int correctId = -1;
                    for (Answer a : q.getAnswers()) {
                        if (a.isCorrect()) {
                            correctId = a.getId();
                            break;
                        }
                    }
            %>

            <div id="q<%=index%>" class="question-block">
                <h2>Question <%= index %>:</h2>
                <p style="font-size: 17px; margin-bottom: 20px;"><%= q.getContent() %></p>

                <% for (Answer a : q.getAnswers()) { %>
                <label class="answer-option">
                    <input type="radio"
                           name="q<%=index%>"
                           value="<%= a.getId() %>">
                    <span><%= a.getContent() %></span>
                </label>
                <% } %>

                <!-- Hidden correct answer -->
                <input type="hidden" name="a<%= index %>" value="<%= correctId %>">
            </div>

            <%
                index++;
                }
            %>

        </form>
    </div>
</div>

<!-- MODAL -->
<div class="modal" id="submitModal">
    <div class="modal-box">
        <h3>Submit Test?</h3>
        <p>Are you sure you want to submit?</p>
        <button class="yes-btn" onclick="document.getElementById('testForm').submit()">Yes</button>
        <button class="no-btn" onclick="closeModal()">No</button>
    </div>
</div>

<script>
    function showQuestion(i) {
        document.querySelectorAll(".question-block")
            .forEach(el => el.classList.remove("active"));
        document.getElementById("q" + i).classList.add("active");
    }

    function openModal() {
        document.getElementById("submitModal").style.display = "flex";
    }

    function closeModal() {
        document.getElementById("submitModal").style.display = "none";
    }

    // TIMER
    let sec = 600;
    setInterval(() => {
        let h = String(Math.floor(sec / 3600)).padStart(2, "0");
        let m = String(Math.floor((sec % 3600) / 60)).padStart(2, "0");
        let s = String(sec % 60).padStart(2, "0");

        document.getElementById("timer").textContent = h+`:`+m+`:`+s;
        sec--;

        if (sec < 0) document.getElementById("testForm").submit();
    }, 1000);

    showQuestion(1);
</script>

<jsp:include page="/layout/footer.jsp" />
