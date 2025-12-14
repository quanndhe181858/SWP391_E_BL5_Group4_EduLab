<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>My Accomplishments</title>
        <jsp:include page="/layout/import.jsp"/>
    </head>

    <body class="bg-slate-100">
        <%@include file="/layout/header.jsp"%>

        <div class="max-w-7xl mx-auto px-6 py-10">

            <!-- HEADER -->
            <div class="mb-8 flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                <div>
                    <h1 class="text-3xl font-bold text-slate-800">🎓 Thành tích học tập</h1>
                    <p class="text-slate-600 mt-1">
                        Theo dõi các khóa học bạn đã hoàn thành và đạt yêu cầu
                    </p>
                </div>

                <!-- SEARCH -->
                <div class="relative">
                    <input id="searchInput" type="text"
                           placeholder="Tìm khóa học..."
                           class="w-64 pl-10 pr-4 py-2 rounded-lg border border-slate-300
                           focus:outline-none focus:ring focus:ring-blue-200">
                    <span class="absolute left-3 top-2.5 text-slate-400">🔍</span>
                </div>
            </div>

            <!-- EMPTY -->
            <c:if test="${empty accomplishments}">
                <div class="bg-white rounded-xl shadow p-10 text-center text-slate-600">
                    Bạn chưa hoàn thành khóa học nào.
                </div>
            </c:if>

            <!-- TABLE -->
            <c:if test="${not empty accomplishments}">
                <div class="bg-white rounded-xl shadow overflow-hidden">

                    <!-- SORT BAR -->
                    <div class="flex items-center justify-between px-6 py-4 border-b bg-slate-50">
                        <div class="text-sm text-slate-600">
                            Tổng: <strong>${fn:length(accomplishments)}</strong> khóa học
                        </div>
                    </div>

                    <!-- DATA TABLE -->
                    <table class="w-full">
                        <thead class="bg-slate-100 border-b text-sm">
                            <tr>
                                <th class="px-6 py-4 text-left">Khóa học</th>
                                <th class="px-6 py-4 text-left">Ngày hoàn thành</th>
                                <th class="px-6 py-4 text-center">Điểm</th>
                                <th class="px-6 py-4 text-center">Trạng thái</th>
                                <th class="px-6 py-4 text-center">Chứng chỉ</th>
                            </tr>
                        </thead>

                        <tbody id="tableBody" class="divide-y text-sm">
                            <c:forEach var="c" items="${accomplishments}">
                                <tr class="ac-row hover:bg-slate-50 transition"
                                    data-title="${c.courseTitle}"
                                    data-date="${c.completedAt.time}"
                                    data-grade="${c.passedGrade}">

                                    <td class="px-6 py-4 font-medium">
                                        ${c.courseTitle}
                                    </td>

                                    <td class="px-6 py-4 text-slate-600">
                                        <fmt:formatDate value="${c.completedAt}" pattern="dd/MM/yyyy"/>
                                    </td>

                                    <td class="px-6 py-4 text-center font-semibold text-green-600">
                                        ${c.passedGrade}
                                    </td>

                                    <td class="px-6 py-4 text-center">
                                        <span class="px-3 py-1 rounded-full bg-green-100 text-green-700 font-semibold">
                                            Completed
                                        </span>
                                    </td>

                                    <td class="px-6 py-4 text-center">
                                        <a href="${pageContext.request.contextPath}/trainee/accomplishment-detail?courseId=${c.courseId}"
                                           class="text-blue-600 font-semibold hover:underline">
                                            Xem chi tiết
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- PAGINATION -->
                    <div class="flex justify-between items-center px-6 py-4 border-t text-sm">
                        <span id="pageInfo" class="text-slate-600"></span>
                        <div class="flex gap-2">
                            <button id="prevBtn" class="px-3 py-1 border rounded hover:bg-slate-100">
                                ← Trước
                            </button>
                            <button id="nextBtn" class="px-3 py-1 border rounded hover:bg-slate-100">
                                Sau →
                            </button>
                        </div>
                    </div>
                </div>
            </c:if>

        </div>



        <!-- ================= JS ================= -->
        <script>
            const rows = Array.from(document.querySelectorAll(".ac-row"));
            const pageSize = 5;
            let currentPage = 1;
            let filtered = [...rows];

            // Render
            function render() {
                rows.forEach(r => r.style.display = "none");

                const start = (currentPage - 1) * pageSize;
                const end = start + pageSize;
                filtered.slice(start, end).forEach(r => r.style.display = "");

                const totalPages = Math.max(1, Math.ceil(filtered.length / pageSize));
                document.getElementById("pageInfo").innerText =
                        "Trang " + currentPage + " / " + totalPages;

            }

            // Search
            document.getElementById("searchInput").addEventListener("input", e => {
                const q = e.target.value.toLowerCase();
                filtered = rows.filter(r =>
                    r.dataset.title.toLowerCase().includes(q)
                );
                currentPage = 1;
                render();
            });

            // Sort
            document.getElementById("sortSelect").addEventListener("change", e => {
                const v = e.target.value;
                filtered.sort((a, b) => {
                    switch (v) {
                        case "titleAsc":
                            return a.dataset.title.localeCompare(b.dataset.title);
                        case "titleDesc":
                            return b.dataset.title.localeCompare(a.dataset.title);
                        case "gradeAsc":
                            return a.dataset.grade - b.dataset.grade;
                        case "gradeDesc":
                            return b.dataset.grade - a.dataset.grade;
                        case "dateAsc":
                            return a.dataset.date - b.dataset.date;
                        default:
                            return b.dataset.date - a.dataset.date;
                    }
                });
                currentPage = 1;
                render();
            });

            // Pagination
            document.getElementById("prevBtn").onclick = () => {
                if (currentPage > 1) {
                    currentPage--;
                    render();
                }
            };
            document.getElementById("nextBtn").onclick = () => {
                if (currentPage < Math.ceil(filtered.length / pageSize)) {
                    currentPage++;
                    render();
                }
            };

            render();
        </script>
        <%@include file="/layout/footer.jsp"%>
    </body>
</html>
