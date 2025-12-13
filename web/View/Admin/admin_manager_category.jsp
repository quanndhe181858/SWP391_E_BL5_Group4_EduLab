<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Danh mục Khóa học - EduLAB</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <style>
        @keyframes fade-in {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fade-out {
            from {
                opacity: 1;
                transform: translateY(0);
            }
            to {
                opacity: 0;
                transform: translateY(-10px);
            }
        }

        .animate-fade-in {
            animation: fade-in 0.3s ease-out;
        }

        .animate-fade-out {
            animation: fade-out 0.3s ease-out;
        }
    </style>
    <body class="bg-gray-50">

        <jsp:include page="/layout/header.jsp"/>
        <div class="flex">

            <div class="w-64">
                <!-- SIDEBAR -->
                <jsp:include page="/layout/admin_sidebar.jsp"/>
            </div>

            <!-- MAIN CONTENT -->
            <main class="flex-1 p-8">
                <!-- HEADER -->
                <div class="mb-8">
                    <div class="flex items-center justify-between">
                        <div>
                            <h1 class="text-3xl font-bold text-gray-800">Quản lý Danh mục</h1>
                            <p class="text-gray-500 mt-1">Quản lý các danh mục khóa học của hệ thống</p>
                        </div>
                        <button onclick="openAddModal()" class="flex items-center gap-2 bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-all shadow-lg hover:shadow-xl">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                            </svg>
                            <span class="font-semibold">Thêm danh mục</span>
                        </button>
                    </div>
                </div>
                <!-- SEARCH AND FILTER -->
                <div class="bg-white rounded-xl shadow-sm p-6 mb-6 border border-gray-100">
                    <form action="${pageContext.request.contextPath}/manager_category" method="get"
                          class="flex flex-wrap gap-4 items-center">

                        <!-- SEARCH INPUT -->
                        <div class="flex-1 min-w-[300px]">
                            <div class="relative">
                                <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400"
                                     fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                                </svg>

                                <input
                                    type="text"
                                    name="keyword"
                                    value="${param.keyword}"
                                    placeholder="Tìm kiếm danh mục..."
                                    class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg
                                    focus:ring-2 focus:ring-blue-500 focus:border-transparent"/>
                            </div>
                        </div>

                        <!-- SEARCH BUTTON -->
                        <button type="submit"
                                class="flex items-center gap-2 bg-blue-600 text-white px-6 py-2.5
                                rounded-lg hover:bg-blue-700 transition-colors font-semibold">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                            </svg>
                            Tìm kiếm
                        </button>

                    </form>
                </div>

                <!-- CATEGORY TABLE -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                    <table id="datatablesSimple" class="w-full">
                        <thead class="bg-gray-50 border-b border-gray-200">
                            <tr>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                    STT
                                </th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Danh mục</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Mô tả</th>
                                <th class="px-6 py-4 text-center text-xs font-semibold text-gray-600 uppercase tracking-wider">Khóa học phụ thuộc   </th>
                                <th class="px-6 py-4 text-center text-xs font-semibold text-gray-600 uppercase tracking-wider">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">

                            <c:set var="stt" value="0"/>

                            <!-- LOOP PARENT -->
                            <c:forEach var="p" items="${parents}">
                                <c:set var="stt" value="${stt + 1}"/>

                                <!-- PARENT ROW -->
                                <tr class="bg-gray-50 font-semibold">
                                    <td class="px-6 py-4">${stt}</td>

                                    <td class="font-semibold text-gray-900 text-base">
                                        📁 ${p.name}
                                    </td>

                                    <td class="px-6 py-4 text-gray-600">
                                        ${p.description}
                                    </td>

                                    <td class="px-6 py-4 text-center">
                                        <span class="inline-flex items-center justify-center w-8 h-8
                                              bg-blue-100 text-blue-600 rounded-full font-semibold text-sm">
                                            ${countMap[p.id]}
                                        </span>
                                    </td>

                                    <td class="px-6 py-4">
                                        <div class="flex justify-center gap-2">
                                            <button
                                                onclick="openEditModal(${p.id}, '${p.name}', '${p.description}', 0)"
                                                class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg"
                                                title="Chỉnh sửa">
                                                ✏️
                                            </button>

                                            <button
                                                onclick="confirmDelete(${p.id}, '${p.name}')"
                                                class="p-2 text-red-600 hover:bg-red-50 rounded-lg"
                                                ${countMap[p.id] > 0 ? "disabled" : ""}>
                                                🗑️
                                            </button>
                                        </div>
                                    </td>
                                </tr>

                                <!-- CHILDREN -->
                                <c:forEach var="c" items="${childrenMap[p.id]}">
                                    <tr class="hover:bg-gray-50">
                                        <!-- KHÔNG STT CHO CON -->
                                        <td class="px-6 py-4 text-gray-400 text-center"></td>

                                        <td class="text-xs text-gray-600">
                                            └─ ${c.name}
                                        </td>

                                        <td class="px-6 py-4 text-gray-600">
                                            ${c.description}
                                        </td>

                                        <td class="px-6 py-4 text-center">
                                            <span class="inline-flex items-center justify-center w-8 h-8
                                                  bg-indigo-100 text-indigo-600 rounded-full font-semibold text-sm">
                                                ${countMap[c.id]}
                                            </span>
                                        </td>

                                        <td class="px-6 py-4">
                                            <div class="flex justify-center gap-2">
                                                <button
                                                    onclick="openEditModal(${c.id}, '${c.name}', '${c.description}', ${c.parent_id})"
                                                    class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg"
                                                    title="Chỉnh sửa">
                                                    ✏️
                                                </button>

                                                <button
                                                    onclick="confirmDelete(${c.id}, '${c.name}')"
                                                    class="p-2 text-red-600 hover:bg-red-50 rounded-lg"
                                                    ${countMap[c.id] > 0 ? "disabled" : ""}>
                                                    🗑️
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </c:forEach>

                        </tbody>

                    </table>
                </div>
            </main>
        </div>

        <!-- ADD/EDIT MODAL -->
        <div id="categoryModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
            <div class="bg-white rounded-2xl shadow-2xl w-full max-w-2xl mx-4 max-h-[90vh] overflow-y-auto">
                <!-- MODAL HEADER -->
                <div class="sticky top-0 bg-white border-b border-gray-200 px-6 py-4 flex items-center justify-between rounded-t-2xl">
                    <h2 id="modalTitle" class="text-2xl font-bold text-gray-800">Thêm danh mục mới</h2>
                    <button type="button" onclick="closeModal()" class="text-gray-400 hover:text-gray-600 transition-colors">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                        </svg>
                    </button>
                </div>

                <!-- MODAL FORM -->
                <form id="categoryForm" action="${pageContext.request.contextPath}/manager_category" method="post" class="p-6 space-y-6">
                    <!-- HIDDEN FIELDS -->
                    <input type="hidden" name="action" id="formAction" value="create">
                    <input type="hidden" name="id" id="categoryId" value="">

                    <!-- TÊN DANH MỤC -->
                    <div>
                        <label for="categoryName" class="block text-sm font-semibold text-gray-700 mb-2">
                            Tên danh mục <span class="text-red-500">*</span>
                        </label>
                        <input 
                            type="text" 
                            id="categoryName"
                            name="name" 
                            required
                            maxlength="255"
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-colors"
                            placeholder="Ví dụ: Lập trình Web">
                    </div>

                    <!-- MÔ TẢ -->
                    <div>
                        <label for="categoryDescription" class="block text-sm font-semibold text-gray-700 mb-2">
                            Mô tả
                        </label>
                        <textarea 
                            id="categoryDescription"
                            name="description" 
                            rows="4"
                            maxlength="500"
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-colors resize-none"
                            placeholder="Mô tả về danh mục này..."></textarea>
                        <p class="text-xs text-gray-500 mt-1">Tối đa 500 ký tự</p>
                    </div>
                    <!-- CATEGORY TYPE -->
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">
                            Loại danh mục <span class="text-red-500">*</span>
                        </label>

                        <div class="flex gap-6">
                            <label class="flex items-center gap-2 cursor-pointer">
                                <input type="radio" name="category_type" value="parent" checked
                                       onchange="toggleParentSelect()">
                                <span>Danh mục cha</span>
                            </label>

                            <label class="flex items-center gap-2 cursor-pointer">
                                <input type="radio" name="category_type" value="child"
                                       onchange="toggleParentSelect()">
                                <span>Danh mục con</span>
                            </label>
                        </div>
                    </div>

                    <div id="parentSelectWrapper" class="hidden">
                        <label for="categoryParentId" class="block text-sm font-semibold text-gray-700 mb-2">
                            Danh mục cha <span class="text-red-500">*</span>
                        </label>

                        <select 
                            id="categoryParentId"
                            name="parent_id"
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg
                            focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            <option value="">— Chọn danh mục cha —</option>
                            <c:forEach var="p" items="${parents}">
                                <c:if test="${p.parent_id == 0 && p.id != c.id}">
                                    <option value="${p.id}">${p.name}</option>
                                </c:if>
                            </c:forEach>

                        </select>
                    </div>

                    <!-- ACTION BUTTONS -->
                    <div class="flex gap-3 pt-4 border-t border-gray-200">
                        <button 
                            type="button" 
                            onclick="closeModal()"
                            class="flex-1 px-6 py-3 border border-gray-300 rounded-lg font-semibold text-gray-700 hover:bg-gray-50 transition-colors">
                            Hủy
                        </button>
                        <button 
                            type="submit"
                            id="submitBtn"
                            class="flex-1 px-6 py-3 bg-blue-600 text-white rounded-lg font-semibold hover:bg-blue-700 transition-colors">
                            Tạo danh mục
                        </button>
                    </div>
                </form>
            </div>
        </div>


        <script>
            function openAddModal() {
                document.getElementById("categoryForm").reset();
                document.getElementById("formAction").value = "create";
                document.getElementById("categoryId").value = "";
                document.getElementById("categoryName").value = "";
                document.getElementById("categoryDescription").value = "";

                document.querySelector("input[value='parent']").checked = true;
                toggleParentSelect();

                document.getElementById("modalTitle").textContent = "Thêm danh mục mới";
                document.getElementById("submitBtn").textContent = "Tạo danh mục";
                document.getElementById("categoryModal").classList.remove("hidden");
                setTimeout(() => {
                    document.getElementById("categoryName").focus();
                }, 100);
            }

            function openEditModal(id, name, description, parentId) {
                document.getElementById("formAction").value = "update";
                document.getElementById("categoryId").value = id;
                document.getElementById("categoryName").value = name || "";
                document.getElementById("categoryDescription").value = description || "";
                if (parentId && parentId > 0) {
                    document.querySelector("input[value='child']").checked = true;
                    toggleParentSelect();
                    document.getElementById("categoryParentId").value = parentId;
                } else {
                    document.querySelector("input[value='parent']").checked = true;
                    toggleParentSelect();
                }

                if (parentId === id) {
                    option.disabled = true;
                }

                document.getElementById("modalTitle").textContent = "Chỉnh sửa danh mục";
                document.getElementById("submitBtn").textContent = "Cập nhật";
                document.getElementById("categoryModal").classList.remove("hidden");
                setTimeout(() => {
                    document.getElementById("categoryName").focus();
                }, 100);
            }

            function closeModal() {
                document.getElementById("categoryModal").classList.add("hidden");
                document.getElementById("categoryForm").reset();
            }
            function toggleParentSelect() {
                const type = document.querySelector("input[name='category_type']:checked").value;
                const wrapper = document.getElementById("parentSelectWrapper");
                const parentSelect = document.getElementById("categoryParentId");

                if (type === "child") {
                    wrapper.classList.remove("hidden");
                    parentSelect.required = true;
                } else {
                    wrapper.classList.add("hidden");
                    parentSelect.required = false;
                    parentSelect.value = "";
                }
            }
            function confirmDelete(id, name) {
                if (confirm('Bạn có chắc chắn muốn xóa danh mục "' + name + '"?\n\nHành động này không thể hoàn tác!')) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/manager_category';
                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'delete';
                    const idInput = document.createElement('input');
                    idInput.type = 'hidden';
                    idInput.name = 'id';
                    idInput.value = id;

                    form.appendChild(actionInput);
                    form.appendChild(idInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            }

            document.addEventListener('DOMContentLoaded', function () {
                const modal = document.getElementById('categoryModal');

                modal.addEventListener('click', function (e) {
                    if (e.target === this) {
                        closeModal();
                    }
                });
                document.addEventListener('keydown', function (e) {
                    if (e.key === 'Escape' && !modal.classList.contains('hidden')) {
                        closeModal();
                    }
                });
            });

            window.addEventListener('DOMContentLoaded', () => {
                const table = document.getElementById('datatablesSimple');
                if (!table)
                    return;

                const dataTable = new simpleDatatables.DataTable(table, {
                    perPage: 5,
                    searchable: false,
                    perPageSelect: false,
                    labels: {
                        perPage: "dòng / trang",
                        noRows: "Không có dữ liệu",
                        info: "Hiển thị {start} - {end} của {rows} danh mục"
                    }
                });

                const searchInput = document.getElementById("searchInput");
                const sortSelect = document.getElementById("sortSelect");
                searchInput.addEventListener("input", function () {
                    const keyword = this.value.toLowerCase();

                    dataTable.search((row, rowIndex) => {
                        // cột "Danh mục" = index 1
                        const title = row.cells[1].innerText.toLowerCase();
                        return title.includes(keyword);
                    });
                });
                sortSelect.addEventListener("change", function () {
                    switch (this.value) {
                        case "az":
                            dataTable.columns().sort(1, "asc"); // Tên A-Z
                            break;

                        case "za":
                            dataTable.columns().sort(1, "desc"); // Tên Z-A
                            break;

                        case "most":
                            dataTable.columns().sort(3, "desc"); // Khóa học phụ thuộc
                            break;

                        default:
                            dataTable.columns().sort(0, "asc"); // Mới nhất (STT / id)
                    }
                });



                dataTable.on("datatable.page", updateSTT);
                dataTable.on("datatable.search", updateSTT);
                dataTable.on("datatable.sort", updateSTT);

            });

            window.addEventListener('DOMContentLoaded', () => {
            <c:if test="${not empty success}">
                showNotification('${success}', 'success');
            </c:if>

            <c:if test="${not empty error}">
                showNotification('${error}', 'error');
            </c:if>
            });
            function showNotification(message, type) {
                const bgColor = type === 'success' ? 'bg-green-500' : 'bg-red-500';
                const icon = type === 'success'
                        ? '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/></svg>'
                        : '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/></svg>';

                const notification = document.createElement('div');
                notification.className = `fixed top-4 right-4 \${bgColor} text-white px-6 py-3 rounded-lg shadow-lg z-[60] animate-fade-in flex items-center gap-2`;
                notification.innerHTML = icon + '<span>' + message + '</span>';
                document.body.appendChild(notification);

                setTimeout(() => {
                    notification.classList.add('animate-fade-out');
                    setTimeout(() => notification.remove(), 300);
                }, 3000);
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    </body>
</html>