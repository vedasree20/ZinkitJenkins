package com.src.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import com.src.model.Category;
import com.src.model.Product;

public interface ProductDAO {
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
	 boolean add(Product product);
	    boolean update(Product product);
	    boolean delete(String productId);
	    Product findById(String productId);
	    List<Product> findAll();
	    List<Product> findByCategory(Category category);
	    boolean decrementQuantity(String productId, int quantity);
	    List<Product> searchProducts(String keyword);



}
