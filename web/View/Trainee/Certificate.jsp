<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chứng Chỉ Của Tôi</title>
        <jsp:include page="/layout/import.jsp" />
        <style>
            .pagination-btn {
                padding: 0.25rem 0.75rem;
                border-radius: 0.375rem;
                border: 1px solid;
            }
            .pagination-btn.active {
                background-color: #2563eb;
                color: white;
                border-color: #2563eb;
            }
            .pagination-btn:not(.active) {
                background-color: white;
                color: #334155;
                border-color: #cbd5e1;
            }
            .pagination-btn:not(.active):hover {
                background-color: #f8fafc;
            }
            .pagination-btn:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }
        </style>
    </head>
    <body class="bg-slate-100">
        <%@include file="/layout/header.jsp" %>
        <div class="max-w-7xl mx-auto px-6 py-12">
            <!-- TIÊU ĐỀ -->
            <h1 class="text-3xl font-bold text-slate-800 mb-8">
                🎓 Chứng Chỉ Của Tôi
            </h1>

            <!-- THANH TÌM KIẾM & BỘ LỌC -->
            <div class="bg-white rounded-xl shadow p-6 mb-6">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <!-- Tìm kiếm -->
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-2">
                            Tìm Kiếm Mã Chứng Chỉ
                        </label>
                        <input 
                            type="text" 
                            id="searchInput"
                            placeholder="Nhập mã chứng chỉ..."
                            class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            />
                    </div>

                    <!-- Sắp xếp -->
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-2">
                            Sắp Xếp Theo
                        </label>
                        <select 
                            id="sortSelect"
                            class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            >
                            <option value="date-desc">Mới nhất trước</option>
                            <option value="date-asc">Cũ nhất trước</option>
                            <option value="code-asc">Mã (A-Z)</option>
                            <option value="code-desc">Mã (Z-A)</option>
                        </select>
                    </div>

                    <!-- Số lượng trên mỗi trang -->
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-2">
                            Số Lượng Mỗi Trang
                        </label>
                        <select 
                            id="itemsPerPage"
                            class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            >
                            <option value="4">4</option>
                            <option value="8">8</option>
                            <option value="12">12</option>
                            <option value="all">Tất cả</option>
                        </select>
                    </div>
                </div>

                <!-- Thông tin kết quả -->
                <div class="mt-4 flex items-center justify-between">
                    <p class="text-sm text-slate-600">
                        Đang hiển thị <span id="showingCount" class="font-semibold">0</span> 
                        trong tổng số <span id="totalCount" class="font-semibold">0</span> chứng chỉ
                    </p>
                    <button 
                        id="resetBtn"
                        class="text-sm text-blue-600 hover:text-blue-700 font-medium"
                        >
                        Đặt Lại Bộ Lọc
                    </button>
                </div>
            </div>

            <!-- TRẠNG THÁI TRỐNG -->
            <div id="emptyState" class="bg-white p-10 rounded-xl shadow text-center text-slate-500 hidden">
                <svg class="w-16 h-16 mx-auto mb-4 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                </svg>
                <p class="text-lg font-medium mb-2">Không tìm thấy chứng chỉ</p>
                <p class="text-sm">Thử điều chỉnh từ khóa tìm kiếm hoặc bộ lọc</p>
            </div>

            <!-- THÔNG BÁO CHƯA CÓ CHỨNG CHỈ -->
            <div id="noCertificates" class="bg-white p-10 rounded-xl shadow text-center text-slate-500 hidden">
                <svg class="w-16 h-16 mx-auto mb-4 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                </svg>
                <p class="text-lg font-medium">Bạn chưa có chứng chỉ nào.</p>
            </div>

            <!-- DANH SÁCH CHỨNG CHỈ -->
            <div id="certificateGrid" class="space-y-4">
                <!-- Các chứng chỉ sẽ được render ở đây bởi JavaScript -->
            </div>

            <!-- PHÂN TRANG -->
            <div id="paginationContainer" class="mt-8 flex justify-center items-center gap-2 hidden">
                <button id="prevBtn" class="pagination-btn">
                    « Trước
                </button>
                <div id="pageNumbers" class="flex gap-2">
                    <!-- Số trang sẽ được chèn vào đây -->
                </div>
                <button id="nextBtn" class="pagination-btn">
                    Sau »
                </button>
            </div>
        </div>
        <%@include file="/layout/footer.jsp" %>

        <script>
            // Dữ liệu chứng chỉ từ server
            const allCertificates = [
            <c:forEach var="c" items="${certificates}" varStatus="status">
            {
            id: '${c.id}',
                    certificateCode: '${c.certificateCode}',
                    issuedAt: '${c.issuedAt}',
                    issuedAtRaw: new Date('${c.issuedAt}').getTime()
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
            ];

            // Quản lý trạng thái
            let state = {
                allCertificates: allCertificates,
                filteredCertificates: [...allCertificates],
                currentPage: 1,
                itemsPerPage: 4,
                searchTerm: '',
                sortBy: 'date-desc'
            };

            // Khởi tạo
            function init() {
                if (allCertificates.length === 0) {
                    document.getElementById('noCertificates').classList.remove('hidden');
                    return;
                }

                updateDisplay();
                attachEventListeners();
            }

            // Gắn sự kiện
            function attachEventListeners() {
                // Tìm kiếm
                document.getElementById('searchInput').addEventListener('input', debounce((e) => {
                    state.searchTerm = e.target.value.toLowerCase();
                    state.currentPage = 1;
                    filterAndSort();
                }, 300));

                // Sắp xếp
                document.getElementById('sortSelect').addEventListener('change', (e) => {
                    state.sortBy = e.target.value;
                    filterAndSort();
                });

                // Số lượng mỗi trang
                document.getElementById('itemsPerPage').addEventListener('change', (e) => {
                    state.itemsPerPage = e.target.value === 'all' ? state.filteredCertificates.length : parseInt(e.target.value);
                    state.currentPage = 1;
                    updateDisplay();
                });

                // Đặt lại
                document.getElementById('resetBtn').addEventListener('click', () => {
                    document.getElementById('searchInput').value = '';
                    document.getElementById('sortSelect').value = 'date-desc';
                    document.getElementById('itemsPerPage').value = '4';
                    state.searchTerm = '';
                    state.sortBy = 'date-desc';
                    state.itemsPerPage = 4;
                    state.currentPage = 1;
                    filterAndSort();
                });

                // Phân trang
                document.getElementById('prevBtn').addEventListener('click', () => {
                    if (state.currentPage > 1) {
                        state.currentPage--;
                        updateDisplay();
                    }
                });

                document.getElementById('nextBtn').addEventListener('click', () => {
                    const totalPages = Math.ceil(state.filteredCertificates.length / state.itemsPerPage);
                    if (state.currentPage < totalPages) {
                        state.currentPage++;
                        updateDisplay();
                    }
                });
            }

            // Lọc và sắp xếp
            function filterAndSort() {
                // Lọc
                state.filteredCertificates = state.allCertificates.filter(cert => {
                    return cert.certificateCode.toLowerCase().includes(state.searchTerm);
                });

                // Sắp xếp
                state.filteredCertificates.sort((a, b) => {
                    switch (state.sortBy) {
                        case 'date-desc':
                            return b.issuedAtRaw - a.issuedAtRaw;
                        case 'date-asc':
                            return a.issuedAtRaw - b.issuedAtRaw;
                        case 'code-asc':
                            return a.certificateCode.localeCompare(b.certificateCode);
                        case 'code-desc':
                            return b.certificateCode.localeCompare(a.certificateCode);
                        default:
                            return 0;
                    }
                });

                updateDisplay();
            }

            // Cập nhật hiển thị
            function updateDisplay() {
            const grid = document.getElementById('certificateGrid');
                    const emptyState = document.getElementById('emptyState');
                    const paginationContainer = document.getElementById('paginationContainer');
                    // Cập nhật số lượng
                    document.getElementById('totalCount').textContent = state.filteredCertificates.length;
                    // Kiểm tra nếu không có kết quả
                    if (state.filteredCertificates.length === 0) {
            grid.innerHTML = '';
                    emptyState.classList.remove('hidden');
                    paginationContainer.classList.add('hidden');
                    document.getElementById('showingCount').textContent = '0';
                    return;
            }

            emptyState.classList.add('hidden');
                    // Phân trang
                    const startIndex = (state.currentPage - 1) * state.itemsPerPage;
                    const endIndex = startIndex + state.itemsPerPage;
                    const paginatedCertificates = state.filteredCertificates.slice(startIndex, endIndex);
                    // Cập nhật số lượng đang hiển thị
                    document.getElementById('showingCount').textContent = paginatedCertificates.length;
                    // Render chứng chỉ (1 chứng chỉ/dòng)
                    grid.innerHTML = paginatedCertificates.map(cert => `
                            <div class="bg-white rounded-xl shadow hover:shadow-lg transition p-6">
                                        <div class="flex items-center justify-between gap-6">
                                        <!-- Icon chứng chỉ -->
                                        <div class="flex-shrink-0">
                                        <div class="w-16 h-16 bg-blue-100 rounded-lg flex items-center justify-center">
                                        <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"></path>
                                    </svg>
                                </div>
                            </div>
                            
                            <!-- Thông tin chứng chỉ -->
                            <div class="flex-grow">
                                <div class="flex items-center gap-2 mb-2">
                                    <span class="text-xs font-medium text-blue-600 bg-blue-50 px-2 py-1 rounded">
                                        Chứng chỉ
                                    </span>
                                </div>
                                <h3 class="text-lg font-bold text-slate-800 mb-1">
                                    \${cert.certificateCode}
                                </h3>
                                <div class="flex items-center text-sm text-slate-600">
                                    <svg class="w-4 h-4 mr-1.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                    </svg>
                                    Ngày cấp: <span class="font-medium ml-1">\${cert.issuedAt}</span>
                                </div>
                            </div>
                            
                            <!-- Nút hành động -->
                            <div class="flex-shrink-0 flex gap-3">
                                <a href="${pageContext.request.contextPath}/trainee/certificate/view?id=\${cert.id}"
                                   class="inline-flex items-center px-4 py-2 bg-blue-600 text-white text-sm font-semibold rounded-lg hover:bg-blue-700 transition">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                    </svg>
                                    Xem
                                </a>
                                <a href="${pageContext.request.contextPath}/trainee/certificate/download?id=\${cert.id}"
                                   class="inline-flex items-center px-4 py-2 bg-slate-200 text-slate-800 text-sm font-semibold rounded-lg hover:bg-slate-300 transition">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path>
                                    </svg>
                                    Tải xuống
                                </a>
                            </div>
                        </div>
                    </div>
                `).join('');

                // Cập nhật phân trang
                updatePagination();
            }

            // Cập nhật phân trang
            function updatePagination() {
                const totalPages = Math.ceil(state.filteredCertificates.length / state.itemsPerPage);
                const paginationContainer = document.getElementById('paginationContainer');
                const pageNumbers = document.getElementById('pageNumbers');
                const prevBtn = document.getElementById('prevBtn');
                const nextBtn = document.getElementById('nextBtn');

                if (totalPages <= 1) {
                    paginationContainer.classList.add('hidden');
                    return;
                }

                paginationContainer.classList.remove('hidden');

                // Cập nhật nút trước/sau
                prevBtn.disabled = state.currentPage === 1;
                nextBtn.disabled = state.currentPage === totalPages;

                if (state.currentPage === 1) {
                    prevBtn.classList.add('opacity-50', 'cursor-not-allowed');
                } else {
                    prevBtn.classList.remove('opacity-50', 'cursor-not-allowed');
                }

                if (state.currentPage === totalPages) {
                    nextBtn.classList.add('opacity-50', 'cursor-not-allowed');
                } else {
                    nextBtn.classList.remove('opacity-50', 'cursor-not-allowed');
                }

                // Tạo số trang
                let pages = [];
                if (totalPages <= 7) {
                    pages = Array.from({length: totalPages}, (_, i) => i + 1);
                } else {
                    if (state.currentPage <= 4) {
                        pages = [1, 2, 3, 4, 5, '...', totalPages];
                    } else if (state.currentPage >= totalPages - 3) {
                        pages = [1, '...', totalPages - 4, totalPages - 3, totalPages - 2, totalPages - 1, totalPages];
                    } else {
                        pages = [1, '...', state.currentPage - 1, state.currentPage, state.currentPage + 1, '...', totalPages];
                    }
                }

                pageNumbers.innerHTML = pages.map(page => {
                    if (page === '...') {
                        return '<span class="px-3 py-1 text-slate-500">...</span>';
                    }
                    const activeClass = page === state.currentPage ? 'active' : '';
                    return `
                        <button 
                            class="pagination-btn \${activeClass}"
                            onclick="goToPage(\${page})"
                        >
                            \${page}
                        </button>
                    `;
                }).join('');
            }

            // Chuyển trang
            function goToPage(page) {
                state.currentPage = page;
                updateDisplay();
                window.scrollTo({top: 0, behavior: 'smooth'});
            }

            // Hàm debounce
            function debounce(func, wait) {
                let timeout;
                return function executedFunction(...args) {
                    const later = () => {
                        clearTimeout(timeout);
                        func(...args);
                    };
                    clearTimeout(timeout);
                    timeout = setTimeout(later, wait);
                };
            }

            // Chạy khi trang tải xong
            document.addEventListener('DOMContentLoaded', init);
        </script>
    </body>
</html>