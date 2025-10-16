package com.src.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.src.dao.CartDAO;
import com.src.dao.CartDAOImpl;
import com.src.dao.OrderDAO;
import com.src.dao.OrderDAOImpl;
import com.src.dao.ProductDAO;
import com.src.dao.ProductDAOImpl;
import com.src.model.Cart;
import com.src.model.Order;
import com.src.model.OrderItem;
import com.src.model.User;
import com.src.service.UserService;
import com.src.service.UserServiceImpl;
import com.src.util.DBUtil;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    public static boolean updateWalletBalance(String userId, double amount) throws SQLException {
        String sql = "UPDATE ZinkUSERS " +
                     "SET WALLET_BALANCE = WALLET_BALANCE - ?, UPDATED_AT = CURRENT_TIMESTAMP " +
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
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            return DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "TIGER");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("Driver not found");
        }
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("userId");
        String paymentMethod = req.getParameter("paymentMethod");
        UserService us = new UserServiceImpl();
        User u = (userId != null) ? us.findById(userId.toString()) : null;
        @SuppressWarnings("unchecked")
        List<Cart> cartItems = (List<Cart>) session.getAttribute("cartItems");
        if (cartItems == null || cartItems.isEmpty()) {
            res.sendRedirect("Cart.jsp");
            return;
        }

        double subtotal = (double) session.getAttribute("subtotal");
        double shipping = (double) session.getAttribute("shippingCost");
        double total = (double) session.getAttribute("grandTotal");
        double discountAmount = req.getParameter("discountAmount") != null ?
                Double.parseDouble(req.getParameter("discountAmount")) : 0.0;

		boolean useWallet = req.getParameter("useWallet") != null &&
		            Boolean.parseBoolean(req.getParameter("useWallet"));
		
		double finalAmount = total - discountAmount;
		
		long walletUsed = 0;
		System.out.print(useWallet+" "+finalAmount);
		// Deduct wallet if used
		if (useWallet && u.getWalletBalance() > 0) {
		    walletUsed = (long) Math.min(u.getWalletBalance(), finalAmount);
		    finalAmount -= walletUsed;
		    u.setWalletBalance((long) (u.getWalletBalance() - walletUsed));

		    try {
		        boolean b = updateWalletBalance(userId, walletUsed);
		        System.out.println(userId+" "+walletUsed);
		        System.out.println("Wallet updated: " + b);
		    } catch (SQLException e) {
		        e.printStackTrace();
		        res.sendRedirect("error.jsp");
		        return;
		    }
		}

		// Order creation should be here, outside the if

		
               // Create Order object
        Order order = new Order();
        order.setOrderId("ORD-" + UUID.randomUUID().toString().substring(0, 8));
        order.setUserId(userId);
        order.setPaymentMethod(paymentMethod);
        order.setTotalAmount(total);
        order.setOrderStatus("Placed");
        order.setDeliveryAddress("Hyderabad"); // you can replace with real fields
        order.setCity("Hyderabad");
        order.setState("Telangana");
        order.setPincode("500001");

        // Create OrderItem list
        List<OrderItem> orderItems = new ArrayList<>();
        for (Cart c : cartItems) {
            OrderItem oi = new OrderItem();
            oi.setOrderItemId("ITEM-" + UUID.randomUUID().toString().substring(0, 8));
            oi.setProductId(c.getProductId());
            oi.setQuantity(c.getQuantity());
            oi.setPriceAtTime(c.getPriceAtTime());
            orderItems.add(oi);
        }

        // Save order
        OrderDAO orderDAO = new OrderDAOImpl();
        boolean success = orderDAO.insertOrder(order, orderItems);
        

       

            // Clear session cart
            session.removeAttribute("cartItems");
            session.removeAttribute("subtotal");
            session.removeAttribute("shippingCost");
            session.removeAttribute("grandTotal");
            
            Connection con;
			try {
				con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "TIGER");
				CartDAO cartDAO = new CartDAOImpl(con); // pass your DB connection
				for(Cart c : cartItems) {
					cartDAO.removeCartItem(c.getCartItemId());
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

            


            req.setAttribute("orderId", order.getOrderId());
            RequestDispatcher rd = req.getRequestDispatcher("orderSuccess.jsp");
            rd.forward(req, res);
       
    }
}
