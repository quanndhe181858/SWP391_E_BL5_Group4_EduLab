<%-- 
    Document   : header
    Created on : Dec 6, 2025, 2:55:22 PM
    Author     : quan
--%>

<header>
    <nav class="bg-white border-b border-gray-200 mb-4">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center space-x-8">
                    <div class="flex items-center">
                        <a href="${pageContext.request.contextPath}/courses"><span class="text-2xl font-bold text-blue-600">LabEdu</span></a>
                    </div>
                    <div class="">
                        <div class="relative w-[500px]">
                            <input 
                                type="text" 
                                placeholder="What do you want to learn?" 
                                class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                                />
                            <button class="absolute right-2 top-1/2 transform -translate-y-1/2 bg-blue-600 text-white p-2 rounded-md">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="flex items-center space-x-4">
                    <button class="text-blue-600 text-sm font-medium hover:underline">Log In</button>
                    <button class="px-4 py-2 text-sm font-medium text-blue-600 border border-blue-600 rounded hover:bg-blue-50">
                        Join for Free
                    </button>
                </div>
            </div>

        </div>
    </nav>
</header>