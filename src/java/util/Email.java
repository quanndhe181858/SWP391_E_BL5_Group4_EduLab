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
            msg.setText(content, "UTF-8", "html");

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

    public static void main(String[] args) {
        for (int i = 0; i < 1; i++) {
            boolean result = sendEmail("haohoangdanh1@gmail.com",
                    "Lêu lêu FA " + System.currentTimeMillis(),
                    "Đây là phần nội dung trêu mấy đứa FA " + System.currentTimeMillis());
            if (result) {
                System.out.println("Email " + (i + 1) + " đã được gửi thành công.");
            } else {
                System.out.println("Gửi email " + (i + 1) + " không thành công.");
            }
        }
    }

}
