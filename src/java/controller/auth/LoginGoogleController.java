/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;
import java.util.ResourceBundle;
import model.User;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import util.Hash;
import util.RandomUtils;

/**
 *
 * @author hao
 */
@WebServlet(name = "LoginGoogleController", urlPatterns = {"/auth/google"})
public class LoginGoogleController extends HttpServlet {

    static final ResourceBundle bundle = ResourceBundle.getBundle("configuration.google");
    static final UserDAO userDao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String code = request.getParameter("code");
        String accessToken = getToken(code);

        String url = "https://people.googleapis.com/v1/people/me?personFields=names,emailAddresses,phoneNumbers,photos,genders";

        String apiResponse = Request.Get(url)
                .addHeader("Authorization", "Bearer " + accessToken)
                .execute()
                .returnContent()
                .asString();

        System.out.println(apiResponse);

        Gson gson = new Gson();
        JsonObject userInfo = gson.fromJson(apiResponse, JsonObject.class);

        String email;
        String fName;
        String lName;
        String avatar;

        if (userInfo.has("emailAddresses") && userInfo.getAsJsonArray("emailAddresses").size() > 0) {
            JsonObject emailAddresses = userInfo.getAsJsonArray("emailAddresses").get(0).getAsJsonObject();
            System.out.println("Email: " + emailAddresses.get("value").getAsString());
            email = emailAddresses.get("value").getAsString();
        } else {
            email = null;
        }

        if (userInfo.has("names") && userInfo.getAsJsonArray("names").size() > 0) {
            JsonObject names = userInfo.getAsJsonArray("names").get(0).getAsJsonObject();
            lName = names.get("familyName").getAsString();
            fName = names.get("givenName").getAsString();
        } else {
            lName = null;
            fName = null;
        }

        if (userInfo.has("photos") && userInfo.getAsJsonArray("photos").size() > 0) {
            JsonObject photos = userInfo.getAsJsonArray("photos").get(0).getAsJsonObject();
            avatar = photos.get("url").getAsString();
        } else {
            avatar = null;
        }

        if (email == null) {
            request.setAttribute("msg", "Tài khoản google có vấn đề, không thể đăng nhập bằng phương thức này!");
            request.getRequestDispatcher("View/Auth/Login.jsp").forward(request, response);
        } else {
            doAuthorizeGoogleUser(email, fName, lName, avatar, session, request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(bundle.getString("GOOGLE_LINK_GET_TOKEN"))
                .bodyForm(Form.form().add("client_id", bundle.getString("GOOGLE_CLIENT_ID"))
                        .add("client_secret", bundle.getString("GOOGLE_CLIENT_SECRET"))
                        .add("redirect_uri", bundle.getString("GOOGLE_REDIRECT_URI")).add("code", code)
                        .add("grant_type", bundle.getString("GOOGLE_GRANT_TYPE")).build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static User getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = bundle.getString("GOOGLE_LINK_GET_USER_INFO") + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        User googleUser = new Gson().fromJson(response, User.class);

        return googleUser;
    }

    private void doAuthorizeGoogleUser(String email, String fName, String lName, String avatar,
            HttpSession session, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean isEmailExisted = userDao.isEmailExisted(email);
        if (isEmailExisted) {
            User u = userDao.getAuthUserByEmail(email);

            if (!"Active".equals(u.getStatus())) {
                String msg = "Tài khoản đã bị khoá, vui lòng liên hệ quản trị viên.";
                request.setAttribute("msg", msg);
                request.getRequestDispatcher("View/Auth/Login.jsp").forward(request, response);
            }

            session.setAttribute("user", u);

            int roleId = u.getRole_id();

            switch (roleId) {
                case 1 ->
                    response.sendRedirect(request.getContextPath() + "/admin_dashboard");
                case 2 ->
                    response.sendRedirect(request.getContextPath() + "/instructor/courses");
                default ->
                    response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            String random_string = RandomUtils.getRandomString(8);
            String hash_password = Hash.sha512(random_string);

            User u = new User();
            u.setFirst_name(fName);
            u.setLast_name(lName);
            u.setEmail(email);
            u.setHash_password(hash_password);

            userDao.doRegister(u);
            User newU = userDao.getAuthUserByEmail(email);

            session.setAttribute("user", newU);

            int roleId = u.getRole_id();

            switch (roleId) {
                case 1 ->
                    response.sendRedirect(request.getContextPath() + "/admin_dashboard");
                case 2 ->
                    response.sendRedirect(request.getContextPath() + "/instructor/courses");
                default ->
                    response.sendRedirect(request.getContextPath() + "/home");
            }
        }
    }
}
