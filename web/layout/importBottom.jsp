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
            success: "green",
            error: "red",
            warning: "yellow",
            info: "blue"
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