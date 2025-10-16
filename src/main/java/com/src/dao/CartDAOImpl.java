package com.src.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.src.model.Cart;

public class CartDAOImpl implements CartDAO {

    private Connection connection;

    public CartDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public boolean addCartItem(Cart cart) {
        String sql = "INSERT INTO ZINKIT_CART (CART_ITEM_ID, USER_ID, PRODUCT_ID, QUANTITY, PRICE_AT_TIME, ADDED_AT) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, cart.getCartItemId());
            ps.setString(2, cart.getUserId());
            ps.setString(3, cart.getProductId());
            ps.setInt(4, cart.getQuantity());
            ps.setDouble(5, cart.getPriceAtTime());
            ps.setTimestamp(6, cart.getAddedAt());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateCartItemQuantity(String cartItemId, int quantity) {
        String sql = "UPDATE ZINKIT_CART SET QUANTITY=? WHERE CART_ITEM_ID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setString(2, cartItemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean removeCartItem(String cartItemId) {
        String sql = "DELETE FROM ZINKIT_CART WHERE CART_ITEM_ID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, cartItemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Cart getCartItemById(String cartItemId) {
        String sql = "SELECT * FROM ZINKIT_CART WHERE CART_ITEM_ID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, cartItemId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToCart(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Cart> getCartItemsByUser(String userId) {
        List<Cart> carts = new ArrayList<>();
        String sql = "SELECT * FROM ZINKIT_CART WHERE USER_ID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                carts.add(mapResultSetToCart(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return carts;
    }

    private Cart mapResultSetToCart(ResultSet rs) throws SQLException {
        return new Cart(
            rs.getString("CART_ITEM_ID"),
            rs.getString("USER_ID"),
            rs.getString("PRODUCT_ID"),
            rs.getInt("QUANTITY"),
            rs.getDouble("PRICE_AT_TIME"),
            rs.getTimestamp("ADDED_AT")
        );
    }
    
    @Override
    public List<Cart> getCartItemsByUserId(String userId) throws SQLException {
        List<Cart> cartList = new ArrayList<>();
        String query = "SELECT * FROM ZINKIT_CART WHERE USER_ID = ?";
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setString(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Cart c = new Cart(
                rs.getString("CART_ITEM_ID"),
                rs.getString("USER_ID"),
                rs.getString("PRODUCT_ID"),
                rs.getInt("QUANTITY"),
                rs.getDouble("PRICE_AT_TIME"),
                rs.getTimestamp("ADDED_AT")
            );
            cartList.add(c);
        }
        return cartList;
    }
    
    @Override
    public Cart findByUserAndProduct(String userId, String productId) {
        Cart cart = null;
        Connection con = connection;
        try {
        	String sql = "SELECT * FROM ZINKIT_CART WHERE USER_ID = ? AND PRODUCT_ID = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, userId);
            ps.setString(2, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                cart = new Cart();
                cart.setUserId(userId);
                cart.setProductId(rs.getString("PRODUCT_ID"));
                cart.setQuantity(rs.getInt("QUANTITY"));
                cart.setPriceAtTime(rs.getDouble("PRICE_AT_TIME"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cart;
    }

    @Override
    public boolean update(Cart cart) {
    	Connection con = connection;
        try {
            
            String sql = "UPDATE ZINKIT_CART SET quantity = ?, price_at_time = ? WHERE user_id = ? AND product_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, cart.getQuantity());
            ps.setDouble(2, cart.getPriceAtTime());
            ps.setString(3, cart.getUserId());
            ps.setString(4, cart.getProductId()); // ✅ parameter 4
            ps.executeUpdate();

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean removeCartItem(String userId, String productId) {
        String sql = "DELETE FROM ZINKIT_CART WHERE USER_ID = ? AND PRODUCT_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, productId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
