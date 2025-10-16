package com.src.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import com.src.model.Cart;

public interface CartDAO {
	 static final String URL = "jdbc:oracle:thin:@//localhost:1521/xe";
	 static final String USER = "system";
	 static final String PASSWORD = "TIGER";
	 public static Connection getConnection() {
	        try {
	            Class.forName("oracle.jdbc.driver.OracleDriver");
	            return DriverManager.getConnection(URL, USER, PASSWORD);
	        } catch (SQLException | ClassNotFoundException e) {
	            e.printStackTrace();
	        }
	        return null;
	    }
    boolean addCartItem(Cart cart);
    boolean updateCartItemQuantity(String cartItemId, int quantity);
    boolean removeCartItem(String cartItemId);
    Cart getCartItemById(String cartItemId);
    List<Cart> getCartItemsByUser(String userId);
    List<Cart> getCartItemsByUserId(String userId) throws SQLException;
    Cart findByUserAndProduct(String userId, String productId) ;
    boolean update(Cart cart);
    boolean removeCartItem(String userId, String productId);



}
