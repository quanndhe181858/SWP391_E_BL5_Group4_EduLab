<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Import libraries (Tailwind, jQuery, Toastify, SweetAlert2) -->
<jsp:include page="/layout/import.jsp"/>

<body class="bg-gray-100">

    <!-- Header -->
    <jsp:include page="/layout/header.jsp"/>

    <div class="max-w-6xl mx-auto bg-white p-6 shadow rounded-lg mt-4">
        <h2 class="text-2xl font-bold mb-4">Danh sách bài Test</h2>

        <!-- Table hiển thị test -->
        <table class="min-w-full bg-white border">
            <thead class="bg-gray-200">
                <tr>
                    <th class="px-4 py-2 border">ID</th>
                    <th class="px-4 py-2 border">Tên bài Test</th>
                    <th class="px-4 py-2 border">Course</th>
                    <th class="px-4 py-2 border">Giảng viên</th>
                    <th class="px-4 py-2 border">Category</th>
                    <th class="px-4 py-2 border">Ngày tạo</th>
                    <th class="px-4 py-2 border text-center">Hành động</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach items="${listTest}" var="t">
                    <tr class="hover:bg-gray-50">
                        <td class="border px-4 py-2">${t.id}</td>
                        <td class="border px-4 py-2">${t.title}</td>
                        <td class="border px-4 py-2">${t.courseName}</td>
                        <td class="border px-4 py-2">${t.instructorName}</td>
                        <td class="border px-4 py-2">${t.categoryName}</td>
                        <td class="border px-4 py-2">${t.dateCreated}</td>

                        <!-- ACTION BUTTONS -->
                        <td class="border px-4 py-2 text-center">

                            <!-- Nút Update -->
                            <a href="updateTest?id=${t.id}"
                               class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded">
                                Update
                            </a>

                            <!-- Nút Delete -->
                            <a href="javascript:void(0)"
                               onclick="confirmDelete(${t.id})"
                               class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded ml-2">
                                Delete
                            </a>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Footer -->
    <jsp:include page="/layout/footer.jsp"/>

    <!-- Import bottom scripts -->
    <jsp:include page="/layout/importBottom.jsp"/>

</body>

<!-- SweetAlert2 Confirm Delete -->
<script>
    function confirmDelete(id) {
        Swal.fire({
            title: "Bạn chắc chắn muốn xóa?",
            text: "Hành động này không thể hoàn tác!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#e3342f",
            cancelButtonColor: "#6c757d",
            confirmButtonText: "Xóa"
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "/yourProject/instructor/deleteTest?id=" + id;
            }
        });
    }
</script>
