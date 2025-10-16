package com.src.model;


import java.sql.Timestamp;

public class Order {
    private String orderId;
    private String userId;
    private double totalAmount;
    private String paymentMethod;
    private String orderStatus;
    private Timestamp orderDate;
    private String deliveryAddress;
    private String city;
    private String state;
    private String pincode;
    

	public Order() {
		super();
	}
	public Order(String orderId, String userId, double totalAmount, String paymentMethod, String orderStatus,
			Timestamp orderDate, String deliveryAddress, String city, String state, String pincode) {
		super();
		this.orderId = orderId;
		this.userId = userId;
		this.totalAmount = totalAmount;
		this.paymentMethod = paymentMethod;
		this.orderStatus = orderStatus;
		this.orderDate = orderDate;
		this.deliveryAddress = deliveryAddress;
		this.city = city;
		this.state = state;
		this.pincode = pincode;
	}
	// Getters and Setters
    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getOrderStatus() { return orderStatus; }
    public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }

    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public String getPincode() { return pincode; }
    public void setPincode(String pincode) { this.pincode = pincode; }
}
