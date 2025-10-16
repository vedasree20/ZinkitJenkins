package com.src.servlet;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.src.model.User;
import com.src.service.UserService;
import com.src.service.UserServiceImpl;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
//    private UserDAO userDAO = new UserDAOImpl();
	private UserService us = new UserServiceImpl();

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            // --- Read form parameters ---
            String userId = request.getParameter("userId"); // hidden input auto generated
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
//            String confirmPassword = request.getParameter("confirmPassword");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String pincode = request.getParameter("pincode");

            // --- Basic validation ---
            if (username == null || email == null || password == null ) {

                request.setAttribute("errorMessage", "Passwords do not match or missing fields!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // --- Create User object ---
            User user = new User();
            user.setUserId(userId);
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setPhone(phone);
            user.setAddress(address);
            user.setCity(city);
            user.setState(state);
            user.setPincode(pincode);
            user.setWalletBalance(0);
            user.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            user.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

            // --- Save using DAO ---
            boolean success = us.register(user);

            if (success) {
                request.setAttribute("successMessage", "Registration successful! Please login.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Registration failed. Email may already exist.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Internal server error: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
