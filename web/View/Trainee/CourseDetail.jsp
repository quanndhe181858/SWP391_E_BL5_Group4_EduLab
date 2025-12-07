<%-- 
    Document   : CourseDetail
    Created on : Dec 7, 2025, 7:39:35 PM
    Author     : quan
--%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết khoá học</title>
        <jsp:include page="/layout/import.jsp" />
    </head>
    <body>
        <jsp:include page="/layout/header.jsp" />
        <div class="bg-gradient-to-br from-blue-50 to-indigo-50 relative overflow-hidden">
            <div class="container mx-auto px-4 py-16 relative z-10">
                <div class="max-w-4xl">
                    <h1 class="text-5xl font-bold text-gray-900 mb-8">
                        ${course.title}
                    </h1>
                    <div>
                        <button class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-12 py-4 rounded-lg transition-colors">
                            Học ngay
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="bg-white border-b">
            <div class="container mx-auto px-4 py-8">
                <div class="grid grid-cols-1 gap-6">
                    <div class="text-center">
                        <h3 class="text-2xl font-bold text-blue-600 mb-2">${fn:length(sections)} bài học</h3>
                        <p class="text-sm text-gray-600">Tiến tới với sự đỉnh cao</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="bg-white border-b">
            <div class="container mx-auto px-4">
                <nav class="flex gap-8">
                    <a href="#" data-tab="description" class="tab-link py-4 border-b-2 border-blue-600 text-blue-600 font-medium">Mô tả khoá học</a>
                    <a href="#" data-tab="sections" class="tab-link py-4 border-b-2 border-transparent hover:border-gray-300 text-gray-600">Danh sách bài học</a>
                </nav>
            </div>
        </div>
        <div class="container mx-auto px-4 py-12 min-h-[280px]">
            <div id="description-content" class="tab-content">
                <h2 class="text-3xl font-bold mb-6">Bạn sẽ học được gì ?</h2>
                <p class="text-gray-700 leading-relaxed max-w-4xl">
                    ${course.description}
                </p>
            </div>

            <div id="sections-content" class="tab-content hidden">
                <h2 class="text-3xl font-bold mb-6">Danh sách bài học</h2>
                <div id="sections-list">
                    <div class="flex justify-center items-center py-8">
                        <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/layout/footer.jsp" />
        <jsp:include page="/layout/importBottom.jsp" />

        <script>
            $(document).ready(function () {
                let sectionsLoaded = false;

                $('.tab-link').click(function (e) {
                    e.preventDefault();

                    const tab = $(this).data('tab');

                    $('.tab-link').removeClass('border-blue-600 text-blue-600').addClass('border-transparent text-gray-600');
                    $(this).removeClass('border-transparent text-gray-600').addClass('border-blue-600 text-blue-600');

                    $('.tab-content').addClass('hidden');

                    $(`#` + tab + `-content`).removeClass('hidden');

                    if (tab === 'sections' && !sectionsLoaded) {
                        loadSections();
                    }
                });

                function loadSections() {
                    const courseId = '${course.id}';

                    $.ajax({
                        url: '${pageContext.request.contextPath}/courses/sections',
                        type: 'GET',
                        data: {id: courseId},
                        success: function (response) {
                            sectionsLoaded = true;
                            displaySections(response.sections);
                        },
                        error: function (xhr, status, error) {
                            $('#sections-list').html(`
                                <div class="text-center py-8">
                                    <p class="text-red-600">Không thể tải danh sách bài học. Vui lòng thử lại.</p>
                                </div>
                            `);
                        }
                    });
                }

                function displaySections(sections) {
                    let html = "";

                    if (sections && sections.length > 0) {
                        html = "<div class=\"space-y-4\">";

                        sections.forEach((section, index) => {
                            html +=
                                    "<div class=\"border rounded-lg p-6 hover:shadow-md transition-shadow\">" +
                                    "<div class=\"flex items-start justify-between\">" +
                                    "<div class=\"flex-1\">" +
                                    "<h3 class=\"text-xl font-semibold text-gray-900 mb-2\">" +
                                    (index + 1) + ". " + (section.title || section.name) +
                                    "</h3>" +
                                    "<p class=\"text-gray-600 text-sm\">" +
                                    (section.description || "Không có mô tả") +
                                    "</p>" +
                                    (section.duration
                                            ? "<p class=\"text-gray-500 text-sm mt-2\">" +
                                            "<span class=\"inline-flex items-center\">" +
                                            "<svg class=\"w-4 h-4 mr-1\" fill=\"none\" stroke=\"currentColor\" viewBox=\"0 0 24 24\">" +
                                            "<path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z\"></path>" +
                                            "</svg>" +
                                            section.duration +
                                            "</span>" +
                                            "</p>"
                                            : ""
                                            ) +
                                    "</div>" +
                                    "</div>" +
                                    "</div>";
                        });

                        html += "</div>";
                    } else {
                        html =
                                "<div class=\"text-center py-8\">" +
                                "<p class=\"text-gray-600\">Chưa có bài học nào.</p>" +
                                "</div>";
                    }

                    $("#sections-list").html(html);
                }
            });
        </script>
    </body>
</html>