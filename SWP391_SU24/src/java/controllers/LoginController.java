/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import model.User;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.time.Instant;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.UserGoogleDetails;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import utils.ConstantUtils;
import utils.EncryptionUtils;

/**
 *
 * @author LAPTOP
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String accessToken = getToken(code);
        UserGoogleDetails userGoogle = getUserInfo(accessToken);
        System.out.println(userGoogle);
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        // call api to get token
        String response = Request.Post(ConstantUtils.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", ConstantUtils.GOOGLE_CLIENT_ID)
                        .add("client_secret", ConstantUtils.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", ConstantUtils.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", ConstantUtils.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static UserGoogleDetails getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = ConstantUtils.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        UserGoogleDetails googlePojo = new Gson().fromJson(response, UserGoogleDetails.class);

        return googlePojo;
    }

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Check if the user is already logged in
    if (request.getSession().getAttribute("user") != null) {
        User user = (User) request.getSession().getAttribute("user");
        request.setAttribute("email", user.getEmail());
        request.setAttribute("password", user.getPassword());
    }
    // Check if there's a validation message
    boolean inValid = "".equals(request.getSession().getAttribute("validate"));
    if (!inValid) {
        request.getSession().setAttribute("validate", "");
    }

    // Check if user is logging in with Google
    String googleCode = request.getParameter("code");
    if (googleCode != null) {
        try {
            // Process Google login
            String accessToken = getToken(googleCode);
            UserGoogleDetails googleUser = getUserInfo(accessToken);
            // Check user's role based on email or any unique identifier
            UserDAO userDAO = new UserDAO();
            String email = googleUser.getEmail();
            List<User> isUser = userDAO.checkUserByEmail(email);
            // If user is found, set session attribute
            if (!isUser.isEmpty()) {
                User user = userDAO.getUserByEmail(email);
                if (user.getRestrictUntil().compareTo(Date.from(Instant.now())) > 0) {
                    request.getSession().setAttribute("validate", "You have been restricted to use our service! Come back at " + user.getRestrictUntil() + ". Reason: " + user.getRestrictReason());
                    response.sendRedirect(request.getContextPath() + "login");
                    return;
                }
                request.getSession().setAttribute("user", user);
                if (userDAO.checkAdminUsingEmail(email)) {
                    response.sendRedirect("admin");
                    return;
                }
                if (userDAO.checkManagerUsingEmail(email)) {
                    response.sendRedirect("manager");
                    return;
                }
                if (userDAO.checkTeacherUsingEmail(email)) {
                    response.sendRedirect("teacher");
                    return;
                }
                request.getSession().setAttribute("validate", "");
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                request.getSession().setAttribute("validate", "Wrong Email!");
                response.sendRedirect("login");
            }
        } catch (SQLException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
    } else {
        // Render the login page
        request.getRequestDispatcher("/login/login.jsp").forward(request, response);
    }
}
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String validate = "Email or password is incorrect.";
        UserDAO userDAO = new UserDAO();
        EncryptionUtils eu = new EncryptionUtils();
        List<User> isUser = userDAO.checkUser(email, eu.toMD5(password));
        if (!isUser.isEmpty()) {
            try {
                User user = userDAO.getUser(email, eu.toMD5(password));
                if (user.getRestrictUntil().compareTo(Date.from(Instant.now())) > 0) {
                    request.getSession().setAttribute("validate", "You have been restricted to use our service! Come back at " + user.getRestrictUntil() + ". Reason: " + user.getRestrictReason());
                    response.sendRedirect(request.getContextPath() + "login");
                    return;
                }

                request.getSession().setAttribute("user", user);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (userDAO.checkAdmin(email, eu.toMD5(password))) {
                response.sendRedirect("admin");
                return;
            }

            if (userDAO.checkManager(email, eu.toMD5(password))) {
                response.sendRedirect("manager");
                return;
            }

            if (userDAO.checkTeacher(email, eu.toMD5(password))) {
                response.sendRedirect("teacher");
                return;
            }
            request.getSession().setAttribute("validate", "");
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.getSession().setAttribute("validate", validate);
            response.sendRedirect("login");
        }
    }
}
