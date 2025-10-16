package com.src.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.src.model.User;
import com.src.service.UserService;
import com.src.service.UserServiceImpl;

@WebServlet("/AddWalletServlet")
public class AddWalletServlet extends HttpServlet {



    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            return DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "TIGER");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("Driver not found");
        }
    }

    public static boolean updateWalletBalance(String userId, double amount) throws SQLException {
        String sql = "UPDATE ZinkUSERS " +
                     "SET WALLET_BALANCE = WALLET_BALANCE + ?, UPDATED_AT = CURRENT_TIMESTAMP " +
                     "WHERE USER_ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Just execute, no commit needed
            ps.setDouble(1, amount);
            ps.setString(2, userId);
            int updated = ps.executeUpdate();
            return updated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String id = session.getAttribute("userId").toString();
        UserService us = new UserServiceImpl();
        User u = us.findById(id); 
        if (u == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        String userId = u.getUserId();
        long amount = Long.parseLong(request.getParameter("amount"));

        boolean success = false;
		try {
			success = updateWalletBalance(userId, amount);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        if (success) {
            // Update the User object in session to reflect new balance
            u.setWalletBalance(amount+(long)u.getWalletBalance());
            session.setAttribute("user", u);
            request.setAttribute("msg", "Money added successfully!");
        } else {
            request.setAttribute("msg", "Failed to add money!");
        }

        request.getRequestDispatcher("AddMoney.jsp").forward(request, response);
    }
}
