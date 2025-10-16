package com.src.service;

import java.util.List;

import com.src.model.Order;
import com.src.model.OrderItem;

public interface OrderServiceInterface {
    boolean placeOrder(Order order, List<OrderItem> items);
    List<Order> getUserOrders(String userId);
    List<Order> getAllOrders();
    Order getOrderById(String orderId);
}
