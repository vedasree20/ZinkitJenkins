package com.src.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.src.dao.UserDAOImpl;
import com.src.model.User;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        UserDAOImpl dao = new UserDAOImpl();
        User user = dao.findByEmail(email);

        if (user != null) {
            // store email in session temporarily for next step
            HttpSession session = request.getSession();
            session.setAttribute("resetEmail", email);
            // forward to password reset page
            response.sendRedirect("reset_password.jsp");
        } else {
            request.setAttribute("message", "No account found with this email!");
            RequestDispatcher rd = request.getRequestDispatcher("forgot_password.jsp");
            rd.forward(request, response);
        }
    }
}
