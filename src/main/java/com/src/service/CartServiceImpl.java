package com.src.service;


import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.src.dao.CartDAO;
import com.src.model.Cart;

public class CartServiceImpl implements CartService {

    private CartDAO cartDAO;

    
    public CartServiceImpl(CartDAO cartDAO) {
        this.cartDAO = cartDAO;
    }

    @Override
    public boolean addToCart(Cart cart) {
        // Check if item already exists
        Cart existingCart = cartDAO.getCartItemById(cart.getCartItemId());
        if (existingCart != null) {
            return cartDAO.updateCartItemQuantity(cart.getCartItemId(), existingCart.getQuantity() + cart.getQuantity());
        }
        return cartDAO.addCartItem(cart);
    }

    @Override
    public boolean incrementCartItem(String cartItemId) {
        Cart cart = cartDAO.getCartItemById(cartItemId);
        if (cart != null) {
            return cartDAO.updateCartItemQuantity(cartItemId, cart.getQuantity() + 1);
        }
        return false;
    }

    @Override
    public boolean decrementCartItem(String cartItemId) {
        Cart cart = cartDAO.getCartItemById(cartItemId);
        if (cart != null && cart.getQuantity() > 1) {
            return cartDAO.updateCartItemQuantity(cartItemId, cart.getQuantity() - 1);
        }
        return false;
    }

    @Override
    public boolean removeCartItem(String cartItemId) {
        return cartDAO.removeCartItem(cartItemId);
    }

    @Override
    public List<Cart> getUserCart(String userId) {
        return cartDAO.getCartItemsByUser(userId);
    }
    
    @Override
    public List<Cart> getCartItemsByUserId(String userId) {
        try {
            return cartDAO.getCartItemsByUserId(userId);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public Cart getCartItemByUserAndProduct(String userId, String productId) {
        return cartDAO.findByUserAndProduct(userId, productId);
    }

    @Override
    public boolean updateCartItem(Cart cartItem) {
        return cartDAO.update(cartItem);
    }
    
    @Override
    public boolean removeCartItem(String userId, String productId) {
    	return cartDAO.removeCartItem(userId,productId);
    }



}
