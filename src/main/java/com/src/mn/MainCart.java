package com.src.mn;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;

import com.src.dao.CartDAO;
import com.src.dao.CartDAOImpl;
import com.src.model.Cart;
import com.src.service.CartService;
import com.src.service.CartServiceImpl;
import com.src.service.ProductService;
import com.src.service.ProductServiceImpl;

public class MainCart {
    public static void main(String[] args) {

        // 1️⃣ Database connection setup
        String url = "jdbc:oracle:thin:@localhost:1521:xe"; // Change according to your DB
        String username = "system";
        String password = "TIGER";

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            // 2️⃣ Initialize DAO and Service
            CartDAO cartDAO = new CartDAOImpl(connection);
            CartService cartService = new CartServiceImpl(cartDAO);

            // 3️⃣ Create a new cart item
            String cartItemId = UUID.randomUUID().toString(); // Unique ID
            Cart cart = new Cart(
                    cartItemId,
                    "123",           // Replace with an existing USER_ID
                    "P149",              // Replace with an existing PRODUCT_ID
                    2,                   // Quantity
                    100.0,               // Price at time
                    new Timestamp(System.currentTimeMillis())
            );

            boolean added = cartService.addToCart(cart);
            System.out.println("Cart added: " + added);

            // 4️⃣ Increment cart item quantity
            boolean incremented = cartService.incrementCartItem(cartItemId);
            System.out.println("Quantity incremented: " + incremented);

            // 5️⃣ Decrement cart item quantity
            boolean decremented = cartService.decrementCartItem(cartItemId);
            System.out.println("Quantity decremented: " + decremented);

            // 6️⃣ Fetch all cart items for a user
            List<Cart> userCart = cartService.getUserCart("123");
            System.out.println("Cart items for USER001:");
            ProductService ps = new ProductServiceImpl();
            for (Cart c : userCart) {
                System.out.println(c.getCartItemId() + " | " + ps.getProductById(c.getProductId()) + " | " + c.getQuantity());
            }

            // 7️⃣ Remove cart item
            boolean removed = cartService.removeCartItem(cartItemId);
            System.out.println("Cart item removed: " + removed);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
