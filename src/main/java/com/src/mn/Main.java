package com.src.mn;


import java.sql.Timestamp;
import java.util.Base64;
import java.util.List;
import java.util.Scanner;

import com.src.model.User;
import com.src.service.UserService;
import com.src.service.UserServiceImpl;

public class Main {

    private static final Scanner sc = new Scanner(System.in);
    private static final UserService userService = new UserServiceImpl();

    public static void main(String[] args) {
        int choice;
        do {
            System.out.println("\n=== Zinkit Grocery User Management ===");
            System.out.println("1. Register User");
            System.out.println("2. Login");
            System.out.println("3. Update User");
            System.out.println("4. Delete User");
            System.out.println("5. Reset Password");
            System.out.println("6. Display All Users");
            System.out.println("7. Find User by ID");
            System.out.println("0. Exit");
            System.out.print("Enter choice: ");
            choice = sc.nextInt();
            sc.nextLine(); // consume newline

            switch (choice) {
                case 1 : {
                	registerUser();
                	break;
                }
                case 2 : {
                	loginUser();
                	break;
                }
                case 3 :{
                	updateUser();
                	break;
                } 
                case 4 :{
                	deleteUser();
                	break;
                } 
                case 5 : {
                	resetPassword();
                	break;
                }
                case 6 : {
                	displayAllUsers();
                	break;
                }
                case 7 : {
                	findUserById();
                	break;
                }
                case 0 : {
                	System.out.println("Exiting...");
                	break;
                }
                default : {
                	System.out.println("Invalid choice!");
                	break;
                }
            }

        } while (choice != 0);
    }

    private static void registerUser() {
        User user = new User();
        System.out.print("User ID: ");
        user.setUserId(sc.nextLine());
        System.out.print("Username: ");
        user.setUsername(sc.nextLine());
        System.out.print("Email: ");
        user.setEmail(sc.nextLine());
        System.out.print("Password: ");
        String password = sc.nextLine();
        user.setPassword(encodePassword(password));
        System.out.print("Phone: ");
        user.setPhone(sc.nextLine());
        System.out.print("Address: ");
        user.setAddress(sc.nextLine());
        System.out.print("City: ");
        user.setCity(sc.nextLine());
        System.out.print("State: ");
        user.setState(sc.nextLine());
        System.out.print("Pincode: ");
        user.setPincode(sc.nextLine());
        user.setWalletBalance(0);
        user.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        user.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

        boolean success = userService.register(user);
        System.out.println(success ? "User registered successfully!" : "Registration failed!");
    }

    private static void loginUser() {
        System.out.print("Email: ");
        String email = sc.nextLine();
        System.out.print("Password: ");
        String password = sc.nextLine();

        User user = userService.login(email, password);
        if (user != null) {
            System.out.println("Login successful! Welcome " + user.getUsername());
        } else {
            System.out.println("Login failed!");
        }
    }

    private static void updateUser() {
        System.out.print("Enter User ID to update: ");
        String userId = sc.nextLine();
        User user = userService.findById(userId);
        if (user != null) {
            System.out.print("New Username: ");
            user.setUsername(sc.nextLine());
            System.out.print("New Phone: ");
            user.setPhone(sc.nextLine());
            System.out.print("New Address: ");
            user.setAddress(sc.nextLine());
            user.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

            boolean success = userService.update(user);
            System.out.println(success ? "User updated successfully!" : "Update failed!");
        } else {
            System.out.println("User not found!");
        }
    }

    private static void deleteUser() {
        System.out.print("Enter User ID to delete: ");
        String userId = sc.nextLine();
        boolean success = userService.delete(userId);
        System.out.println(success ? "User deleted successfully!" : "Deletion failed!");
    }

    private static void resetPassword() {
        System.out.print("Enter Email: ");
        String email = sc.nextLine();
        System.out.print("Enter New Password: ");
        String newPassword = sc.nextLine();

        boolean success = userService.resetPassword(email, newPassword);
        System.out.println(success ? "Password reset successfully!" : "Password reset failed!");
    }

    private static void displayAllUsers() {
        List<User> users = userService.displayAll();
        if (users.isEmpty()) {
            System.out.println("No users found!");
        } else {
            users.forEach(System.out::println);
        }
    }

    private static void findUserById() {
        System.out.print("Enter User ID: ");
        String userId = sc.nextLine();
        User user = userService.findById(userId);
        if (user != null) {
            System.out.println(user);
        } else {
            System.out.println("User not found!");
        }
    }

    private static String encodePassword(String password) {
        return Base64.getEncoder().encodeToString(password.getBytes());
    }
}
