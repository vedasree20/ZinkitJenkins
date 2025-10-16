package com.src.service;


import java.util.List;

import com.src.model.Cart;

public interface CartService {
    boolean addToCart(Cart cart);
    boolean incrementCartItem(String cartItemId);
    boolean decrementCartItem(String cartItemId);
    boolean removeCartItem(String cartItemId);
    List<Cart> getUserCart(String userId);
    List<Cart> getCartItemsByUserId(String userId);
    Cart getCartItemByUserAndProduct(String userId, String productId);
    boolean updateCartItem(Cart cartItem);
    boolean removeCartItem(String userId, String productId);



}
