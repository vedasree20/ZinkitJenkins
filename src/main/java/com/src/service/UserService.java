package com.src.service;


import java.util.List;

import com.src.model.User;

public interface UserService {

    /**
     * Register a new user
     * @param user - user object containing details
     * @return true if registration successful, false otherwise
     */
    boolean register(User user);

    /**
     * Login user
     * @param email - email of the user
     * @param password - password entered by the user
     * @return User object if login successful, null otherwise
     */
    User login(String email, String password);

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
     * Reset password for a user
     * @param email - email of the user
     * @param newPassword - new password to set
     * @return true if reset successful, false otherwise
     */
    boolean resetPassword(String email, String newPassword);

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
