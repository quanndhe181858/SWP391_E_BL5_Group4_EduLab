<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/layout/import.jsp"/>
<jsp:include page="/layout/header.jsp"/>

<div class="max-w-3xl mx-auto bg-white p-6 shadow rounded-lg mt-4">
    <h2 class="text-2xl font-bold mb-4">${test != null ? "Sửa Test" : "Thêm Test"}</h2>

    <form method="post" action="${test != null ? 'editTest' : 'addTest'}">
        <c:if test="${test != null}">
            <input type="hidden" name="id" value="${test.id}"/>
        </c:if>

        <div class="mb-4">
            <label class="block mb-1">Tên bài Test</label>
            <input type="text" name="title" value="${test != null ? test.title : ''}" class="w-full px-4 py-2 border rounded"/>
        </div>

        <div class="mb-4">
            <label class="block mb-1">Course ID</label>
            <input type="number" name="courseId" value="${test != null ? test.courseId : ''}" class="w-full px-4 py-2 border rounded"/>
        </div>

        <div class="mb-4">
            <label class="block mb-1">Category ID</label>
            <input type="number" name="categoryId" value="${test != null ? test.categoryId : ''}" class="w-full px-4 py-2 border rounded"/>
        </div>

        <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
            ${test != null ? "Cập nhật" : "Thêm mới"}
        </button>
    </form>
</div>

<jsp:include page="/layout/footer.jsp"/>
<jsp:include page="/layout/importBottom.jsp"/>
