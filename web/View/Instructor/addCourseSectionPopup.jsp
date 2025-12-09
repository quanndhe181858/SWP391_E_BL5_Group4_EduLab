<%-- 
    Document   : addCourseSectionPopup
    Created on : Dec 7, 2025, 2:22:06 PM
    Author     : quan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="addSectionModal" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50" style="display: none;">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-2xl mx-4 max-h-[90vh] overflow-y-auto">
        <div class="sticky top-0 bg-white border-b border-gray-200 px-6 py-4 flex items-center justify-between">
            <h2 class="text-2xl font-bold text-gray-900">Thêm bài học mới</h2>
            <button type="button" onclick="closeAddSectionModal()" class="text-gray-400 hover:text-gray-600 transition">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </button>
        </div>

        <form id="addSectionForm" class="p-6 space-y-5">
            <div>
                <label for="sectionTitle" class="block text-sm font-semibold text-gray-700 mb-2">
                    Tên bài học <span class="text-red-500">*</span>
                </label>
                <input 
                    type="text" 
                    id="sectionTitle" 
                    name="title"
                    maxlength="200"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                    placeholder="Nhập tên bài học..."
                    required>
                <p class="text-xs text-gray-500 mt-1">
                    <span id="sectionTitleCount">0</span>/200 ký tự
                </p>
            </div>

            <div>
                <label for="sectionDescription" class="block text-sm font-semibold text-gray-700 mb-2">
                    Mô tả bài học <span class="text-red-500">*</span>
                </label>
                <textarea 
                    id="sectionDescription" 
                    name="description"
                    rows="3"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                    placeholder="Mô tả ngắn gọn về bài học..."
                    required></textarea>
            </div>

            <div>
                <label for="sectionType" class="block text-sm font-semibold text-gray-700 mb-2">
                    Thể loại <span class="text-red-500">*</span>
                </label>
                <select 
                    id="sectionType" 
                    name="type"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white"
                    required
                    onchange="handleTypeChange()">
                    <option value="">Chọn thể loại</option>
                    <option value="text">Text (Chỉ văn bản)</option>
                    <option value="image">Image (Văn bản + Hình ảnh)</option>
                    <option value="video">Video (Văn bản + Video)</option>
                </select>
            </div>

            <!-- Content Section - Always visible and required -->
            <div>
                <label for="sectionContent" class="block text-sm font-semibold text-gray-700 mb-2">
                    Nội dung bài học <span class="text-red-500">*</span>
                </label>
                <textarea 
                    id="sectionContent" 
                    name="content"
                    rows="6"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                    placeholder="Nhập nội dung chi tiết của bài học..."
                    required></textarea>
                <p class="text-xs text-gray-500 mt-1">Nội dung văn bản là bắt buộc cho mọi loại bài học</p>
            </div>

            <!-- Image Upload (Only for Image type) -->
            <div id="imageUploadSection" class="hidden">
                <label class="block text-sm font-semibold text-gray-700 mb-2">
                    Đính kèm hình ảnh <span class="text-red-500">*</span>
                </label>
                <div class="space-y-3">
                    <div id="imagePreviewContainer" class="hidden">
                        <div class="relative w-full h-64 bg-gray-100 rounded-lg overflow-hidden">
                            <img 
                                id="imagePreview" 
                                src="" 
                                alt="Image preview"
                                class="w-full h-full object-contain">
                            <button 
                                type="button"
                                onclick="removeImagePreview()"
                                class="absolute top-2 right-2 p-2 bg-red-600 text-white rounded-full hover:bg-red-700 transition">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                    <input 
                        type="file" 
                        id="sectionImage" 
                        name="media"
                        accept="image/*"
                        class="hidden"
                        onchange="handleImageUpload(event)">
                    <button 
                        type="button"
                        onclick="document.getElementById('sectionImage').click()"
                        class="w-full px-4 py-3 border-2 border-dashed border-gray-300 text-gray-700 font-medium rounded-lg hover:bg-gray-50 transition flex items-center justify-center gap-2">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                        </svg>
                        Chọn hình ảnh
                    </button>
                    <p class="text-xs text-gray-500">Khuyến nghị: JPG, PNG hoặc GIF, tối đa 10MB</p>
                </div>
            </div>

            <!-- Video Upload (Only for Video type) -->
            <div id="videoUploadSection" class="hidden">
                <label class="block text-sm font-semibold text-gray-700 mb-2">
                    Đính kèm video <span class="text-red-500">*</span>
                </label>
                <div class="space-y-3">
                    <div id="videoPreviewContainer" class="hidden">
                        <div class="relative w-full bg-gray-100 rounded-lg overflow-hidden">
                            <video 
                                id="videoPreview" 
                                controls
                                class="w-full max-h-96">
                                <source id="videoSource" src="" type="video/mp4">
                                Your browser does not support the video tag.
                            </video>
                            <button 
                                type="button"
                                onclick="removeVideoPreview()"
                                class="absolute top-2 right-2 p-2 bg-red-600 text-white rounded-full hover:bg-red-700 transition">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                    <input 
                        type="file" 
                        id="sectionVideo" 
                        name="media"
                        accept="video/*"
                        class="hidden"
                        onchange="handleVideoUpload(event)">
                    <button 
                        type="button"
                        onclick="document.getElementById('sectionVideo').click()"
                        class="w-full px-4 py-3 border-2 border-dashed border-gray-300 text-gray-700 font-medium rounded-lg hover:bg-gray-50 transition flex items-center justify-center gap-2">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                        </svg>
                        Chọn video
                    </button>
                    <p class="text-xs text-gray-500">Khuyến nghị: MP4, MOV hoặc AVI, tối đa 100MB</p>
                </div>
            </div>

            <div>
                <label for="sectionPosition" class="block text-sm font-semibold text-gray-700 mb-2">
                    Vị trí <span class="text-red-500">*</span>
                </label>
                <input 
                    type="number" 
                    id="sectionPosition" 
                    name="position"
                    min="1"
                    value="1"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                    required>
                <p class="text-xs text-gray-500 mt-1">Thứ tự hiển thị của bài học trong khóa học</p>
            </div>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">
                    Trạng thái <span class="text-red-500">*</span>
                </label>
                <div class="space-y-2">
                    <label class="flex items-center p-3 border-2 border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition">
                        <input 
                            type="radio" 
                            name="status" 
                            value="Active"
                            checked
                            class="w-4 h-4 text-blue-600 focus:ring-blue-500">
                        <span class="ml-3 font-medium text-gray-900">Hoạt động</span>
                    </label>
                    <label class="flex items-center p-3 border-2 border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition">
                        <input 
                            type="radio" 
                            name="status" 
                            value="Inactive"
                            class="w-4 h-4 text-blue-600 focus:ring-blue-500">
                        <span class="ml-3 font-medium text-gray-900">Không hoạt động</span>
                    </label>
                </div>
            </div>

            <div class="flex gap-3 pt-4">
                <button 
                    type="submit"
                    class="flex-1 px-4 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition">
                    Thêm bài học
                </button>
                <button 
                    type="button"
                    onclick="closeAddSectionModal()"
                    class="flex-1 px-4 py-3 bg-white border border-gray-300 text-gray-700 font-medium rounded-lg hover:bg-gray-50 transition">
                    Hủy
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function addSection() {
        document.getElementById('addSectionModal').style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }

    function closeAddSectionModal() {
        document.getElementById('addSectionModal').style.display = 'none';
        document.body.style.overflow = 'auto';
        document.getElementById('addSectionForm').reset();

        document.getElementById('imagePreviewContainer').classList.add('hidden');
        document.getElementById('videoPreviewContainer').classList.add('hidden');
        document.getElementById('imageUploadSection').classList.add('hidden');
        document.getElementById('videoUploadSection').classList.add('hidden');
    }

    function handleTypeChange() {
        const type = document.getElementById('sectionType').value;

        document.getElementById('imageUploadSection').classList.add('hidden');
        document.getElementById('videoUploadSection').classList.add('hidden');

        document.getElementById('sectionImage').value = '';
        document.getElementById('sectionVideo').value = '';
        document.getElementById('imagePreviewContainer').classList.add('hidden');
        document.getElementById('videoPreviewContainer').classList.add('hidden');

        if (type === 'image') {
            document.getElementById('imageUploadSection').classList.remove('hidden');
        } else if (type === 'video') {
            document.getElementById('videoUploadSection').classList.remove('hidden');
        }
    }

    function handleImageUpload(event) {
        const file = event.target.files[0];
        if (!file)
            return;

        if (file.size > 10 * 1024 * 1024) {
            showToast('Kích thước file phải nhỏ hơn 10MB', 'error', 2500);
            event.target.value = '';
            return;
        }

        if (!file.type.startsWith('image/')) {
            showToast('Vui lòng chọn file hình ảnh', 'error', 2500);
            event.target.value = '';
            return;
        }

        const reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('imagePreview').src = e.target.result;
            document.getElementById('imagePreviewContainer').classList.remove('hidden');
        };
        reader.readAsDataURL(file);
    }

    function handleVideoUpload(event) {
        const file = event.target.files[0];
        if (!file)
            return;

        if (file.size > 100 * 1024 * 1024) {
            showToast('Kích thước file phải nhỏ hơn 100MB', 'error', 2500);
            event.target.value = '';
            return;
        }

        if (!file.type.startsWith('video/')) {
            showToast('Vui lòng chọn file video', 'error', 2500);
            event.target.value = '';
            return;
        }

        const reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('videoSource').src = e.target.result;
            document.getElementById('videoPreview').load();
            document.getElementById('videoPreviewContainer').classList.remove('hidden');
        };
        reader.readAsDataURL(file);
    }

    function removeImagePreview() {
        document.getElementById('sectionImage').value = '';
        document.getElementById('imagePreview').src = '';
        document.getElementById('imagePreviewContainer').classList.add('hidden');
    }

    function removeVideoPreview() {
        document.getElementById('sectionVideo').value = '';
        document.getElementById('videoSource').src = '';
        document.getElementById('videoPreview').load();
        document.getElementById('videoPreviewContainer').classList.add('hidden');
    }

    document.getElementById('addSectionForm').addEventListener('submit', function (e) {
        e.preventDefault();

        const type = document.getElementById('sectionType').value;
        const title = document.getElementById('sectionTitle').value.trim();
        const description = document.getElementById('sectionDescription').value.trim();
        const content = document.getElementById('sectionContent').value.trim();
        const position = document.getElementById('sectionPosition').value;
        const status = document.querySelector('input[name="status"]:checked').value;

        console.log(title + description + type + content + position);

        if (!title || !description || !type || !content || !position) {
            showToast('Vui lòng điền đầy đủ thông tin bắt buộc', 'error', 2500);
            return;
        }

        if (type === 'image') {
            const imageFile = document.getElementById('sectionImage').files[0];
            if (!imageFile) {
                showToast('Vui lòng chọn hình ảnh đính kèm', 'error', 2500);
                return;
            }
        } else if (type === 'video') {
            const videoFile = document.getElementById('sectionVideo').files[0];
            if (!videoFile) {
                showToast('Vui lòng chọn video đính kèm', 'error', 2500);
                return;
            }
        }

        const formData = new FormData();
        formData.append('courseId', '${course.id}');
        formData.append('title', title);
        formData.append('description', description);
        formData.append('content', content);
        formData.append('type', type);
        formData.append('position', position);
        formData.append('status', status);

        if (type === 'image') {
            formData.append('media', document.getElementById('sectionImage').files[0]);
        } else if (type === 'video') {
            formData.append('media', document.getElementById('sectionVideo').files[0]);
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/instructor/courses/sections",
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                showToast("Thêm bài học thành công!", "success", 2500);
                closeAddSectionModal();
                setTimeout(() => location.reload(), 1500);
            },
            error: function (xhr) {
                const errorMsg = xhr.responseJSON?.message || "Có lỗi xảy ra khi thêm bài học, vui lòng thử lại";
                showToast(errorMsg, "error", 2500);
            }
        });
    });

    document.getElementById('addSectionModal').addEventListener('click', function (e) {
        if (e.target === this) {
            closeAddSectionModal();
        }
    });
</script>