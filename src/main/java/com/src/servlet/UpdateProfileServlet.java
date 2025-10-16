package com.src.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.src.dao.UserDAO;
import com.src.dao.UserDAOImpl;
import com.src.model.User;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAOImpl();

    public UpdateProfileServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            User loggedInUser = (User) session.getAttribute("loggedInUser");

            // Get updated details from form
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String pincode = request.getParameter("pincode");
            String password = request.getParameter("password"); // optional

            // Update fields
            loggedInUser.setUsername(username);
            loggedInUser.setEmail(email);
            loggedInUser.setPhone(phone);
            loggedInUser.setAddress(address);
            loggedInUser.setCity(city);
            loggedInUser.setState(state);
            loggedInUser.setPincode(pincode);

            if (password != null && !password.isEmpty()) {
                loggedInUser.setPassword(encodePassword(password)); // encode password
            }

            boolean updated = userDAO.update(loggedInUser);

            if (updated) {
                session.setAttribute("loggedInUser", loggedInUser);
                request.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile. Try again.");
            }

            request.getRequestDispatcher("editProfile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred!");
            request.getRequestDispatcher("editProfile.jsp").forward(request, response);
        }
    }

    // Example simple password encoding (you can use stronger hashing)
    private String encodePassword(String password) {
        // For demo purposes, reverse string (replace with real hashing e.g., BCrypt)
        return new StringBuilder(password).reverse().toString();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("editProfile.jsp");
    }
}
