<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Question, model.QuizAnswer" %>

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
        user-select: none;
    }
    .question-box.answered {
        background: #007bff;
        color: white;
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
        cursor: pointer;
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
    .modal {
        position: fixed;
        inset: 0;
        background: rgba(0,0,0,0.4);
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .modal-box {
        background: white;
        padding: 25px;
        border-radius: 12px;
        width: 300px;
        text-align: center;
    }
    .modal-box button {
        margin: 10px;
        padding: 8px 16px;
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
            <%
                int stt = 1;
                for (Question q : qs) {
            %>
            <div class="question-box" id="box-<%= q.getId() %>"
                 onclick="showQuestion('<%= q.getId() %>')">
                <%= stt++ %>
            </div>
            <% } %>
        </div>

        <button class="submit-btn" onclick="openModal()">Submit</button>
    </div>


    <div class="test-content">
        <form id="testForm"
              action="${pageContext.request.contextPath}/trainee/submit-test"
              method="POST">

            <input type="hidden" name="testId"
                   value="<%= request.getAttribute("testId") %>">

            <%
                for (Question q : qs) {
            %>

            <div id="q<%= q.getId() %>" class="question-block">
                <h3>Question</h3>
                <p><%= q.getContent() %></p>

                <% for (QuizAnswer a : q.getAnswers()) { %>
                <%
    boolean isMultiple = "Multiple Choice".equalsIgnoreCase(q.getType());
    boolean isSingle   = "Single Choice".equalsIgnoreCase(q.getType());
                %>

                <label>
                    <input
                        type="<%= isMultiple ? "checkbox" : "radio" %>"
                        name="q<%= q.getId() %><%= isMultiple ? "[]" : "" %>"
                        value="<%= a.getId() %>"
                        onclick="markAnswered('<%= q.getId() %>')"
                        <%= isSingle ? "required" : "" %>
                        >
                    <%= a.getContent() %>
                </label><br>

                <% } %>

            </div>

            <% } %>

        </form>
    </div>
</div>


<div class="modal" id="submitModal" style="display:none;">
    <div class="modal-box">
        <p>Are you sure you want to submit?</p>
        <button onclick="submitTest()">Yes</button>
        <button onclick="closeModal()">No</button>
    </div>
</div>

<script>
    let submitted = false;

    function showQuestion(id) {
        document.querySelectorAll(".question-block")
                .forEach(q => q.classList.remove("active"));
        document.getElementById("q" + id).classList.add("active");
    }

    function markAnswered(id) {
        document.getElementById("box-" + id)
                .classList.add("answered");
    }

    function openModal() {
        document.getElementById("submitModal").style.display = "flex";
    }

    function closeModal() {
        document.getElementById("submitModal").style.display = "none";
    }

    function submitTest() {
        if (!submitted) {
            submitted = true;
            document.getElementById("testForm").submit();
        }
    }


    let totalSeconds = 10 * 60;

    let timer = setInterval(() => {
        let h = String(Math.floor(totalSeconds / 3600)).padStart(2, "0");
        let m = String(Math.floor((totalSeconds % 3600) / 60)).padStart(2, "0");
        let s = String(totalSeconds % 60).padStart(2, "0");

        document.getElementById("timer").innerText = h + ":" + m + ":" + s;
        totalSeconds--;

        if (totalSeconds < 0) {
            clearInterval(timer);
            submitTest();
        }
    }, 1000);

    <% if (qs != null && !qs.isEmpty()) { %>
    showQuestion("<%= qs.get(0).getId() %>");
    <% } %>
</script>

<jsp:include page="/layout/footer.jsp" />
