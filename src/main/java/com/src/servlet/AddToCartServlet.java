package com.src.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Timestamp;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.src.dao.CartDAO;
import com.src.dao.CartDAOImpl;
import com.src.model.Cart;
import com.src.service.CartService;
import com.src.service.CartServiceImpl;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");
        String productId = request.getParameter("productId");
        double priceAtTime = Double.parseDouble(request.getParameter("priceAtTime"));

        try {
            Connection connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "system", "TIGER"
            );

            CartDAO cartDAO = new CartDAOImpl(connection);
            CartService cartService = new CartServiceImpl(cartDAO);

            String cartItemId = UUID.randomUUID().toString(); // unique ID

            Cart cart = new Cart(cartItemId, userId, productId, 1, priceAtTime, new Timestamp(System.currentTimeMillis()));

            boolean added = cartService.addToCart(cart);

            if (added) {
                response.sendRedirect("index.jsp"); // redirect to cart page
            } else {
                response.sendRedirect("loginToAdd.jsp"); // redirect to cart page
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
