package com.src.service;

import java.util.List;

import com.src.dao.OrderDAO;
import com.src.dao.OrderDAOImpl;
import com.src.model.Order;
import com.src.model.OrderItem;

public class OrderServiceImpl implements OrderServiceInterface {

    private OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    public boolean placeOrder(Order order, List<OrderItem> items) {
        return orderDAO.insertOrder(order, items);
    }

    @Override
    public List<Order> getUserOrders(String userId) {
        return orderDAO.fetchOrdersByUser(userId);
    }
    
    @Override
    public List<Order> getAllOrders() {
    	return orderDAO.getAllOrders();
    }

    @Override
    public Order getOrderById(String orderId) {
        return orderDAO.fetchOrderById(orderId);
    }
}
