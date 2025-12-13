<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Danh mục Khóa học - EduLAB</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
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

                <!-- STATISTICS CARDS -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-gray-500 text-sm font-medium">Tổng danh mục</p>
                                <h3 class="text-3xl font-bold text-gray-800 mt-2">24</h3>
                            </div>
                            <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                                <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"/>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-gray-500 text-sm font-medium">Đang hoạt động</p>
                                <h3 class="text-3xl font-bold text-green-600 mt-2">18</h3>
                            </div>
                            <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
                                <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-gray-500 text-sm font-medium">Tạm ngưng</p>
                                <h3 class="text-3xl font-bold text-orange-600 mt-2">6</h3>
                            </div>
                            <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center">
                                <svg class="w-6 h-6 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 9v6m4-6v6m7-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-gray-500 text-sm font-medium">Khóa học</p>
                                <h3 class="text-3xl font-bold text-purple-600 mt-2">156</h3>
                            </div>
                            <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center">
                                <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- SEARCH AND FILTER -->
                <div class="bg-white rounded-xl shadow-sm p-6 mb-6 border border-gray-100">
                    <div class="flex flex-wrap gap-4">
                        <div class="flex-1 min-w-[300px]">
                            <div class="relative">
                                <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                                </svg>
                                <input type="text" placeholder="Tìm kiếm danh mục..." class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            </div>
                        </div>
                        <select class="px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            <option>Tất cả trạng thái</option>
                            <option>Đang hoạt động</option>
                            <option>Tạm ngưng</option>
                        </select>
                        <select class="px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            <option>Sắp xếp: Mới nhất</option>
                            <option>Tên A-Z</option>
                            <option>Tên Z-A</option>
                            <option>Nhiều khóa học nhất</option>
                        </select>
                    </div>
                </div>

                <!-- CATEGORY TABLE -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                    <table class="w-full">
                        <thead class="bg-gray-50 border-b border-gray-200">
                            <tr>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                                    <input type="checkbox" class="w-4 h-4 text-blue-600 rounded focus:ring-2 focus:ring-blue-500">
                                </th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Danh mục</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Mô tả</th>
                                <th class="px-6 py-4 text-center text-xs font-semibold text-gray-600 uppercase tracking-wider">Khóa học</th>
                                <th class="px-6 py-4 text-center text-xs font-semibold text-gray-600 uppercase tracking-wider">Trạng thái</th>
                                <th class="px-6 py-4 text-center text-xs font-semibold text-gray-600 uppercase tracking-wider">Ngày tạo</th>
                                <th class="px-6 py-4 text-center text-xs font-semibold text-gray-600 uppercase tracking-wider">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <!-- Row 1 -->
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-6 py-4">
                                    <input type="checkbox" class="w-4 h-4 text-blue-600 rounded focus:ring-2 focus:ring-blue-500">
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-3">
                                        <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-blue-600 rounded-lg flex items-center justify-center">
                                            <span class="text-white font-bold text-sm">LP</span>
                                        </div>
                                        <div>
                                            <p class="font-semibold text-gray-800">Lập trình</p>
                                            <p class="text-xs text-gray-500">programming</p>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <p class="text-sm text-gray-600 max-w-xs truncate">Các khóa học về lập trình và phát triển phần mềm</p>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <span class="inline-flex items-center justify-center w-8 h-8 bg-blue-100 text-blue-600 rounded-full font-semibold text-sm">42</span>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <span class="inline-flex px-3 py-1 text-xs font-semibold text-green-700 bg-green-100 rounded-full">Hoạt động</span>
                                </td>
                                <td class="px-6 py-4 text-center text-sm text-gray-600">15/01/2024</td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center justify-center gap-2">
                                        <button onclick="openEditModal(1)" class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors" title="Chỉnh sửa">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                            </svg>
                                        </button>
                                        <button onclick="confirmDelete(1)" class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors" title="Xóa">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                            </svg>
                                        </button>
                                    </div>
                                </td>
                            </tr>

                            <!-- Row 2 -->
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-6 py-4">
                                    <input type="checkbox" class="w-4 h-4 text-blue-600 rounded focus:ring-2 focus:ring-blue-500">
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-3">
                                        <div class="w-10 h-10 bg-gradient-to-br from-purple-500 to-purple-600 rounded-lg flex items-center justify-center">
                                            <span class="text-white font-bold text-sm">TK</span>
                                        </div>
                                        <div>
                                            <p class="font-semibold text-gray-800">Thiết kế</p>
                                            <p class="text-xs text-gray-500">design</p>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <p class="text-sm text-gray-600 max-w-xs truncate">Thiết kế đồ họa, UI/UX và các công cụ thiết kế</p>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <span class="inline-flex items-center justify-center w-8 h-8 bg-purple-100 text-purple-600 rounded-full font-semibold text-sm">28</span>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <span class="inline-flex px-3 py-1 text-xs font-semibold text-green-700 bg-green-100 rounded-full">Hoạt động</span>
                                </td>
                                <td class="px-6 py-4 text-center text-sm text-gray-600">18/01/2024</td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center justify-center gap-2">
                                        <button onclick="openEditModal(2)" class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors" title="Chỉnh sửa">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                            </svg>
                                        </button>
                                        <button onclick="confirmDelete(2)" class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors" title="Xóa">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                            </svg>
                                        </button>
                                    </div>
                                </td>
                            </tr>

                            <!-- Row 3 -->
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-6 py-4">
                                    <input type="checkbox" class="w-4 h-4 text-blue-600 rounded focus:ring-2 focus:ring-blue-500">
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-3">
                                        <div class="w-10 h-10 bg-gradient-to-br from-green-500 to-green-600 rounded-lg flex items-center justify-center">
                                            <span class="text-white font-bold text-sm">KD</span>
                                        </div>
                                        <div>
                                            <p class="font-semibold text-gray-800">Kinh doanh</p>
                                            <p class="text-xs text-gray-500">business</p>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <p class="text-sm text-gray-600 max-w-xs truncate">Quản trị kinh doanh, marketing và khởi nghiệp</p>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <span class="inline-flex items-center justify-center w-8 h-8 bg-green-100 text-green-600 rounded-full font-semibold text-sm">35</span>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <span class="inline-flex px-3 py-1 text-xs font-semibold text-orange-700 bg-orange-100 rounded-full">Tạm ngưng</span>
                                </td>
                                <td class="px-6 py-4 text-center text-sm text-gray-600">20/01/2024</td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center justify-center gap-2">
                                        <button onclick="openEditModal(3)" class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors" title="Chỉnh sửa">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                            </svg>
                                        </button>
                                        <button onclick="confirmDelete(3)" class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors" title="Xóa">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                            </svg>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- PAGINATION -->
                    <div class="px-6 py-4 border-t border-gray-200 flex items-center justify-between">
                        <p class="text-sm text-gray-600">
                            Hiển thị <span class="font-semibold">1</span> đến <span class="font-semibold">10</span> trong tổng số <span class="font-semibold">24</span> danh mục
                        </p>
                        <div class="flex gap-2">
                            <button class="px-3 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed" disabled>
                                Trước
                            </button>
                            <button class="px-3 py-2 bg-blue-600 text-white rounded-lg text-sm font-medium">1</button>
                            <button class="px-3 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50">2</button>
                            <button class="px-3 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50">3</button>
                            <button class="px-3 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50">
                                Sau
                            </button>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <!-- ADD/EDIT MODAL -->
        <div id="categoryModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
            <div class="bg-white rounded-2xl shadow-2xl w-full max-w-2xl mx-4 max-h-[90vh] overflow-y-auto">
                <div class="sticky top-0 bg-white border-b border-gray-200 px-6 py-4 flex items-center justify-between rounded-t-2xl">
                    <h2 class="text-2xl font-bold text-gray-800">Thêm danh mục mới</h2>
                    <button onclick="closeModal()" class="text-gray-400 hover:text-gray-600 transition-colors">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                        </svg>
                    </button>
                </div>

                <form class="p-6 space-y-6">
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Tên danh mục <span class="text-red-500">*</span></label>
                        <input type="text" required class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="Ví dụ: Lập trình Web">
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Slug <span class="text-red-500">*</span></label>
                        <input type="text" required class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="lap-trinh-web">
                        <p class="text-xs text-gray-500 mt-1">URL thân thiện cho danh mục (không dấu, viết thường)</p>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Mô tả</label>
                        <textarea rows="4" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="Mô tả về danh mục này..."></textarea>
                    </div>

                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Màu sắc</label>
                            <select class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                <option>Xanh dương</option>
                                <option>Xanh lá</option>
                                <option>Tím</option>
                                <option>Cam</option>
                                <option>Đỏ</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Trạng thái</label>
                            <select class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                <option>Hoạt động</option>
                                <option>Tạm ngưng</option>
                            </select>
                        </div>
                    </div>

                    <div class="flex items-center gap-2">
                        <input type="checkbox" id="featured" class="w-4 h-4 text-blue-600 rounded focus:ring-2 focus:ring-blue-500">
                        <label for="featured" class="text-sm font-medium text-gray-700">Hiển thị trên trang chủ</label>
                    </div>

                    <div class="flex gap-3 pt-4 border-t border-gray-200">
                        <button type="button" onclick="closeModal()" class="flex-1 px-6 py-3 border border-gray-300 rounded-lg font-semibold text-gray-700 hover:bg-gray-50 transition-colors">
                            Hủy
                        </button>
                        <button type="submit" class="flex-1 px-6 py-3 bg-blue-600 text-white rounded-lg font-semibold hover:bg-blue-700 transition-colors">
                            Lưu danh mục
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function openAddModal() {
                document.getElementById('categoryModal').classList.remove('hidden');
            }

            function openEditModal(id) {
                document.getElementById('categoryModal').classList.remove('hidden');
                // Load category data for editing
            }

            function closeModal() {
                document.getElementById('categoryModal').classList.add('hidden');
            }

            function confirmDelete(id) {
                if (confirm('Bạn có chắc chắn muốn xóa danh mục này?')) {
                    // Handle delete
                    alert('Đã xóa danh mục #' + id);
                }
            }

            // Close modal when clicking outside
            document.getElementById('categoryModal').addEventListener('click', function (e) {
                if (e.target === this) {
                    closeModal();
                }
            });
        </script>
    </body>
</html>