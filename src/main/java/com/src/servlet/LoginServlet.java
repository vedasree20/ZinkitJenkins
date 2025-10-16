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
import com.src.service.UserService;
import com.src.service.UserServiceImpl;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAOImpl();

    public LoginServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	UserService userService = new UserServiceImpl();
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            // ✅ Get login form values
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // ✅ Fetch user from DB
            User user = userDAO.findByEmail(email);
//         if(email.equals("vedasree2045@gmail.com")&&password.equals("veda")) {
//        	 User u = new User();
//        	 u.setUserId("U1001");
//        	 u.setUsername("Veda Sree");
//        	 u.setEmail("vedasree2045@gmail.com");
//        	 u.setPassword("veda"); // for testing only
//        	 u.setPhone("9876543210");
//        	 u.setAddress("123, Green Street");
//        	 u.setCity("Hyderabad");
//        	 u.setState("Telangana");
//        	 u.setPincode("500081");
//        	 u.setWalletBalance(1500); // example balance
//        	 u.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));
//        	 u.setUpdatedAt(new java.sql.Timestamp(System.currentTimeMillis()));
//        	 // ✅ Valid credentials → create session
//        	 HttpSession session = request.getSession();
//        	 session.setAttribute("loggedInUser", u);
//        	 session.setAttribute("userId", u.getUserId());
//        	 
//        	 // Optionally, set session timeout (in seconds)
//        	 session.setMaxInactiveInterval(30 * 60); // 30 minutes
//        	 
//        	 // Redirect to homepage or dashboard
//        	 response.sendRedirect("index.jsp");
//         } else 
        if (user != null && userService.login(email,password)!=null){
            	
                // ✅ Valid credentials → create session
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);
                session.setAttribute("userId", user.getUserId());

                // Optionally, set session timeout (in seconds)
                session.setMaxInactiveInterval(30 * 60); // 30 minutes

                // Redirect to homepage or dashboard
                response.sendRedirect("index.jsp");
            } else {
                // ❌ Invalid login

                request.setAttribute("errorMessage", "Invalid email or password!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
