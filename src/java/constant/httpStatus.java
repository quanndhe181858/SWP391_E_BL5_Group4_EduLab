/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package constant;

/**
 *
 * @author quan
 */
public enum httpStatus {
    INTERNAL_SERVER_ERROR(500, "Ối, có gì đó không ổn ở phía máy chủ, vui lòng thử lại sau!"),
    NOT_FOUND(404, "Không tìm thấy tài nguyên, bạn có đang làm nhầm gì đó không?"),
    UNAUTHORIZED(401, "Bạn không có quyền thực hiện điều này, nếu chưa đăng nhập, hãy thử đăng nhập trước nhé!"),
    FORBIDDEN(403, "Bạn đã bị cấm xem tài nguyên này!"),
    OK(200, "OK"),
    CREATED(201, "Tài nguyên đã được tạo, lưu thành công");

    private final int code;
    private final String message;

    httpStatus(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public static httpStatus fromCode(int code) {
        for (httpStatus s : values()) {
            if (s.code == code) {
                return s;
            }
        }
        throw new IllegalArgumentException("Invalid code: " + code);
    }
}
