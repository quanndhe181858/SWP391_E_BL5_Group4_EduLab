<%-- 
    Document   : editCourseSectionPopup
    Created on : Dec 7, 2025, 2:23:33 PM
    Author     : quan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="editSectionModal" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50" style="display: none;">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-2xl mx-4 max-h-[90vh] overflow-y-auto">
        <div class="sticky top-0 bg-white border-b border-gray-200 px-6 py-4 flex items-center justify-between">
            <h2 class="text-2xl font-bold text-gray-900">Chỉnh sửa bài học</h2>
            <button type="button" onclick="closeEditSectionModal()" class="text-gray-400 hover:text-gray-600 transition">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </button>
        </div>

        <form id="editSectionForm" class="p-6 space-y-5">
            <input type="hidden" id="editSectionId" name="id">

            <div>
                <label for="editSectionTitle" class="block text-sm font-semibold text-gray-700 mb-2">
                    Tên bài học <span class="text-red-500">*</span>
                </label>
                <input 
                    type="text" 
                    id="editSectionTitle" 
                    name="title"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                    placeholder="Nhập tên bài học..."
                    required>
            </div>

            <div>
                <label for="editSectionDescription" class="block text-sm font-semibold text-gray-700 mb-2">
                    Mô tả bài học <span class="text-red-500">*</span>
                </label>
                <textarea 
                    id="editSectionDescription" 
                    name="description"
                    rows="3"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                    placeholder="Mô tả ngắn gọn về bài học..."
                    required></textarea>
            </div>

            <div>
                <label for="editSectionType" class="block text-sm font-semibold text-gray-700 mb-2">
                    Thể loại <span class="text-red-500">*</span>
                </label>
                <select 
                    id="editSectionType" 
                    name="type"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white"
                    required
                    onchange="handleEditTypeChange()">
                    <option value="">Chọn thể loại</option>
                    <option value="text">Text (Văn bản)</option>
                    <option value="image">Image (Hình ảnh)</option>
                    <option value="video">Video</option>
                </select>
            </div>

            <!-- Text Content (Only for Text type) -->
            <div id="editTextContentSection" class="hidden">
                <label for="editSectionContent" class="block text-sm font-semibold text-gray-700 mb-2">
                    Nội dung văn bản <span class="text-red-500">*</span>
                </label>
                <textarea 
                    id="editSectionContent" 
                    name="content"
                    rows="6"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                    placeholder="Nhập nội dung bài học..."></textarea>
            </div>

            <!-- Image Upload (Only for Image type) -->
            <div id="editImageUploadSection" class="hidden">
                <label class="block text-sm font-semibold text-gray-700 mb-2">
                    Hình ảnh hiện tại / Tải lên mới
                </label>
                <div class="space-y-3">
                    <div id="editImagePreviewContainer" class="hidden">
                        <div class="relative w-full h-64 bg-gray-100 rounded-lg overflow-hidden">
                            <img 
                                id="editImagePreview" 
                                src="" 
                                alt="Image preview"
                                class="w-full h-full object-contain">
                            <button 
                                type="button"
                                onclick="removeEditImagePreview()"
                                class="absolute top-2 right-2 p-2 bg-red-600 text-white rounded-full hover:bg-red-700 transition">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                    <input type="hidden" id="editCurrentImageUrl" name="currentImageUrl">
                    <input 
                        type="file" 
                        id="editSectionImage" 
                        name="image"
                        accept="image/*"
                        class="hidden"
                        onchange="handleEditImageUpload(event)">
                    <button 
                        type="button"
                        onclick="document.getElementById('editSectionImage').click()"
                        class="w-full px-4 py-3 border-2 border-dashed border-gray-300 text-gray-700 font-medium rounded-lg hover:bg-gray-50 transition flex items-center justify-center gap-2">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                        </svg>
                        <span id="editImageButtonText">Thay đổi hình ảnh</span>
                    </button>
                    <p class="text-xs text-gray-500">Khuyến nghị: JPG, PNG hoặc GIF, tối đa 10MB</p>
                </div>
            </div>

            <!-- Video Upload (Only for Video type) -->
            <div id="editVideoUploadSection" class="hidden">
                <label class="block text-sm font-semibold text-gray-700 mb-2">
                    Video hiện tại / Tải lên mới
                </label>
                <div class="space-y-3">
                    <div id="editVideoPreviewContainer" class="hidden">
                        <div class="relative w-full bg-gray-100 rounded-lg overflow-hidden">
                            <video 
                                id="editVideoPreview" 
                                controls
                                class="w-full max-h-96">
                                <source id="editVideoSource" src="" type="video/mp4">
                                Your browser does not support the video tag.
                            </video>
                            <button 
                                type="button"
                                onclick="removeEditVideoPreview()"
                                class="absolute top-2 right-2 p-2 bg-red-600 text-white rounded-full hover:bg-red-700 transition">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                    <input type="hidden" id="editCurrentVideoUrl" name="currentVideoUrl">
                    <input 
                        type="file" 
                        id="editSectionVideo" 
                        name="video"
                        accept="video/*"
                        class="hidden"
                        onchange="handleEditVideoUpload(event)">
                    <button 
                        type="button"
                        onclick="document.getElementById('editSectionVideo').click()"
                        class="w-full px-4 py-3 border-2 border-dashed border-gray-300 text-gray-700 font-medium rounded-lg hover:bg-gray-50 transition flex items-center justify-center gap-2">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                        </svg>
                        <span id="editVideoButtonText">Thay đổi video</span>
                    </button>
                    <p class="text-xs text-gray-500">Khuyến nghị: MP4, MOV hoặc AVI, tối đa 100MB</p>
                </div>
            </div>

            <div>
                <label for="editSectionPosition" class="block text-sm font-semibold text-gray-700 mb-2">
                    Vị trí <span class="text-red-500">*</span>
                </label>
                <input 
                    type="number" 
                    id="editSectionPosition" 
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
                            name="editStatus" 
                            value="Active"
                            class="w-4 h-4 text-blue-600 focus:ring-blue-500">
                        <span class="ml-3 font-medium text-gray-900">Hoạt động</span>
                    </label>
                    <label class="flex items-center p-3 border-2 border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition">
                        <input 
                            type="radio" 
                            name="editStatus" 
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
                    Cập nhật bài học
                </button>
                <button 
                    type="button"
                    onclick="closeEditSectionModal()"
                    class="flex-1 px-4 py-3 bg-white border border-gray-300 text-gray-700 font-medium rounded-lg hover:bg-gray-50 transition">
                    Hủy
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    let editSectionData = null;

    function editSection(sectionId) {
        $.ajax({
            url: "${pageContext.request.contextPath}/instructor/courses/sections?csid=" + sectionId,
            type: "GET",
            success: function (response) {
                editSectionData = response;
                populateEditForm(response);
                document.getElementById('editSectionModal').style.display = 'flex';
                document.body.style.overflow = 'hidden';
            },
            error: function (xhr) {
                showToast("Không thể tải thông tin bài học", "error", 2500);
            }
        });
    }

    function populateEditForm(section) {
        document.getElementById('editSectionId').value = section.id;
        document.getElementById('editSectionTitle').value = section.title;
        document.getElementById('editSectionDescription').value = section.description;
        document.getElementById('editSectionType').value = section.type;
        document.getElementById('editSectionPosition').value = section.position;

        const statusRadios = document.querySelectorAll('input[name="editStatus"]');
        statusRadios.forEach(radio => {
            radio.checked = radio.value === section.status;
        });

        handleEditTypeChange();

        if (section.type === 'text') {
            document.getElementById('editSectionContent').value = section.content || '';
        } else if (section.type === 'image' && section.content) {
            document.getElementById('editCurrentImageUrl').value = section.content;
            document.getElementById('editImagePreview').src = section.content;
            document.getElementById('editImagePreviewContainer').classList.remove('hidden');
            document.getElementById('editImageButtonText').textContent = 'Thay đổi hình ảnh';
        } else if (section.type === 'video' && section.content) {
            document.getElementById('editCurrentVideoUrl').value = section.content;
            document.getElementById('editVideoSource').src = section.content;
            document.getElementById('editVideoPreview').load();
            document.getElementById('editVideoPreviewContainer').classList.remove('hidden');
            document.getElementById('editVideoButtonText').textContent = 'Thay đổi video';
        }
    }

    function closeEditSectionModal() {
        document.getElementById('editSectionModal').style.display = 'none';
        document.body.style.overflow = 'auto';
        document.getElementById('editSectionForm').reset();
        editSectionData = null;

        document.getElementById('editImagePreviewContainer').classList.add('hidden');
        document.getElementById('editVideoPreviewContainer').classList.add('hidden');

        document.getElementById('editTextContentSection').classList.add('hidden');
        document.getElementById('editImageUploadSection').classList.add('hidden');
        document.getElementById('editVideoUploadSection').classList.add('hidden');
    }

    function handleEditTypeChange() {
        const type = document.getElementById('editSectionType').value;

        document.getElementById('editTextContentSection').classList.add('hidden');
        document.getElementById('editImageUploadSection').classList.add('hidden');
        document.getElementById('editVideoUploadSection').classList.add('hidden');

        if (type === 'text') {
            document.getElementById('editTextContentSection').classList.remove('hidden');
        } else if (type === 'image') {
            document.getElementById('editImageUploadSection').classList.remove('hidden');
        } else if (type === 'video') {
            document.getElementById('editVideoUploadSection').classList.remove('hidden');
        }
    }

    function handleEditImageUpload(event) {
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
            document.getElementById('editImagePreview').src = e.target.result;
            document.getElementById('editImagePreviewContainer').classList.remove('hidden');
            document.getElementById('editImageButtonText').textContent = 'Thay đổi hình ảnh';
        };
        reader.readAsDataURL(file);
    }

    function handleEditVideoUpload(event) {
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
            document.getElementById('editVideoSource').src = e.target.result;
            document.getElementById('editVideoPreview').load();
            document.getElementById('editVideoPreviewContainer').classList.remove('hidden');
            document.getElementById('editVideoButtonText').textContent = 'Thay đổi video';
        };
        reader.readAsDataURL(file);
    }

    function removeEditImagePreview() {
        document.getElementById('editSectionImage').value = '';
        document.getElementById('editCurrentImageUrl').value = '';
        document.getElementById('editImagePreview').src = '';
        document.getElementById('editImagePreviewContainer').classList.add('hidden');
        document.getElementById('editImageButtonText').textContent = 'Chọn hình ảnh';
    }

    function removeEditVideoPreview() {
        document.getElementById('editSectionVideo').value = '';
        document.getElementById('editCurrentVideoUrl').value = '';
        document.getElementById('editVideoSource').src = '';
        document.getElementById('editVideoPreview').load();
        document.getElementById('editVideoPreviewContainer').classList.add('hidden');
        document.getElementById('editVideoButtonText').textContent = 'Chọn video';
    }

    document.getElementById('editSectionForm').addEventListener('submit', function (e) {
        e.preventDefault();

        const sectionId = document.getElementById('editSectionId').value;
        const type = document.getElementById('editSectionType').value;
        const title = document.getElementById('editSectionTitle').value.trim();
        const description = document.getElementById('editSectionDescription').value.trim();
        const position = document.getElementById('editSectionPosition').value;
        const status = document.querySelector('input[name="editStatus"]:checked').value;

        if (!title || !description || !type || !position) {
            showToast('Vui lòng điền đầy đủ thông tin bắt buộc', 'error', 2500);
            return;
        }

        const formData = new FormData();
        formData.append('id', sectionId);
        formData.append('courseId', '${course.id}');
        formData.append('title', title);
        formData.append('description', description);
        formData.append('type', type);
        formData.append('position', position);
        formData.append('status', status);

        if (type === 'text') {
            const content = document.getElementById('editSectionContent').value.trim();
            if (!content) {
                showToast('Vui lòng nhập nội dung văn bản', 'error', 2500);
                return;
            }
            formData.append('content', content);
        } else if (type === 'image') {
            const imageFile = document.getElementById('editSectionImage').files[0];
            const currentImageUrl = document.getElementById('editCurrentImageUrl').value;

            if (imageFile) {
                formData.append('content', imageFile);
            } else if (currentImageUrl) {
                formData.append('currentContent', currentImageUrl);
            } else {
                showToast('Vui lòng chọn hình ảnh', 'error', 2500);
                return;
            }
        } else if (type === 'video') {
            const videoFile = document.getElementById('editSectionVideo').files[0];
            const currentVideoUrl = document.getElementById('editCurrentVideoUrl').value;

            if (videoFile) {
                formData.append('content', videoFile);
            } else if (currentVideoUrl) {
                formData.append('currentContent', currentVideoUrl);
            } else {
                showToast('Vui lòng chọn video', 'error', 2500);
                return;
            }
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/instructor/courses/sections",
            type: "PUT",
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                showToast("Cập nhật bài học thành công!", "success", 2500);
                closeEditSectionModal();
                setTimeout(() => location.reload(), 1500);
            },
            error: function (xhr) {
                const errorMsg = xhr.responseJSON?.message || "Có lỗi xảy ra khi cập nhật bài học, vui lòng thử lại";
                showToast(errorMsg, "error", 2500);
            }
        });
    });

    document.getElementById('editSectionModal').addEventListener('click', function (e) {
        if (e.target === this) {
            closeEditSectionModal();
        }
    });
</script>