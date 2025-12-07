<%-- 
    Document   : importBottom
    Created on : Dec 7, 2025, 3:24:27 AM
    Author     : quan
--%>

<script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
<script>
    function showToast(message, type = "info", duration = 3000, position = "right") {

        const colors = {
            success: "linear-gradient(to right, #00b09b, #96c93d)",
            error: "linear-gradient(to right, #ff0000, #b30000)",
            warning: "linear-gradient(to right, #f7971e, #ffd200)",
            info: "linear-gradient(to right, #2193b0, #6dd5ed)"
        };

        Toastify({
            text: message,
            duration: duration,
            gravity: "top",
            position: position,
            close: true,
            stopOnFocus: true,
            style: {
                background: colors[type] || colors.info
            }
        }).showToast();
    }
</script>