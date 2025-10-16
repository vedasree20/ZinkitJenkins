package com.src.servlet;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.src.dao.UserDAOImpl;
import com.src.model.User;


@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

	 private String encodePassword(String password) {
	        return Base64.getEncoder().encodeToString(password.getBytes(StandardCharsets.UTF_8));
	    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("resetEmail") == null) {
            response.sendRedirect("forgot_password.jsp");
            return;
        }

        String email = (String) session.getAttribute("resetEmail");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("message", "Passwords do not match!");
            RequestDispatcher rd = request.getRequestDispatcher("reset_password.jsp");
            rd.forward(request, response);
            return;
        }

        UserDAOImpl dao = new UserDAOImpl();
        User user = dao.findByEmail(email);

        if (user != null) {
            user.setPassword(encodePassword(newPassword));
            boolean updated = dao.update(user);

            if (updated) {
                session.removeAttribute("resetEmail");
                request.setAttribute("message", "Password updated successfully! Please log in.");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("message", "Failed to update password. Try again.");
                RequestDispatcher rd = request.getRequestDispatcher("reset_password.jsp");
                rd.forward(request, response);
            }
        } else {
            response.sendRedirect("forgot_password.jsp");
        }
    }
}
