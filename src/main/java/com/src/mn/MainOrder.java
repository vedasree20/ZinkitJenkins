package com.src.mn;

import java.util.ArrayList;
import java.util.List;

import com.src.model.Order;
import com.src.model.OrderItem;
import com.src.service.OrderServiceImpl;
import com.src.service.OrderServiceInterface;

public class MainOrder {
    public static void main(String[] args) {
        OrderServiceInterface orderService = new OrderServiceImpl();

        // Create order
        Order order = new Order();
        order.setOrderId("O1002");
        order.setUserId("U1001");
        order.setTotalAmount(260.0);
        order.setPaymentMethod("Wallet");
        order.setOrderStatus("Pending");
        order.setDeliveryAddress("123, Green Street");
        order.setCity("Hyderabad");
        order.setState("Telangana");
        order.setPincode("500081");

        // Create order items
        List<OrderItem> items = new ArrayList<>();

        OrderItem item1 = new OrderItem();
        item1.setOrderItemId("OI1002");
        item1.setOrderId("O1001");
        item1.setProductId("P001");
        item1.setQuantity(2);
        item1.setPriceAtTime(100);
        items.add(item1);

        OrderItem item2 = new OrderItem();
        item2.setOrderItemId("OI1003");
        item2.setOrderId("O1001");
        item2.setProductId("P002");
        item2.setQuantity(1);
        item2.setPriceAtTime(60);
        items.add(item2);

        boolean success = orderService.placeOrder(order, items);
        System.out.println(success ? "✅ Order placed successfully!" : "❌ Failed to place order.");
    }
}
