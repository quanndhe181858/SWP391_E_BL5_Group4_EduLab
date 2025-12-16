/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.Date;
import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Random;
import java.util.ResourceBundle;

/**
 *
 * @author hao
 */
public class Email {

    static final ResourceBundle bundle = ResourceBundle.getBundle("configuration.google");
    static final String EMAIL_FROM = bundle.getString("EMAIL_FROM");
    static final String EMAIL_PASSWORD = bundle.getString("EMAIL_PASSWORD");

    public static boolean sendEmail(String to, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        props.put("mail.mime.charset", "UTF-8");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_FROM, EMAIL_PASSWORD);
            }
        };

        Session session = Session.getInstance(props, auth);

        try {
            MimeMessage msg = new MimeMessage(session);

            // Người gửi
            msg.setFrom(new InternetAddress(EMAIL_FROM, "EduLAB", "UTF-8"));

            // Người nhận
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));

            // Tiêu đề email
            msg.setSubject(subject, "UTF-8");

            // Ngày gửi
            msg.setSentDate(new Date());

            // Nội dung
            msg.setContent(content, "text/html; charset=UTF-8");
//            msg.setText(content, "UTF-8", "html");

            // Gửi email
            Transport.send(msg);
            System.out.println("Gửi email thành công");
            return true;
        } catch (MessagingException | java.io.UnsupportedEncodingException e) {
            System.err.println("Gặp lỗi trong quá trình gửi email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    public static String generateRandomPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%";
        Random random = new Random();
        StringBuilder password = new StringBuilder();
        for (int i = 0; i < 10; i++) {
            password.append(chars.charAt(random.nextInt(chars.length())));
        }
        return password.toString();
    }

    public static boolean sendOTPEmail(String toEmail, String otp) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_FROM, EMAIL_PASSWORD);
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_FROM, "EduLAB", "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Xac thuc OTP - EduLAB", "UTF-8");

            String htmlContent = """
<html>
<body style='font-family: Arial, sans-serif; padding: 20px; background-color: #f4f4f4;'>
    <div style='max-width: 600px; margin: 0 auto; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);'>
        <div style='text-align: center; margin-bottom: 30px;'>
            <h1 style='color: #3B82F6; margin: 0;'>EduLAB</h1>
        </div>

        <h2 style='color: #333; margin-bottom: 20px;'>Xac thuc OTP</h2>

        <p style='color: #666; font-size: 16px; line-height: 1.6;'>
            Ban da yeu cau dat lai mat khau.
            Vui long su dung ma OTP duoi day de xac thuc:
        </p>

        <div style='background-color: #f0f9ff; padding: 20px; border-radius: 8px; text-align: center; margin: 30px 0;'>
            <p style='color: #666; margin: 0 0 10px 0; font-size: 14px;'>
                Ma OTP cua ban la:
            </p>
            <h1 style='color: #3B82F6; font-size: 36px; letter-spacing: 8px; margin: 0;'>
                """ + otp + """
            </h1>
        </div>

        <p style='color: #999; font-size: 14px; margin-top: 20px;'>
            <strong>Luu y:</strong> Ma OTP nay chi co hieu luc trong <strong>5 phut</strong>.
        </p>

        <p style='color: #999; font-size: 14px;'>
            Neu ban khong yeu cau dat lai mat khau, vui long bo qua email nay.
        </p>

        <hr style='border: none; border-top: 1px solid #eee; margin: 30px 0;'>

        <p style='color: #999; font-size: 12px; text-align: center;'>
            © 2024 EduLAB. All rights reserved.
        </p>
    </div>
</body>
</html>
""";

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean sendNewPasswordEmail(String toEmail, String newPassword) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_FROM, EMAIL_PASSWORD);
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_FROM, "EduLAB", "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mat khau moi - EduLAB", "UTF-8");

            String htmlContent = """
<html>
<body style='font-family: Arial, sans-serif; padding: 20px; background-color: #f4f4f4;'>
    <div style='max-width: 600px; margin: 0 auto; background-color: white; padding: 30px;
                border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);'>

        <div style='text-align: center; margin-bottom: 30px;'>
            <h1 style='color: #3B82F6; margin: 0;'>EduLAB</h1>
        </div>

        <h2 style='color: #333; margin-bottom: 20px;'>Mat khau moi cua ban</h2>

        <p style='color: #666; font-size: 16px; line-height: 1.6;'>
            Mat khau cua ban da duoc dat lai thanh cong.
            Duoi day la mat khau moi cua ban:
        </p>

        <div style='background-color: #f0f9ff; padding: 20px; border-radius: 8px; margin: 30px 0;'>
            <p style='color: #666; margin: 0 0 10px 0; font-size: 14px;'>
                Mat khau moi:
            </p>
            <h2 style='color: #3B82F6; font-size: 24px; margin: 0; word-break: break-all;'>
                """ + newPassword + """
            </h2>
        </div>

        <div style='background-color: #fff3cd; border-left: 4px solid #ffc107;
                    padding: 15px; margin: 20px 0;'>
            <p style='color: #856404; margin: 0; font-size: 14px;'>
                <strong>Quan trong:</strong>
                Vui long doi mat khau ngay sau khi dang nhap de dam bao an toan tai khoan.
            </p>
        </div>

        <p style='color: #666; font-size: 14px;'>
            Ban co the dang nhap va thay doi mat khau tai muc
            <strong>Cai dat tai khoan</strong>.
        </p>

        <hr style='border: none; border-top: 1px solid #eee; margin: 30px 0;'>

        <p style='color: #999; font-size: 12px; text-align: center;'>
            © 2024 EduLAB. All rights reserved.
        </p>

    </div>
</body>
</html>
""";

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        System.out.println(System.getProperty("file.encoding"));
        System.out.println("Xác thực OTP – tiếng Việt có dấu");

    }

}
