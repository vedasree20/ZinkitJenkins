package com.src.model;


import java.io.Serializable;
import java.sql.Timestamp;

import com.src.annotations.Column;

public class Cart implements Serializable{

    @Column(name = "CART_ITEM_ID", length = 30, nullable = false, unique = true)
    private String cartItemId;

    @Column(name = "USER_ID", length = 30, nullable = false)
    private String userId;

    @Column(name = "PRODUCT_ID", length = 30, nullable = false)
    private String productId;

    @Column(name = "QUANTITY", nullable = false, defaultValue = "1")
    private int quantity;

    @Column(name = "PRICE_AT_TIME")
    private double priceAtTime;

    @Column(name = "ADDED_AT", defaultValue = "CURRENT_TIMESTAMP")
    private Timestamp addedAt;

    // Constructors
    public Cart() {}

    public Cart(String cartItemId, String userId, String productId, int quantity, double priceAtTime, Timestamp addedAt) {
        this.cartItemId = cartItemId;
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.priceAtTime = priceAtTime;
        this.addedAt = addedAt;
    }

    
    @Override
	public String toString() {
		return "Cart [cartItemId=" + cartItemId + ", userId=" + userId + ", productId=" + productId + ", quantity="
				+ quantity + ", priceAtTime=" + priceAtTime + ", addedAt=" + addedAt + "]";
	}

	// Getters and Setters
    public String getCartItemId() { return cartItemId; }
    public void setCartItemId(String cartItemId) { this.cartItemId = cartItemId; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getProductId() { return productId; }
    public void setProductId(String productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPriceAtTime() { return priceAtTime; }
    public void setPriceAtTime(double priceAtTime) { this.priceAtTime = priceAtTime; }

    public Timestamp getAddedAt() { return addedAt; }
    public void setAddedAt(Timestamp addedAt) { this.addedAt = addedAt; }
}
