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
    }
    .timer {
        font-size: 26px;
        text-align: center;
        font-weight: bold;
        margin-bottom: 20px;
        color: #d9534f;
    }
    .question-grid {
        display: grid;
        grid-template-columns: repeat(5, 1fr);
        gap: 10px;
    }
    .question-box {
        width: 42px;
        height: 42px;
        border: 1px solid #007bff;
        color: #007bff;
        border-radius: 8px;
        line-height: 42px;
        text-align: center;
        cursor: pointer;
    }
    .submit-btn {
        margin-top: 25px;
        width: 100%;
        padding: 12px;
        background: #007bff;
        color: white;
        border: none;
        border-radius: 8px;
        font-weight: bold;
    }
    .test-content {
        flex: 1;
        background: white;
        border-radius: 12px;
        padding: 35px;
        border: 1px solid #e3e3e3;
    }
    .question-block {
        display: none;
    }
    .question-block.active {
        display: block;
    }
</style>

<%
    List<Question> qs = (List<Question>) request.getAttribute("questions");
    int total = (qs != null) ? qs.size() : 0;
%>

<div class="container-test">

    <div class="test-sidebar">
        <div class="timer" id="timer">00:10:00</div>

        <div class="question-grid">
            <% for (int i = 1; i <= total; i++) { %>
            <div class="question-box" onclick="showQuestion(<%= i %>)">
                <%= i %>
            </div>
            <% } %>
        </div>

        <button class="submit-btn" onclick="openModal()">Submit</button>
    </div>

    <div class="test-content">
        <form id="testForm"
              action="${pageContext.request.contextPath}/trainee/submit-test"
              method="POST">

            <input type="hidden" name="testId" value="${testId}">

            <%
                int index = 1;
                for (Question q : qs) {
            %>

            <div id="q<%= index %>" class="question-block">
                <h3>Question <%= index %></h3>
                <p><%= q.getContent() %></p>

                <% for (Answer a : q.getAnswers()) { %>
                <label>
                    <input type="radio" name="q<%= index %>" value="<%= a.getId() %>">
                    <%= a.getContent() %>
                </label><br>
                <% } %>
            </div>

            <%
                index++;
                }
            %>

        </form>
    </div>
</div>

<!-- SUBMIT MODAL -->
<div class="modal" id="submitModal" style="display:none;">
    <button onclick="document.getElementById('testForm').submit()">Yes</button>
    <button onclick="closeModal()">No</button>
</div>

<script>
    function showQuestion(i) {
        document.querySelectorAll(".question-block")
                .forEach(q => q.classList.remove("active"));
        document.getElementById("q" + i).classList.add("active");
    }

    function openModal() {
        document.getElementById("submitModal").style.display = "block";
    }
    function closeModal() {
        document.getElementById("submitModal").style.display = "none";
    }

    /* ===== TIMER H:M:S ===== */

    let totalSeconds = 10 * 60; 

    setInterval(() => {
        let h = String(Math.floor(totalSeconds / 3600)).padStart(2, "0");
        let m = String(Math.floor((totalSeconds % 3600) / 60)).padStart(2, "0");
        let s = String(totalSeconds % 60).padStart(2, "0");

        document.getElementById("timer").innerText = h + ":" + m + ":" + s;
        totalSeconds--;

        if (totalSeconds < 0) {
            document.getElementById("testForm").submit();
        }
    }, 1000);

    showQuestion(1);
</script>

<jsp:include page="/layout/footer.jsp" />
