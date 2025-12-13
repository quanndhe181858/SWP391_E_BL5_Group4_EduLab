<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <jsp:include page="/layout/import.jsp"/>
    </head>

    <body class="bg-gray-100">

        <!-- HEADER -->
        <jsp:include page="/layout/header.jsp"/>

        <!-- SIDEBAR -->
        <jsp:include page="/layout/admin_sidebar.jsp"/>

        <!-- MAIN CONTENT -->
        <main class="ml-64 pt-6 px-6 min-h-screen">

            <!-- TITLE -->
            <div class="mb-6">
                <h1 class="text-2xl font-bold text-gray-800">Admin Dashboard</h1>
                <p class="text-sm text-gray-500">System overview</p>
            </div>

            <!-- KPI -->
            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6 mb-8">
                <div class="bg-white p-5 rounded-xl shadow">
                    <p class="text-sm text-gray-500">Total Users</p>
                    <p class="text-3xl font-bold text-blue-600">1,240</p>
                </div>

                <div class="bg-white p-5 rounded-xl shadow">
                    <p class="text-sm text-gray-500">Total Courses</p>
                    <p class="text-3xl font-bold text-green-600">86</p>
                </div>

                <div class="bg-white p-5 rounded-xl shadow">
                    <p class="text-sm text-gray-500">Total Quizzes</p>
                    <p class="text-3xl font-bold text-purple-600">312</p>
                </div>

                <div class="bg-white p-5 rounded-xl shadow">
                    <p class="text-sm text-gray-500">Total Tests</p>
                    <p class="text-3xl font-bold text-red-600">54</p>
                </div>
            </div>

            <!-- TABLES -->
            <div class="grid grid-cols-1 xl:grid-cols-2 gap-6">

                <!-- Recent Users -->
                <div class="bg-white rounded-xl shadow">
                    <div class="p-4 border-b">
                        <h2 class="font-semibold text-gray-700">Recent Users</h2>
                    </div>
                    <div class="p-4">
                        <table class="w-full text-sm">
                            <thead>
                                <tr class="text-gray-500 text-left">
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-t">
                                    <td class="py-2">Nguyen Van A</td>
                                    <td>a@gmail.com</td>
                                    <td>2025-12-05</td>
                                </tr>
                                <tr class="border-t">
                                    <td class="py-2">Tran Thi B</td>
                                    <td>b@gmail.com</td>
                                    <td>2025-12-04</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Recent Courses -->
                <div class="bg-white rounded-xl shadow">
                    <div class="p-4 border-b">
                        <h2 class="font-semibold text-gray-700">Recent Courses</h2>
                    </div>
                    <div class="p-4 space-y-3 text-sm">
                        <div class="flex justify-between">
                            <span>Java Web Fullstack</span>
                            <span class="text-gray-500">2025-12-06</span>
                        </div>
                        <div class="flex justify-between">
                            <span>ASP.NET Core</span>
                            <span class="text-gray-500">2025-12-04</span>
                        </div>
                    </div>
                </div>

            </div>

        </main>

    </body>
</html>
