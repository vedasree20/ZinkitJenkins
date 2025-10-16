package com.src.dao;

import java.util.List;

import com.src.model.Order;
import com.src.model.OrderItem;

public interface OrderDAO {
    boolean insertOrder(Order order, List<OrderItem> items);
    List<Order> fetchOrdersByUser(String userId);
    Order fetchOrderById(String orderId);
    List<OrderItem> fetchItemsByOrder(String orderId);
    List<Order> getAllOrders();

}
