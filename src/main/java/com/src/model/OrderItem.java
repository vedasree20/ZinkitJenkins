package com.src.model;

public class OrderItem {
    private String orderItemId;
    private String orderId;
    private String productId;
    private int quantity;
    private double priceAtTime;

    public OrderItem() {
		super();
	}
	public OrderItem(String orderItemId, String orderId, String productId, int quantity, double priceAtTime) {
		super();
		this.orderItemId = orderItemId;
		this.orderId = orderId;
		this.productId = productId;
		this.quantity = quantity;
		this.priceAtTime = priceAtTime;
	}
	// Getters and Setters
    public String getOrderItemId() { return orderItemId; }
    public void setOrderItemId(String orderItemId) { this.orderItemId = orderItemId; }

    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }

    public String getProductId() { return productId; }
    public void setProductId(String productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPriceAtTime() { return priceAtTime; }
    public void setPriceAtTime(double priceAtTime) { this.priceAtTime = priceAtTime; }
}
