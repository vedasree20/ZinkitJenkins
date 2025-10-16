package com.src.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import com.src.model.User;

public interface UserDAO {
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
    /**
     * Register a new user
     * @param user - user object containing details
     * @return true if registration successful, false otherwise
     */
    boolean register(User user);

  
    /**
     * Update existing user details
     * @param user - user object containing updated details
     * @return true if update successful, false otherwise
     */
    boolean update(User user);

    /**
     * Delete user by ID
     * @param userId - ID of the user to delete
     * @return true if deletion successful, false otherwise
     */
    boolean delete(String userId);

   
    /**
     * Display all users
     * @return list of all users
     */
    List<User> displayAll();

    /**
     * Find user by email
     * @param email - email of the user
     * @return User object if found, null otherwise
     */
    User findByEmail(String email);

    /**
     * Find user by ID
     * @param userId - ID of the user
     * @return User object if found, null otherwise
     */
    User findById(String userId);
}
